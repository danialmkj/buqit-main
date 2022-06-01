




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
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';






class RecoveryPassword extends HookWidget{


  @override
  Widget build(BuildContext context) {



    final formState=useState(GlobalKey<FormBuilderState>());

    var email=ModalRoute.of(context)?.settings.arguments as String;





    useEffect((){

      Future.delayed(Duration(milliseconds: 10),(){
        Provider.of<AuthProvider>(context,listen: false).sendPasswordRecoveryCode(context,email:email,onSuccess:(res){},onFail:(e){});
      });
    },[]);


    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          bool? validated=formState.value.currentState?.validate();

          if(validated==true){

            String code=formState.value.currentState?.value['code'];
            // Navigator.of(context).pushNamed(Pages.changePassword,arguments: email);

            Provider.of<AuthProvider>(context,listen: false).verifyPasswordRecoveryCode(context,email:email,code:code,onSuccess:(res)async{

              // print(res);
              Navigator.of(context).pushNamed(Pages.changePassword,arguments: {"email":email,"id":res.data['data'],"code":code});




            });


          }else{

          }


        },
        child: Icon(CupertinoIcons.arrow_right),

      ),
      appBar: CustomAppbar(
        title: "Recover Password",
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
                    child: Wrap(
                      children: [
                        Typo(text: "Enter the 6-digit code sent to you at ",size:15),
                        Typo(text:email,bold:true,size:16),
                      ],
                    ),
                  ),
                  FormBuilder(
                      key: formState.value,
                      child: Column(
                        children: [
                          FormTextField(
                              form:formState.value,
                              name: "code",hint:"Verification code",validators:FormBuilderValidators.compose([

                            FormBuilderValidators.required(context),
                          ])),
                        ],
                      )),
                  SizedBox(height: 100,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                        onTap: (){

                          Provider.of<AuthProvider>(context,listen: false).resendPasswordRecoveryCode(context,email:email, onSuccess: (res){
                            Fluttertoast.showToast(
                                msg: "New verification code has been sent.",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          });
                        },
                        child: Container(
                            margin: EdgeInsets.only(bottom:30),
                            child: Typo(text:"Resend code",color:Colour.primaryBlue,size:16))),
                  )
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

}