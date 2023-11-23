import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void showCertificate(BuildContext context, {bool isFromCourseScreen = false}){ 
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) =>
      Center(
        child: Align(
          alignment:Alignment.center,
          child: Material(
            color: const Color.fromARGB(0, 0,0,0),
            child:Padding(
              padding: const EdgeInsets.symmetric(horizontal:10.0),
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: isFromCourseScreen 
                  ? GestureDetector(
                    onTap: (){
                      context.push('/dashboard');
                    },
                    child: const Text('Claim Your Certificate.',style: TextStyle(color: Colors.blue, fontSize: 22)),
                  ) 
                  : const Text('Claim Your Certificate.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22),
                  )
                )
              )
            )
          )
        )
      )
    );
}