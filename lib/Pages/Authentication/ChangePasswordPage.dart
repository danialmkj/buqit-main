




import 'dart:convert';
import 'dart:io';

import 'package:buqit/Pages/Pages.dart';
import 'package:buqit/States/Authentication/AuthProvider.dart';
import 'package:buqit/Utils/Colour.dart';
import 'package:buqit/Utils/Network/Api.dart';
import 'package:buqit/Utils/Network/NetworkManager.dart';
import 'package:buqit/Widgets/Appbar/CustomAppbar.dart';
import 'package:buqit/Widgets/Form/FormTetField.dart';
import 'package:buqit/Widgets/Typo.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:device_info/device_info.dart';
import 'package:provider/provider.dart';

class ChangePasswordPage extends HookWidget{
  @override
  Widget build(BuildContext context) {



    final formState=useState(GlobalKey<FormBuilderState>());

    dynamic passedValues=ModalRoute.of(context)?.settings.arguments ;
    print(passedValues);
    var email=passedValues['email'] ;
    var userId=passedValues['id'] ;
    var code=passedValues['code'] ;







    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async{

          String password=formState.value.currentState?.value['password'];

          Provider.of<AuthProvider>(context,listen: false).changePassword(context,email:email,id:userId,password:password, onSuccess: (r){

            Navigator.of(context).pop();
            Navigator.of(context).pop();
            print(r);
          }, code: code);

        },
        child: Icon(CupertinoIcons.arrow_right),

      ),
      appBar: CustomAppbar(
        title: "New Password",
      ),
      body: SafeArea(
        bottom: true,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Typo(maxLines:3,text: "Changing your password will sign you out of all devices. You will need to enter your new password on all your devices.",color: Colors.grey,size:15),
                  ),
                  const SizedBox(height: 30,),
                  FormBuilder(
                      key: formState.value,
                      child: Column(
                        children: [
                          FormTextField(form:formState.value,name: "password",hint:"New password",secure:true),
                        ],
                      )),
                  const SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Typo(text: "Password strength",bold:true),
                        Typo(maxLines:3,text: "Secure passwords contain 8 or more characters with a mix of letters, numbers & symbols.",color: Colors.grey,),
                      ],
                    ),
                  )
                ],
              ),
              // Align(alignment: Alignment.bottomLeft,child:Padding(
              //   padding: const EdgeInsets.only(bottom:15),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       GestureDetector(
              //           onTap: (){
              //             Navigator.of(context).pushNamed(Pages.recoverPassword,arguments: email);
              //           },
              //           child: Typo(text:"I forgot my password",color:Colour.primaryBlue)),
              //       SizedBox(height: 10,),
              //       GestureDetector(
              //           onTap: (){
              //             Navigator.of(context).pushNamed(Pages.register);
              //           },
              //           child: Typo(text:"I don't have an account",color:Colour.primaryBlue)),
              //     ],
              //   ),
              // ),)
            ],
          ),
        ),
      ),
    );
  }

}