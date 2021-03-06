import 'package:flutter/material.dart';

import 'screens/theme.dart';
import 'screens/backup_and_restore_screen.dart';
import 'screens/backup_screen.dart';
import 'screens/biometric_auth_screen.dart';
import 'screens/restore_screen.dart';
import 'screens/add_account_screen.dart';
import 'screens/connect_screen.dart';
import 'screens/edit_custom_field_screen.dart';
import 'screens/edit_id_card_screen.dart';
import 'screens/edit_identity_screen.dart';
import 'screens/edit_password_screen.dart';
import 'screens/edit_payment_card_screen.dart';
import 'screens/id_card_screen.dart';
import 'screens/identity_screen.dart';
import 'screens/log_screen.dart';
import 'screens/login_screen.dart';
import 'screens/main_screen.dart';
import 'screens/note_screen.dart';
import 'screens/password_screen.dart';
import 'screens/passwords_screen.dart';
import 'screens/search_screen.dart';
import 'screens/payment_card_screen.dart';
import 'screens/confirm_string_screen.dart';
import 'screens/payment_cards_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/splash_screen.dart';

void main() => runApp(const Passy());

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Passy extends StatelessWidget {
  const Passy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Passy',
      theme: theme,
      navigatorKey: navigatorKey,
      routes: {
        AddAccountScreen.routeName: (context) => const AddAccountScreen(),
        BackupAndRestoreScreen.routeName: (context) =>
            const BackupAndRestoreScreen(),
        BackupScreen.routeName: (context) => const BackupScreen(),
        BiometricAuthScreen.routeName: (context) => const BiometricAuthScreen(),
        ConfirmStringScreen.routeName: (context) => const ConfirmStringScreen(),
        ConnectScreen.routeName: (context) => const ConnectScreen(),
        EditCustomFieldScreen.routeName: (context) =>
            const EditCustomFieldScreen(),
        EditIdCardScreen.routeName: (context) => const EditIdCardScreen(),
        EditIdentityScreen.routeName: (context) => const EditIdentityScreen(),
        EditPasswordScreen.routeName: (context) => const EditPasswordScreen(),
        EditPaymentCardScreen.routeName: (context) =>
            const EditPaymentCardScreen(),
        IDCardScreen.routeName: (context) => const IDCardScreen(),
        IdentityScreen.routeName: (context) => const IdentityScreen(),
        LogScreen.routeName: (context) => const LogScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        MainScreen.routeName: (context) => const MainScreen(),
        NoteScreen.routeName: (context) => const NoteScreen(),
        PasswordsScreen.routeName: (context) => const PasswordsScreen(),
        PasswordScreen.routeName: (context) => const PasswordScreen(),
        PaymentCardsScreen.routeName: (context) => const PaymentCardsScreen(),
        PaymentCardScreen.routeName: (context) => const PaymentCardScreen(),
        RestoreScreen.routeName: (context) => const RestoreScreen(),
        SearchScreen.routeName: (context) => const SearchScreen(),
        SettingsScreen.routeName: (context) => const SettingsScreen(),
        SplashScreen.routeName: (context) => const SplashScreen(),
      },
    );
  }
}
