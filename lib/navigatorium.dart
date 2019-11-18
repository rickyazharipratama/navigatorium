import 'dart:async';

import 'package:flutter/material.dart';

class Navigatorium {

  static Future<dynamic>push(
    BuildContext context,
    {
      @required Widget child
    }
  )async{
    return await Navigator.of(context)
    .push(PageRouteBuilder(
      barrierColor: Color(0x77000000),
      pageBuilder: (context,_,__)=> child,
      transitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (context,anim,_,child){
        return FadeTransition(
          opacity: Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(
              curve: Interval(0.4, 1,
                curve: Curves.easeIn
              ),
              parent: anim
            )
          ),
          child: SlideTransition(
            position: Tween<Offset>(begin: Offset(0,0.1), end: Offset(0,0)).animate(
              CurvedAnimation(
                curve: Curves.easeIn,
                parent: anim
              )
            ),
            child: child,
          ),
        );
      }
    ));
  }

  static Future<dynamic> changeWidget(BuildContext context,{
    @required Widget child
  }) async{
    Navigator.of(context).pop();
    return await push(context,
      child: child
    );
  }

  static Future<void> newRoute(BuildContext context,{
    @required Widget child
  }) async{
    return await Navigator.of(context).pushAndRemoveUntil(PageRouteBuilder(
      barrierColor: Color(0x77000000),
      pageBuilder: (contet,_,__) => child,
      transitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (context,anim,_,child){
        return FadeTransition(
          opacity: Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(
              curve: Curves.easeIn,
              parent: anim
            )
          ),
          child: child,
        );
      }
    ),(Route route) => route == null);
  }
}
