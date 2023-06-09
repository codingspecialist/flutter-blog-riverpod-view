import 'package:flutter_blog_2/dto/response_dto.dart';
import 'package:flutter_blog_2/main.dart';
import 'package:flutter_blog_2/model/post/post.dart';
import 'package:flutter_blog_2/model/post/post_repository.dart';
import 'package:flutter_blog_2/provider/session_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final postListPageProvider = StateNotifierProvider<PostListPageViewModel, PostListPageModel?>((ref) {
  return PostListPageViewModel(ref, null)..notifyInit();
});

// 창고 데이터
class PostListPageModel{
  List<Post> posts;
  PostListPageModel({required this.posts});
}

// 창고
class PostListPageViewModel extends StateNotifier<PostListPageModel?>{
  final mContext = navigatorKey.currentContext;
  final Ref ref;

  PostListPageViewModel(this.ref, super.state);

  void notifyInit() async {
    Logger().d("notifyInit");
    SessionUser sessionUser = ref.read(sessionProvider);
    ResponseDTO responseDTO = await PostRepository().fetchPostList(sessionUser.jwt!);
    state = PostListPageModel(posts: responseDTO.data);
  }

}