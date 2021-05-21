import 'package:flutter/material.dart';


class ForgotPassword extends StatelessWidget {
  final bool login;
  final Function press;
  const ForgotPassword({
    Key key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "  " : " ",
          style: TextStyle(color: Colors.green),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "Forgot password" : " ",
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}