import 'package:buqit/States/Worker/WorkerProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class FavouriteToggleIcon extends HookWidget{


  String workerId;


  @override
  Widget build(BuildContext context) {

    final localStatus=useState(false);
    final loading=useState(false);

    
    useEffect((){
      ()async{
        var status=await Provider.of<WorkerProvider>(context,listen: false).chekWorkerFavourite(context,workerId);
        localStatus.value=status.data;
      }();
    },[]);



   return GestureDetector(
     onTap: (){

       if(!loading.value){
         loading.value=true;
         Provider.of<WorkerProvider>(context,listen: false).likeOrDislikeWorker(context,workerId,onSuccess:(res){
           localStatus.value=!localStatus.value;
           loading.value=false;
         },onError:(e){
           loading.value=true;
         });
       }

     },
     child: Container(
         padding: EdgeInsets.symmetric(horizontal: 10),
         child: Icon(localStatus.value ? Icons.favorite : Icons.favorite_border)),
   );
  }

  FavouriteToggleIcon({
    required this.workerId,
  });
}