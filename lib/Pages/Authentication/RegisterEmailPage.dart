import 'package:buqit/States/Authentication/AuthProvider.dart';
import 'package:buqit/Utils/Colour.dart';
import 'package:buqit/Widgets/Appbar/CustomAppbar.dart';
import 'package:buqit/Widgets/Form/FormTetField.dart';
import 'package:buqit/Widgets/Typo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class RegisterEmailPage extends HookWidget {

  @override
  Widget build(BuildContext context) {
    final formState = useState(GlobalKey<FormBuilderState>());

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          bool? validated = formState.value.currentState?.validate();

          if (validated == true) {
            String? email = formState.value.currentState?.value['email']??'Email Not Found';
           // print('email is : ....' + email!);
            Provider.of<AuthProvider>(context, listen: false)
                .registerCheckEmail(context, email: email!, onSuccess: (res) {});
          } else {
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
                    child: Typo(text: "Enter your email address"),
                  ),
                  FormBuilder(
                      key: formState.value,
                      child: Column(
                        children: [

                          FormTextField(
                              form: formState.value,
                              name: "email",
                              hint: "Email address",
                              validators: FormBuilderValidators.compose([
                                FormBuilderValidators.email(context),
                                FormBuilderValidators.required(context),
                              ])),
                        ],
                      )),
                ],
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                        margin: EdgeInsets.only(bottom: 30),
                        child: Typo(
                            text: "I already have an account",
                            color: Colour.primaryBlue,
                            size: 16))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
