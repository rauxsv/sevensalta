import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sevensalta/generated/codegen_loader.g.dart';
import 'package:sevensalta/pages/register_form_page.dart';

void main() async {
  await _initializeApp();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('kk'), Locale('en'), Locale('ru')],
      path: 'assets/translations',
      fallbackLocale: Locale('ru'),
      assetLoader: const CodegenLoader(),
      child: const MyApp(),
    ),
  );
}

Future<void> _initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: RegisterFormPage(),
    );
  }
}
