import 'package:buqit/Pages/Pages.dart';
import 'package:buqit/States/Authentication/AuthProvider.dart';
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
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class LoginPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final formState = useState(GlobalKey<FormBuilderState>());

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          //print('before validated value in Login Page is...'+formState.value.currentState?.value['email']);

          bool? validated = formState.value.currentState?.validate();

          //print('After validated value in Login Page is...'+formState.value.currentState?.value['email']);

          if (validated == true) {
            //print('I\'m in Login Page for Checking Empty or Not.');

            String? email = formState.value.currentState?.value['email']??' Null Email to send';

            //print('email in login page is : ... ' + email!);

            Provider.of<AuthProvider>(context, listen: false)
                .checkEmail(context, email: email!, onSuccess: (res) {});
          } else {}
        },
        child: Icon(CupertinoIcons.arrow_right),
      ),
      body: SafeArea(
        bottom: true,
        top: true,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Typo(
                        text: "Enter the email address you used to register"),
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
                      Navigator.of(context).pushNamed(Pages.registerEmail);
                    },
                    child: Container(
                        margin: EdgeInsets.only(bottom: 30),
                        child: Typo(
                            text: "I don't have an account",
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
