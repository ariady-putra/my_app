import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

import 'widget/base_page.dart';
import 'widget/const/page_name.dart';
import 'widget/page_title.dart';

class NfcPage extends StatefulWidget {
  const NfcPage({super.key});

  @override
  State<NfcPage> createState() => _NfcPageState();
}

class _NfcPageState extends State<NfcPage> {
  bool _isNfcAvailable = false;
  final ValueNotifier _nfc = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    PageName.get(AppPage.nfc)!.isAlive = true;
    NfcManager.instance.isAvailable().then(
          (value) => setState(
            () {
              if (_isNfcAvailable = value) {
                NfcManager.instance.startSession(
                  onDiscovered: (tag) async {
                    _nfc.value = tag;
                  },
                );
              }
            },
          ),
        );
  }

  @override
  void dispose() {
    PageName.get(AppPage.nfc)!.isAlive = false;
    NfcManager.instance.stopSession();
    super.dispose();
  }

  Widget _readNFC() {
    return ValueListenableBuilder(
      valueListenable: _nfc,
      builder: (context, value, child) {
        if (value == null) return const Text('Scanning for NFC...');
        // IsoDep isoDep = IsoDep.from(value)!;
        // isoDep
        //     .transceive(
        //       data: Uint8List.fromList([]),
        //     )
        //     .then(
        //       (value) => null,
        //     );
        return Text('${value.data}');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      const PageTitle('read', 'nfc'),
      [
        !_isNfcAvailable
            ? const Text('NFC Reader is currently turned off or not available')
            : _readNFC(),
      ],
    );
  }
}
