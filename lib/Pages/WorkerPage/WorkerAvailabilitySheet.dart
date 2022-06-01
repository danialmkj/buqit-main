import 'package:buqit/Models/Service.dart';
import 'package:buqit/Models/Worker.dart';
import 'package:buqit/Models/WorkingDay.dart';
import 'package:buqit/Pages/Pages.dart';
import 'package:buqit/Pages/Payment/widgets/SelectPaymentWidget.dart';
import 'package:buqit/Pages/WorkerPage/widgets/SelectedServiceCard.dart';
import 'package:buqit/States/Payment/PaymentProvider.dart';
import 'package:buqit/States/Worker/WorkerProvider.dart';
import 'package:buqit/Utils/Colour.dart';
import 'package:buqit/Utils/DateUtility.dart';
import 'package:buqit/Widgets/Typo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:table_calendar/table_calendar.dart';




class WorkerAvailabilitySheet extends HookWidget{

  Service? selectedService;
  Worker worker;



  _totalAmount( selectedServices){
    if(selectedServices.isEmpty){
      return 0.0;
    }else{
      return selectedServices.map((e) => e?.price).reduce((value, element) => value! + element! );
    }

  }



  @override
  Widget build(BuildContext context) {


    DateTime now=DateTime.now();
    final selectedDay=useState<DateTime?>(now);
    final selectedTime=useState<WorkingTime?>(null);
    final selectedServices=useState([selectedService]);



    useEffect((){

      if(selectedDay.value!=null && selectedServices.value.isNotEmpty){
        Provider.of<WorkerProvider>(context,listen: false).getAvailableTimes(context,
            workerId:worker.id,
            selectedServices: selectedServices.value,
            date: selectedDay.value,
          onSuccess:(List<WorkingTime> times){
          if(times.isNotEmpty){
            selectedTime.value=times[0];
          }else{
            selectedTime.value=null;
          }

          },
          onError: (e){}
        );

      }

    },[selectedDay.value,selectedServices.value.length]);




    // useEffect((){
    //
    //   print("selected time->${selectedTime.value}");
    //
    // },[selectedTime.value]);


    return Container(
      height: MediaQuery.of(context).size.height*0.9,
      child: Center(
        child: Material(
          child: Column(

            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                    color:Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10)
                ),
                width: 80,height: 5,),
              const SizedBox(height: 20,),
              TableCalendar(
                headerStyle: HeaderStyle(
                    titleCentered: true,
                    titleTextStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                    formatButtonVisible: false,
                    leftChevronVisible: false,
                    rightChevronVisible: false,
                    titleTextFormatter: (s,f)=>"",

                    leftChevronIcon: Container(
                      padding: const EdgeInsets.all(5),
                      decoration:BoxDecoration(
                          color:Colour.lightGrey,
                          border: Border.all(width:0.5,color:Colors.grey),
                          borderRadius: BorderRadius.circular(10)
                      ) ,
                      child:const Icon(Icons.chevron_left) ,
                    ),
                    rightChevronIcon: Container(
                      padding: const EdgeInsets.all(5),
                      decoration:BoxDecoration(
                          color:Colour.lightGrey,
                          border: Border.all(width:0.5,color:Colors.grey),
                          borderRadius: BorderRadius.circular(10)
                      ) ,
                      child:const Icon(Icons.chevron_right) ,
                    )
                ),
                calendarBuilders: CalendarBuilders(


                  selectedBuilder: (context, day, focusedDay) => Container(
                    // height: 80,

                    margin: const EdgeInsets.symmetric(horizontal: 7,vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border:Border.all(width: 1,color: Colors.blueAccent),
                      color: Colour.primaryBlue.withOpacity(0.2)
                    ),
                    // color:Colors.green,
                    child: Center(child: Typo(text:day.day.toString(),color:Colors.black,bold:true)),
                  ),
                ),
                onDaySelected: (d,g){
                  selectedDay.value=d;
                },
                onCalendarCreated: (a){

                },
                selectedDayPredicate: (day) {
                  return isSameDay(selectedDay.value, day);
                },
                calendarFormat: CalendarFormat.twoWeeks,
                firstDay: now,
                lastDay: now.add(Duration(days: 7)),
                focusedDay: DateTime.now(),
              ),
              Container(
                height: 60,
                decoration: const BoxDecoration(
                  border: Border(top:BorderSide(width: 0.4,color:Colors.grey),bottom:BorderSide(width: 0.4,color:Colors.grey))
                ),
                child: Consumer<WorkerProvider>(builder:(ctx,state,f){

                  // if(state.gettingTimeLoading){
                  //   return Container(
                  //
                  //     padding: EdgeInsets.symmetric(horizontal: 20),
                  //     alignment: Alignment.center,
                  //       child: SizedBox(height:10,width:double.infinity,child: LinearProgressIndicator(minHeight: 10,)));
                  // }

                  return Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                    child:state.workingTimes.isEmpty ? Center(child: Typo(text: "No time available",size:15)) : ListView(
                      scrollDirection: Axis.horizontal,

                      children: [
                        ...state.workingTimes.map((workingTime) =>GestureDetector(
                          onTap:(){
                            selectedTime.value=workingTime;
                          },
                          child: Container(
                            child: Typo(text:DateUtility(dateTime: workingTime.start, ).renderTime(),bold:true),
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(

                                color: selectedTime.value?.start==workingTime.start ? Colour.primaryBlue.withOpacity(0.2) : Theme.of(context).canvasColor,
                                border:Border.all(width: 1,color: Colour.primaryBlue),
                                borderRadius: BorderRadius.circular(5)
                            ),
                          ),
                        ))
                      ],
                    ),
                  );

                }),
              ),
              Expanded(
                child: Container(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: [
                      ...selectedServices.value.map((service) => Stack(
                        children: [
                          SelectedServiceCard(service:service!),
                          Positioned(
                              top:5,right:5,
                              child:GestureDetector(
                                  onTap: (){
                                    List<Service?> newService=[...selectedServices.value];
                                    newService.removeWhere((element) => element?.id==service.id);
                                    selectedServices.value=[...newService];
                                  },
                                  child: Container(child: Icon(Icons.close,color:Colors.red,size:20),)))
                        ],
                      ))
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(width: 0.3,color:Colors.grey),bottom:BorderSide(width: 0.3,color:Colors.grey))
                ),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: ()async{
                      var result=await Navigator.of(context).pushNamed(Pages.addService,arguments: [...selectedServices.value]);

                      print(result);

                      if(result!=null){
                        selectedServices.value=[...result as List];
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Typo(text:"+ Add another service",color:Colour.primaryBlue,bold:true,size:15),
                    ),
                  ),
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SelectPaymentWidget(worker: worker,amount: _totalAmount(selectedServices.value), onPaymentSelect: (){}),

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      child: ElevatedButton(

                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)
                            ),
                            primary: Colour.primaryBlue),
                        onPressed:selectedTime.value==null ? null : (){

                          Provider.of<WorkerProvider>(context,listen: false).requestService(context,
                              start:selectedTime.value!.start,
                              end:selectedTime.value!.end,
                              serviceIds:selectedServices.value.map((e) =>e!.id).toList(),
                              workerId:worker.id,
                            onSuccess:(data){


                            Navigator.of(context).pop();

                            Fluttertoast.showToast(
                                msg: "Services reserved successfully",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );

                            }
                          );
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(vertical: 13),
                            child: Typo(text:"REQUEST",size:16)),
                      ),
                    )

                  ],
                ),
              ),
              SizedBox(height: 30,)

              // InkWell(
              //   onTap: () => Navigator.pop(context, 'This is the result.'),
              //   child: Padding(
              //       padding: const EdgeInsets.all(16),
              //       child: Typo(text:selectedService?.name ?? "")
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  WorkerAvailabilitySheet({
    this.selectedService,
    required this.worker,
  });
}