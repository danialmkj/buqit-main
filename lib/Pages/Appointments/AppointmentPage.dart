


import 'package:buqit/Pages/Appointments/widgets/AppointmentTab.dart';
import 'package:buqit/States/Appointments/AppointmentProvider.dart';
import 'package:buqit/States/Appointments/data.dart';
import 'package:buqit/Widgets/Appbar/CustomAppbar.dart';
import 'package:buqit/Widgets/Typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class AppointmentPage extends HookWidget{
  @override
  Widget build(BuildContext context) {






    final tabController=useTabController(initialLength: 4);


    AppointmentType currentType=AppointmentType.values[tabController.index];

    final tabIndex=useState(0);




    useEffect((){
      Provider.of<AppointmentProvider>(context,listen: false).getAppointments(context, AppointmentType.values[tabIndex.value]);
    },[tabIndex.value]);



    return Scaffold(

      appBar: CustomAppbar(
        title: "Appointments",
        actions: [],
      ),
      body:SafeArea(
        child: Container(
          child: Column(
            children: [
              TabBar(

                isScrollable: true,
                labelColor:Theme.of(context).textTheme.subtitle1?.color,
                unselectedLabelColor:Theme.of(context).textTheme.subtitle1?.color?.withOpacity(0.3),


                onTap: (index){

                  tabIndex.value=index;
                },
                controller:tabController ,
                tabs:  [

                  Tab(iconMargin: EdgeInsets.zero,text: AppointmentType.Upcoming.name.toUpperCase(),),
                  Tab(iconMargin: EdgeInsets.zero,text: AppointmentType.Requests.name.toUpperCase(),),
                  Tab(iconMargin: EdgeInsets.zero,text: AppointmentType.History.name.toUpperCase(),),
                  Tab(iconMargin: EdgeInsets.zero,text: AppointmentType.Ongoing.name.toUpperCase(),),

                ],
              ),
              Expanded(
                child: TabBarView(

                  controller: tabController,
                  children: [
                    AppointmentTab(type: AppointmentType.Upcoming),
                    AppointmentTab(type: AppointmentType.Requests),
                    AppointmentTab(type: AppointmentType.History),
                    AppointmentTab(type: AppointmentType.Ongoing),




                  ],
                ),
              )
            ],
          )
        ),
      )
    );
  }

}