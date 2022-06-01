



import 'dart:convert';
import 'dart:io';

import 'package:buqit/Pages/Pages.dart';
import 'package:buqit/States/Authentication/AuthProvider.dart';
import 'package:buqit/Utils/Colour.dart';
import 'package:buqit/Utils/Network/Api.dart';
import 'package:buqit/Utils/Network/NetworkManager.dart';
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

class EnterPromoCodePage extends HookWidget{

  @override
  Widget build(BuildContext context) {

    final formState=useState(GlobalKey<FormBuilderState>());

    return Scaffold(

      appBar: AppBar(centerTitle: false,title:Typo(text:"Promotions",color: Colors.black,size:20),elevation: 0,backgroundColor: Colors.transparent,iconTheme: IconThemeData(color: Colors.black),),
      body: SafeArea(
        bottom: true,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  FormBuilder(
                      key: formState.value,
                      child: Column(
                        children: [
                          FormTextField(form:formState.value,name: "code",hint:"Enter code",numeric:true),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Wrap(
                      direction: Axis.horizontal,
                      children: [
                        Typo(text: "By tapping 'Apply',you agree to the Promotional Code",maxLines: 2,),
                        Typo(text:"Terms and Conditions",style: TextStyle(decoration: TextDecoration.underline,color:Colour.primaryBlue),),
                      ],
                    )
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)
                    ),
                    primary: Colour.primaryBlue),
                onPressed: (){
                  Navigator.of(context).pop(formState.value.currentState?.value['code']);
                },
                // onPressed:selectedTime.value==null ? null : (){},
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 13),
                    child: Typo(text:"APPLY",size:16)),
              ),
              // Align(alignment: Alignment.bottomLeft,child:Typo(text:"I don't have an account",color:Colour.primaryBlue),)
            ],
          ),
        ),
      ),
    );
  }

}