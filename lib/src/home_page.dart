import 'package:flutter/material.dart';

import 'global/local_storage.dart';
import 'widget/base_page.dart';
import 'widget/const/color_palette.dart';
import 'widget/const/page_name.dart';
import 'widget/page_title.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    PageName.get(AppPage.home)!.isAlive = true;
  }

  @override
  void dispose() {
    PageName.get(AppPage.home)!.isAlive = false;
    super.dispose();
  }

  Widget _mainMenus() {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final iconSize = screenWidth / 8;

    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      children: [
        _menu(
          'Accounts',
          Icon(
            size: iconSize.toDouble(),
            Icons.account_balance_wallet_outlined,
          ),
          AppPage.accounts,
        ),
        _menu(
          'Transfer',
          Icon(
            size: iconSize.toDouble(),
            Icons.transform_outlined,
          ),
          AppPage.transfer,
        ),
        _menu(
          'Payments',
          Icon(
            size: iconSize.toDouble(),
            Icons.payments_outlined,
          ),
          AppPage.payments,
        ),
        _menu(
          'Commerce',
          Icon(
            size: iconSize.toDouble(),
            Icons.local_grocery_store_outlined,
          ),
          AppPage.commerce,
        ),
        _menu(
          'Investments',
          Icon(
            size: iconSize.toDouble(),
            Icons.bar_chart_outlined,
          ),
          AppPage.investments,
        ),
        _menu(
          'NFC',
          Icon(
            size: iconSize.toDouble(),
            Icons.nfc_outlined,
          ),
          AppPage.nfc,
        ),
        _menu(
          'Support',
          Icon(
            size: iconSize.toDouble(),
            Icons.contact_phone_outlined,
          ),
          AppPage.contact,
        ),
        _menu(
          'More',
          Icon(
            size: iconSize.toDouble(),
            Icons.more_horiz_outlined,
          ),
          AppPage.home,
        ),
      ],
    );
  }

  Widget _news() {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        color: Colors.grey.withOpacity(.33),
        child: Center(
          child: Text(
            'News',
            style: TextStyle(
              color: Colors.grey.withOpacity(.67),
            ),
          ),
        ),
      ),
    );
  }

  Widget _menu(String label, Icon icon, AppPage page,
      {bool hideLabel = false}) {
    return InkWell(
      onTap: () => PageName.goto(page, context),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.deep),
          color: const Color(0x7FFFFFFF),
        ),
        child: Column(
          mainAxisAlignment: hideLabel
              ? MainAxisAlignment.center
              : MainAxisAlignment.spaceBetween,
          children: hideLabel
              ? [icon]
              : [
                  const SizedBox(height: 12),
                  icon,
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: RichText(
                      text: TextSpan(
                        text: label,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      const PageTitle('metro', 'bank'),
      [
        _mainMenus(),
        const SizedBox(height: 20),
        _news(),
      ],
      backButtonLabel: 'Logout',
      showUserpanel: true,
      username: AppStorage.username,
    );
  }
}
