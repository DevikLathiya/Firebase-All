
import 'package:flutter/material.dart';
import 'constants.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({Key? key, this.text, this.press,}) : super(key: key);
  final String? text;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,margin: EdgeInsets.all(10),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: kPrimaryColor,
          shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        onPressed: press as void Function()?,
        child: Text(text!, style: const TextStyle(fontSize: (18), color: Colors.white,),),
      ),
    );
  }
}
