import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passy/common/common.dart';
import 'package:passy/passy_data/common.dart';
import 'package:passy/passy_data/loaded_account.dart';
import 'package:passy/passy_data/screen.dart';

import 'assets.dart';
import 'add_account_screen.dart';
import 'main_screen.dart';
import 'confirm_string_screen.dart';
import 'log_screen.dart';
import 'splash_screen.dart';
import 'theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  String _password = '';
  String _username = data.info.value.lastUsername;

  void login() {
    if (getPassyHash(_password).toString() != data.getPasswordHash(_username)) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Row(children: [
        Icon(
          Icons.lock_rounded,
          color: darkContentColor,
        ),
        const SizedBox(width: 20),
        const Expanded(child: Text('Incorrect password')),
      ])));
      return;
    }
    data.info.value.lastUsername = _username;
    data.info.save().whenComplete(() {
      try {
        LoadedAccount _account = data.loadAccount(
            data.info.value.lastUsername, getPassyEncrypter(_password));
        Navigator.pushReplacementNamed(context, MainScreen.routeName);
        if (_account.defaultScreen == Screen.main) return;
        Navigator.pushNamed(
            context, screenToRouteName[_account.defaultScreen]!);
      } catch (e, s) {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(SnackBar(
            content: Row(children: [
              Icon(Icons.lock_rounded, color: darkContentColor),
              const SizedBox(width: 20),
              const Text('Could not login'),
            ]),
            action: SnackBarAction(
              label: 'Details',
              onPressed: () => Navigator.pushNamed(context, LogScreen.routeName,
                  arguments: e.toString() + '\n' + s.toString()),
            ),
          ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuItem<String>> usernames = data.usernames
        .map<DropdownMenuItem<String>>((_username) => DropdownMenuItem(
              child: Row(children: [
                Expanded(child: Text(_username)),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(
                        context, ConfirmStringScreen.routeName,
                        arguments: ConfirmStringScreenArguments(
                            title: const Text('Remove account'),
                            message: Padding(
                              padding: entryPadding,
                              child: RichText(
                                text: TextSpan(
                                    text: 'Confirm the removal of account ',
                                    children: [
                                      TextSpan(
                                        text: '\'$_username\' ',
                                        style: TextStyle(
                                            color: lightContentSecondaryColor),
                                      ),
                                      const TextSpan(
                                          text:
                                              'by typing in its username.\n\nThis action is '),
                                      TextSpan(
                                        text: 'irreversible',
                                        style: TextStyle(
                                            color: lightContentSecondaryColor),
                                      ),
                                      const TextSpan(text: '.'),
                                    ]),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            labelText: 'Confirm username',
                            confirmIcon:
                                const Icon(Icons.delete_outline_rounded),
                            onBackPressed: (context) =>
                                Navigator.pushReplacementNamed(
                                    context, LoginScreen.routeName),
                            onConfirmPressed: (context, value) {
                              if (value != _username) {
                                ScaffoldMessenger.of(context)
                                  ..clearSnackBars()
                                  ..showSnackBar(SnackBar(
                                    content: Row(children: [
                                      Icon(Icons.error_outline_rounded,
                                          color: darkContentColor),
                                      const SizedBox(width: 20),
                                      const Expanded(
                                          child:
                                              Text('Usernames do not match')),
                                    ]),
                                  ));
                                return;
                              }
                              Navigator.pushReplacementNamed(
                                  context, SplashScreen.routeName);
                              data.removeAccount(_username).then((value) {
                                if (data.noAccounts) {
                                  Navigator.pushReplacementNamed(
                                      context, AddAccountScreen.routeName);
                                  return;
                                }
                                Navigator.pushReplacementNamed(
                                    context, LoginScreen.routeName);
                              });
                            }));
                  },
                  icon: const Icon(Icons.delete_outline_rounded),
                  splashRadius: appBarButtonSplashRadius,
                  padding: appBarButtonPadding,
                ),
              ]),
              value: _username,
            ))
        .toList();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                const Spacer(flex: 2),
                logo60Purple,
                const Spacer(),
                Expanded(
                  child: Row(
                    children: [
                      const Spacer(),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                FloatingActionButton(
                                  onPressed: () =>
                                      Navigator.pushReplacementNamed(
                                          context, AddAccountScreen.routeName),
                                  child: const Icon(Icons.add_rounded),
                                  heroTag: 'addAccountBtn',
                                ),
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    value: _username,
                                    items: usernames,
                                    selectedItemBuilder: (context) {
                                      return usernames.map<Widget>((item) {
                                        return Text(item.value!);
                                      }).toList();
                                    },
                                    onChanged: (a) {
                                      _username = a!;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: TextEditingController(),
                                    obscureText: true,
                                    onChanged: (a) => _password = a,
                                    decoration: const InputDecoration(
                                      hintText: 'Password',
                                    ),
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(32),
                                    ],
                                    autofocus: true,
                                  ),
                                ),
                                FloatingActionButton(
                                  onPressed: () => login(),
                                  child: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                  ),
                                  heroTag: 'loginBtn',
                                ),
                              ],
                            ),
                          ],
                        ),
                        flex: 10,
                      ),
                      const Spacer(),
                    ],
                  ),
                  flex: 4,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
