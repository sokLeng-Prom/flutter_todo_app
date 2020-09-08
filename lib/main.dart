

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/todos_provider.dart';
import 'screens/todos_screen/todos_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => TodosProvider(),
          ),
        ],
        child: TodoScreen(),
      ),
    );
  }
}
