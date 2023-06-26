import 'package:dio/dio.dart';
import 'package:flutter_blog_2/core/constants/http.dart';
import 'package:flutter_blog_2/data/dtos/response_dto.dart';
import 'package:flutter_blog_2/data/dtos/user_request.dart';
import 'package:flutter_blog_2/data/models/user.dart';

class UserRepository {
  static final UserRepository _instance = UserRepository._single();
  factory UserRepository() {
    return _instance;
  }
  UserRepository._single();

  Future<ResponseDTO> fetchLogin(LoginReqDTO loginReqDTO) async {
    try{
      // 1. 통신 시작
      Response response = await dio.post("/login", data: loginReqDTO.toJson());

      // 2. DTO 파싱
      ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);
      responseDTO.data = User.fromJson(responseDTO.data);

      // 3. 토큰 받기
      final authorization = response.headers["authorization"];
      if(authorization != null){
        responseDTO.token = authorization.first;
      }
      return responseDTO;
    }catch(e){
      return ResponseDTO(code: -1, msg: "유저네임 혹은 비번이 틀렸습니다");
    }
  }

  Future<ResponseDTO> fetchJoin(JoinReqDTO joinReqDTO) async {
    try{
      Response response = await dio.post("/join", data: joinReqDTO.toJson());
      ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);
      responseDTO.data = User.fromJson(responseDTO.data);
      return responseDTO;
    }catch(e){
      return ResponseDTO(code: -1, msg: "중복되는 유저명입니다.");
    }
  }

  Future<ResponseDTO> fetchUser(String jwt, int id) async {
    try {
      Response response = await dio.get("/user/$id",
          options: Options(headers: {"Authorization": "$jwt"}));
      ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);
      responseDTO.data = User.fromJson(responseDTO.data);
      return responseDTO;
    } catch (e) {
      return ResponseDTO(code: -1, msg: "실패 : ${e}");
    }
  }
}