import 'package:flutter/material.dart';

void showLoading({required BuildContext context}){
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Center(
      child: Align(
        alignment: Alignment.center,
        child: Material(
          color: const Color.fromARGB(0, 0, 0, 0),
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white),
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Center( child: CircularProgressIndicator(color: Colors.black)
              )
            )
          )
        )
      )
    )
  );
}