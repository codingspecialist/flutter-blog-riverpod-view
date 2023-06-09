import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog_2/core/constants/size.dart';
import 'package:flutter_blog_2/ui/pages/user/info_page/widgets/user_info_profile.dart';
import 'package:flutter_blog_2/ui/widgets/custom_bottom_icon_button.dart';

class UserInfoBody extends StatelessWidget {
  const UserInfoBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Spacer(),
        UserInfoProfile(),
        SizedBox(height: mediumGap),
        Divider(color: Colors.white),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 18),
          child: CustomBottomIconButton(
            icon: CupertinoIcons.pen,
            text: "프로필 편집",
          ),
        )
      ],
    );
  }
}
