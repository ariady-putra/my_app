import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'widget/base_page.dart';
import 'widget/clipper/rrect_frame.dart';
import 'widget/const/page_name.dart';
import 'widget/page_title.dart';

class QrisPage extends StatefulWidget {
  const QrisPage({super.key});

  @override
  State<QrisPage> createState() => _QrisPageState();
}

class _QrisPageState extends State<QrisPage> {
  final qrControl = MobileScannerController(formats: [BarcodeFormat.qrCode]);

  @override
  void initState() {
    super.initState();
    PageName.get(AppPage.qris)!.isAlive = true;
  }

  @override
  void dispose() {
    PageName.get(AppPage.qris)!.isAlive = false;
    super.dispose();
  }

  IconData camflashIcon = Icons.no_flash_outlined;
  void _turnCamFlashOff() {
    // print('Turning camera flash off');
    if (camflashIcon == Icons.flash_on_outlined) {
      qrControl.toggleTorch();
    }
  }

  String? qris;
  Widget _qrCodeScanner() {
    final contextSize = MediaQuery.of(context).size;
    final sW = contextSize.width;
    final sH = contextSize.height;

    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Stack(
            children: [
              ClipPath(
                clipper: RRectFrame(16),
                child: MobileScanner(
                  onDetect: (barcode, args) => setState(
                    () {
                      qris = barcode.rawValue;
                    },
                  ),
                  controller: qrControl,
                ),
              ),
              Positioned(
                bottom: 8,
                right: 8,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).canvasColor,
                  ),
                  child: IconButton(
                    splashRadius: 8,
                    onPressed: () => qrControl.toggleTorch(),
                    icon: ValueListenableBuilder(
                      valueListenable: qrControl.torchState,
                      builder: (context, value, child) {
                        IconData flashIcon;
                        switch (value) {
                          case TorchState.off:
                            flashIcon = Icons.flash_off_outlined;
                            break;
                          case TorchState.on:
                            flashIcon = Icons.flash_on_outlined;
                            break;
                          default:
                            flashIcon = Icons.no_flash_outlined;
                            break;
                        }
                        // setState(
                        //   () {
                        camflashIcon = flashIcon;
                        //   },
                        // );
                        return Icon(flashIcon);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Text(qris ?? 'QR Code'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      const PageTitle('scan', 'qris'),
      [
        _qrCodeScanner(),
      ],
      onNavPageChange: _turnCamFlashOff,
    );
  }
}
