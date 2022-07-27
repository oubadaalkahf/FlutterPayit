import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testingg/cubit/app_cubit.dart';
import 'package:testingg/cubit/app_states.dart';
import 'package:testingg/models/TransactionInfos.dart';
import 'package:testingg/models/userModel.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:testingg/screens/Payment/PaymentRoute.dart';

import '../Routes/CustomPageRouteRight.dart';

class PaimentQrCodeResult extends StatelessWidget {
  PaimentQrCodeResult({Key? key}) : super(key: key);
  String data = "";
  @override
  Widget build(BuildContext context) {

    TransactionInfos? transactionInfos = AppCubit.get(context).transactionInfos;
    return BlocConsumer<AppCubit, AppStates>(listener: (context, state) {
      if (state is AppGeneratedQrCodeSuccessStates) {
        data = state.url;
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context)
                  .push(CustomPageRouteRight(child: PaymentRoute()));
            },
          ),
          title: const Text(
            'Piement d\'argent par QR Code',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xff4c91bc),
          elevation: 0,
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Text("${transactionInfos?.transactionAmount}"),
              SizedBox(
                height: 50,
              ),
              Container(
                child: PrettyQr(
                  elementColor: Colors.black,
                  size: 250,
                  data: "${AppCubit.get(context).qrString}",
                  errorCorrectLevel: QrErrorCorrectLevel.M,
                ),
              ),
              SizedBox(
                height: 200,
              ),
              Text("Ce QR code respecte les spécificatoin MarocPay"),
            ],
          ),
        ),
      );
    });
  }
}
