import 'dart:io';
import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:restotrack_app/features/orders/data/models/order_model.dart';
import 'package:restotrack_app/features/sales_report/data/repositories/sales_report_repository.dart';

class SalesReportExportService {
  // ── PDF ──────────────────────────────────────────────────────────────

  static Future<Uint8List> generatePdf({
    required List<OrderModel> orders,
    required SalesReportStats stats,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final pdf = pw.Document();
    final dateFormat = DateFormat('MMM dd, yyyy');
    final timeFormat = DateFormat('hh:mm a');
    final startStr = dateFormat.format(startDate);
    final endStr = dateFormat.format(endDate);
    final periodLabel = startStr == endStr ? startStr : '$startStr - $endStr';

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        header: (context) => _pdfHeader(periodLabel),
        footer: (context) => _pdfFooter(context),
        build: (context) => [
          // Summary
          _pdfSummary(stats),
          pw.SizedBox(height: 20),

          // Orders table
          _pdfOrdersTable(orders, dateFormat, timeFormat),
        ],
      ),
    );

    return pdf.save();
  }

  static pw.Widget _pdfHeader(String periodLabel) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              'RestoTrack',
              style: pw.TextStyle(
                fontSize: 22,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Text(
              'Sales Report',
              style: pw.TextStyle(
                fontSize: 16,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.grey700,
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          'Period: $periodLabel',
          style: const pw.TextStyle(fontSize: 11, color: PdfColors.grey600),
        ),
        pw.Text(
          'Generated: ${DateFormat('MMM dd, yyyy hh:mm a').format(DateTime.now())}',
          style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey500),
        ),
        pw.SizedBox(height: 8),
        pw.Divider(thickness: 1),
        pw.SizedBox(height: 12),
      ],
    );
  }

  static pw.Widget _pdfFooter(pw.Context context) {
    return pw.Column(
      children: [
        pw.Divider(thickness: 0.5, color: PdfColors.grey300),
        pw.SizedBox(height: 4),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              'Powered by RestoTrack',
              style: const pw.TextStyle(
                fontSize: 8,
                color: PdfColors.grey500,
              ),
            ),
            pw.Text(
              'Page ${context.pageNumber} of ${context.pagesCount}',
              style: const pw.TextStyle(
                fontSize: 8,
                color: PdfColors.grey500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  static pw.Widget _pdfSummary(SalesReportStats stats) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey100,
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
        children: [
          _pdfSummaryItem(
            'Total Sales',
            'P${stats.totalSales.toStringAsFixed(2)}',
          ),
          _pdfSummaryItem('Orders', '${stats.orderCount}'),
          _pdfSummaryItem(
            'Average Order',
            'P${stats.averageOrderValue.toStringAsFixed(2)}',
          ),
        ],
      ),
    );
  }

  static pw.Widget _pdfSummaryItem(String label, String value) {
    return pw.Column(
      children: [
        pw.Text(
          label,
          style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          value,
          style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
        ),
      ],
    );
  }

  static pw.Widget _pdfOrdersTable(
    List<OrderModel> orders,
    DateFormat dateFormat,
    DateFormat timeFormat,
  ) {
    return pw.TableHelper.fromTextArray(
      border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
      headerStyle: pw.TextStyle(
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
        color: PdfColors.white,
      ),
      headerDecoration: const pw.BoxDecoration(color: PdfColor(0.1, 0.3, 0.18)),
      cellStyle: const pw.TextStyle(fontSize: 9),
      cellAlignment: pw.Alignment.centerLeft,
      cellPadding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      headers: ['Order #', 'Date', 'Time', 'Items', 'Total'],
      columnWidths: {
        0: const pw.FixedColumnWidth(60),
        1: const pw.FixedColumnWidth(90),
        2: const pw.FixedColumnWidth(70),
        3: const pw.FlexColumnWidth(),
        4: const pw.FixedColumnWidth(80),
      },
      data: orders.map((order) {
        final date = order.createdAt != null
            ? dateFormat.format(order.createdAt!)
            : 'N/A';
        final time = order.createdAt != null
            ? timeFormat.format(order.createdAt!)
            : '';
        final items = order.items.map((i) => '${i.name} x${i.quantity}').join(', ');
        return [
          '#${order.orderNumber}',
          date,
          time,
          items,
          'P${order.total.toStringAsFixed(2)}',
        ];
      }).toList(),
    );
  }

  // ── Excel ────────────────────────────────────────────────────────────

  static Future<File> generateExcel({
    required List<OrderModel> orders,
    required SalesReportStats stats,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final excel = Excel.createExcel();
    final dateFormat = DateFormat('MMM dd, yyyy');
    final timeFormat = DateFormat('hh:mm a');
    final startStr = dateFormat.format(startDate);
    final endStr = dateFormat.format(endDate);
    final periodLabel = startStr == endStr ? startStr : '$startStr - $endStr';

    // ── Summary sheet ──
    final summary = excel['Summary'];
    excel.setDefaultSheet('Summary');

    // Title
    summary.appendRow([TextCellValue('RestoTrack - Sales Report')]);
    summary.appendRow([TextCellValue('Period: $periodLabel')]);
    summary.appendRow([
      TextCellValue(
        'Generated: ${DateFormat('MMM dd, yyyy hh:mm a').format(DateTime.now())}',
      ),
    ]);
    summary.appendRow([TextCellValue('')]);

    // Stats
    summary.appendRow([
      TextCellValue('Total Sales'),
      DoubleCellValue(stats.totalSales),
    ]);
    summary.appendRow([
      TextCellValue('Total Orders'),
      IntCellValue(stats.orderCount),
    ]);
    summary.appendRow([
      TextCellValue('Average Order Value'),
      DoubleCellValue(stats.averageOrderValue),
    ]);

    // ── Orders sheet ──
    final ordersSheet = excel['Orders'];

    // Headers
    ordersSheet.appendRow([
      TextCellValue('Order #'),
      TextCellValue('Date'),
      TextCellValue('Time'),
      TextCellValue('Items'),
      TextCellValue('Qty'),
      TextCellValue('Total'),
    ]);

    // Style header row
    for (var col = 0; col < 6; col++) {
      final cell = ordersSheet.cell(
        CellIndex.indexByColumnRow(columnIndex: col, rowIndex: 0),
      );
      cell.cellStyle = CellStyle(
        bold: true,
        backgroundColorHex: ExcelColor.fromHexString('#1A4D2E'),
        fontColorHex: ExcelColor.white,
      );
    }

    // Data rows
    for (final order in orders) {
      final date = order.createdAt != null
          ? dateFormat.format(order.createdAt!)
          : 'N/A';
      final time = order.createdAt != null
          ? timeFormat.format(order.createdAt!)
          : '';
      final items =
          order.items.map((i) => '${i.name} x${i.quantity}').join(', ');

      ordersSheet.appendRow([
        TextCellValue('#${order.orderNumber}'),
        TextCellValue(date),
        TextCellValue(time),
        TextCellValue(items),
        IntCellValue(order.itemCount),
        DoubleCellValue(order.total),
      ]);
    }

    // Remove default Sheet1 if it exists
    if (excel.sheets.containsKey('Sheet1')) {
      excel.delete('Sheet1');
    }

    // Save to file
    final dir = await getApplicationDocumentsDirectory();
    final fileName =
        'SalesReport_${DateFormat('yyyyMMdd_HHmmss').format(DateTime.now())}.xlsx';
    final file = File('${dir.path}/$fileName');
    final bytes = excel.save();
    if (bytes != null) {
      await file.writeAsBytes(bytes);
    }
    return file;
  }
}
