import 'package:flutter/material.dart';

import 'common.dart';

class IDCardScreen extends StatefulWidget {
  const IDCardScreen({Key? key}) : super(key: key);

  static const routeName = '/main/idCard';

  @override
  State<StatefulWidget> createState() => _IDCardScreen();
}

class _IDCardScreen extends State<IDCardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: getBackButton(
          onPressed: () => Navigator.pop(context),
        ),
        title: const Center(child: Text('ID Card')),
      ),
    );
  }
}
