import 'dart:typed_data';

import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'dart:io';
import 'package:flutter/services.dart';

/// Build a simple multi-page PDF.
/// Rows can be provided in two formats:
/// 1) Legacy: `[label, value]` (list of length 2)
/// 2) Table aware: `[[label, value], [label2, value2], ...]` per row.
///    The number of inner items controls how many columns appear for that row.
///    This lets the PDF mirror the on-screen row grouping (1 item = full width,
///    2 items = two columns, etc.).
Future<Uint8List> buildMultiPagePdf(List<Map<String, dynamic>> pages, {String? header}) async {
  final pdf = pw.Document();

  for (final page in pages) {
    // Ensure rows are a list of two-string lists
    final rawRows = (page['rows'] as List?) ?? [];
    final rows = rawRows.map<List<List<String>>>((r) {
      // Table-aware: a row that is already a list of cells
      if (r is List && r.isNotEmpty && r.first is List) {
        final List rowList = r;
        return rowList
            .map<List<String>>((cell) => (cell as List).map((c) => c?.toString() ?? '').toList())
            .toList();
      }
      // Legacy: a single cell row (label/value)
      if (r is List) {
        return [
          r.map((c) => c?.toString() ?? '').toList(),
        ];
      }
      // Fallback: single text cell
      return [
        [r.toString(), ''],
      ];
    }).toList();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(16),
        build: (context) {
          return [
            // if (header != null) pw.Text(header, style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
            // pw.SizedBox(height: 8),
            if (page.containsKey('title')) pw.Text(page['title'] ?? '', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 12),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: rows.map((cells) {
                return pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 6),
                  child: pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: cells.map((cell) {
                      final label = cell.isNotEmpty ? cell[0] : '';
                      final value = cell.length > 1 ? cell[1] : '';
                      return pw.Expanded(
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(6),
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(color: PdfColors.grey300, width: 0.5),
                            borderRadius: pw.BorderRadius.circular(3),
                          ),
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              if (label.isNotEmpty)
                                pw.Text(
                                  label,
                                  style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold, color: PdfColors.grey800),
                                ),
                              if (label.isNotEmpty) pw.SizedBox(height: 2),
                              pw.Text(
                                value,
                                style: pw.TextStyle(fontSize: 10, color: PdfColors.black),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
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
