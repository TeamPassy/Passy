import 'package:flutter/material.dart';

import 'common.dart';

class EditIdCardScreen extends StatefulWidget {
  const EditIdCardScreen({Key? key}) : super(key: key);

  static const routeName = '/main/idCards/editIdCard';

  @override
  State<StatefulWidget> createState() => _EditIdCardScreen();
}

class _EditIdCardScreen extends State<EditIdCardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: getBackButton(
          onPressed: () => Navigator.pop(context),
        ),
        title: const Center(child: Text('Add ID Card')),
      ),
    );
  }
}
