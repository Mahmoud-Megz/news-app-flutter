

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/cubit/bloc_observer.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/networks/Remote/dio_helper.dart';
import 'package:news_app/networks/local/cache_helper.dart';
import 'package:news_app/news_home_layout.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  dynamic isDark= CacheHelper.getData(key: 'isDark');

  runApp( MyApp(isDark));
}

class MyApp extends StatelessWidget {
  bool isDark;
  MyApp(this.isDark);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context)=>NewsCubit()..getBusinessData()..getSportsData()..getSciencesData()..ChangeMod(formShared: isDark),
        child: BlocConsumer<NewsCubit,NewsStates>(
            listener: (BuildContext context, state) {},
            builder: (BuildContext context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: ThemeData(
                    primarySwatch: Colors.deepOrange,
                    scaffoldBackgroundColor: Colors.white,
                    appBarTheme: AppBarTheme(
                      titleSpacing: 20.0,
                      systemOverlayStyle: SystemUiOverlayStyle(
                          statusBarColor: Colors.white,
                          statusBarIconBrightness: Brightness.dark),
                      backgroundColor: Colors.white,
                      elevation: 0.0,
                      titleTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      iconTheme: IconThemeData(color: Colors.black),

                    ),
                    bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.orange,
                      elevation: 20.0,
                      unselectedItemColor: Colors.grey,
                      backgroundColor:Colors.white,) ,

                    floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Colors.orange),
                    textTheme: TextTheme(
                        bodyText1: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w600
                        )
                    )

                ),
                darkTheme: ThemeData(

                    primarySwatch: Colors.deepOrange,
                    scaffoldBackgroundColor: HexColor('333739'),
                    appBarTheme: AppBarTheme(
                      titleSpacing: 20.0,
                      systemOverlayStyle: SystemUiOverlayStyle(
                          statusBarColor: HexColor('333739'),
                          statusBarIconBrightness: Brightness.light),
                      backgroundColor: HexColor('333739'),
                      elevation: 0.0,
                      titleTextStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                      iconTheme: IconThemeData(color: Colors.white),


                    ),
                    bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.orange,
                      elevation: 20.0,
                      unselectedItemColor: Colors.grey,
                      backgroundColor:HexColor('333739'),) ,
                    floatingActionButtonTheme:
                    FloatingActionButtonThemeData(backgroundColor: Colors.orange),
                    textTheme: TextTheme(
                        bodyText1: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600
                        )
                    )
                ),

                themeMode: NewsCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
                home: const NewsLayout(),
              );
            }
        ));
  }
}
