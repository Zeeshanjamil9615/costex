import 'dart:typed_data';

import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'dart:io';
import 'package:flutter/services.dart';

/// Build a simple multi-page PDF. Each page is a title + list of key/value rows.
Future<Uint8List> buildMultiPagePdf(List<Map<String, dynamic>> pages, {String? header}) async {
  final pdf = pw.Document();

  for (final page in pages) {
    // Ensure rows are a list of two-string lists
    final rawRows = (page['rows'] as List?) ?? [];
    final rows = rawRows.map<List<String>>((r) {
      if (r is List) return r.map((c) => c?.toString() ?? '').toList();
      return [r.toString(), ''];
    }).toList();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(16),
        build: (context) {
          return [
            if (header != null) pw.Text(header, style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 8),
            if (page.containsKey('title')) pw.Text(page['title'] ?? '', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 12),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: rows.map((r) {
                final left = r.isNotEmpty ? r[0] : '';
                final right = r.length > 1 ? r[1] : '';
                return pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 6),
                  child: pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Expanded(flex: 3, child: pw.Text(left, style: pw.TextStyle(fontSize: 11, color: PdfColors.black))),
                      pw.SizedBox(width: 8),
                      pw.Expanded(flex: 4, child: pw.Text(right, style: pw.TextStyle(fontSize: 11, color: PdfColors.black))),
                    ],
                  ),
                );
              }).toList(),
            ),
          ];
        },
        footer: (context) => pw.Align(alignment: pw.Alignment.center, child: pw.Text('Page ${context.pageNumber} / ${context.pagesCount}', style: pw.TextStyle(fontSize: 10))),
      ),
    );
  }

  return pdf.save();
}

/// Directly send a PDF to the platform print dialog without preview.
Future<void> printPagesDirect(List<Map<String, dynamic>> pages, {String? header}) async {
  final bytes = await buildMultiPagePdf(pages, header: header);
  try {
    await Printing.layoutPdf(onLayout: (_) => bytes);
  } on MissingPluginException catch (_) {
    // Printing plugin not available on this platform (or app not restarted after adding plugin).
    // Save PDF to a temporary file so user can retrieve it and we can show a helpful message.
    try {
      final tmpDir = Directory.systemTemp;
      final file = File('${tmpDir.path}/costex_export_${DateTime.now().millisecondsSinceEpoch}.pdf');
      await file.writeAsBytes(bytes);
      throw Exception('Printing plugin not available. PDF saved to: ${file.path}');
    } catch (e) {
      // If saving also fails, rethrow original plugin error
      rethrow;
    }
  }
}
