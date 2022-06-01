


import 'package:buqit/Models/Profile/Profile.dart';
import 'package:buqit/States/Authentication/AuthProvider.dart';
import 'package:buqit/Utils/Colour.dart';
import 'package:buqit/Widgets/Appbar/CustomAppbar.dart';
import 'package:buqit/Widgets/Form/FormTetField.dart';
import 'package:buqit/Widgets/Typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';



enum FieldType{
  firstName,
  lastName,
  email,
  phone
}



class UpdateProfileField extends HookWidget{





  @override
  Widget build(BuildContext context) {

    FieldType type=ModalRoute.of(context)?.settings.arguments as FieldType;

    final formState=useState(GlobalKey<FormBuilderState>());

    final controller=useTextEditingController();

    Profile? profile=Provider.of<AuthProvider>(context).profile;
    String label="";

    switch(type){

      case FieldType.firstName:
        label="First Name";
        break;
      case FieldType.lastName:
        label="Last Name";
        break;
      case FieldType.email:
        label="Email";
        break;
      case FieldType.phone:
        label="Phone Number";
        break;
    }


    useEffect((){

      switch(type){

        case FieldType.firstName:
          controller.text=profile!.firstName;
          break;
        case FieldType.lastName:
          controller.text=profile!.lastName;
          break;
        case FieldType.email:
          controller.text=profile!.email;
          break;
        case FieldType.phone:
          controller.text=profile!.phone;
          break;
      }


    },[]);



    return Scaffold(
      appBar: CustomAppbar(title: "Update $label",),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Typo(text: label,bold:true,size:16),

                SizedBox(height: 10,),

                FormBuilder(
                    key: formState.value,
                    child: Column(

                      children: [
                        FormBuilderTextField(
                            controller: controller,
                            onChanged: (s){
                              controller.text=s!;
                            },



                            name: "field",validator:FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                        ])),
                      ],
                    )),
              ],
            ),

              SizedBox(height: 25,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)
                    ),
                    primary: Colour.primaryBlue),
                onPressed: (){

                  Map<String,dynamic> map={};

                  String? value=controller.text;

                  switch(type){
                    case FieldType.firstName:
                     map['firstName']=value;
                      break;
                    case FieldType.lastName:
                      map['lastName']=value;
                      break;
                    case FieldType.email:
                      map['email']=value;
                      break;
                    case FieldType.phone:
                      // TODO: Handle this case.
                      break;
                  }

                  Provider.of<AuthProvider>(context,listen: false).updateField(context,type:type,onSuccess:(res){
                        Navigator.of(context).pop();
                  }, data: map);
                },
                // onPressed:selectedTime.value==null ? null : (){},
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 13),
                    child: Typo(text:"UPDATE",size:16)),
              ),


            ],



          ),
        ),
      ),
    );
  }

}