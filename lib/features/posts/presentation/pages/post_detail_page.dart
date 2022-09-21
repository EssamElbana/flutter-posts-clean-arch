import 'package:flutter/material.dart';
import 'package:posts_clean_architecture/features/posts/presentation/widgets/post_details_widget.dart';

import '../../domain/entities/post.dart';

class PostDetailPage extends StatelessWidget {
  final Post post;

  const PostDetailPage({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Post Details'),
    );
  }

  Widget _buildBody() {
    return PostDetailsWidget(post: post);
  }
}
