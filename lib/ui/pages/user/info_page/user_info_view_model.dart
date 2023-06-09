import 'package:flutter_blog_2/data/dtos/response_dto.dart';
import 'package:flutter_blog_2/data/models/user.dart';
import 'package:flutter_blog_2/data/providers/session_provider.dart';
import 'package:flutter_blog_2/data/repositories/user_repository.dart';
import 'package:flutter_blog_2/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final userInfoPageProvider = StateNotifierProvider.autoDispose<UserInfoPageViewModel, UserInfoPageModel?>((ref) {
  return UserInfoPageViewModel(ref, null)..notifyInit();
});

// 창고 데이터
class UserInfoPageModel{
  User user;
  UserInfoPageModel({required this.user});
}

// 창고
class UserInfoPageViewModel extends StateNotifier<UserInfoPageModel?>{
  final mContext = navigatorKey.currentContext;
  final Ref ref;

  UserInfoPageViewModel(this.ref, super.state);

  void notifyInit() async {
    Logger().d("notifyInit");

    SessionUser sessionUser = ref.read(sessionProvider);
    ResponseDTO responseDTO = await UserRepository().fetchUser(sessionUser.jwt!, sessionUser.user!.id);

    state = UserInfoPageModel(user: responseDTO.data);
  }

}