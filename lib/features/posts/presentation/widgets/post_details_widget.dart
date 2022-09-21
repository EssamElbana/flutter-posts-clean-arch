import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_clean_architecture/core/util/snackbar_message.dart';
import 'package:posts_clean_architecture/core/widgets/loading_widget.dart';
import 'package:posts_clean_architecture/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_bloc.dart';
import 'package:posts_clean_architecture/features/posts/presentation/pages/post_update_delete_page.dart';

import '../../domain/entities/post.dart';
import '../pages/posts_page.dart';
import 'delete_dialog_widget.dart';

class PostDetailsWidget extends StatelessWidget {
  final Post post;

  const PostDetailsWidget({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            post.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Divider(
            height: 32,
          ),
          Text(
            post.body,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          const Divider(
            height: 32,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              PostUpdateDeletePage(
                                isUpdatePost: true,
                                post: post,
                              )));
                },
                icon: const Icon(Icons.edit),
                label: const Text("Edit"),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  _deleteDialog(context);
                },
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(Colors.redAccent)),
                icon: const Icon(Icons.delete),
                label: const Text("Delete"),
              )
            ],
          )
        ],
      ),
    );
  }

  void _deleteDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<AddDeleteUpdatePostBloc, AddDeleteUpdatePostState>(
            listener: (context, state) {
              if (state is MessageAddDeleteUpdatePostState) {
                SnackBarMessage().showSuccessSnackBar(
                    message: state.message, context: context);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => const PostsPage(),
                    ),
                        (route) => false);
              } else if (state is ErrorAddDeleteUpdatePostState) {
                Navigator.of(context).pop();
                SnackBarMessage()
                    .showErrorSnackBar(
                    message: state.message, context: context);
              }
            },
            builder: (context, state) {
              if (state is LoadingAddDeleteUpdatePostState) {
                return const AlertDialog(
                  title: LoadingWidget(),
                );
              }
              return DeleteDialogWidget(postId: post.id!);
            },
          );
        });
  }
}
