import 'dart:math';

import 'package:flutter/material.dart';

import 'bezier_container.dart';
import 'button/prev_button.dart';
import 'const/color_palette.dart';
import 'const/page_name.dart';
import 'page_title.dart';

class BasePage extends StatelessWidget {
  final PageTitle title;
  final List<Widget> children;
  final String backButtonLabel;
  final bool showUserpanel;
  final String username;
  final Function()? onNavPageChange;

  const BasePage(
    this.title,
    this.children, {
    this.backButtonLabel = 'Back',
    this.showUserpanel = false,
    this.username = '',
    this.onNavPageChange,
    super.key,
  });

  Widget _customBg(BuildContext context) {
    return Positioned(
      top: -MediaQuery.of(context).size.height * .15,
      right: -MediaQuery.of(context).size.width * .4,
      child: const BezierContainer(),
    );
  }

  Widget _customAppBar(BuildContext context) {
    return Positioned(
      top: 35,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          PrevButton(label: backButtonLabel),
          _userPanel(),
        ],
      ),
    );
  }

  Widget _userPanel() {
    return Row(
      children: !showUserpanel
          ? []
          : [
              _greetings(),
              _notifications(),
            ],
    );
  }

  Widget _greetings() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(color: Colors.black),
        children: [
          const TextSpan(text: ' Hello '),
          TextSpan(
            text: username,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _notifications() {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              child: const Icon(Icons.notifications),
            ),
          ],
        ),
      ),
    );
  }

  Widget _contentArea(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(
          20, 80, 20, .1 * MediaQuery.of(context).size.height),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: Container(
          constraints: BoxConstraints(
              minHeight: .9 * MediaQuery.of(context).size.height - 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // const SizedBox(height: 20),
              title,
              const SizedBox(height: 20),
              Column(children: children),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Gradient _navBgColor(BuildContext context) {
    // final bool isHomePage = ModalRoute.of(context)!.settings.name ==
    //     PageName.get(AppPage.home)!.name;
    final bool isQrisPage = ModalRoute.of(context)!.settings.name ==
        PageName.get(AppPage.qris)!.name;
    final bool isHistoryPage = ModalRoute.of(context)!.settings.name ==
        PageName.get(AppPage.history)!.name;

    return LinearGradient(
      colors: isQrisPage
          ? [
              AppColor.deep,
              AppColor.lite,
              AppColor.deep,
            ]
          : isHistoryPage
              ? [
                  AppColor.deep,
                  AppColor.lite,
                ]
              : [
                  AppColor.lite,
                  AppColor.deep,
                ],
      transform: const GradientRotation(-pi / 3.5),
    );
  }

  Color _navButtonColor(BuildContext context, String pagePath,
      {Color highlight = AppColor.deep, Color normal = Colors.black}) {
    return ModalRoute.of(context)!.settings.name == pagePath
        ? highlight
        : normal;
  }

  Shadow _glow(double opacity) {
    return Shadow(
      blurRadius: 10,
      color: Colors.white.withOpacity(opacity),
      offset: const Offset(1, 1),
    );
  }

  Widget _customNavBar(BuildContext context) {
    final contextSize = MediaQuery.of(context).size;
    final sW = contextSize.width;
    final sH = .1 * contextSize.height;

    final homeColor = _navButtonColor(
      context,
      PageName.get(AppPage.home)!.name,
      highlight: AppColor.dark,
    );
    final qrisColor = _navButtonColor(
      context,
      PageName.get(AppPage.qris)!.name,
      highlight: AppColor.darker,
    );
    final histColor = _navButtonColor(
      context,
      PageName.get(AppPage.history)!.name,
      highlight: AppColor.darkest,
    );

    return Positioned(
      bottom: 0,
      width: sW,
      height: sH,
      child: Container(
        decoration: BoxDecoration(
          gradient: _navBgColor(context),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade800,
              blurRadius: .08 * sH,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            _navMenu(
              context,
              'Home',
              Icon(
                Icons.home_outlined,
                color: homeColor,
                size: .4 * sH,
                shadows: [_glow(.6)],
              ),
              homeColor,
              _glow(.6),
              AppPage.home,
            ),
            _navMenu(
              context,
              'QRIS',
              Icon(
                Icons.qr_code_scanner_outlined,
                color: qrisColor,
                size: .5 * sH,
                shadows: [_glow(.7)],
              ),
              qrisColor,
              _glow(.7),
              AppPage.qris,
            ),
            _navMenu(
              context,
              'History',
              Icon(
                Icons.history_edu_outlined,
                color: histColor,
                size: .4 * sH,
                shadows: [_glow(.5)],
              ),
              histColor,
              _glow(.5),
              AppPage.history,
            ),
          ],
        ),
      ),
    );
  }

  Widget _navMenu(BuildContext context, String label, Icon icon, Color color,
      Shadow glow, AppPage targetPage,
      {bool hideLabel = false}) {
    final contextSize = MediaQuery.of(context).size;
    final sW = contextSize.width;
    final sH = contextSize.height;
    final iconLabel = [
      icon,
      Padding(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * .01),
        child: RichText(
          text: TextSpan(
            text: hideLabel ? '' : label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              shadows: [glow],
              color: color,
            ),
          ),
        ),
      ),
    ];

    return Expanded(
      child: InkWell(
        onTap: () =>
            PageName.goto(targetPage, context, onPageChange: onNavPageChange),
        child: sW > sH
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: iconLabel,
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: iconLabel,
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            _customBg(context),
            _customAppBar(context),
            _contentArea(context),
            _customNavBar(context),
          ],
        ),
      ),
    );
  }
}
