import 'package:flutter/material.dart';
import 'package:posts_clean_architecture/core/app_theme.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: SizedBox(height: 32, width: 32,
          child: CircularProgressIndicator(color: secondaryColor,),
        ),
      ),
    );
  }
}
