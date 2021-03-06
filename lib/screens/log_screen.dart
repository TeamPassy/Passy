import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import 'common.dart';
import 'theme.dart';

class LogScreen extends StatelessWidget {
  const LogScreen({Key? key}) : super(key: key);

  static const routeName = '/log';

  @override
  Widget build(BuildContext context) {
    final String _log =
        ModalRoute.of(context)!.settings.arguments as String? ?? '';
    return Scaffold(
        appBar: AppBar(
            title: const Text('Log'),
            centerTitle: true,
            leading: getBackButton(
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                padding: appBarButtonPadding,
                splashRadius: appBarButtonSplashRadius,
                icon: const Icon(Icons.copy_rounded),
                onPressed: () => Clipboard.setData(ClipboardData(text: _log)),
              ),
              IconButton(
                padding: appBarButtonPadding,
                splashRadius: appBarButtonSplashRadius,
                icon: SvgPicture.asset(
                  'assets/images/github_icon.svg',
                  color: lightContentColor,
                ),
                onPressed: () =>
                    launch('https://github.com/GleammerRay/Passy/issues'),
              )
            ]),
        body: SelectableText(_log));
  }
}
