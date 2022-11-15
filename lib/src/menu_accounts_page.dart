import 'dart:math';

import 'package:flutter/material.dart';

import 'widget/base_page.dart';
import 'widget/const/page_name.dart';
import 'widget/page_title.dart';
import 'widget/account_card.dart';

class AccountsPage extends StatefulWidget {
  const AccountsPage({super.key});

  @override
  State<AccountsPage> createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  @override
  void initState() {
    super.initState();
    PageName.get(AppPage.accounts)!.isAlive = true;
  }

  @override
  void dispose() {
    PageName.get(AppPage.accounts)!.isAlive = false;
    super.dispose();
  }
  
  Widget _accounts() {
    final ctxMediaQuery = MediaQuery.of(context);
    final ctxMediaQuerySize = ctxMediaQuery.size;
    final sW = ctxMediaQuerySize.width;
    final sH = ctxMediaQuerySize.height;
    final nr = .0625 * min(sW, sH); // num font size

    return GridView(
      // padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        crossAxisSpacing: 0,
        mainAxisSpacing: 16,
        childAspectRatio: 780 / 487,
      ),
      children: [
        AccountCard(
          'Savings',
          '1234 5678 9012 3456',
          'Rp 123 456 789',
          formattedDate: '12/34',
          nrSize: nr,
        ),
        AccountCard(
          'Current',
          '2468 1632 6412 8256',
          'Rp 2 468 163 264',
          formattedDate: '06/36',
          nrSize: nr,
        ),
        AccountCard(
          'Checking',
          '3693 6936 9369 3693',
          'Rp 36 936 936',
          formattedDate: '03/33',
          nrSize: nr,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      const PageTitle('my', 'accounts'),
      [
        _accounts(),
      ],
    );
  }
}
