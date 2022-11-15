import 'package:flutter/material.dart';

import 'widget/base_page.dart';
import 'widget/const/page_name.dart';
import 'widget/page_title.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
    PageName.get(AppPage.history)!.isAlive = true;
  }

  @override
  void dispose() {
    PageName.get(AppPage.history)!.isAlive = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      const PageTitle('transactions', 'history'),
      [],
    );
  }
}
