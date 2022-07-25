import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:testingg/cubit/app_states.dart';
import 'package:testingg/models/TransactionModel.dart';
import 'package:testingg/models/UserModelNative.dart';

import 'package:testingg/models/userModel.dart';
import 'package:testingg/network/local/cache_helper.dart';
import 'package:testingg/network/remote/dio_helper.dart';
import 'package:testingg/screens/AccountScreen.dart';
import 'package:testingg/screens/AlimentationScreen.dart';
import 'package:testingg/screens/HomeScreen.dart';
import 'package:testingg/screens/TransactionsHistory/TransactionReceiveScreen.dart';
import 'package:testingg/screens/TransactionsHistory/TransactionSentScreen.dart';
import 'package:testingg/screens/Transfer/BillTransactionDetails.dart';
import 'package:testingg/screens/Transfer/TransferQrCodeResult.dart';
import 'package:testingg/shared/component.dart';

import '../models/TransactionInfos.dart';
import '../screens/AccueilScreen.dart';
import '../screens/Transfer/TransferScreen.dart';
import 'package:restart_app/restart_app.dart';

class AppCubit extends Cubit<AppStates> {
  bool verified = false;
  bool? verifiedcin;
  bool? verifiedphone;
  bool? verifiedEmail;
  String? qrString;

  AppCubit() : super(AppInitialStates());

  String? email;
  String? firstName;
  String? lastName;
  String? username;
  String? password;
  String? cin;
  String? phone_number;

  static AppCubit get(context) => BlocProvider.of(context);
  static late Widget widget;
  int currentIndex = 0;
  int currentIndexHistory = 0;
  List<Widget> bottomScreens = [
    AccueilScreen(),
    TransferScreen(),
    AccountScreen(),
  ];

  List<Widget> screensHistory = [
    TransactionReceiveScreen(),
    TransactionSentScreen(),
  ];

  static Locale currentLocale = const Locale("fr");

  void changeLocale(String _locale, context) {
    emit(ChangeLanguageInitialStates());
    print(currentLocale.toString());
    currentLocale = Locale(_locale);
    CacheHelper.saveData(key: 'lang', value: _locale);
    Restart.restartApp();
    emit(ChangeLanguageSuccessStates());
    Navigator.pop(context);
    print("Cache Helper ------------");
    print(CacheHelper.getData(key: "lang"));
  }

  int currentStep = 0;

  void changeStep(index) {
    currentStep = currentStep + 1;
    emit(AppStepPageStates());
  }




  void changeBottom(index) {
    currentIndex = index;
    emit(AppChangeBottomNavStates());
  }

  void changeBottomHistory(index) {
    currentIndexHistory = index;
    emit(AppChangeHistoryScreenStates());
  }

  //-----------------------------------------------------------------------//
  UserModel? userModel;
  List<TransactionModel> transactionsEmetteur = [];
  List<TransactionModel> transactionsDestinataire = [];



  Future<void> userLogin(
      {required String phone_number, required String password}) async {

    emit(AppLoginInitialStates());
   try{
     const MethodChannel AuthCHANNEL = MethodChannel("payit/auth");
     var response = await AuthCHANNEL.invokeMethod(
         "loginNative", {"phoneNumber": phone_number, "password": password});
     print(jsonDecode(response));
     userModel = UserModel.fromJson(jsonDecode(response));
  CacheHelper.saveData(key: "phone", value: userModel?.data.phoneNumber);
     emit(AppLoginSuccessStates(userModel!));
   }catch(e){
     print(e.toString());
     showToast(message: "login failed");
   }
  }

  Future<void> showHistoryEmetteur(String? phoneNumber) async {
  transactionsEmetteur = [];
  emit(AppTransactionHistoryEmetteurInitialStates());
    const MethodChannel hsitoryChannel = MethodChannel("payit/history");
   try{
     var history = await hsitoryChannel
         .invokeMethod("showHistoryEmetteur", {"phoneNumber": phoneNumber});
     List<dynamic> hy = jsonDecode(history);
     print(hy);
     hy.forEach((element) {
       transactionsEmetteur.add(TransactionModel.fromJson(element));
     });
     emit(AppTransactionHistoryEmetteurSuccessStates());
   }catch(e){
     print(e.toString());
     emit(AppTransactionHistoryEmetteurErrorStates());
    }

  }

  Future<void> showHistoryDestinataire(String? phoneNumber) async {
transactionsDestinataire = [];
    emit(AppTransactionHistoryDestinataireInitialStates());
    const MethodChannel hsitoryChannel = MethodChannel("payit/history");
    try{
      var history = await hsitoryChannel
          .invokeMethod("showHistoryDestinataire", {"phoneNumber": phoneNumber});

      List<dynamic> destinataire = jsonDecode(history);
      print(destinataire);
      destinataire.forEach((element) {
        transactionsDestinataire.add(TransactionModel.fromJson(element));
      });
      emit(AppTransactionHistoryDestinataireSuccessStates());
    }catch(e){
      print(e.toString());
      emit(AppTransactionHistoryDestinataireErrorStates());
    }

  }


