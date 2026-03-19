import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:provider/provider.dart';
import 'package:thel_dawasa/screens/results_screen.dart';

import '../providers/language_provider.dart';

class ScannerScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  const ScannerScreen({super.key, required this.cameras});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  late CameraController _controller;
  final TextRecognizer _textRecognizer = TextRecognizer();
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.cameras[0],
      ResolutionPreset.high,
      enableAudio: false, // Disables microphone access
    );
    _controller.initialize().then((_) {
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _textRecognizer.close();
    super.dispose();
  }

  Future<void> _scanImage() async {
    if (_isProcessing) return;
    setState(() => _isProcessing = true);

    try {
      final image = await _controller.takePicture();
      final inputImage = InputImage.fromFilePath(image.path);
      final RecognizedText recognizedText = await _textRecognizer.processImage(
        inputImage,
      );

      String? numberPlate;
      for (TextBlock block in recognizedText.blocks) {
        for (TextLine line in block.lines) {
          String text = line.text.replaceAll(RegExp(r'[^A-Z0-9-]'), '');
          if (text.length >= 4) {
            numberPlate = text;
          }
        }
      }

      if (numberPlate != null) {
        _processResult(numberPlate);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Poddak hariyata allanna malli... can't see the plate!",
            ),
          ),
        );
      }
    } catch (e) {
      debugPrint("Error scanning: $e");
    } finally {
      setState(() => _isProcessing = false);
    }
  }

  void _processResult(String plate) {
    String digitsOnly = plate.replaceAll(RegExp(r'[^0-9]'), '');
    if (digitsOnly.isEmpty) return;

    int lastDigit = int.parse(digitsOnly[digitsOnly.length - 1]);
    int todayDate = DateTime.now().day;

    bool isTodayEven = todayDate % 2 == 0;
    bool isDigitEven = lastDigit % 2 == 0;

    bool success = isTodayEven == isDigitEven;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ResultScreen(success: success, lastDigit: lastDigit),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context);
    if (!_controller.value.isInitialized) return Container();
    return Scaffold(
      body: Stack(
        children: [
          CameraPreview(_controller),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: FloatingActionButton.extended(
                backgroundColor: Colors.yellow[800],
                onPressed: _scanImage,
                label: _isProcessing
                    ? const CircularProgressIndicator(color: Colors.black)
                    : Text(
                        langProvider.getText('capture_btn_text'),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Center(
            child: Container(
              width: 300,
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.yellow, width: 3),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
