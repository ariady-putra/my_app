import 'dart:math';

import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

import 'global/local_storage.dart';
import 'widget/button/default_button.dart';
import 'widget/const/color_palette.dart';
import 'widget/const/page_name.dart';
import 'widget/entry_field.dart';
import 'widget/msg_box.dart';
import 'widget/page_title.dart';

class LoginPage extends StatefulWidget {
  static bool blockingInstance = false;

  final Function()? onSuccess;

  const LoginPage({this.onSuccess, super.key});

  @override
  State<LoginPage> createState() => _LoginPageState(onSuccess);
}

class _LoginPageState extends State<LoginPage> {
  final Function()? _successAction;

  _LoginPageState(this._successAction);

  final Color _foreColor = Colors.white.withOpacity(.9);

  final _loginForm = GlobalKey<FormState>();
  final _username = TextEditingController();

  final _sensor = LocalAuthentication();

  @override
  void initState() {
    super.initState();

    _username.text = AppStorage.username;
    PageName.get(AppPage.login)!.isAlive = true;
  }

  @override
  void dispose() {
    PageName.get(AppPage.login)!.isAlive = false;
    _username.dispose();

    super.dispose();
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: [
        EntryField(
          'Username',
          color: _foreColor,
          control: _username,
          validator: (value) => value == null || value.isEmpty
              ? 'Username cannot be empty'
              : null,
        ),
        EntryField(
          'Password',
          color: _foreColor,
          isPassword: true,
          validator: (value) => value == null || value.isEmpty
              ? 'Password cannot be empty'
              : null,
        ),
      ],
    );
  }

  Widget _signin() {
    return DefaultButton(
      'Login',
      tapAction: () {
        if (_loginForm.currentState!.validate()) {
          AppStorage.cfg // set variable and write file
              .setItem('username', AppStorage.username = _username.text);
          if (_successAction == null) {
            PageName.goto(AppPage.home, context);
          } else {
            _successAction!();
          }
        }
      },
    );
  }

  Widget _forgotPassword() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.centerRight,
      child: InkWell(
        // onTap: () => Navigator.pop(context),
        child: Text(
          'Forgot Password ?',
          style: TextStyle(color: _foreColor),
        ),
      ),
    );
  }

  Future<bool> _doBiometricAuthentication() async {
    return await _sensor.authenticate(
      localizedReason: '',
      options: const AuthenticationOptions(
        biometricOnly: true,
        stickyAuth: true,
      ),
    );
  }

  void _handleBiometricAuthenticationError(error) {
    try {
      MsgBox.showAlertDialogOK(
        context,
        DialogIcon.error,
        error.message,
      );
    } catch (_) {
      MsgBox.showAlertDialogOK(
        context,
        DialogIcon.error,
        error.toString(),
      );
    }
  }

  Widget _signinBiometric() {
    final ctxMediaQuery = MediaQuery.of(context);
    final ctxMediaQuerySize = ctxMediaQuery.size;
    final sW = ctxMediaQuerySize.width;
    final sH = ctxMediaQuerySize.height;
    final thumbSize = .25 * min(sW, sH);

    return Container(
      margin: const EdgeInsets.only(
        top: 40,
        bottom: 40,
      ),
      child: Column(
        children: [
          Text(
            'Quick Login',
            style: TextStyle(
              color: _foreColor,
              fontWeight: FontWeight.bold,
              fontSize: .25 * thumbSize,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              if (AppStorage.username == '') {
                MsgBox.showAlertDialogOK(
                  context,
                  DialogIcon.warn,
                  'No saved login data\n',
                  postfix: '\nPlease login using password',
                );
                return;
              }

              _doBiometricAuthentication().then(
                onError: _handleBiometricAuthenticationError,
                (value) => !value
                    ? MsgBox.showAlertDialogOK(
                        context,
                        DialogIcon.warn,
                        'Authentication Failed\n',
                        postfix: '\nPlease try again, or login using password',
                      )
                    : _successAction == null
                        ? PageName.goto(AppPage.home, context)
                        : _successAction!(),
              );
            },
            borderRadius: BorderRadius.circular(thumbSize),
            child: Icon(
              Icons.fingerprint,
              size: thumbSize,
              color: _foreColor,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'tap here',
            style: TextStyle(
              color: _foreColor,
              fontWeight: FontWeight.w500,
              fontSize: .15 * thumbSize,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ctxMediaQuery = MediaQuery.of(context);
    final ctxMediaQuerySize = ctxMediaQuery.size;
    // final sW = ctxMediaQuerySize.width;
    final sH = ctxMediaQuerySize.height;

    return Scaffold(
      backgroundColor: AppColor.deep,
      body: WillPopScope(
        onWillPop: () async => !PageName.get(AppPage.home)!.isAlive,
        child: SizedBox(
          height: sH,
          child: Form(
            key: _loginForm,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  PageTitle(
                    'mii',
                    'mo',
                    firstColor: Colors.black.withOpacity(.8),
                    secondColor: Colors.white.withOpacity(.9),
                  ),
                  const SizedBox(height: 20),
                  _emailPasswordWidget(),
                  const SizedBox(height: 20),
                  _signin(),
                  _forgotPassword(),
                  const SizedBox(height: 20),
                  Divider(
                    color: _foreColor,
                    thickness: 2,
                    height: 2,
                  ),
                  _signinBiometric(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
