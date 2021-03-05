import 'package:flutter/material.dart';

Route enterExitRoute(Widget exitPage, Widget enterPage) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => enterPage,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        Stack(
      children: [
        SlideTransition(
          position:
              Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(-1.0, 0.0))
                  .animate(animation),
          child: exitPage,
        ),
        SlideTransition(
          position: Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset.zero)
              .animate(animation),
          child: enterPage,
        ),
      ],
    ),
  );
}
