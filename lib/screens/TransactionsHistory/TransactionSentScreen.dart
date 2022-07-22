import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testingg/cubit/app_cubit.dart';
import 'package:testingg/cubit/app_states.dart';
import 'package:testingg/models/TransactionModel.dart';
import 'package:testingg/shared/component.dart';



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

              itemBuilder: (context,index)=> historyWidget(AppCubit.get(context).transactionsEmetteur[index],context),


              itemCount: AppCubit.get(context).transactionsEmetteur.length,

              shrinkWrap: true,

              physics: BouncingScrollPhysics(),
            ),
          );
        });
  }

}
