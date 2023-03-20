import 'package:flutter/material.dart';

TextFormField inputBox(
    {keyboardType = TextInputType.text,
    String errorMsg = "값을 입력",
    String labelText = "값을 입력",
    bool obscureText = false,
    Function(dynamic value)? onChanged}) {
  return TextFormField(
    onChanged: onChanged,
    keyboardType: keyboardType,
    obscureText: obscureText,
    // onSaved: (Value) {},
    // validator 에서 return 한 메시지를 inputbox 하단에 보이기
    autovalidateMode: AutovalidateMode.always,
    validator: (value) {
      if (value!.isEmpty) {
        return errorMsg;
      }
      return null;
    },
    decoration: InputDecoration(
        border: const OutlineInputBorder(), labelText: labelText),
  );
}
