
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testingg/cubit/app_cubit.dart';
import 'package:testingg/screens/Payment/PaiementQrCodeResult.dart';

import 'package:testingg/screens/Payment/PaymentRoute.dart';

import '../../cubit/app_states.dart';
import '../../shared/PopUp.dart';
import '../Routes/CustomPageRouteRight.dart';



class FormulairePayment extends StatefulWidget {
// List of items in our dropdown menu
  FormulairePayment({Key? key}) : super(key: key);

  @override
  State<FormulairePayment> createState() => _FormulairePaymentState();
}

enum point_of_initiation_methode { dynamic, static }

class _FormulairePaymentState extends State<FormulairePayment> {
  var pointofinitiationmethode = TextEditingController();
  var phonenNumber = TextEditingController();
  var transactionAmount = TextEditingController();
  var purposeOfTransaction = TextEditingController();
  var financialinstitutioncode = TextEditingController();
  var oerationtype = TextEditingController();
  var merchantcategory = TextEditingController();
  var merchantname = TextEditingController();
  var merchantcity = TextEditingController();

  //operation_type
  List<DropdownMenuItem<String>> get oeration_type_Payment {
    List<DropdownMenuItem<String>> operation_type = [
      DropdownMenuItem(child: Text("Transfer P2P"), value: "0"),
      DropdownMenuItem(
          child: Text("Paiement commercant a face 2 face"), value: "1"),
      DropdownMenuItem(
          child: Text("Paiement commercant a distance"), value: "2"),
      DropdownMenuItem(child: Text("Paiement FMCG"), value: "3"),
    ];
    return operation_type;
  }

  String valueOfOperationType = '0';
  String selectedValueOperationTypePayment = "0";

  // Initial Selected Value
  String valueofoperationtype = 'Transfer P2P';

  // List of items in our dropdown menu
  var Operation_type= [
    'Transfer P2P',
    'Paiement commercant a face 2 face',
    'Paiement commercant a distance',
    'Paiement FMCG',
  ];
  String valueofoftransactioncurrency = '504';

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("MAD"), value: "504"),
      DropdownMenuItem(child: Text("EURO"), value: "978"),
      DropdownMenuItem(child: Text("USD"), value: "840"),
    ];
    return menuItems;
  }

  String selectedValue = "504";
  List<DropdownMenuItem<String>> get dropdowncountrycode {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("MAROC"), value: "MA"),
      DropdownMenuItem(child: Text("USA"), value: "US"),
      DropdownMenuItem(child: Text("Royaume-Uni"), value: "GB"),
    ];
    return menuItems;
  }
  String selectedcountrycode = "MA";
  point_of_initiation_methode? character =
      point_of_initiation_methode.dynamic;


  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();
    return BlocConsumer<AppCubit,AppStates>( listener: (context,state){
      if(state is AppGeneratedQrCodeSuccessStates)
      {
        navigateTo(context, PaimentQrCodeResult());
      }
    },builder: (context,state){

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context)
                .push(CustomPageRouteRight(child: PaymentRoute()));
          },
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 50.0),
          child: const Text(
            'mode commerçant',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Color(0xff4c91bc),
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Container(
                width: 350,
                constraints: const BoxConstraints(maxWidth: 600),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Point of Initiation method',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blueGrey,
                      ),
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
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Phone number',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blueGrey,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(9),
                      ],
                      controller: phonenNumber,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return " Phone Number must not be empty";
                        }
                      },
                      decoration: InputDecoration(
                        prefix:Text("+212 | "),
                        contentPadding: const EdgeInsets.symmetric(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xff4c91bc), width: 2.0),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Transaction Amount',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blueGrey,
                            )),
                        Text('Transaction Currency',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blueGrey,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 150,
                          child: TextFormField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(4),
                            ],
                            controller: transactionAmount,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Transaction  Amount must not be empty";
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
                          height: 60,
                          child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 2),
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
                    Text('Purpose Of Transaction',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.blueGrey,
                        )),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: purposeOfTransaction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Purpose Of Transaction must not be empty";
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
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text('financial institution code',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.blueGrey,
                        )),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(3),
                      ],
                      keyboardType: TextInputType.phone,
                      controller: financialinstitutioncode,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "financial institution code must not be empty";
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
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text('Operation type',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.blueGrey,
                        )),
                    SizedBox(
                      height: 8,
                    ),
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
                      child: DropdownButtonFormField(
                        items: oeration_type_Payment,
                        value:selectedValueOperationTypePayment ,
                        onChanged: (String? value) {
                          setState(() {
                            selectedValueOperationTypePayment = value!;
                          });
                        },
                      ),

                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text('merchant category\ncode',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.blueGrey,
                            )),
                        SizedBox(width: 14,),
                        Text('country code\n',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.blueGrey,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 150,
                          child: TextFormField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(3),
                            ],
                            keyboardType: TextInputType.phone,
                            controller: merchantcategory,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "merchant category code must not be empty";
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
                            ),
                          ),
                        ),
                        SizedBox(width: 5,),
                        Container(
                          width: 150,
                          child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                contentPadding:
                                const EdgeInsets.symmetric(horizontal: 6),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,
                              ),
                              value: selectedcountrycode,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedcountrycode = newValue!;
                                });
                              },
                              items: dropdowncountrycode),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text('merchant name',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.blueGrey,
                        )),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: merchantname,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return " merchant name must not be empty";
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
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text('merchant city',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.blueGrey,
                        )),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: merchantcity,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return " merchant city must not be empty";
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
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 210.0),
                      child: RaisedButton(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {

                            AppCubit.get(context).PaimnentCommercant(
                              '${character?.name}',
                              "+212" + phonenNumber.text,
                              selectedValue,
                              transactionAmount.text,
                              purposeOfTransaction.text,
                              selectedValueOperationTypePayment,
                              merchantcategory.text,
                              selectedcountrycode,
                              merchantname.text,
                              merchantcity.text,
                            );
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
                    ),
                    SizedBox(
                      height: 10,
                    ),
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
