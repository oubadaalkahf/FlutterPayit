// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Settings`
  String get title {
    return Intl.message(
      'Settings',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get reset_password {
    return Intl.message(
      'Change Password',
      name: 'reset_password',
      desc: '',
      args: [],
    );
  }

  /// `Change Email Address`
  String get change_email {
    return Intl.message(
      'Change Email Address',
      name: 'change_email',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get change_language {
    return Intl.message(
      'Change Language',
      name: 'change_language',
      desc: '',
      args: [],
    );
  }

  /// `Choose Language`
  String get choose_language_title {
    return Intl.message(
      'Choose Language',
      name: 'choose_language_title',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `My QR Code`
  String get my_qr_code {
    return Intl.message(
      'My QR Code',
      name: 'my_qr_code',
      desc: '',
      args: [],
    );
  }

  /// `My Account`
  String get my_account {
    return Intl.message(
      'My Account',
      name: 'my_account',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `My History`
  String get my_history {
    return Intl.message(
      'My History',
      name: 'my_history',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Hello`
  String get hello {
    return Intl.message(
      'Hello',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get enter_your_phone_number {
    return Intl.message(
      'Phone Number',
      name: 'enter_your_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get log_in {
    return Intl.message(
      'Log in',
      name: 'log_in',
      desc: '',
      args: [],
    );
  }

  /// `Not a member ? `
  String get not_member {
    return Intl.message(
      'Not a member ? ',
      name: 'not_member',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `the Password must not be empty`
  String get the_Password_must_not_be_empty {
    return Intl.message(
      'the Password must not be empty',
      name: 'the_Password_must_not_be_empty',
      desc: '',
      args: [],
    );
  }

  /// `the phone number must not be empty`
  String get the_phone_number_must_not_be_empty {
    return Intl.message(
      'the phone number must not be empty',
      name: 'the_phone_number_must_not_be_empty',
      desc: '',
      args: [],
    );
  }

  /// `Activation`
  String get activation {
    return Intl.message(
      'Activation',
      name: 'activation',
      desc: '',
      args: [],
    );
  }

  /// `STEP 1 : Identification`
  String get step_1 {
    return Intl.message(
      'STEP 1 : Identification',
      name: 'step_1',
      desc: '',
      args: [],
    );
  }

  /// `Enter your phone number and your CIN`
  String get enter_your_phone_number_and_your_cin {
    return Intl.message(
      'Enter your phone number and your CIN',
      name: 'enter_your_phone_number_and_your_cin',
      desc: '',
      args: [],
    );
  }

  /// `phone Number Already Exist`
  String get phone_number_already_exist {
    return Intl.message(
      'phone Number Already Exist',
      name: 'phone_number_already_exist',
      desc: '',
      args: [],
    );
  }

  /// `the CIN must not be empty`
  String get the_cin_must_not_be_empty {
    return Intl.message(
      'the CIN must not be empty',
      name: 'the_cin_must_not_be_empty',
      desc: '',
      args: [],
    );
  }

  /// `Cin Already Exist`
  String get cin_already_exist {
    return Intl.message(
      'Cin Already Exist',
      name: 'cin_already_exist',
      desc: '',
      args: [],
    );
  }

  /// `CIN`
  String get cin {
    return Intl.message(
      'CIN',
      name: 'cin',
      desc: '',
      args: [],
    );
  }

  /// `By continuing, you agree to the terms and conditions of use `
  String get terms_of_use {
    return Intl.message(
      'By continuing, you agree to the terms and conditions of use ',
      name: 'terms_of_use',
      desc: '',
      args: [],
    );
  }

  /// `NEXT`
  String get next {
    return Intl.message(
      'NEXT',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Send money`
  String get send_money {
    return Intl.message(
      'Send money',
      name: 'send_money',
      desc: '',
      args: [],
    );
  }

  /// `Receive money`
  String get receive_money {
    return Intl.message(
      'Receive money',
      name: 'receive_money',
      desc: '',
      args: [],
    );
  }

  /// `Scan Qr Code`
  String get scan_qr_code {
    return Intl.message(
      'Scan Qr Code',
      name: 'scan_qr_code',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get acceuil {
    return Intl.message(
      'Home',
      name: 'acceuil',
      desc: '',
      args: [],
    );
  }

  /// `MAD`
  String get dh {
    return Intl.message(
      'MAD',
      name: 'dh',
      desc: '',
      args: [],
    );
  }

  /// `Transfer to`
  String get transfer_to {
    return Intl.message(
      'Transfer to',
      name: 'transfer_to',
      desc: '',
      args: [],
    );
  }

  /// `Services\n`
  String get services {
    return Intl.message(
      'Services\n',
      name: 'services',
      desc: '',
      args: [],
    );
  }

  /// `Transfer\n`
  String get transfer {
    return Intl.message(
      'Transfer\n',
      name: 'transfer',
      desc: '',
      args: [],
    );
  }

  /// `Top up`
  String get top_up {
    return Intl.message(
      'Top up',
      name: 'top_up',
      desc: '',
      args: [],
    );
  }

  /// `Mobile\nRefill`
  String get mobile_refill {
    return Intl.message(
      'Mobile\nRefill',
      name: 'mobile_refill',
      desc: '',
      args: [],
    );
  }

  /// `Bill\nPayment`
  String get bill_payment {
    return Intl.message(
      'Bill\nPayment',
      name: 'bill_payment',
      desc: '',
      args: [],
    );
  }

  /// `Merchant\nPayment`
  String get merchant_payment {
    return Intl.message(
      'Merchant\nPayment',
      name: 'merchant_payment',
      desc: '',
      args: [],
    );
  }

  /// `Airplane\nTicket`
  String get airplane_ticket {
    return Intl.message(
      'Airplane\nTicket',
      name: 'airplane_ticket',
      desc: '',
      args: [],
    );
  }

  /// `More\n`
  String get more {
    return Intl.message(
      'More\n',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  /// `Payment`
  String get payment {
    return Intl.message(
      'Payment',
      name: 'payment',
      desc: '',
      args: [],
    );
  }

  /// `Top up\n`
  String get top_up_acceuil {
    return Intl.message(
      'Top up\n',
      name: 'top_up_acceuil',
      desc: '',
      args: [],
    );
  }

  /// `STEP 2 : Identification \n`
  String get step_2 {
    return Intl.message(
      'STEP 2 : Identification \n',
      name: 'step_2',
      desc: '',
      args: [],
    );
  }

  /// `Enter the code sent to `
  String get Enter_the_code_sent_to {
    return Intl.message(
      'Enter the code sent to ',
      name: 'Enter_the_code_sent_to',
      desc: '',
      args: [],
    );
  }

  /// `Vous n'avez pas reçu le code`
  String get Didnt_receive_the_code {
    return Intl.message(
      'Vous n\'avez pas reçu le code',
      name: 'Didnt_receive_the_code',
      desc: '',
      args: [],
    );
  }

  /// `RENVOYER`
  String get RESEND {
    return Intl.message(
      'RENVOYER',
      name: 'RESEND',
      desc: '',
      args: [],
    );
  }

  /// `SUIVANT`
  String get NEXT {
    return Intl.message(
      'SUIVANT',
      name: 'NEXT',
      desc: '',
      args: [],
    );
  }

  /// `ÉTAPE 3 `
  String get step_3 {
    return Intl.message(
      'ÉTAPE 3 ',
      name: 'step_3',
      desc: '',
      args: [],
    );
  }

  /// `Entrez votre prénom,Nom et l'adresse email `
  String get Enter_your_first_last_name {
    return Intl.message(
      'Entrez votre prénom,Nom et l\'adresse email ',
      name: 'Enter_your_first_last_name',
      desc: '',
      args: [],
    );
  }

  /// `E-mail`
  String get Email {
    return Intl.message(
      'E-mail',
      name: 'Email',
      desc: '',
      args: [],
    );
  }

  /// `Prénom`
  String get First_name {
    return Intl.message(
      'Prénom',
      name: 'First_name',
      desc: '',
      args: [],
    );
  }

  /// `Nom`
  String get Last_name {
    return Intl.message(
      'Nom',
      name: 'Last_name',
      desc: '',
      args: [],
    );
  }

  /// `Securité`
  String get Security {
    return Intl.message(
      'Securité',
      name: 'Security',
      desc: '',
      args: [],
    );
  }

  /// ` Entrez un nouveau mot de passe 2 fois  `
  String get Enter_new_password {
    return Intl.message(
      ' Entrez un nouveau mot de passe 2 fois  ',
      name: 'Enter_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Confrimer votre mot de passe `
  String get Confirm_password {
    return Intl.message(
      'Confrimer votre mot de passe ',
      name: 'Confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `CREER`
  String get CREATE {
    return Intl.message(
      'CREER',
      name: 'CREATE',
      desc: '',
      args: [],
    );
  }

  /// `ouvrir l'application de messagerie`
  String get Open_Email_App {
    return Intl.message(
      'ouvrir l\'application de messagerie',
      name: 'Open_Email_App',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'fr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
