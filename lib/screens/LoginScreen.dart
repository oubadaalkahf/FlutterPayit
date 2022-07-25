import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testingg/cubit/app_cubit.dart';
import 'package:testingg/cubit/app_states.dart';
import 'package:testingg/generated/l10n.dart';
import 'package:testingg/network/local/cache_helper.dart';
import 'package:testingg/screens/HomeScreen.dart';
import 'package:testingg/screens/signup/SignupScreen1.dart';
import 'package:testingg/shared/component.dart';

class LoginScreen extends StatefulWidget {
  static String id = "LoginScreen";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  var phoneNumberController = TextEditingController();
  var passwordLogController = TextEditingController();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(listener: (context, state) async {
      if (state is AppLoginSuccessStates) {
        String? token = await FirebaseMessaging.instance.getToken();

        AppCubit.get(context)
            .addTokenToUser(AppCubit.get(context).userModel?.data.email, token);
        CacheHelper.saveData(key: 'token', value: state.userModel.token);
        CacheHelper.saveData(key: 'email', value: state.userModel.data.email);
        CacheHelper.saveData(key: 'phoneNumber', value: state.userModel.data.phoneNumber);

        showToast(message: state.userModel.message);
        navigateAndFinish(context, HomeScreen());
      } else if (state is AppLoginErrorStates) {
        showToast(message: state.error);
      }
    }, builder: (context, state) {
      return Container(
        child: Form(
          key: _formKey,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: ListView(
              padding: EdgeInsets.only(left: 55, right: 55, top: 120),
              physics: BouncingScrollPhysics(),
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 130,
                      width: 200,
                      margin: EdgeInsets.only(top: 40),
                      child: Image(image:  AssetImage("images/blue_payit.png")),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 70),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return S.of(context).the_phone_number_must_not_be_empty;
                          }
                          return null;
                        },
                        controller: phoneNumberController,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          hintText:S.of(context).enter_your_phone_number,
                          fillColor: Color(0xff243656),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                color: Colors.green, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                color: Colors.green, width: 2.0),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, bottom: 30),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return S.of(context).the_Password_must_not_be_empty;
                          }
                          return null;
                        },
                        controller: passwordLogController,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                          hintText: S.of(context).password,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: _isObscure ? Colors.green : Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          ),
                          fillColor: Color(0xff243656),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                color: Colors.green, width: 2.0),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff1546A0).withOpacity(0.5),
                            offset: Offset(0, 24),
                            blurRadius: 50,
                            spreadRadius: -18,
                          ),
                        ],
                      ),
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            print(phoneNumberController.text);
                            print(passwordLogController.text);
                            AppCubit.get(context).userLogin(
                                phone_number: phoneNumberController.text,
                                password: passwordLogController.text);
                          }
                        },
                        textColor: Color(0xffFFFFFF),
                        padding: EdgeInsets.all(0),
                        shape: StadiumBorder(),
                        child: Container(
                          width: 275,
                          height: 65,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              colors: [
                                Colors.green,
                                Color(0xff1546A0),
                              ],
                            ),
                          ),
                          child: Text(
                            S.of(context).log_in,
                            style: GoogleFonts.manrope(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 65),
                      child: Text(
                        S.of(context).not_member,
                        style: GoogleFonts.manrope(
                          color: Color(0xff1546A0).withOpacity(0.5),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 28),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xffF5F7FA),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SizedBox(
                        height: 0,
                        width: 65,
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 22, bottom: 22),
                        child: TextButton(
                          onPressed: () {
                            navigateTo(context, SignupScreen1());
                          },
                          child:  Text(
                            S.of(context).register,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
