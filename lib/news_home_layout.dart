import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/components/components.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/cubit/states.dart';

import 'package:news_app/screens/search/search.dart';


class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (BuildContext context, Object? state) {  },
        builder: (BuildContext context, state)
    {
      var cubit= NewsCubit.get(context);
      return Scaffold(
          appBar: AppBar(

            title: Text("News App"),
            actions: [
              IconButton(onPressed: ()

              {
                navigateTo(context, SearchScreen());
              }, icon: Icon(Icons.search)),
              IconButton(onPressed: (){
                cubit.ChangeMod();
              }, icon: Icon(Icons.brightness_4_rounded))
            ],
          ),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: ()
          //   {
          //
          //   },
          //   child: Icon(Icons.add),
          // ),
          body: (cubit.screens[cubit.currentIndex]),
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index)
              {
              cubit.changeNavBar(index);
              },
              items: cubit.bottomItems)
      );
    },


    );
  }
}
