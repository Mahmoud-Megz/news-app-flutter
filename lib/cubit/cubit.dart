import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/networks/Remote/dio_helper.dart';
import 'package:news_app/screens/business_screen/business_screen.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/networks/local/cache_helper.dart';
import 'package:news_app/screens/science_screen/science_screen.dart';
import 'package:news_app/screens/sports_screen/sports_screen.dart';


class NewsCubit extends Cubit<NewsStates>{
  List <dynamic>  search=[];
  NewsCubit() : super(NewsIntialState());

  static NewsCubit get(context)=> BlocProvider.of(context);

  int currentIndex=0;
  List <BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business_center),label: "Business"),
    BottomNavigationBarItem(icon: Icon(Icons.sports),label: "Sports"),
    BottomNavigationBarItem(icon: Icon(Icons.science),label: "Science"),


  ];
  List <Widget> screens=[
    BusinessScreen(),
    SportScreen(),
    ScienceScreen(),


  ];
  void changeNavBar(int index){
    currentIndex=index;
    emit(NewsBottomNavState());
  }
  List <dynamic>  business=[];
  List <dynamic>  sports=[];
  List <dynamic>  sciences=[];


  void getSearchData(String value)
  {
    emit(NewsLoadingState());

    DioHelper.getData(url: 'v2/everything', query: {
      'q': value,
      'apikey':'1e57bcfdfca24d7394d7f3d545e13001',
    }).then((value)  {
      //print(value.data.toString())
      search=value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      print(error.toString());
    });
  }
  void getBusinessData()
  {
    emit(NewsLoadingSearchState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country':'eg',
      'category':'business',
      'apikey':'1e57bcfdfca24d7394d7f3d545e13001',
    }).then((value)  {
      //print(value.data.toString())
      business=value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
    });
  }
  void getSportsData()
  {
    emit(NewsLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country':'eg',
      'category':'sports',
      'apikey':'1e57bcfdfca24d7394d7f3d545e13001',
    }).then((value)  {
      //print(value.data.toString())
      sports=value.data['articles'];
      print(sports[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
    });
  }
  void getSciencesData()
  {
    emit(NewsLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country':'eg',
      'category':'science',
      'apikey':'1e57bcfdfca24d7394d7f3d545e13001',
    }).then((value)  {
      //print(value.data.toString())
      sciences=value.data['articles'];
      print(sciences[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
    });


  }
  bool isDark = false;
  void ChangeMod({bool? formShared}){
      if(formShared!=null)
        isDark=formShared;
      else
    isDark=!isDark;
    CacheHelper.putData(key: 'isDark',value: isDark).then((value) {
      emit(NewsChangeMode());
    });

  }
}

