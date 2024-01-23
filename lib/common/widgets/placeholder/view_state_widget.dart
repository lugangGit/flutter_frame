import 'package:flutter/material.dart';

/// 基础Widget
class ViewStateWidget extends StatelessWidget {
  final Widget? title;
  final Widget? message;
  final Widget? image;
  final Widget? buttonText;
  final Widget? buttonTextData;
  final VoidCallback? onPressed;
  final double? height;

  ViewStateWidget(
      {Key? key,
        this.image,
        this.title,
        this.message,
        this.buttonText,
        this.onPressed,
        this.buttonTextData,
        this.height})
      : super(key: key);

  void _onTap(){
    if(onPressed != null){
      onPressed?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget current = GestureDetector(
        behavior:HitTestBehavior.opaque,
        onTap: ()=>_onTap(),
        child:Container(
          height: (height ?? 0) > 0 ? height : MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          width:double.maxFinite,
          child:Column(
            mainAxisSize: MainAxisSize.min,
            children:[
              image ?? SizedBox(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    title??SizedBox(),
                    SizedBox(height: 14),
                    message??SizedBox(),
                    SizedBox(height: message!=null?14:0),
                    buttonTextData??SizedBox()
                  ],
                ),
              ),
            ],
          )
        )
    );
    return current;
  }
}