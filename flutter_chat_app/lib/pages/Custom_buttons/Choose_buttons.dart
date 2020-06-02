import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback call_back;
  final String text_button;
  const CustomButton({Key key,this.call_back,this.text_button});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        elevation:  6.0,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: call_back,
          minWidth: 150.0,
          child: Text(text_button),
        ),
      ),
    );
  }
}
