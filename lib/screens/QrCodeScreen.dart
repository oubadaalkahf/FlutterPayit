import 'package:flutter/material.dart';
import 'package:testingg/screens/Routes/CustomPageRouteRight.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../cubit/app_cubit.dart';
import 'HomeScreen.dart';

class QrCodeScreen extends StatefulWidget {
  static String id = "Mon QR COde";

  const QrCodeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _QrCodeScreenState();
  }
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).push(
                  CustomPageRouteRight(child: const HomeScreen()),
                );
              },
            ),
            title:const  Padding(
              padding:  EdgeInsets.only(left: 78.0),
              child:  Text(
                'My QR Code',
                style: TextStyle(color: Colors.white),
              ),
            ),
            backgroundColor: const Color(0xff4c91bc),
            elevation: 0,
          ),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PrettyQr(
                  elementColor: const Color(0xff4c91bc),

                  size: 250,
                  data: "${AppCubit.get(context).userModel?.data.phoneNumber}",
                  errorCorrectLevel: QrErrorCorrectLevel.M,
                ),
                const  SizedBox(
                  height: 120,
                ),
                const  Text('Ce QR code respecte les spécifications MarocPay'),
              ],
            ),
          ),
        ));
  }
}
