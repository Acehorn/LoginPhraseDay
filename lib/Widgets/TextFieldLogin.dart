import 'package:flutter/material.dart';

class TextFieldLogin extends StatefulWidget {
  final TextInputType keyboardType;
  final Icon icon;
  final String hintText;
  final String regex;
  final String errorMessage;
  final onChanged;
  final bool obscureField;
  TextFieldLogin({
    Key key,
    this.keyboardType,
    this.icon,
    @required this.hintText,
    @required this.regex,
    @required this.errorMessage,
    this.onChanged,
    this.obscureField,
  }) : super(key: key);

  @override
  State<TextFieldLogin> createState() => _TextFieldLoginState();
}

class _TextFieldLoginState extends State<TextFieldLogin> {
  bool eyeText = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: eyeText,
      autocorrect: false,
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType != null ? widget.keyboardType : null,
      validator: (value) {
        RegExp regExp = new RegExp(widget.regex);

        return regExp.hasMatch(value ?? "") ? null : widget.errorMessage;
      },
      decoration: InputDecoration(
        suffixIcon: widget.obscureField
            ? GestureDetector(
                onTap: () {
                  setState(() {});
                  eyeText = !eyeText;
                },
                child: Icon(
                  Icons.remove_red_eye,
                  color: Colors.black,
                ))
            : null,
        hintText: widget.hintText,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
        prefixIcon: widget.icon != null ? widget.icon : null,
      ),
    );
  }
}
