



import 'package:flutter/material.dart';

class ImageHandler extends StatelessWidget {

  double size;
  String? url;
  double round;
  Widget? errorWidget;


  @override
  Widget build(BuildContext context) {
    return  ClipRRect(
        borderRadius: BorderRadius.circular(round),
      child:  Image.network(url ?? "",width: size,height: size,fit: BoxFit.cover,

    errorBuilder: (e,s,g){

        if(errorWidget!=null){
          return Container(
            color: Theme.of(context).primaryColor,
              height: size,width: size,
              child: Center(child: errorWidget!));
        }else{
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border:Border.all(width: 0.5,color:Colors.grey)
            ),
            width: size,height: size,
            child: Icon(Icons.image_not_supported),
          );
        }

    },
    ));
  }

  ImageHandler({
    required this.size,
    required this.url,
     this.round=10,
     this.errorWidget,
  });
}
