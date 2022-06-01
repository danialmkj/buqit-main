
import 'package:buqit/Models/Worker.dart';
import 'package:buqit/Pages/Pages.dart';
import 'package:buqit/States/Payment/PaymentProvider.dart';
import 'package:buqit/Widgets/Typo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class SelectPaymentWidget extends HookWidget{

  double amount;
  Function onPaymentSelect;
  Worker worker;

  @override
  Widget build(BuildContext context) {


    final reload=useState(false);

    useEffect((){
      Future.delayed(
        Duration(milliseconds: 10),
          (){
            Provider.of<PaymentProvider>(context,listen: false).getPaymentMethods(context, worker.id);
          }
      );
    },[reload.value]);


    return  Consumer<PaymentProvider>(
      builder: (ctx,state,child){


        if(state.loading){

          return const SizedBox(
              height: 50,
              width: 100,
              child: Align(alignment:Alignment.center,child:CupertinoActivityIndicator(
                  animating:true
              ))
          );
        }

        if(!state.loading && state.paymentMethods.isEmpty){
          return SizedBox(
            height: 50,
            child: Column(
              children: [
                Typo(text: "There is no payments available"),
                GestureDetector(onTap:(){
                  reload.value=!reload.value;
                },child: Icon(Icons.refresh),)
              ],
            ),
          );
        }

        return  InkWell(
          onTap: (){

            Navigator.of(context).pushNamed(Pages.payment);

          },
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(children: [const Icon(Icons.payments_outlined),SizedBox(width: 15,),Typo(text:state.activePayment?.last4Digits==null ? "Cash" : '**** ${state.activePayment?.last4Digits}',bold:true,size:15)],),
                Row(children: [Typo(text:'R${amount}',bold:true,size:15),const SizedBox(width: 10,),const Icon(Icons.chevron_right)],)
              ],
            ),
          ),
        );
      },
    );
  }

  SelectPaymentWidget({
    required this.amount,
    required this.onPaymentSelect,
    required this.worker,
  });
}