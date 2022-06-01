



import 'package:buqit/Widgets/Typo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:image_picker/image_picker.dart';

class ProfileImagePicker extends HookWidget{


  String firstName;
  Function onAdd;
  Function onRemove;
  double size;


  @override
  Widget build(BuildContext context) {


    final imageUrl=useState<String?>("");
    final _picker=useState(ImagePicker());
    final loading=useState(false);






    Widget _render(){


      if(loading.value){
        return Container(width:35,height: 35,child: CupertinoActivityIndicator(
            animating:true
        ));
      }

      if(imageUrl.value==""){
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color:Theme.of(context).primaryColor,
          ),

          child: Center(child: Typo(text:firstName[0].toUpperCase(),bold: true,size:22,)),
        );

      }
      return Image.asset(imageUrl.value ?? "",height: size,width: size,fit: BoxFit.cover,);
    }



    return Container(
        child:  GestureDetector(
          onTap: ()async{

            loading.value=true;
            _picker.value.pickImage(source: ImageSource.gallery).then((image){
              loading.value=false;
              imageUrl.value=image?.path;
              onAdd(image?.path);

            }).catchError((e){
              loading.value=false;
              print(e);
            });


          },
          child: FittedBox(
            child: Container(
              height: size,width:size,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child:_render()),
            ),
          ),
        )

    );
  }

  ProfileImagePicker({
    required this.firstName,
    required this.onAdd,
    required this.onRemove,
    this.size=50,
  });

}
