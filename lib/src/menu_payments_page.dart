import 'package:flutter/material.dart';

import 'widget/base_page.dart';
import 'widget/const/color_palette.dart';
import 'widget/const/page_name.dart';
import 'widget/padded_row.dart';
import 'widget/page_title.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({super.key});

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  @override
  void initState() {
    super.initState();
    PageName.get(AppPage.payments)!.isAlive = true;
  }

  @override
  void dispose() {
    PageName.get(AppPage.payments)!.isAlive = false;
    super.dispose();
  }

  Widget _menuLoans() {
    return PaddedRow(
      'Credit cards',
      Icon(
        Icons.credit_card_outlined,
        color: Colors.lime.shade900,
      ),
      tapAction: () {},
    );
  }

  Widget _menuUtilities() {
    return PaddedRow(
      'Utilities',
      Icon(
        Icons.wb_incandescent_outlined,
        color: Colors.amberAccent.shade700,
      ),
      tapAction: () {},
    );
  }

  Widget _menuInternet() {
    return PaddedRow(
      'Internet',
      const Icon(
        Icons.wifi_outlined,
        color: Colors.indigoAccent,
      ),
      tapAction: () {},
    );
  }

  Widget _menuCableTV() {
    return PaddedRow(
      'Cable TV',
      const Icon(
        Icons.live_tv_outlined,
        color: Colors.pink,
      ),
      tapAction: () {},
    );
  }

  Widget _menuCellphones() {
    return PaddedRow(
      'Cellphones',
      Icon(
        Icons.phone_android_outlined,
        color: Colors.greenAccent.shade700,
      ),
      tapAction: () {},
    );
  }

  Widget _menuLandlines() {
    return PaddedRow(
      'Landlines',
      const Icon(
        Icons.phone_outlined,
        color: Colors.teal,
      ),
      tapAction: () {},
    );
  }

  Widget _menuInsurance() {
    return PaddedRow(
      'Insurance',
      const Icon(
        Icons.health_and_safety_outlined,
        color: Colors.redAccent,
      ),
      tapAction: () {},
    );
  }

  Widget _menuOthers() {
    return PaddedRow(
      'Others',
      const Icon(
        Icons.more_vert_outlined,
        color: AppColor.deep,
      ),
      tapAction: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      const PageTitle('bill', 'payments'),
      [
        _menuLoans(),
        const Divider(),
        _menuInternet(),
        const Divider(),
        _menuCableTV(),
        const Divider(),
        _menuCellphones(),
        const Divider(),
        _menuLandlines(),
        const Divider(),
        _menuUtilities(),
        const Divider(),
        _menuInsurance(),
        const Divider(),
        _menuOthers(),
      ],
    );
  }
}
