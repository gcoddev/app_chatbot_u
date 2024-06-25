import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import '../constants.dart';
import '../models/Document.dart';
import 'package:chatbot_u/env.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRatio = 1.02,
    required this.document,
    required this.onPress,
  }) : super(key: key);

  final double width, aspectRatio;
  final Document document;
  final VoidCallback onPress;

  Future<void> _downloadPDF(String pdfUrl) async {
    // Solicita permisos
    final status = await Permission.storage.request();
    if (status.isGranted) {
      try {
        // Inicializa FlutterDownloader
        // WidgetsFlutterBinding.ensureInitialized();
        // await FlutterDownloader.initialize(debug: true);

        // Inicia la descarga
        final taskId = await FlutterDownloader.enqueue(
          url: pdfUrl,
          savedDir: '/storage/emulated/0/Download/',
          fileName: '${document.titulo}.pdf',
          showNotification: true,
          openFileFromNotification: true,
        );
        print("Download taskId: $taskId");
      } catch (e) {
        print("Error: $e");
      }
    } else {
      print("Storage permission not granted");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: GestureDetector(
        onTap: () {
          _downloadPDF(
              apiUrl + '/documentos/${document.documento}');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: aspectRatio,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: kSecondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: PDF(
                  swipeHorizontal: false,
                ).cachedFromUrl(
                  apiUrl + '/documentos/${document.documento}',
                  placeholder: (progress) =>
                      Center(child: CircularProgressIndicator(value: progress)),
                  errorWidget: (error) =>
                      Center(child: Text('Error loading PDF')),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              document.titulo,
              style: TextStyle(fontSize: 12.0),
              maxLines: 3,
              softWrap: true,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Descargar',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
