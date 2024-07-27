import 'package:flutter/material.dart';
import '../../constant/diriction.dart';
import '../model/post_model.dart';

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
