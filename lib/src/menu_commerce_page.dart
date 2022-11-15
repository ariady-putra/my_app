import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'widget/base_page.dart';
import 'widget/const/page_name.dart';
import 'widget/loading_indicator.dart';
import 'widget/padded_row.dart';
import 'widget/page_title.dart';

class CommercePage extends StatefulWidget {
  const CommercePage({super.key});

  @override
  State<CommercePage> createState() => _CommercePageState();
}

class _CommercePageState extends State<CommercePage> {
  @override
  void initState() {
    super.initState();
    PageName.get(AppPage.commerce)!.isAlive = true;
  }

  @override
  void dispose() {
    PageName.get(AppPage.commerce)!.isAlive = false;
    super.dispose();
  }

  Widget _menu(String label, String url, dynamic tapAction) {
    return PaddedRow(
      label,
      CachedNetworkImage(
        imageUrl: url,
        width: 24,
        height: 24,
        placeholder: (context, url) => const LoadingIndicator(),
        errorWidget: (context, url, error) => const Icon(
          Icons.local_grocery_store_outlined,
          color: Colors.red,
        ),
      ),
      tapAction: tapAction,
    );
  }

  Widget _tokopedia() {
    return _menu(
      'Tokopedia',
      'https://ecs7.tokopedia.net/assets-tokopedia-lite/prod/icon144.png',
      () {},
    );
  }

  Widget _shopee() {
    return _menu(
      'Shopee',
      'https://deo.shopeemobile.com/shopee/shopee-appdlpage-live-id/favicon.ico',
      () {},
    );
  }

  Widget _lazada() {
    return _menu(
      'Lazada',
      'https://laz-img-cdn.alicdn.com/tfs/TB1ODo.f2b2gK0jSZK9XXaEgFXa-64-64.png',
      () {},
    );
  }

  Widget _jdid() {
    return _menu(
      'JD.ID',
      'https://www.jd.id/favicon.ico',
      () {},
    );
  }

  Widget _bukalapak() {
    return _menu(
      'Bukalapak',
      'https://s2.bukalapak.com/marketplace/favicon-new.ico',
      () {},
    );
  }

  Widget _blibli() {
    return _menu(
      'Blibli',
      'https://www.static-src.com/frontend/static/icons/blibli-favicon.png',
      () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      const PageTitle('e', 'commerce'),
      [
        _tokopedia(),
        const Divider(),
        _shopee(),
        const Divider(),
        _lazada(),
        const Divider(),
        _jdid(),
        const Divider(),
        _bukalapak(),
        const Divider(),
        _blibli(),
      ],
    );
  }
}
