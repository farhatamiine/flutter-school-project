import 'package:Flutter_Showcase/pages/wrapper.dart';
import 'package:Flutter_Showcase/utils/theme.dart';
import 'package:Flutter_Showcase/utils/themeNotifer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(lightTheme),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      title: 'Flutter Showcase',
      debugShowCheckedModeBanner: false,
      theme: themeNotifier.getTheme(),
      home: Wrapper(),
    );
  }
}
