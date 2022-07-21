import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:testingg/cubit/app_cubit.dart';
import 'package:testingg/cubit/app_states.dart';
import 'package:testingg/shared/Colors.dart';


class TransactionsHistory extends StatelessWidget {
  const TransactionsHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(listener: (context,state){},builder: (context,state){
      return Scaffold(
        appBar: AppBar(
          title: Text("History"),
          backgroundColor: blueGreyColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child:   Column(
            children: [
              FlutterToggleTab(
// width in percent
                width: 90,
                borderRadius: 30,
                height: 50,
                selectedIndex: AppCubit.get(context).currentIndexHistory,

                selectedBackgroundColors: [blueGreyColor, blueGreyColor],

                selectedTextStyle:

                TextStyle(
                    color: Colors.white,
                    fontSize: 18,

                    fontWeight: FontWeight.w700),
                unSelectedTextStyle:

                TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
                labels: ["Receive","Sent"],
                selectedLabelIndex: (index) {
                  AppCubit.get(context).changeBottomHistory(index);
                },
                isScroll: false,
              ),

          SizedBox(height: 10,),
              AppCubit.get(context)
                  .screensHistory[AppCubit.get(context).currentIndexHistory],

            ],
          ),
        ),
      );
    } );
  }

}
