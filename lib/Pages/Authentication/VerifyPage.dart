

import 'package:buqit/Pages/Pages.dart';
import 'package:buqit/States/Authentication/AuthProvider.dart';
import 'package:buqit/States/Drawer/DrawerProvider.dart';
import 'package:buqit/Utils/Colour.dart';
import 'package:buqit/Utils/Network/Api.dart';
import 'package:buqit/Utils/Network/NetworkManager.dart';
import 'package:buqit/Widgets/Appbar/CustomAppbar.dart';
import 'package:buqit/Widgets/Form/FormTetField.dart';
import 'package:buqit/Widgets/Typo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';






class VerifyPage extends HookWidget{


  @override
  Widget build(BuildContext context) {



    final formState=useState(GlobalKey<FormBuilderState>());

    var email=ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          bool? validated=formState.value.currentState?.validate();

          if(validated==true){

            String code=formState.value.currentState?.value['code'];

            Provider.of<AuthProvider>(context,listen: false).verifyEmail(context,email:email,code:code,onSuccess:(res)async{

              final storage = new FlutterSecureStorage();
              String? id=await storage.read(key: "ID");

              Provider.of<DrawerProvider>(context,listen: false).getDrawerItems(context,userId:id);

              Navigator.of(context).pushReplacementNamed(Pages.home);


            });


          }else{

          }


        },
        child: Icon(CupertinoIcons.arrow_right),

      ),
      appBar: CustomAppbar(
        title: "",
      ),
      body: SafeArea(
        bottom: true,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Typo(text: "Enter the code you received"),
                  ),
                  FormBuilder(
                      key: formState.value,
                      child: Column(
                        children: [
                          FormTextField(
                              form:formState.value,
                              name: "code",hint:"Received Code",validators:FormBuilderValidators.compose([

                            FormBuilderValidators.required(context),
                          ])),
                        ],
                      )),
                ],
              ),
              Align(alignment: Alignment.bottomLeft,child:GestureDetector(
                  onTap: (){

                    Provider.of<AuthProvider>(context,listen: false).resendCode(context, onSuccess: (res){

                    });
                  },
                  child: Container(
                      margin: EdgeInsets.only(bottom:30),
                      child: Typo(text:"Resend the verification code.",color:Colour.primaryBlue,size:16))),)
            ],
          ),
        ),
      ),
    );
  }

}