

import 'package:buqit/Models/Payment/PaymentMethod.dart';
import 'package:buqit/Pages/Pages.dart';
import 'package:buqit/States/Payment/PaymentProvider.dart';
import 'package:buqit/Utils/Colour.dart';
import 'package:buqit/Widgets/Appbar/CustomAppbar.dart';
import 'package:buqit/Widgets/Typo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';



class PaymentPage extends HookWidget{
  @override
  Widget build(BuildContext context) {


    final paymentMethods=Provider.of<PaymentProvider>(context).paymentMethods;

    PaymentMethod selectedPayment=Provider.of<PaymentProvider>(context).activePayment!;


    final discount=useState<double>(0.0);

    return Scaffold(
      appBar: CustomAppbar(
        title: "Payment",
        actions: [],
      ),
      body: Container(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Container(
                padding:EdgeInsets.only(left: 15),
                child: Typo(text: "Payment methods",bold: true,color:Colors.grey)),
            ...paymentMethods.map((payment){
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.only(left:10,right:10,top:10,bottom:5),
                decoration: const BoxDecoration(
                  border: Border(bottom:BorderSide(width: 0.4,color:Colors.grey))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Row(children: [ const Icon(Icons.payments_outlined),SizedBox(width: 5,),Typo(text:payment.last4Digits==null ? "Cash" : '**** ${payment.last4Digits}',bold:true,size:15)],),
                  Radio(value: payment.id , groupValue: selectedPayment.id, onChanged: (val){
                    Provider.of<PaymentProvider>(context,listen: false).setActivePayment(context,payment,onSuccess:(data){

                    });
                  })

                ],),
              );
            }),
            SizedBox(height: 10,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15,),
              decoration: BoxDecoration(
                  border: Border(bottom:BorderSide(width: 0.4,color:Colors.grey)),


              ),
              child: Container(

                margin: EdgeInsets.symmetric(horizontal: 0,vertical: 15),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colour.primaryBlue,

                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,


                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Typo(text: "R${discount.value} Discount",color:Colors.white,bold:true,size:16),
                        SizedBox(height: 5,),
                        Typo(text: "You have no discount",color:Colors.white),
                        SizedBox(height: 5,),
                        Typo(text: "No expiry date",color:Colors.white),
                      ],
                    ),
                    Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(30)
                        ),
                        child: Icon(Icons.check,color: Colors.white,))
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: ()async{
                var result = await Navigator.of(context).pushNamed(Pages.enterPromoCode);
                discount.value=double.parse(result as String);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                child:Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(CupertinoIcons.captions_bubble),
                    SizedBox(width: 10,),
                    Typo(text:"Enter promo code",size:17),
                  ],
                )
              ),
            )
          ],
        )

      ),
    );



  }
}