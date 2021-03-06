import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:passy/common/common.dart';
import 'package:passy/common/synchronization_wrapper.dart';
import 'package:passy/screens/theme.dart';
import 'package:passy/passy_data/loaded_account.dart';

import 'payment_cards_screen.dart';
import 'common.dart';
import 'connect_screen.dart';
import 'passwords_screen.dart';
import 'settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  static const routeName = '/main';

  @override
  State<StatefulWidget> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final LoadedAccount _account = data.loadedAccount!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Passy'),
        actions: [
          IconButton(
            splashRadius: appBarButtonSplashRadius,
            padding: appBarButtonPadding,
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  shape: dialogShape,
                  title: Center(
                      child: Text(
                    'Synchronize',
                    style: TextStyle(color: lightContentColor),
                  )),
                  actionsAlignment: MainAxisAlignment.center,
                  actions: [
                    TextButton(
                        child: Text(
                          'Host',
                          style: TextStyle(color: lightContentSecondaryColor),
                        ),
                        onPressed: () =>
                            SynchronizationWrapper(context: context)
                                .host(_account)),
                    TextButton(
                      child: Text(
                        'Connect',
                        style: TextStyle(color: lightContentSecondaryColor),
                      ),
                      onPressed: isCameraSupported
                          ? () => showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                    title: const Text(
                                      'Scan QR code',
                                      textAlign: TextAlign.center,
                                    ),
                                    content: QRView(
                                      key: qrKey,
                                      onQRViewCreated: (controller) {
                                        bool _scanned = false;
                                        controller.scannedDataStream
                                            .listen((event) {
                                          if (_scanned) return;
                                          if (event.code == null) return;
                                          _scanned = true;
                                          SynchronizationWrapper(
                                                  context: context)
                                              .connect(_account,
                                                  address: event.code!);
                                        });
                                      },
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.popUntil(
                                              context,
                                              (route) =>
                                                  route.settings.name ==
                                                  MainScreen.routeName);
                                          Navigator.pushNamed(
                                              context, ConnectScreen.routeName,
                                              arguments: _account);
                                        },
                                        child: Text(
                                          'Can\'t scan?',
                                          style: TextStyle(
                                            color: lightContentSecondaryColor,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.pop(ctx),
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(
                                            color: lightContentSecondaryColor,
                                          ),
                                        ),
                                      )
                                    ],
                                  ))
                          : () {
                              Navigator.popUntil(
                                  context,
                                  (route) =>
                                      route.settings.name ==
                                      MainScreen.routeName);
                              Navigator.pushNamed(
                                  context, ConnectScreen.routeName,
                                  arguments: _account);
                            },
                    ),
                  ],
                ),
              ).then((value) => null);
            },
            icon: const Icon(Icons.sync_rounded),
          ),
          IconButton(
            padding: appBarButtonPadding,
            onPressed: () =>
                Navigator.pushNamed(context, SettingsScreen.routeName),
            icon: const Icon(Icons.settings),
            splashRadius: appBarButtonSplashRadius,
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: entryPadding,
            child: getThreeWidgetButton(
              left: const Icon(Icons.lock_rounded),
              right: const Icon(Icons.arrow_forward_ios_rounded),
              center: const Text('Passwords'),
              onPressed: () {
                Navigator.pushNamed(context, PasswordsScreen.routeName);
              },
            ),
          ),
          Padding(
            padding: entryPadding,
            child: getThreeWidgetButton(
              left: const Icon(Icons.payment_rounded),
              right: const Icon(Icons.arrow_forward_ios_rounded),
              center: const Text('Payment cards'),
              onPressed: () {
                Navigator.pushNamed(context, PaymentCardsScreen.routeName);
              },
            ),
          ),
        ],
      ),
    );
  }
}
