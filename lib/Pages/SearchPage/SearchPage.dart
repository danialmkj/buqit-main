import 'package:buqit/Models/SearchHistory.dart';
import 'package:buqit/Models/WorkPlace.dart';
import 'package:buqit/Pages/Pages.dart';
import 'package:buqit/Pages/SearchPage/widgets/ServiceListing.dart';
import 'package:buqit/Pages/SearchPage/widgets/WorkPlaceListing.dart';
import 'package:buqit/States/Workplace/WorkPlaceProvider.dart';
import 'package:buqit/Utils/Colour.dart';
import 'package:buqit/Widgets/Buttons/SplashTouch.dart';
import 'package:buqit/Widgets/DebounceSearch.dart';
import 'package:buqit/Widgets/Typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';




enum SearchType{
  workPlace,
  service
}


class SearchPage extends HookWidget{



  @override
  Widget build(BuildContext context) {

    final _controller=useTextEditingController();

    List<Workplace> salons=Provider.of<WorkPlaceProvider>(context).workPlaces;
    List<String> services=Provider.of<WorkPlaceProvider>(context).services;




    print(salons);


    // List items=[
    //   {"type":SearchType,"title":"Service","icon":Icons.home},
    //   {"type":SearchType,"title":"Salons","icon":Icons.tag_sharp}
    // ];

    // final selected=useState(items[0]['title']);

    final shops=useState([]);


    SearchHistory? searchHistory =ModalRoute.of(context)?.settings.arguments as SearchHistory?;

    print(searchHistory?.type);


    final tabController=useTabController(initialLength: 2,initialIndex:(searchHistory?.type==SearchType.workPlace || searchHistory==null) ? 0 : 1 );

    // ignore: unrelated_type_equality_checks
    final searchType=useState(searchHistory?.type==SearchType.workPlace ? SearchType.workPlace : SearchType.service);


    final  searchedItems=useState([
      
    ]);






    final isSearching=useState(false);



    useEffect((){
     Future.delayed(Duration(milliseconds: 100),
         (){
           if(searchHistory!=null){

             var type=searchHistory.type=="workplace" ? SearchType.workPlace : SearchType.service;
             _controller.text=searchHistory.content;
             Provider.of<WorkPlaceProvider>(context,listen: false).search(context, type:type,text:_controller.text);

           }
         }
     );

    },[]);

    return Scaffold(
      body: SafeArea(
        child: Container(

          child: Column(
            children: [
              const SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                   Row(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       SplashTouch(
                           round:50,
                           padding: EdgeInsets.all(5),
                           onTap: (){
                         Navigator.of(context).pop();
                       },child: const Icon(Icons.arrow_back,size:30)),

                       SizedBox(
                         width: MediaQuery.of(context).size.width*0.7,
                         child: DebounceField(onDebounce: (text){

                           Provider.of<WorkPlaceProvider>(context,listen: false).search(context, type: searchType.value,text:text);
                           // if(searchType.value==SearchType.service){
                           //   Provider.of<WorkPlaceProvider>(context,listen: false).getServices(context,text);
                           // }else{
                           //   Provider.of<WorkPlaceProvider>(context,listen: false).getWorkPlaces(context,text);
                           // }

                         }, errorText: null, controller: _controller),
                       ),
                     ],
                   ),
                    Row(
                      children: [
                        if(isSearching.value)GestureDetector(
                          onTap: (){
                            isSearching.value=true;
                          },
                            child: const Icon(Icons.search)),
                        // if(!isSearching.value)Icon(Icons.close),
                        // const SizedBox(width: 15,),
                        // if(!isSearching.value)SplashTouch(
                        //   round: 50,
                        //     padding: EdgeInsets.all(5),
                        //     onTap: (){
                        //
                        //     },
                        //     child: const Icon(Icons.filter_list_alt)),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10,),

              TabBar(

                // labelStyle: TextStyle(color: Colors.blueAccent),
                // indicatorColor: Colors.blueAccent,
                labelColor:Theme.of(context).textTheme.subtitle1?.color,
                unselectedLabelColor:Theme.of(context).textTheme.subtitle1?.color?.withOpacity(0.3),
                // unselectedLabelColor: Colors.grey,

                onTap: (index){
                  _controller.text="";
                  if(index==0){
                    searchType.value=SearchType.service;
                  }else{
                    searchType.value=SearchType.workPlace;
                  }
                },
                controller:tabController ,
                tabs: const [
                  Tab(text: "Services",),
                  Tab(text:"Salons"),

                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    Container(child: ListView(
                      children: [...services.map((service)=>GestureDetector(
                          onTap: (){

                          },
                          child: ServiceListing(service:service)))]

                    ),),
                    Container(child: ListView(
                        children:  [...salons.map((workplace)=>GestureDetector(
                            onTap: (){
                              Navigator.of(context).pushNamed(Pages.workPlace,arguments: workplace);
                            },
                            child: WorkPlaceListing(workplace:workplace)))] ,

                    ),),



                  ],
                )
              )

            ],
          ),
        ),
      ),
    );
  }


}