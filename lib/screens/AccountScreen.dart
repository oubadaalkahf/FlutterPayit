import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testingg/cubit/app_cubit.dart';
import 'package:testingg/cubit/app_states.dart';
import 'package:testingg/models/userModel.dart';
import 'package:testingg/network/local/cache_helper.dart';


import 'HomeScreen.dart';
import 'Routes/CustomPageRouteRight.dart';

class AccountScreen extends StatelessWidget {
  static String id = "ACCOUNT";

  const  AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String swift = CacheHelper.getData(key: 'swift');
    UserModel? userModel = AppCubit.get(context).userModel;
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).push(
                      CustomPageRouteRight(child:const HomeScreen()),
                    );
                  },
                ),
                backgroundColor:const Color(0xff4c91bc),
                elevation: 2,
                actions: const [],
                title:const Padding(
                  padding: EdgeInsets.only(left: 78.0),
                  child: Text(
                    'Mon Compte',
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
                          child: Column(
                            children: [
                              const Icon(Icons.person_outline,color: Colors.white60,size: 120,),
                              Text(
                                "${userModel?.data.solde} DH",
                                style:const TextStyle(
                                    color: Colors.white,
                                    fontSize: 21,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: 'avenir'),
                              ),
                            ],
                          ),
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
                            att: "Nom",
                            text: "${userModel?.data.firstName.toUpperCase()}"),
                        const SizedBox(
                          height: 25,
                        ),
                        rowBuilder(
                            att: "Prenom",
                            text: "${userModel?.data.lastName.toUpperCase()}"),
                        const  SizedBox(
                          height: 25,
                        ),
                        rowBuilder(
                            att: "E-mail",
                            text: "${userModel?.data.email.toUpperCase()}"),
                        const  SizedBox(
                          height: 25,
                        ),
                        rowBuilder(
                            att: "Numéro de téléphone",
                            text: "${userModel?.data.phoneNumber}"),
                        const  SizedBox(
                          height: 25,
                        ),
                        rowBuilder(att: "Banque", text: swift.toUpperCase()),
                        const  SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const    Text(
                              'Dernières opérations ',
                              style: TextStyle(fontSize: 17),
                            ),
                            InkWell(
                              onTap: (){},
                              child: Ink(
                                child:  SizedBox(
                                  height: 50,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Text('HISTORIQUE', style: TextStyle(
                                        color: Color(0xff4c91bc),
                                      ),), // <-- Text
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon( // <-- Icon
                                        Icons.arrow_forward_sharp,
                                        size: 24.0,
                                        color: Color(0xff4c91bc),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }
}

Widget rowBuilder({
  required String text,
  required String att,
}) {
  return Padding(
    padding:const EdgeInsets.only(left: 15, right: 15),
    child: Container(
      height: 35,
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(
          color: Colors.grey.shade300,
          width: 0.5,
        ),
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            att,
            style:const TextStyle(
                color: Colors.black54,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: 'avenir'),
          ),
          const  Spacer(),
          Text(
            text,
            style: GoogleFonts.pragatiNarrow(
              letterSpacing: 0.5,
              textStyle:const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    ),
  );
}
