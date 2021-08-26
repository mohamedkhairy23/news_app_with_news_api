import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/health/health_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/modules/technology/technology_screen.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'news_states.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business_outlined),
      label: "Business",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science_outlined),
      label: "Science",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.run_circle_outlined),
      label: "Sports",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.health_and_safety_outlined),
      label: "Health",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.phonelink),
      label: "Technology",
    ),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    ScienceScreen(),
    SportsScreen(),
    HealthScreen(),
    TechnologyScreen(),
  ];

  void changeBottomNavBar(int index) {
    if (index == 1) getScience();
    if (index == 2) getSports();
    if (index == 3) getHealth();
    if (index == 4) getTechnology();

    currentIndex = index;
    emit(NewsBottomNavBarState());
  }

  List<dynamic> business = [];

  //this list must be dynamic because I don't know the value that will return.

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    if (business.length == 0) {
      DioHelper.getData(
        url: "v2/top-headlines",
        query: {
          "country": "eg",
          "category": "business",
          "apiKey": "4399d4a76747461f9994662d2f796361",
        },
      ).then((value) {
        business = value.data["articles"];
        print(value.data);
        emit(NewsGetBusinessSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetBusinessErrorState(error.toString()));
      });
    } else {
      emit(NewsGetBusinessSuccessState());
    }
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportsLoadingState());
    if (sports.length == 0) {
      DioHelper.getData(
        url: "v2/top-headlines",
        query: {
          "country": "eg",
          "category": "sports",
          "apiKey": "4399d4a76747461f9994662d2f796361",
        },
      ).then((value) {
        sports = value.data["articles"];
        print(value.data);
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetScienceLoadingState());
    if (science.length == 0) {
      DioHelper.getData(
        url: "v2/top-headlines",
        query: {
          "country": "eg",
          "category": "science",
          "apiKey": "4399d4a76747461f9994662d2f796361",
        },
      ).then((value) {
        science = value.data["articles"];
        print(value.data);
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> health = [];

  void getHealth() {
    emit(NewsGetHealthLoadingState());
    if (health.length == 0) {
      DioHelper.getData(
        url: "v2/top-headlines",
        query: {
          "country": "eg",
          "category": "health",
          "apiKey": "4399d4a76747461f9994662d2f796361",
        },
      ).then((value) {
        health = value.data["articles"];
        print(value.data);
        emit(NewsGetHealthSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetHealthErrorState(error.toString()));
      });
    } else {
      emit(NewsGetHealthSuccessState());
    }
  }

  List<dynamic> technology = [];

  void getTechnology() {
    emit(NewsGetTechnologyLoadingState());
    if (technology.length == 0) {
      DioHelper.getData(
        url: "v2/top-headlines",
        query: {
          "country": "eg",
          "category": "technology",
          "apiKey": "4399d4a76747461f9994662d2f796361",
        },
      ).then((value) {
        technology = value.data["articles"];
        print(value.data);
        emit(NewsGetTechnologySuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetTechnologyErrorState(error.toString()));
      });
    } else {
      emit(NewsGetTechnologySuccessState());
    }
  }

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());
    //search = [];

    DioHelper.getData(
      url: "v2/everything",
      query: {
        "q": "$value",
        "apiKey": "4399d4a76747461f9994662d2f796361",
      },
    ).then((value) {
      search = value.data["articles"];
      print(value.data);
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
    emit(NewsGetSearchSuccessState());
  }

  //Theme of the App
  bool isDark = false;

  void changeThemeMode({bool fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ChangeAppModeState());
    } else {
      isDark = !isDark;
      CacheHelper.sharedPreferences.setBool("isDark", isDark).then((value) {
        emit(ChangeAppModeState());
      });
    }
  }
}
