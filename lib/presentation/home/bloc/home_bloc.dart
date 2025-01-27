import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utills/model/post_model.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<LoadDataEvent>((event, emit) async {
      emit(LoadingState());
      await _loadData();
    });

    on<DataLoadedEvent>((event, emit) {
      emit(DataLoadedState(event.postModel));
    });

    on<SearchEvent>((event, emit) {
      _filterList(event.postModel,event.textSearch,emit);
    });

    on<LogoutEvent>((event, emit) {
      emit(LogoutState());
      _deleteSession();
    });

    on<SuccessfullyEvent>((event, emit) {
      emit(SuccessfullyState());
    });
  }

  Future<void> _loadData() async {
    var dio = Dio();
    try {
      var response = await dio.request(
        'https://jsonplaceholder.typicode.com/posts',
        options: Options(
          method: 'GET',
        ),
      );

      if (response.statusCode == 200) {
        List<PostModel> posts = postModelFromJson(json.encode(response.data));
        add(DataLoadedEvent(posts));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void _filterList(List<PostModel> postModel, String textSearch,Emitter<HomeState>  emit) {
    List<PostModel> filter = [];
    filter = postModel.where(
          (element) {
        return element.title!
            .startsWith(textSearch);
      },
    ).toList();

    emit(SearchState(postModel,filter));
  }

  void _deleteSession() async{
    try{
      final SharedPreferences shard = await SharedPreferences
          .getInstance();
      await shard.clear().then((value) {
        if(value){
          add(SuccessfullyEvent());
        }
      },);

    }catch(e){
      if (kDebugMode) {
        print(e);
      }
    }
  }


}
