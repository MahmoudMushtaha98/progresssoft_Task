import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progresssoft_task/constant/diriction.dart';
import 'package:progresssoft_task/presentation/home/bloc/home_bloc.dart';
import 'package:progresssoft_task/presentation/widget/text_form.dart';

import '../../model/post_model.dart';

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
                SearchTextFieldWidget(controller: controller,postModel: state.postModel,),
                PostWidget(postModel: state.filterPostModel),
              ],
            ),
          );
        } else if (state is DataLoadedState) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SearchTextFieldWidget(controller: controller,postModel: state.postModel,),
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

class SearchTextFieldWidget extends StatelessWidget {
  const SearchTextFieldWidget({
    super.key,
    required this.controller, required this.postModel,
  });

  final TextEditingController controller;
  final List<PostModel> postModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormFieldWidget(
        controller: controller,
        label: 'Search',
        suffixIcon: IconButton(
            onPressed: () {
              BlocProvider.of<HomeBloc>(context)
                  .add(SearchEvent(controller.text, postModel));
            },
            icon: const Icon(Icons.search)),
      ),
    );
  }
}

class PostWidget extends StatelessWidget {
  const PostWidget({
    super.key,
    required this.postModel,
  });

  final List<PostModel> postModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: height(context) * 0.8,
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
              child: Divider(
                thickness: 5,
              ),
            ),
            itemCount: postModel.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    postModel[index].title!,
                    style: TextStyle(
                        fontSize: height(context) * 0.015,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    postModel[index].body!,
                    style: TextStyle(
                      fontSize: height(context) * 0.015,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
