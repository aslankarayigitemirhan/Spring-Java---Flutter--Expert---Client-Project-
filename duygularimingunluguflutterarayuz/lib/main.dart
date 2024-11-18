import 'package:duygularimingunluguflutterarayuz/logIn/UserTypeSelectionPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(
    Directionality(
      textDirection: TextDirection.ltr, // Soldan sağa okuma
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale('tr', 'TR'), // Türkçe dil ve bölge ayarı
      supportedLocales: [
        Locale('tr', 'TR'),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: UserTypeSelectionPage(),
    );
  }
}
