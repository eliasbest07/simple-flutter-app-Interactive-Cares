import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScree extends StatelessWidget {
  const HomeScree({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Authentication')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text('Welcome, please login or register to continue', textAlign: TextAlign.center, style: TextStyle(fontSize: 22)),
          MaterialButton(
            color: Colors.white,
            elevation: 3,
            onPressed: (){
              context.push('/dashboard');
            },
            child: const Text('Login'),
          ),
          const Text('Are you not registered yet?', textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
            MaterialButton(
            onPressed: (){
            
            },
            child: const Text('sign up here', style: TextStyle(color: Colors.blue, fontSize: 16),),
          ),
          
        ]
      ),
    );
  }
}