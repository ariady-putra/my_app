import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:universal_platform/universal_platform.dart';

import 'src/widget/const/page_name.dart';

Future setDesktopWindow() async {
  const s = Size(432, 864);

  await DesktopWindow.setMinWindowSize(s);
  await DesktopWindow.setWindowSize(s);
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  if (UniversalPlatform.isDesktop) {
    setDesktopWindow();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
          bodyText1: GoogleFonts.montserrat(
            textStyle: textTheme.bodyText1,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: PageName.get(AppPage.welcome)!.page,
      // https://github.com/TheAlphamerc/flutter_login_signup
    );
  }
}
