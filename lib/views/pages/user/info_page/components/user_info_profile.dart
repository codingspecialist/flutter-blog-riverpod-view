import 'package:flutter/material.dart';
import 'package:flutter_blog_2/core/constants/size.dart';
import 'package:flutter_blog_2/model/user/user.dart';
import 'package:flutter_blog_2/views/pages/user/info_page/user_info_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserInfoProfile extends ConsumerWidget {
  const UserInfoProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    UserInfoPageModel? model = ref.watch(userInfoPageProvider);
    if (model == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      User user = model.user;
      return Column(
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(
                      "https://raw.githubusercontent.com/flutter-coder/ui_images/master/messenger_me.jpg"),
                  fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            user.username,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: smallGap),
          Text(
            user.email,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ],
      );
    }
  }
}
