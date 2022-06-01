import 'package:buqit/Utils/Colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';

enum TextFieldStyle { Normal, Round, Outline }

class FormTextField extends HookWidget {
  String name;
  String hint;
  String? label;
  Widget? icon;
  TextFieldStyle? style;
  bool secure;
  bool numeric;
  GlobalKey<FormBuilderState> form;
  dynamic validators;
  dynamic border;

  FormTextField({
    required this.name,
    required this.hint,
    required this.form,
    this.label,
    this.numeric = false,
    this.validators,
    this.border,
    this.icon,
    this.secure = false,
    this.style = TextFieldStyle.Normal,
  });

  @override
  Widget build(BuildContext context) {
    final secureText = useState(secure);

    InputDecoration _renderDecoration() {
      // ignore: missing_enum_constant_in_switch
      switch (style) {
        case TextFieldStyle.Normal:
          return InputDecoration(
              hintText: hint,
              labelText: label ?? null,
              hintStyle: GoogleFonts.poppins(
                  color: Color(0xffB5B6B3),
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500),
              // isDense: true,
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colour.primaryBlue)),

              // focusColor: CustomColors.accentGreen,
              contentPadding: EdgeInsets.only(left: icon != null ? 25 : 0));

        case TextFieldStyle.Round:
          return InputDecoration(
              // suffixIcon: secure ? ,
              focusColor: Colour.primaryBlue,
              fillColor: Colors.grey.shade100,
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colour.primaryBlue, width: 1.5),
                borderRadius: BorderRadius.circular(15.0),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(15.0)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(15.0)),
              hintText: hint,
              labelText: label ?? null,
              hintStyle: GoogleFonts.poppins(
                  color: Color(0xffB5B6B3),
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500),
              contentPadding: EdgeInsets.all(15.0),
              floatingLabelBehavior: FloatingLabelBehavior.always);

        case TextFieldStyle.Outline:
          return InputDecoration(
              // suffixIcon: secure ? ,
              focusColor: Colour.primaryBlue,
              fillColor: Colors.grey.shade100,
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colour.primaryBlue, width: 1.5),
                // borderRadius: BorderRadius.circular(15.0),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              hintText: hint,
              labelText: label ?? null,
              hintStyle: TextStyle(
                  color: Color(0xffB5B6B3),
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500),
              contentPadding: EdgeInsets.all(15.0),
              floatingLabelBehavior: FloatingLabelBehavior.always);
      }

      return InputDecoration();
    }

    return Container(
      // color:Colors.green,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Stack(
        alignment: Alignment.center,
        children: [
          FormBuilderTextField(
              keyboardType: numeric ? TextInputType.number : null,
              onChanged: (v) {
                form.currentState
                    ?.setInternalFieldValue(name, v, isSetState: true);
              },
              validator: validators,
              obscureText: secureText.value,

              // expands: false,

              decoration: _renderDecoration(),
              name: name),
          if (secure == true)
            Positioned(
                right: 15,
                child: GestureDetector(
                    onTapDown: (d) {
                      secureText.value = false;
                    },
                    onTapUp: (d) {
                      secureText.value = true;
                    },
                    child: Icon(
                        secureText.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey))),
          if (icon != null) Positioned(left: 0, child: icon ?? Container())
        ],
      ),
    );
  }
}
