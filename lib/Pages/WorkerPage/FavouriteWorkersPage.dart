

import 'package:buqit/Models/Worker.dart';
import 'package:buqit/Pages/Pages.dart';
import 'package:buqit/Pages/WorkPlacePage/WorkerCard.dart';
import 'package:buqit/States/Profile/ProfileProvider.dart';
import 'package:buqit/States/Worker/WorkerProvider.dart';
import 'package:buqit/Widgets/Appbar/CustomAppbar.dart';
import 'package:buqit/Widgets/Typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class FavoriteWorkersPage extends HookWidget{
  @override
  Widget build(BuildContext context) {



    useEffect((){
      Provider.of<WorkerProvider>(context,listen: false).getFavoriteWorkers(context);
    },[]);

    return Scaffold(
      appBar: CustomAppbar(
        title: "Favorites",
        actions: [],
      ),
      body: Container(
        child: Builder(
          builder: (ctx){

            List<Worker> favorites=ctx.select(( WorkerProvider state) => state.favoriteWorkers);

            return Container(
              child: ListView(
                shrinkWrap: true,
                children: [...favorites.map((worker) => GestureDetector(
                    onTap: (){
                      Navigator.of(context).pushNamed(Pages.worker,arguments: worker);
                    },
                    child: WorkerCard(worker: worker)))],
              ),
            );
          },
        ),
      ),
    );
  }

}