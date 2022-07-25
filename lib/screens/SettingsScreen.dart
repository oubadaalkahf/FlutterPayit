import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testingg/models/userModel.dart';
import 'package:testingg/screens/ResetPasswordScreen.dart';
import '../cubit/app_cubit.dart';
import '../generated/l10n.dart';
import '../network/local/cache_helper.dart';
import 'Payment/PaymentRoute.dart';
import 'Transfer/QrCodeScannerTransfer.dart';
import 'HomeScreen.dart';
import 'LoginScreen.dart';
import 'QrCodeScreen.dart';
import 'Routes/CustomPageRouteRight.dart';
import 'Routes/custom_page_route.dart';
import 'Transfer/FormulaireTransfert.dart';

class SettingsScreen extends StatelessWidget {

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel? userModel = AppCubit.get(context).userModel;
    return Material(
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(.94),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).push(
                CustomPageRouteRight(child: HomeScreen()),
              );
            },
          ),
          title: Padding(
            padding: const EdgeInsets.only(left: 78.0),
            child: const Text(
              'Paramètres',
              style: TextStyle(color: Colors.white),
            ),
          ),
          backgroundColor: Color(0xff4c91bc),
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              // user cards
              SizedBox(height: 120,),

              SettingsGroup(
                items: [
                  SettingsItem(
                    onTap: () { Navigator.pushAndRemoveUntil(
                        context, CustomPageRouteLeft(child: ResetPasswordScreen()),(route)=>false
                    );},
                    icons: CupertinoIcons.lock,
                    iconStyle: IconStyle(
                      backgroundColor: Color(0xff4c91bc),),
                    title: 'réinitialiser mot de passe',
                    subtitle: "**********",
                  ),
                  SettingsItem(
                    onTap: () {Navigator.pushAndRemoveUntil(
                        context, CustomPageRouteLeft(child: PaymentRoute()),(route)=>false
                    );},
                    icons: Icons.dark_mode_rounded,
                    iconStyle: IconStyle(
                      iconsColor: Colors.white,
                      withBackground: true,
                      backgroundColor: Color(0xff4c91bc),
                    ),
                    title: 'Mode Nuit ',
                    subtitle: "English",
                    trailing: Switch.adaptive(
                      value: false,
                      onChanged: (value) {},
                    ),
                  ),
                  SettingsItem(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  S.of(context).choose_language_title,
                                  style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 20),

                                ),
                                ListTile(
                                  leading: Text(
                                    'العربية',
                                    style: GoogleFonts.manrope(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),


                                  onTap: () {
                                    AppCubit.get(context).changeLocale("ar",context);

                                    print("ar");   print(S.of(context).logout);


                                  },
                                ),
                                SizedBox(height: 5,),
                                ListTile(
                                  leading: Text(
                                    'Français',
                                    style: GoogleFonts.manrope(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),

                                  onTap: () {

                                      AppCubit.get(context).changeLocale("fr",context);

                                      print("fr");
                                      print(S.of(context).logout);


                                  },
                                ),
                                SizedBox(height: 5,),
                                ListTile(
                                  leading: Text(
                                    'english',
                                    style: GoogleFonts.manrope(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),

                                  onTap: () {

                                      AppCubit.get(context).changeLocale("en",context);

                                      print("en");
                                      print(S.of(context).logout);



                                  },
                                ),
                              ],
                            ),
                          ));
                    },
                    icons: Icons.language,
                    iconStyle: IconStyle(
                      iconsColor: Colors.white,
                      withBackground: true,
                      backgroundColor: Color(0xff4c91bc),
                    ),
                    title: 'Changer La Langue ',
                    subtitle: "Francais",

                  ),
                ],
              ),

              // You can add a settings title
              SettingsItem(


                    iconStyle: IconStyle(iconsColor: Colors.red,backgroundColor: Colors.transparent),
                    titleStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),

                    onTap: () {
                      print("hiiiiiiiiiiiiiiiiiiiiiiiiiiiiisooo");
                      print(AppCubit.get(context).userModel?.data.email);
                      AppCubit.get(context).removeFcmToken(AppCubit.get(context).userModel?.data.email);

                    CacheHelper.removeData(key: 'token');
                    CacheHelper.removeData(key: 'email');

                    Navigator.pushAndRemoveUntil(
                        context, CustomPageRouteLeft(child: LoginScreen()),(route)=>false
                    );
                    AppCubit.get(context).currentIndex=0;},
                    icons: Icons.exit_to_app_rounded,
                subtitle: "Are you sure ? ",
                    title: S.of(context).logout,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}