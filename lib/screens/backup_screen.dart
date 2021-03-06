import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passy/common/common.dart';

import 'assets.dart';
import 'common.dart';
import 'theme.dart';

import 'backup_and_restore_screen.dart';

class BackupScreen extends StatefulWidget {
  const BackupScreen({Key? key}) : super(key: key);

  static const routeName = '${BackupAndRestoreScreen.routeName}/backup';

  @override
  State<StatefulWidget> createState() => _BackupScreen();
}

class _BackupScreen extends State<BackupScreen> {
  @override
  Widget build(BuildContext context) {
    final String _username =
        ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        leading: getBackButton(onPressed: () => Navigator.pop(context)),
        title: const Text('Backup'),
        centerTitle: true,
      ),
      body: ListView(children: [
        Padding(
          padding: entryPadding,
          child: getThreeWidgetButton(
            center: const Text('Passy backup'),
            left: SvgPicture.asset(
              logoCircleSvg,
              width: 25,
              color: lightContentColor,
            ),
            right: const Icon(Icons.arrow_forward_ios_rounded),
            onPressed: () => FilePicker.platform
                .getDirectoryPath(dialogTitle: 'Backup passy')
                .then((buDir) {
              if (buDir == null) return;
              data.backupAccount(_username, buDir);
            }),
          ),
        ),
      ]),
    );
  }
}
