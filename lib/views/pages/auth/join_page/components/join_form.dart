import 'package:flutter/material.dart';
import 'package:flutter_blog_2/core/constants/size.dart';
import 'package:flutter_blog_2/core/util/validator_util.dart';
import 'package:flutter_blog_2/dto/user_request.dart';
import 'package:flutter_blog_2/provider/user_provider.dart';
import 'package:flutter_blog_2/views/components/custom_auth_text_form_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JoinForm extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  JoinForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomAuthTextFormField(
            text: "Username",
            obscureText: false,
            funValidator: validateUsername(),
            controller: _username,
          ),
          const SizedBox(height: mediumGap),
          CustomAuthTextFormField(
            text: "Email",
            obscureText: false,
            funValidator: validateEmail(),
            controller: _email,
          ),
          const SizedBox(height: mediumGap),
          CustomAuthTextFormField(
            text: "Password",
            obscureText: true,
            funValidator: validatePassword(),
            controller: _password,
          ),
          const SizedBox(height: largeGap),
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                JoinReqDTO reqDTO = JoinReqDTO(username: _username.text, password: _password.text, email: _email.text);
                ref.read(userProvider).join(reqDTO);
              }
            },
            child: const Text("Join"),
          ),
        ],
      ),
    );
  }
}