  //-----------------------------------------------------------------------//
  Future<void> userSignUp({
    required String? email,
    required String? phoneNumber,
    required String? password,
    required String? firstName,
    required String? lastName,
    required String? cin,
  }) async {
    emit(AppSigninInitialStates());

   try{
     const MethodChannel REGISTERCHANNEL = MethodChannel("payit/auth");
     var response = await REGISTERCHANNEL
         .invokeMethod("registerNative", {
           "email" : email,
         "phoneNumber": phoneNumber,
         "password" : password,
       "firstName"  :firstName,
       "lastName": lastName,
       "cin": cin
         });
     print(response.toString());
     emit(AppSigninSuccessStates());
   }catch(e){
     print(e.toString());
     emit(AppSigninErrorStates(e.toString()));
   }
  }

  /**
   *  void addTokenToUser(email, deviceToken) {
      emit(LoginSaveTokenInitialStates());

      DioHelper.postDataLogins(
      url: "fcm_token",
      data: {"email": email, "fcmToken": deviceToken}).then((value) {
      emit(LoginSaveTokenSuccessStates());
      }).catchError((error) {
      print(error.toString());
      emit(LoginSaveTokenErrorStates());
      });
      }
   */
  Future<void> addTokenToUser(email, deviceToken) async {
    emit(LoginSaveTokenInitialStates());
   try{
     const MethodChannel USERCHANNEL = MethodChannel("payit/user");
     var response = await USERCHANNEL
         .invokeMethod("addTokenToUser", {"email": email,"deviceToken":deviceToken});
     print(response.toString());
     emit(LoginSaveTokenSuccessStates());
   }catch(e){
     print(e.toString());
     emit(LoginSaveTokenErrorStates());
   }

  }
  Future<void> removeFcmToken(email) async {
    emit(RemoveTokenInitialStates());

    try{
      const MethodChannel USERCHANNEL = MethodChannel("payit/user");
      var response = await USERCHANNEL
          .invokeMethod("removeFcmToken", {"email": email});
      print(response.toString());
      emit(RemoveTokenSuccessStates());

    }catch(e){
      print(e.toString());
      emit(RemoveTokenErrorStates());
    }
  }
  /**
   * void removeFcmToken(email) {
      emit(RemoveTokenInitialStates());
      print(email);
      DioHelper.postDataLogins(
      url: "remove_fcm_token?user_email=$email",
      data: {},
      ).then((value) {
      emit(RemoveTokenSuccessStates());
      }).catchError((error) {
      print(error.toString());
      emit(RemoveTokenErrorStates());
      });
      }
   */

  //-----------------------------------------------------------------------//
  /**
   * void loadLoggedInUser(email) {
      userModel = null;
      if (email != null) {
      emit(LoadLoggedInUserInitial());

      DioHelper.getData(url: "user?email=$email").then((value) {
      print(value.data);
      userModel = UserModel.fromJson(value.data);
      emit(LoadLoggedInUserSuccessStates());
      }).catchError((error) {
      print(error.toString());
      emit(LoadLoggedInUserErrorStates());
      });
      }
      }
   */



  Future loadLoggedInUserNative(phoneNumber) async {
    emit(LoadLoggedInUserInitial());
    try {
      userModel = null;
      const MethodChannel USERCHANNEL = MethodChannel("payit/user");
      var response = await USERCHANNEL
          .invokeMethod("loadLoggedInUserNative", {"phoneNumber": phoneNumber});
      userModel = UserModel.fromJson(jsonDecode(response));
      print(userModel?.data.phoneNumber);
      emit(LoadLoggedInUserSuccessStates());
      showHistoryEmetteur(userModel?.data.phoneNumber);
      showHistoryDestinataire(userModel?.data.phoneNumber);
    }catch(e){
      print(e.toString());
      emit(LoadLoggedInUserErrorStates());
    }
  }

  //-----------------------------------------------------------------------//
///////////////////////////////////////
  void Makevirement(montant, destinataire, message, String emetteur) {
    if (emetteur.startsWith("+212")) {
      emetteur = emetteur.replaceAll("+212", "0");
    }
    if (destinataire.startsWith("+212")) {
      destinataire = destinataire.replaceAll("+212", "0");
    }
    String operation_type = "virement";
    emit(AppVirementInitialStates());
    DioHelper.postData(url: "transfer/operation", data: {
      "operation_type": operation_type,
      "montant": montant,
      "emetteur": emetteur,
      "destinataire": destinataire,
      "message": message
    }).then((value) {
      print(value.data);
      loadLoggedInUserNative(userModel?.data.phoneNumber);
      emit(AppVirementSuccessStates());
      changeBottom(0);
      Get.off(() => HomeScreen());
    }).catchError((error) {
      emit(AppVirementErrorStates());
    });
  }

