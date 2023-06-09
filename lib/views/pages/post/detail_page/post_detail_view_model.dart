import 'package:flutter_blog_2/dto/response_dto.dart';
import 'package:flutter_blog_2/main.dart';
import 'package:flutter_blog_2/model/post/post.dart';
import 'package:flutter_blog_2/model/post/post_repository.dart';
import 'package:flutter_blog_2/provider/session_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final postDetailPageProvider = StateNotifierProvider.family.autoDispose<PostDetailPageViewModel, PostDetailPageModel?, int>((ref, postId) {
  return PostDetailPageViewModel(ref, null)..notifyInit(postId);
});

// 창고 데이터
class PostDetailPageModel{
  Post post;
  PostDetailPageModel({required this.post});
}

// 창고
class PostDetailPageViewModel extends StateNotifier<PostDetailPageModel?>{
  final mContext = navigatorKey.currentContext;
  final Ref ref;

  PostDetailPageViewModel(this.ref, super.state);

  void notifyInit(int id) async {
    Logger().d("notifyInit");

    SessionUser sessionUser = ref.read(sessionProvider);
    ResponseDTO responseDTO = await PostRepository().fetchPost(sessionUser.jwt!, id);

    state = PostDetailPageModel(post: responseDTO.data);
  }

}