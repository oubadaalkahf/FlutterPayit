import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testingg/cubit/app_cubit.dart';
import 'package:testingg/cubit/app_states.dart';
import 'package:testingg/models/TransactionModel.dart';



class TransactionSentScreen extends StatelessWidget {
  const TransactionSentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        ?.addPostFrameCallback((_) => AppCubit.get(context).showHistoryEmetteur(AppCubit.get(context).userModel?.data.phoneNumber));
    return BlocConsumer<AppCubit,AppStates>( listener: (context,state){

    },
        builder: (context,state){
          return  Expanded(
            child: ListView.builder(

              itemBuilder: (context,index)=> historyWidget(AppCubit.get(context).transactionsEmetteur[index]),


              itemCount: AppCubit.get(context).transactionsEmetteur.length,

              shrinkWrap: true,

              physics: BouncingScrollPhysics(),
            ),
          );
        });
  }
  Widget historyWidget(TransactionModel transaction) {
    return Container(
//      height: 100.0,
      margin: EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
            //    child: Image.asset("images/ico_send_money.png",width: 40,height: 40,),
                child: Icon(Icons.arrow_circle_up_sharp,size: 30,color: Colors.red,)
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
            transaction.destinataire.contains("bank") ?           Text(
              "Withdraw to",
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ):          Text(
              "Sent to",
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
                      Text("${transaction.destinataire}")
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "${transaction.montant} MAD",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "${ transaction.dateTransaction}",
                              textAlign: TextAlign.right,
                            ),
                          ),

                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
