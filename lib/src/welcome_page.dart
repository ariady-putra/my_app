import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_app/src/login_page.dart';

import 'global/local_storage.dart';
import 'widget/button/default_button.dart';
import 'widget/const/color_palette.dart';
import 'widget/const/page_name.dart';
import 'widget/page_title.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with WidgetsBindingObserver {
  bool isReady = false;

  @override
  void initState() {
    super.initState();
    PageName.get(AppPage.welcome)!.isAlive = true;
    WidgetsBinding.instance.addObserver(this);
    _maybeSkipWelcome();
  }

  @override
  void dispose() {
    PageName.get(AppPage.welcome)!.isAlive = false;
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        _maybeSkipWelcome(
          skipAction: !PageName.get(AppPage.home)!.isAlive
              ? null
              : () {
                  return LoginPage.blockingInstance
                      ? null // do not popup another Login Dialog
                      : Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              LoginPage.blockingInstance = true;
                              return LoginPage(
                                onSuccess: () {
                                  LoginPage.blockingInstance = false;
                                  return Navigator.pop(context);
                                },
                              );
                            },
                          ),
                        );
                },
        );
        break;
      default:
        break;
    }
  }

  void _maybeSkipWelcome({Function()? skipAction}) {
    AppStorage.cfg.ready.whenComplete(
      () {
        final username = AppStorage.cfg.getItem('username');
        if (username is String) {
          AppStorage.username = username;
          if (skipAction == null) {
            PageName.goto(AppPage.login, context);
          } else {
            skipAction();
          }
        }
        setState(
          () {
            isReady = true;
          },
        );
      },
    );
  }

  Widget _companyLogo() {
    final ctxMediaQuery = MediaQuery.of(context);
    final ctxMediaQuerySize = ctxMediaQuery.size;
    final sW = ctxMediaQuerySize.width;
    final sH = ctxMediaQuerySize.height;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.align_horizontal_right_outlined,
              color: Colors.white.withOpacity(.9),
              size: min(sW, sH) / 5,
              shadows: [
                Shadow(
                  blurRadius: 10,
                  color: Colors.white.withOpacity(.9),
                  offset: const Offset(1, 1),
                ),
              ],
            ),
            Icon(
              Icons.align_horizontal_left_outlined,
              color: Colors.black.withOpacity(.8),
              size: min(sW, sH) / 5,
              shadows: [
                Shadow(
                  blurRadius: 10,
                  color: Colors.white.withOpacity(.8),
                  offset: const Offset(1, 1),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _signin() {
    return DefaultButton(
      'Login',
      tapAction: () => PageName.goto(AppPage.login, context),
    );
  }

  Widget _signup() {
    return const DefaultButton('Register');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.deep,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  _companyLogo(),
                  PageTitle(
                    'bank',
                    'logo',
                    firstColor: Colors.black.withOpacity(.8),
                    secondColor: Colors.white.withOpacity(.9),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: !isReady
                    ? []
                    : [
                        _signin(),
                        const SizedBox(height: 20),
                        _signup(),
                      ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
