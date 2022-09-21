import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_clean_architecture/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:posts_clean_architecture/features/posts/presentation/pages/post_update_delete_page.dart';
import 'package:posts_clean_architecture/features/posts/presentation/widgets/posts_list_widget.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../widgets/message_display_widget.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingBtn(context),
    );
  }

  AppBar _buildAppBar() =>
      AppBar(
        title: const Text('Posts'),
      );

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: BlocBuilder<PostsBloc, PostsState>(builder: (context, state) {
        if (state is LoadingPostsState) {
          return const LoadingWidget();
        } else if (state is LoadedPostsState) {
          return RefreshIndicator(
            onRefresh: () => _onRefresh(context),
            child: PostsListWidget(posts: state.posts),
          );
        } else if (state is ErrorPostsState) {
          return MessageDisplayWidget(message: state.message);
        }
        return Container();
      }),
    );
  }

  Widget _buildFloatingBtn(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) =>
                const PostUpdateDeletePage(isUpdatePost: false)));
      },
      child: const Icon(Icons.add),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
  }
}
