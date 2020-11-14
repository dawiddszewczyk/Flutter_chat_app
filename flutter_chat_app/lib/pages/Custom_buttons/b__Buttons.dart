import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback callback;
  final String textbutton;
  const CustomButton({Key key,this.callback,this.textbutton});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        elevation:  6.0,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: callback,
          minWidth: 220.0,
          child: Text(textbutton,
            style: TextStyle(
              fontFamily: 'Segoe UI',
              fontSize: 16,
              color: const Color(0xff707070),
            ),
          ),
        ),
      ),
    );
  }
}
