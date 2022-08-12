import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testingg/cubit/app_cubit.dart';
import 'package:testingg/cubit/app_states.dart';
import 'package:testingg/screens/AccueilScreen.dart';
import 'package:testingg/screens/SettingsScreen.dart';
import 'package:testingg/screens/Transfer/BillTransactionDetails.dart';
import 'package:testingg/screens/Transfer/TransferQrCodeResult.dart';
import 'package:testingg/screens/Transfer/TransferMoney.dart';
import 'package:testingg/shared/SideMenu.dart';
import 'package:text_form_field_wrapper/text_form_field_wrapper.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:status_change/status_change.dart';

import '../../shared/PopUp.dart';
import '../HomeScreen.dart';
import '../Routes/CustomPageRouteRight.dart';

class FormulaireTransfert extends StatefulWidget {
  FormulaireTransfert({Key? key}) : super(key: key);

  @override
  State<FormulaireTransfert> createState() => _FormulaireTransfertState();
}
enum point_of_initiation_methode { dynamic, static }
class _FormulaireTransfertState extends State<FormulaireTransfert> {
  var pointofinitiationmethode = TextEditingController();

  var transactionAmount = TextEditingController();
  var purposeOfTransaction = TextEditingController();




  // List of items in our dropdown menu

  String valueOfTransactionCurrency = '504';


  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("MAD"), value: "504"),
      DropdownMenuItem(child: Text("EURO"), value: "978"),
      DropdownMenuItem(child: Text("USD"), value: "840"),
    ];
    return menuItems;
  }

  String selectedValue = "504";
  String valueofoftransactioncurrency = '504';

  List<DropdownMenuItem<String>> get oeration_type {
    List<DropdownMenuItem<String>> operationType = [
      DropdownMenuItem(child: Text("Transfer P2P"), value: "0"),
      DropdownMenuItem(
          child: Text("Paiement commercant a face 2 face"), value: "1"),
      DropdownMenuItem(
          child: Text("Paiement commercant a distance"), value: "2"),
      DropdownMenuItem(child: Text("Paiement FMCG"), value: "3"),
    ];
    return operationType;
  }

  String valueOfOperationType = '0';
  String selectedValueOperationType = "0";

  point_of_initiation_methode? character = point_of_initiation_methode.dynamic;
  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();
    return BlocConsumer<AppCubit,AppStates>( listener: (context,state){
      if(state is AppGeneratedQrCodeSuccessStates)
        {
          navigateTo(context, TransferQrCodeResult());
        }
    },builder: (context,state){

     return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context)
                  .push(CustomPageRouteRight(child: TransferRoute()));
            },
          ),
          title: Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: const Text(
              'Envoi de l\'argent',
              style: TextStyle(color: Colors.white),
            ),
          ),
          backgroundColor: Color(0xff4c91bc),
          elevation: 0,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 60,left: 15),
            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Container(
                  width: 350,
                  constraints: const BoxConstraints(maxWidth: 600),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Point of Initiation method',
                        style: TextStyle(fontSize: 18, color: Colors.blueGrey,),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      RadioListTile<point_of_initiation_methode>(
                        title: const Text('dynamic'),
                        value: point_of_initiation_methode.dynamic,
                        groupValue: character,
                        onChanged: (point_of_initiation_methode? value) {
                          setState(() {
                            character = value;
                          });
                        },
                      ),
                      RadioListTile<point_of_initiation_methode>(
                        title: const Text('static'),
                        value: point_of_initiation_methode.static,
                        groupValue: character,
                        onChanged: (point_of_initiation_methode? value) {
                          setState(() {
                            character = value;
                          });
                        },
                      ),
                      SizedBox(height: 8,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Transaction Amount', style: TextStyle(
                            fontSize: 16, color: Colors.blueGrey,)),
                          Text('Transaction Currency', style: TextStyle(
                            fontSize: 16, color: Colors.blueGrey,)),
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 150,
                            child: TextFormField(
                              controller: transactionAmount,

                              validator: (value) {
                                if (value!.isEmpty) {
                                  return " the Transaction  Amount must not be empty";
                                }
                              },
                              keyboardType: TextInputType.phone,

                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 6),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xff4c91bc), width: 2.0),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0)),
                                ),
                            ),
                          ),
                          Container(
                            width: 150,
                            child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 6),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  filled: true,
                                ),
                                value: selectedValue,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedValue = newValue!;
                                  });
                                },
                                items: dropdownItems),
                          ),


                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text('Purpose Of Transaction', style: TextStyle(
                        fontSize: 18, color: Colors.blueGrey,)),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                          inputFormatters: <TextInputFormatter>[

                          ],
                        controller: purposeOfTransaction,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return " the Purpose Of Transaction must not be empty";
                          }
                        },

                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 6),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0xff4c91bc), width: 2.0),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          )
                      ),
                      SizedBox(height: 8,),
                      Text(('Operation type'), style: TextStyle(
                        fontSize: 18, color: Colors.blueGrey,)),
                      SizedBox(height: 8,),
                      Container(
                        height: 55,
                        decoration: ShapeDecoration(

                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1.0,
                                style: BorderStyle.solid,
                                color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                        margin: EdgeInsets.only(),
                        width: double.infinity,
                        child:      Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: DropdownButtonFormField(

                            decoration: InputDecoration(border: InputBorder.none,

                            ),

                            items: oeration_type,
                            value:selectedValueOperationType ,
                            onChanged: (String? value) {
                              setState(() {
                                selectedValueOperationType = value!;
                              });
                            },
                          ),
                        ),

                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 210.0),
                        child: Container(
                          width: 135,
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: AnimatedButton(
                            text: 'VALIDER',
                            color: Color(0xff4c91bc),
                            pressEvent: () {
                              if (formkey.currentState!.validate()) {
                                AwesomeDialog(
                                context: context,

                                dialogType: DialogType.WARNING,
                                headerAnimationLoop: false,
                                animType: AnimType.TOPSLIDE,
                                showCloseIcon: true,
                                title: 'INFOS',
                                desc:
                                'Vous venez d\'envoyer un montant de ${transactionAmount.text} DH ',
                                btnCancelOnPress: () {Navigator.of(context).push(
                                  CustomPageRouteRight(child: HomeScreen()),
                                ); },
                                btnOkOnPress: ()  {
                                   {
                                    print("hiiiiiiiiii");
                                    print(character?.name);
                                    print("hiiiiiiiiii2");
                                    print(transactionAmount.text);
                                    AppCubit.get(context).transferp2p(
                                        '${character?.name}',

                                        AppCubit.get(context).userModel!.data.phoneNumber,
                                        selectedValue,
                                        transactionAmount.text,
                                        purposeOfTransaction.text,
                                        selectedValueOperationType);

                                  }
                                },
                              ).show();
                              }
                            },
                          ),
                        ),
                      ),

                    /*  Padding(
                        padding: const EdgeInsets.only(left: 210.0),
                        child: RaisedButton(
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              print("hiiiiiiiiii");
                              print(character?.name);
                              print("hiiiiiiiiii2");
                              print(transactionAmount.text);
                              AppCubit.get(context).transferp2p(
                                  '${character?.name}',
                                  "+212" + phoneNumber.text,
                                  selectedValue,
                                  transactionAmount.text,
                                  purposeOfTransaction.text,
                                  selectedValueOperationType);

                            }
                          },
                          textColor: Color(0xffFFFFFF),
                          padding: EdgeInsets.all(0),
                          shape: StadiumBorder(),
                          child: Container(
                            width: 155,
                            height: 55,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xff4c91bc),
                            ),
                            child: Text(
                              'VALIDER',
                              style: GoogleFonts.manrope(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                        ),
                      ), */
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },);
  }





}

