import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_clean_architecture/core/widgets/loading_widget.dart';
import 'package:posts_clean_architecture/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_bloc.dart';
import 'package:posts_clean_architecture/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:posts_clean_architecture/features/posts/presentation/pages/posts_page.dart';
import '../../../../core/util/snackbar_message.dart';
import '../../domain/entities/post.dart';
import '../widgets/form_widget.dart';

class PostUpdateDeletePage extends StatelessWidget {
  final Post? post;
  final bool isUpdatePost;

  const PostUpdateDeletePage({Key? key, this.post, required this.isUpdatePost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() =>
      AppBar(
        title: Text(isUpdatePost ? "Edit Post" : "Add Post"),
      );

  Widget _buildBody() {
    return Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: BlocConsumer<AddDeleteUpdatePostBloc,
              AddDeleteUpdatePostState>(
            listener: (context, state) {
              if (state is MessageAddDeleteUpdatePostState) {
                SnackBarMessage().showSuccessSnackBar(
                    message: state.message,
                    context: context);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const PostsPage()), (
                    route) => false)
                ;
              } else if (state is ErrorAddDeleteUpdatePostState) {
                SnackBarMessage().showErrorSnackBar(
                    message: state.message, context: context);
              }
            },
            builder: (context, state) {
              if (state is LoadingAddDeleteUpdatePostState) {
                return const LoadingWidget();
              }
              return FormWidget(
                isUpdatePost: isUpdatePost, post: isUpdatePost ? post : null,);
            },
          ),
        ));
  }
}
