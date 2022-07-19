import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:testingg/cubit/app_cubit.dart';
import 'package:testingg/cubit/app_states.dart';
import 'package:testingg/models/TransactionInfos.dart';
import 'package:testingg/models/userModel.dart';
import 'package:testingg/network/local/cache_helper.dart';
import 'package:testingg/screens/AccountScreen.dart';
import 'package:testingg/screens/Routes/CustomPageRouteRight.dart';
import 'package:testingg/shared/Colors.dart';
import 'package:testingg/shared/component.dart';
import 'package:testingg/cubit/app_cubit.dart';
import 'package:testingg/cubit/app_states.dart';

import '../HomeScreen.dart';
import '../Routes/custom_page_route.dart';


class BillTransactionDetails extends StatelessWidget {
  TransactionInfos? transactionInfos;
  BillTransactionDetails(this.transactionInfos);



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>( listener: (context,state){
      if (state is AppVersementSuccessStates) {
        Navigator.pushAndRemoveUntil(
            context,
            CustomPageRouteLeft(child: HomeScreen()),
                (route) => false);
      }
    },builder: (context,state){
      return Scaffold(
        appBar: AppBar(

          backgroundColor:const Color(0xff4c91bc),
          elevation: 2,

          title:Center(
            child: Text(
              'Bill',
            ),
          ),
        ),
        body: Column(
          children: [
            const  SizedBox(height: 25,),
            Container(
              color:const Color(0xff4c91bc),
              child: Expanded(
                flex: 1,
                child: Padding(
                  padding:const EdgeInsets.all(20),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white)),
                    child:    Icon(Icons.receipt_long_outlined,color: Colors.white60,size: 120,),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  rowBuilder(
                      att: "Transaction Type",
                      text: "${transactionInfos?.transactionType}"),
                  const SizedBox(
                    height: 25,
                  ),
                  rowBuilder(
                      att: "Merchand Phone Number",
                      text: "${transactionInfos?.merchandPhoneNumber}"),
                  const  SizedBox(
                    height: 25,
                  ),
                  rowBuilder(
                      att: "Transaction Currency",
                      text: "${transactionInfos?.transactionCurrency}"),
                  const  SizedBox(
                    height: 25,
                  ),
                  rowBuilder(
                      att: "Transaction Amount",
                      text: "${transactionInfos?.transactionAmount}"),
                  const  SizedBox(
                    height: 25,
                  ),
                  rowBuilder(att: "Payment Type", text:"${transactionInfos?.paiementType}"),
                  const  SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/2.5,
                    child: Material(
                      borderRadius: BorderRadius.circular(30),
                      color: blueGreyColor,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30),
                        onTap: () {
                          String? destinataire = AppCubit.get(context).userModel?.data.phoneNumber;
                          String? emetteur = transactionInfos?.merchandPhoneNumber;
                          print("hello");
                          AppCubit.get(context).Makevirement(transactionInfos?.transactionAmount, destinataire, "hi",emetteur!);

                        },
                        child: Ink(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(40)),
                            child: const Text(
                              'Accept Transfer',
                              style: TextStyle(color: Colors.white,fontSize: 15),
                            ),
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
