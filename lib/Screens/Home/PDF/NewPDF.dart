//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:printing/printing.dart';
//
// import 'data.dart';
//
// class NewPDF extends StatelessWidget  {
//   int _tab = 0;
//   TabController? _tabController;
//
//   PrintingInfo? printingInfo;
//
//   var _data = const CustomData();
//   var _hasData = false;
//   var _pending = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _init();
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//   }
//
//   Future<void> _init() async {
//     final info = await Printing.info();
//
//
//
//     setState(() {
//       printingInfo = info;
//     });
//   }
//
//   void _showPrintedToast(BuildContext context) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Document printed successfully'),
//       ),
//     );
//   }
//
//   void _showSharedToast(BuildContext context) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Document shared successfully'),
//       ),
//     );
//   }
//
//   Future<void> _saveAsFile(
//       BuildContext context,
//       LayoutCallback build,
//       PdfPageFormat pageFormat,
//       ) async {
//     final bytes = await build(pageFormat);
//
//     final appDocDir = await getApplicationDocumentsDirectory();
//     final appDocPath = appDocDir.path;
//     final file = File(appDocPath + '/' + 'document.pdf');
//     print('Save as file ${file.path} ...');
//     await file.writeAsBytes(bytes);
//     await OpenFile.open(file.path);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     pw.RichText.debug = true;
//
//     if (_tabController == null) {
//       return const Center(child: CircularProgressIndicator());
//     }
//
//     final actions = <PdfPreviewAction>[
//       if (!kIsWeb)
//         PdfPreviewAction(
//           icon: const Icon(Icons.save),
//           onPressed: _saveAsFile,
//         )
//     ];
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Flutter PDF Demo'),
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: examples.map<Tab>((e) => Tab(text: e.name)).toList(),
//           isScrollable: true,
//         ),
//       ),
//       body: PdfPreview(
//         maxPageWidth: 700,
//         build: (format) => examples[_tab].builder(format, _data),
//         actions: actions,
//         onPrinted: _showPrintedToast,
//         onShared: _showSharedToast,
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.deepOrange,
//         onPressed: _showSources,
//         child: const Icon(Icons.code),
//       ),
//     );
//   }
//
//   void _showSources() {
//     ul.launchUrl(
//       Uri.parse(
//         'https://github.com/DavBfr/dart_pdf/blob/master/demo/lib/examples/${examples[_tab].file}',
//       ),
//     );
//   }
//
//   Future<String?> askName(BuildContext context) {
//     return showDialog<String>(
//         barrierDismissible: false,
//         context: context,
//         builder: (context) {
//           final controller = TextEditingController();
//
//           return AlertDialog(
//             title: const Text('Please type your name:'),
//             contentPadding: const EdgeInsets.symmetric(horizontal: 20),
//             content: TextField(
//               decoration: const InputDecoration(hintText: '[your name]'),
//               controller: controller,
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   if (controller.text != '') {
//                     Navigator.pop(context, controller.text);
//                   }
//                 },
//                 child: const Text('OK'),
//               ),
//             ],
//           );
//         });
//   }
// }
