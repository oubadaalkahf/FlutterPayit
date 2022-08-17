import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:testingg/network/local/cache_helper.dart';
import 'package:testingg/screens/Transfer/FormulaireUserTransfer.dart';
import 'package:testingg/screens/Transfer/TransferMoneyRoute.dart';
import '../../generated/l10n.dart';
import '../../cubit/app_cubit.dart';
import 'FormulaireTransfert.dart';
import '../HomeScreen.dart';
import '../Routes/CustomPageRouteRight.dart';
import '../Routes/custom_page_route.dart';

import 'QrCodeScannerTransfer.dart';


class TransferRoute extends StatelessWidget {
  const TransferRoute({Key? key}) : super(key: key);
static Widget widget = Container();

  @override
  Widget build(BuildContext context) {
    if(CacheHelper.getData(key: "developper")==true){
widget = FormulaireTransfert();

    }else if(CacheHelper.getData(key: "developper")==false)
      widget = FormulaireUserTransfer();
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
            padding: const EdgeInsets.only(left: 48.0),
            child: const Text(
              'Transfert d\'argent',
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
              SizedBox(
                height: 120,
              ),
              SettingsGroup(
                items: [
                  SettingsItem(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          CustomPageRouteLeft(child: QrCodeScannerTransfer()),
                          (route) => false);
                    },
                    icons: CupertinoIcons.down_arrow,
                    iconStyle: IconStyle(
                      backgroundColor: Color(0xff4c91bc),
                    ),
                    title: S.of(context).receive_money,
                    subtitle: S.of(context).scan_qr_code
                         ),
                  SettingsItem(
                    onTap: () {
                      Navigator.push(
                          context,
                          CustomPageRouteLeft(child: widget));
                    },
                    icons: CupertinoIcons.up_arrow,
                    iconStyle: IconStyle(
                      iconsColor: Colors.white,
                      withBackground: true,
                      backgroundColor: Color(0xff4c91bc),
                    ),
                    title:S.of(context).send_money
                  ),
                ],
              ),
              // You can add a settings title
            ],
          ),
        ),
      ),
    );
  }
}
