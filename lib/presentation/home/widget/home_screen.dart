import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progresssoft_task/presentation/home/bloc/home_bloc.dart';
import '../../../utills/ui/post_widget.dart';
import '../../../utills/ui/search_text_field_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SearchState) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SearchTextFieldWidget(
                  controller: controller,
                  postModel: state.postModel,
                ),
                PostWidget(postModel: state.filterPostModel),
              ],
            ),
          );
        } else if (state is DataLoadedState) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SearchTextFieldWidget(
                  controller: controller,
                  postModel: state.postModel,
                ),
                PostWidget(
                  postModel: state.postModel,
                ),
              ],
            ),
          );
        }
        return const Center(child: Text('No Data Available ...'));
      },
    );
  }
}
