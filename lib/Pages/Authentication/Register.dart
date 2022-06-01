

import 'package:buqit/Pages/Pages.dart';
import 'package:buqit/States/Authentication/AuthProvider.dart';
import 'package:buqit/Utils/Colour.dart';
import 'package:buqit/Widgets/Appbar/CustomAppbar.dart';
import 'package:buqit/Widgets/Form/FormTetField.dart';
import 'package:buqit/Widgets/Typo.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

class RegisterPage extends HookWidget{
  @override
  Widget build(BuildContext context) {
    final formState=useState(GlobalKey<FormBuilderState>());

    String email=ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          bool? validated=formState.value.currentState?.validate();

          print(formState.value.currentState!.value);
          if(validated==true){

            var value=formState.value.currentState!.value;

            String old=value['phone'];
            String neww="";
            neww=old.substring(0,3) + "-" + old.substring(3,8) + "-" + old.substring(8);
            // proccessedPhone.
            // print(neww);
            Provider.of<AuthProvider>(context,listen: false).register(context,
                phone:"${value['code']} ${neww}" ,
                firstName: value['firstName'],
                email:email,
                lastName: value['lastName'],
                password: value['password'],

                onSuccess: (res){


                    print("register email->$email");
                    Navigator.of(context).pushNamed(Pages.verify,arguments: email);

                },
            );
            // Navigator.of(context).pushNamed(Pages.password,arguments: formState.value.currentState?.value['email']);
          }else{

          }


        },
        child: Icon(CupertinoIcons.arrow_right),

      ),
      appBar: CustomAppbar(
        title: "Sign up",
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
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 20),
                  //   child: Typo(text: "Enter the email address you used to register"),
                  // ),
                  FormBuilder(
                      key: formState.value,
                      child: Column(
                        children: [
                          FormTextField(
                            style: TextFieldStyle.Outline,
                              form:formState.value,
                              name: "firstName",hint:"First name",validators:FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),

                          ])),
                          FormTextField(
                              style: TextFieldStyle.Outline,
                              form:formState.value,
                              name: "lastName",hint:"Last name",validators:FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                          ])),

                          Container(
                            padding: EdgeInsets.only(left:20),

                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              Column(
                                children: [
                                  Container(height: 10,),
                                  Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                          border: Border.all(color:Colors.grey.shade900,width: 0.4),
                                          borderRadius: BorderRadius.circular(4)
                                        ),
                                        child: CountryCodePicker(
                                          padding: EdgeInsets.only(top: 2,bottom:2,right:20),
                                         flagDecoration: BoxDecoration(
                                           border: Border.all(color:Colors.grey,width: 0.4),


                                         ),

                                          onChanged: (v){
                                            formState.value.currentState?.setInternalFieldValue('code', v, isSetState: true);
                                          },
                                          // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                          initialSelection: 'IT',
                                          favorite: ['+39','FR'],
                                          // optional. Shows only country name and flag
                                          showCountryOnly: false,
                                          // optional. Shows only country name and flag when popup is closed.
                                          showOnlyCountryWhenClosed: false,
                                          // optional. aligns the flag and the Text left
                                          alignLeft: false,
                                        ),
                                      ),
                                      Positioned(
                                          right:0,
                                          top:10,
                                          child: Icon(Icons.arrow_drop_down,color: Colors.grey.shade900,))
                                    ],
                                  ),

                                ],
                              ),
                              Expanded(child: FormTextField(
                                  style: TextFieldStyle.Outline,
                                  form:formState.value,
                                  numeric: true,
                                  name: "phone",hint:"Phone",validators:FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                              ])),)
                            ],),
                          ),
                          // Container(
                          //   padding: EdgeInsets.symmetric(horizontal: 20),
                          //   child: IntlPhoneField(
                          //
                          //     dropdownDecoration: BoxDecoration(
                          //       border: Border.all(color:Colors.grey),
                          //       borderRadius: BorderRadius.circular(5)
                          //     ),
                          //
                          //     decoration:  InputDecoration(
                          //       isDense: true,
                          //       counter: Container(),
                          //       hintStyle: const TextStyle(
                          //           color: Color(0xffB5B6B3),
                          //           fontSize: 16.0,
                          //           fontWeight: FontWeight.w500),
                          //       contentPadding: EdgeInsets.all(15.0),
                          //       hintText: "Phone Number",
                          //       border: const OutlineInputBorder(
                          //         borderSide: BorderSide(color: Colour.primaryBlue,width:1.5),
                          //         // borderRadius: BorderRadius.circular(15.0),
                          //       ),
                          //       // labelText: 'Phone Number',
                          //     ),
                          //     initialCountryCode: 'IN',
                          //     onChanged: (phone) {
                          //       formState.value.currentState?.setInternalFieldValue("phone", phone.completeNumber);
                          //     },
                          //   ),
                          // ),
                          FormTextField(
                              style: TextFieldStyle.Outline,
                              form:formState.value,
                              name: "password",hint:"Password",
                              secure: true,
                              validators:FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                          ])),
                          FormTextField(
                              style: TextFieldStyle.Outline,
                              form:formState.value,
                              name: "confirmPassword",hint:"Confirm password",
                              secure: true,
                              validators:FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                              ])),

                        ],
                      )),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Typo(text: "Use 8 or more characters with a mix of letters, numbers & symbols.",bold:true,maxLines: 3,)),
                ],
              ),

              Align(alignment: Alignment.bottomLeft,child:Container(
                margin: EdgeInsets.only(right:50,bottom: 25),
                child: RichText(
                  text: TextSpan(
                    text: 'By Signing up,you agree to our',
                    style: TextStyle(
                        color: Color(0xff292A2A),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400),
                    /*defining default style is optional */
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Terms & Conditions',
                        recognizer: TapGestureRecognizer(),
                        // ..onTap = () async {
                        //   var url =
                        //       "https://buqit.com/appointmentPayment-method";
                        //   if (await canLaunch(url)) {
                        //     await launch(url);
                        //   } else {
                        //     throw 'Could not launch $url';
                        //   }
                        // },
                        style: TextStyle(
                            color: Colour.primaryBlue,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500),
                      ),
                      // TextSpan(
                      //   text: 'Data Policy',
                      //   // recognizer: TapGestureRecognizer()
                      //   //   ..onTap = () async {
                      //   //     var url =
                      //   //         "https://buqit.com/appointmentPayment-method";
                      //   //     if (await canLaunch(url)) {
                      //   //       await launch(url);
                      //   //     } else {
                      //   //       throw 'Could not launch $url';
                      //   //     }
                      //   //   },
                      //   style: TextStyle(
                      //       color: Color(0xff63B803),
                      //       fontSize: 16.0,
                      //       fontWeight: FontWeight.w500),
                      // ),
                      TextSpan(
                        text: ' and ',
                        style: TextStyle(
                            // color: Color(0xff292A2A),
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400),
                      ),
                      TextSpan(
                        text: 'Privacy Policy',
                        // recognizer: TapGestureRecognizer()
                        //   ..onTap = () async {
                        //     var url =
                        //         "https://buqit.com/appointmentPayment-method";
                        //     if (await canLaunch(url)) {
                        //       await launch(url);
                        //     } else {
                        //       throw 'Could not launch $url';
                        //     }
                        //   },
                        style: TextStyle(
                            color: Colour.primaryBlue,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500),
                      ),
                      TextSpan(
                        text: '.',
                        style: TextStyle(
                            // color: Color(0xff292A2A),
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),)
            ],
          ),
        ),
      ),
    );


  }

}