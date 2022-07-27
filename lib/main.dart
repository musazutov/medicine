import 'package:flutter/material.dart';
import 'package:testtask/utils/route_generator.dart';
import 'package:testtask/utils/variables.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test App',
      theme: ThemeData(
        // primarySwatch: Colors.blue,
        colorScheme: const ColorScheme.light(
          primary: Color(0xff5B67CA),
          secondary: Color(0xffE77D7D),
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Color(0xffE77D7D),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: Screens.preparations,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