  void sendOtp(String phone) {
    emit(AppSendOtpInitialState());
    DioHelper.postData(url: "otp/send", data: {"phoneNumber": phone})
        .then((value) {
      print("OTP SEND SUCCESS");
      emit(AppSendOtpSuccessState(value.data));
    }).catchError((error) {
      print(error.toString());
      emit(AppSendOtpErrorState());
    });
  }

  void verifyOtp(String otp) {
    emit(AppVerifyOtpInitialState());
    DioHelper.postData(
        url: "otp/verify",
        data: {"phoneNumber": phone_number, "otp": otp}).then((value) {
      verified = true;
      emit(AppVerifyOtpSuccessState(value.data));
    }).catchError((error) {
      emit(AppVerifyOtpErrorState(error.toString()));
      print(error.toString());
    });
  }

  void makeVersement(montant, message, emetteur) {
    String operation_type = "versement";
    emit(AppVersementInitialStates());
    DioHelper.postData(url: "transfer/operation", data: {
      "operation_type": operation_type,
      "montant": montant,
      "destinataire": emetteur,
      "message": message
    }).then((value) {
      loadLoggedInUserNative(userModel?.data.phoneNumber);
      emit(AppVersementSuccessStates());

    }).catchError((error) {
      emit(AppVersementErrorStates());
    });
  }
///////////////////////////////////////
  void verifycin(cin) {
    emit(AppVerifyCinInitialStates());
    DioHelper.getData(url: "verifycinn?cin=$cin").then((value) {
      verifiedcin = value.data;
      emit(AppVerifyCinSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(AppVerifyCinErrorStates());
    });
  }

  void verifyphone(phone) {
    emit(AppVerifyPhoneInitialStates());
    DioHelper.getData(url: "verifypnn?phone_number=$phone").then((value) {
      emit(AppVerifyPhoneSuccessStates());
      verifiedphone = value.data;
      print("verify phone");
      print(verifiedphone);
    }).catchError((error) {
      print(error.toString());
      emit(AppVerifyPhoneErrorStates());
    });
  }

  void verifyEmail(email) {
    emit(AppVerifyEmailInitialStates());
    DioHelper.getData(url: "verifyemail?email=$email").then((value) {
      emit(AppVerifyEmailSuccessStates());
      verifiedEmail = value.data;
      print("verify email");
      print(verifiedEmail);
    }).catchError((error) {
      print(error.toString());
      emit(AppVerifyEmailErrorStates());
    });
  }

  void transferp2p(String pointofinitiationmethode, paidEntityRef, trans_curr,
      tran_amount, tran_purpose, oper_type) {
    emit(AppGeneratedQrCodeInitialStates());
    print(pointofinitiationmethode);

    print("-----------------------");
    DioHelper.postData(url: 'transferp2p', data: {
      "transaction_type": "transfer p2p",
      "point_of_initiation_method": pointofinitiationmethode,
      "paid_entity_reference": paidEntityRef,
      "transaction_currency": trans_curr,
      "transaction_amount": tran_amount,
      "purpose_of_transaction": tran_purpose,
      "financial_institution_code": "999",
      "operation_type": oper_type
    }).then((value) {
      print(value.data);
      qrString = value.data;
      emit(AppGeneratedQrCodeSuccessStates(value.data));
    }).catchError((error) {
      print(error.toString());
      emit(AppGeneratedQrCodeErrorStates());
    });
  }

  TransactionInfos? transactionInfos;

  void getTransactionInfo(String qrText, context) {
    emit(AppTransactionInitialStates());
    DioHelper.postData(url: "/getqrdata", data: {
      "qrText": qrText,
    }).then((value) {
      transactionInfos = TransactionInfos.fromJson(value.data);
      print(value.data);
      print(transactionInfos?.transactionCurrency);
      emit(AppTransactionSuccessStates());
      print(transactionInfos?.merchandPhoneNumber);
      navigateAndFinish(context, BillTransactionDetails(transactionInfos));
    }).catchError((error) {
      emit(AppTransactionErrorStates());
      print(error.toString());
    });
  }

  void getHistoryTransactionsEmetteur(String emetteur) {
    emit(AppTransactionHistoryEmetteurInitialStates());
  }
}

bool jwtVerification(String token) {
  DateTime? expiryDate = Jwt.getExpiryDate(token);

  DateTime now = DateTime.now();
  if (expiryDate!.compareTo(now) < 0) {
    return true;
  } else {
    return false;
  }
}
