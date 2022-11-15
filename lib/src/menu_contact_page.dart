import 'package:flutter/material.dart';
import 'package:my_app/src/widget/loading_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'widget/base_page.dart';
import 'widget/const/page_name.dart';
import 'widget/entry_label.dart';
import 'widget/padded_row.dart';
import 'widget/page_title.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  void initState() {
    super.initState();
    PageName.get(AppPage.contact)!.isAlive = true;
  }

  @override
  void dispose() {
    PageName.get(AppPage.contact)!.isAlive = false;
    super.dispose();
  }

  Widget _call() {
    return PaddedRow(
      'Call 14045',
      const Icon(Icons.call_outlined),
      tapAction: () => launchUrl(
        Uri(
          scheme: 'tel',
          path: '14045',
        ),
      ),
    );
  }

  Widget _mail() {
    return PaddedRow(
      'Email support@metro.bank',
      const Icon(Icons.mail_outlined),
      tapAction: () => launchUrl(
        Uri(
          scheme: 'mailto',
          path: 'support@metro.bank',
        ),
      ),
    );
  }

  Widget _chat() {
    return PaddedRow(
      'Live chat',
      const Icon(Icons.chat_outlined),
      tapAction: () {},
    );
  }

  bool _isMapLoading = true;
  Widget _maps() {
    const String scheme = 'https';
    const String url = 'www.google.com/maps/search/Metro+Bank';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const EntryLabel('Our branches'),
        Stack(
          children: [
            AspectRatio(
              aspectRatio: .5,
              child: WebView(
                initialUrl: '$scheme://$url',
                javascriptMode: JavascriptMode.unrestricted,
                onPageFinished: (_) => setState(
                  () {
                    _isMapLoading = false;
                  },
                ),
              ),
            ),
            AspectRatio(
              aspectRatio: .5,
              child: InkWell(
                onTap: () => launchUrl(
                  Uri(
                    scheme: scheme,
                    path: url,
                  ),
                  mode: LaunchMode.externalApplication,
                ),
                child: !_isMapLoading
                    ? null
                    : const AspectRatio(
                        aspectRatio: 1,
                        child: LoadingIndicator(),
                      ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      const PageTitle('contact', 'support'),
      [
        _call(),
        const Divider(),
        _mail(),
        const Divider(),
        _chat(),
        const Divider(),
        _maps(),
      ],
    );
  }
}
