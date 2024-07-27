import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/home/bloc/home_bloc.dart';
import '../../presentation/widget/text_form_widget.dart';
import '../model/post_model.dart';

class SearchTextFieldWidget extends StatelessWidget {
  const SearchTextFieldWidget({
    super.key,
    required this.controller,
    required this.postModel,
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
