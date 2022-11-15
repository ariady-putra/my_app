import 'package:flutter/material.dart';

import '../../home_page.dart';
import '../../login_page.dart';
// TODO: import '../../register_page.dart';
import '../../welcome_page.dart';

import '../../menu_accounts_page.dart';
import '../../menu_commerce_page.dart';
import '../../menu_history_page.dart';
import '../../menu_investments_page.dart';
import '../../menu_nfc_page.dart';
import '../../menu_payments_page.dart';
import '../../menu_qris_page.dart';
import '../../menu_contact_page.dart';
import '../../menu_transfer_page.dart';

enum AppPage {
  welcome,
  // register,
  login,
  home,
  accounts,
  commerce,
  contact,
  history,
  investments,
  nfc,
  payments,
  qris,
  transfer,
}

class PageName {
  final String _name;
  final Widget _page;
  bool isAlive = false;

  String get name => _name;
  Widget get page => _page;

  PageName(this._page, this._name);

  static final Map<AppPage, PageName> _pages = {
    AppPage.welcome: PageName(const WelcomePage(), '/welcome'),
    // TODO: AppPage.register: PageName(const RegisterPage(), '/register'),
    AppPage.login: PageName(const LoginPage(), '/login'),
    AppPage.home: PageName(const HomePage(), '/home'),

    AppPage.accounts: PageName(const AccountsPage(), '/accounts'),
    AppPage.commerce: PageName(const CommercePage(), '/commerce'),
    AppPage.contact: PageName(const ContactPage(), '/contact'),
    AppPage.history: PageName(const HistoryPage(), '/history'),
    AppPage.investments: PageName(const InvestmentsPage(), '/investments'),
    AppPage.nfc: PageName(const NfcPage(), '/nfc'),
    AppPage.payments: PageName(const PaymentsPage(), '/payments'),
    AppPage.qris: PageName(const QrisPage(), '/qris'),
    AppPage.transfer: PageName(const TransferPage(), '/transfer'),
  };

  static PageName? get(AppPage page) {
    return _pages[page];
  }

  static dynamic goto(AppPage page, BuildContext context,
      {Function()? onPageChange}) {
    final nav = get(page)!;

    if (nav.name == ModalRoute.of(context)!.settings.name) return;
    if (onPageChange != null) onPageChange();

    return nav.isAlive
        ? Navigator.of(context).popUntil(
            (route) => route.settings.name == nav.name,
          )
        : Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => nav.page,
              settings: RouteSettings(name: nav.name),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(
                opacity: animation,
                child: child,
              ),
              transitionDuration: const Duration(milliseconds: 150),
              reverseTransitionDuration: const Duration(milliseconds: 150),
            ),
          );
  }
}
