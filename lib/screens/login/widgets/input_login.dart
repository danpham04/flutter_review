import 'package:flutter/material.dart';
import 'package:flutter_review/screens/login/widgets/text_login.dart';

class InputLogin extends StatefulWidget {
  const InputLogin({super.key});

  @override
  State<InputLogin> createState() => _InputLoginState();
}

class _InputLoginState extends State<InputLogin> {
  bool showPassword = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: TextLogin(text: "Nhập thông tin gmail của bạn!"),
        ),
        TextFormField(
          decoration: const InputDecoration(
            hintText: "Type your mail?",
            prefixIcon: Icon(Icons.mail),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
          child: TextLogin(text: "Nhập Password của bạn!"),
        ),
        TextFormField(
          obscureText: showPassword,
          decoration: InputDecoration(
            hintText: "Type your password?",
            prefixIcon: const Icon(Icons.password),
            suffixIcon: IconButton(
              icon: Icon(showPassword ? Icons.remove_red_eye : Icons.lock),
              onPressed: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        )
      ],
    );
  }
}
