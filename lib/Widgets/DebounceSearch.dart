



import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';


import 'package:rxdart/src/transformers/backpressure/debounce.dart';

class DebounceField extends HookWidget{


  Function onDebounce;
  String? errorText;
  String hint;
  TextEditingController controller;




  @override
  Widget build(BuildContext context) {




    final streamController=useStreamController<String>();

    // ignore: missing_return
    useEffect((){
      streamController.stream.debounceTime(const Duration(milliseconds: 1000)).listen((value) {


        onDebounce(value);
      });


    },[]);

    return  Stack(

      children: [
        Positioned(
            left:10,top:12,
            child:Icon(Icons.search)),
        TextField(

          onEditingComplete: () => FocusScope.of(context).nextFocus(),
          onChanged: (value){

            streamController.add(value);
          },
          // autofocus: true,
          textInputAction: TextInputAction.next,
          controller: controller,
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.bodyText2,


          decoration: InputDecoration(

            // isDense: true,

            errorText: errorText,

            // fillColor: Colors.grey.shade400,

            // focusedBorder: OutlineInputBorder(
            //
            //     borderRadius: BorderRadius.circular(5.0),
            //     borderSide: BorderSide(color: Colors.green)
            //
            // ),

            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(5),
            //
            // ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide:BorderSide(color:Colors.transparent)

            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide:BorderSide(color:Colors.transparent)

            ),


            filled: true,
//                suffixIcon: const Icon(Icons.phone),
            counterText: "",
            contentPadding: const EdgeInsets.only(
              left: 40,
              top:10,
              bottom:10,
              right: 16,
            ),

            hintText: hint,
            hintStyle: Theme.of(context).textTheme.subtitle1,
          ),
          maxLines: 1,
          keyboardType: TextInputType.name,
          maxLength: 50,
        ),
      ],
    );
  }

  DebounceField({

    required this.onDebounce,
     this.errorText,
    required this.controller,
     this.hint="Search",
  });
}