// ignore_for_file: use_build_context_synchronously

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_flutter_application_interactive_cares/config/auth/login_firebase.dart';
import 'package:simple_flutter_application_interactive_cares/config/auth/registre_firebase.dart';
import 'package:simple_flutter_application_interactive_cares/config/auth/registre_with_google_firebase.dart';

import '/presentation/widgets/show_loading.dart';
import '../providers/riverpod_provider.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final TextEditingController inputLoginEmail = ref.watch(loginEmail);
    final TextEditingController inputLoginPassword = ref.watch(loginPassword);
    final TextEditingController inputRegisterEmail = ref.watch(registerEmail);
    final TextEditingController inputRegisterPassword = ref.watch(registerPassword);
    final bool isHidden = ref.watch(hiddenPassword);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox(
            height: size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal:10.0),
                  child:  Text('Welcome, please login or register to continue', textAlign: TextAlign.center, style: TextStyle(fontSize: 22)),
                ),
                MaterialButton(
                  color: Colors.white,
                  elevation: 3,
                  onPressed: (){
                    loginAnimation.forward();
                    
                  },
                  child: const Text('Login'),
                ),
                const Text('Are you not registered yet?', textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
                  MaterialButton(
                  onPressed: (){
                    registerAnimation.forward();
                  },
                  child: const Text('sign up here', style: TextStyle(color: Colors.blue, fontSize: 16),),
                ),
              ]
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _LoginView(
              size: size, 
              inputLoginEmail: inputLoginEmail, 
              inputLoginPassword: inputLoginPassword, 
              isHidden: isHidden,
              ref: ref
            )
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _RegisterView(
              size: size, 
              inputRegisterEmail: inputRegisterEmail, 
              inputRegisterPassword: inputRegisterPassword, 
              isHidden: isHidden,
              ref:ref
            )
          )
        ]
      )
    );
  }
}

class _RegisterView extends StatelessWidget {
  const _RegisterView({
    required this.size,
    required this.inputRegisterEmail,
    required this.inputRegisterPassword,
    required this.isHidden, 
    required this.ref,
  });

  final Size size;
  final TextEditingController inputRegisterEmail;
  final TextEditingController inputRegisterPassword;
  final bool isHidden;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return FadeInUpBig(
      animate: false,
      controller: (animacionControl) {
        registerAnimation = animacionControl;
      },
      child: Container(
        height: size.height * 0.78,
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(155, 118, 118, 118),
                offset: Offset(-2, -2),
                blurRadius: 8,
                spreadRadius: 1,
              )
            ]),
        child: Column(
          children: [
            SizedBox(height: size.height * 0.015),
            Row(
              children: [
                MaterialButton(
                  height: 60,
                  shape: const CircleBorder(),
                  onPressed: () {
                    registerAnimation.reverse();
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: const Icon(
                    Icons.close_rounded,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.020),
            const Text('New user',
                style: TextStyle(fontSize: 20)),
            SizedBox(height: size.height * 0.040),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(
                    color:
                        const Color.fromARGB(255, 81, 80, 80),
                    width: 2,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color:
                          Color.fromARGB(255, 118, 118, 118),
                      offset: Offset(1, 1),
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                    BoxShadow(
                      color:
                          Color.fromARGB(255, 255, 255, 255),
                      offset: Offset(-1, -1),
                      blurRadius: 3,
                      spreadRadius: 3,
                    )
                  ]),
              child: Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 200,
                    child: TextFormField(
                        controller: inputRegisterEmail,
                        maxLines: 1,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: 'Email'),
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 18,
                        )),
                  )
                ],
              ),
            ),
            SizedBox(height: size.height * 0.030),
            Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(
                      color: const Color.fromARGB(
                          255, 61, 60, 60),
                      width: 2,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(
                            255, 118, 118, 118),
                        offset: Offset(1, 1),
                        blurRadius: 4,
                        spreadRadius: 1,
                      ),
                      BoxShadow(
                        color: Color.fromARGB(
                            255, 255, 255, 255),
                        offset: Offset(-1, -1),
                        blurRadius: 3,
                        spreadRadius: 3,
                      )
                    ]),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: 185,
                      child: TextFormField(
                        controller: inputRegisterPassword,
                        autocorrect: false,
                        obscureText:isHidden,
                        maxLines: 1,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: 'Password'),
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color:Color.fromARGB(255, 0, 0, 0),
                          fontSize: 18,
                        )
                      )
                    ),
                    SizedBox(
                        width: 20,
                        child: IconButton(
                          splashRadius: 20,
                          icon: isHidden
                              ? const Icon(Icons.remove_red_eye_sharp)
                              : const Icon( Icons.visibility_off),
                          onPressed: () {
                            ref.read(hiddenPassword.notifier).update((state) => !state);
                          },
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                )),
            SizedBox(height: size.height * 0.040),
            MaterialButton(
              color: Colors.black,
              splashColor: Colors.white,
              onPressed: () async {
                if (!RegExp( r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(inputRegisterEmail.text)){
                  showMessage(context,'Invalid email');
                }
                if (inputRegisterPassword.text.length < 6) {
                  showMessage(context,'The password must be greater than 6 digits');
                }
                showLoading(context: context);

                var result = await registerWithEmailPassword(inputRegisterEmail.text,inputRegisterPassword.text);
                String message = result.$1;
                bool success = result.$2;

                if(success){
                  context.pushReplacement('/dashboard');
                  return;
                }

                showMessage(context,message);
              },
              child: const Text(
                'Register',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: size.height * 0.030),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 1,
                  width: 40,
                  color: const Color.fromARGB(155, 61, 60, 60),
                ),
                const Text('you can also start with'),
                Container(
                  height: 1,
                  width: 40,
                  color: const Color.fromARGB(155, 61, 60, 60),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.030),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                border: Border.all(
                  color: const Color.fromARGB(255, 61, 60, 60),
                  width: 2,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 118, 118, 118),
                    offset: Offset(1, 1),
                    blurRadius: 2,
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    color:Color.fromARGB(255, 255, 255, 255),
                    offset: Offset(-1, -1),
                    blurRadius: 3,
                    spreadRadius: 1,
                  )
                ]
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: (){
                    inAccountGoogle(context);
                  },
                  child: Center(child: Image.asset( 'assets/google_logo.png'))),
              ),
            ),
            SizedBox(height: size.height * 0.050),
            const Text('By signing in, you agree to our'),
            SizedBox(height: size.height * 0.001),
            TextButton(
              onPressed: () {},
              child: const Text('Terms and Conditions'))
          ],
        ),
      ),
    );
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView({
    required this.size,
    required this.inputLoginEmail,
    required this.inputLoginPassword,
    required this.isHidden, 
    required this.ref,
  });

  final Size size;
  final TextEditingController inputLoginEmail;
  final TextEditingController inputLoginPassword;
  final bool isHidden;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return FadeInUpBig(
      animate: false,
      controller: (animacionControl) {
        loginAnimation = animacionControl;
      },
      child: Container(
        height: size.height * 0.78,
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(155, 118, 118, 118),
                offset: Offset(-2, -2),
                blurRadius: 8,
                spreadRadius: 1,
              )
            ]),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: size.height * 0.015),
              Row(
                children: [
                  MaterialButton(
                    height: 60,
                    shape: const CircleBorder(),
                    onPressed: () {
                      loginAnimation.reverse();
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: const Icon(
                      Icons.close_rounded,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.020),
              const Text('Login',
                  style: TextStyle(fontSize: 20)),
              SizedBox(height: size.height * 0.040),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(
                      color: const Color.fromARGB( 255, 81, 80, 80),
                      width: 2,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(
                            255, 118, 118, 118),
                        offset: Offset(1, 1),
                        blurRadius: 4,
                        spreadRadius: 1
                      ),
                      BoxShadow(
                        color: Color.fromARGB(255, 255, 255, 255),
                        offset: Offset(-1, -1),
                        blurRadius: 3,
                        spreadRadius: 3
                      )
                    ]),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 20
                    ),
                    SizedBox(
                      width: 200,
                      child: TextFormField(
                        controller: inputLoginEmail,
                        maxLines: 1,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: 'Email'),
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 18,
                        )
                      )
                    )
                  ]
                ),
              ),
              SizedBox(height: size.height * 0.030),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(
                    color: const Color.fromARGB(255, 61, 60, 60),
                    width: 2
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 118, 118, 118),
                      offset: Offset(1, 1),
                      blurRadius: 4,
                      spreadRadius: 1
                    ),
                    BoxShadow(
                      color: Color.fromARGB(255, 255, 255, 255),
                      offset: Offset(-1, -1),
                      blurRadius: 3,
                      spreadRadius: 3
                    )
                  ]
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 20
                    ),
                    SizedBox(
                      width: 185,
                      child: TextFormField(
                        controller: inputLoginPassword,
                        maxLines: 1,
                        autocorrect: false,
                        obscureText: isHidden,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          focusedBorder:InputBorder.none,
                          hintText: 'Password'),
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 18
                        )
                      )
                    ),
                    SizedBox(
                      width: 20,
                      child: IconButton(
                        splashColor: Colors.transparent,
                        icon: isHidden
                          ? const Icon(Icons.remove_red_eye_sharp)
                          : const Icon(Icons.visibility_off),
                        onPressed: () {
                          ref.read(hiddenPassword.notifier).update((state) => !state);
                        }
                      )
                    ),
                    const SizedBox( width: 10)
                  ]
                )
              ),
              SizedBox(height: size.height * 0.040),
              MaterialButton(
                color: Colors.black,
                splashColor: Colors.white,
                onPressed: () async {
                  if (!RegExp( r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(inputLoginEmail.text)){
                  showMessage(context,'Invalid email');
                  }
                  if (inputLoginPassword.text.length < 6) {
                    showMessage(context,'The password must be greater than 6 digits');
                  }
                  showLoading(context: context);
                  var result = await signInWithEmailPassword(inputLoginEmail.text,inputLoginPassword.text);
                  String message = result.$1;
                  bool success = result.$2;

                  if(success){
                    context.pushReplacement('/dashboard');
                    return;
                  }
                  showMessage(context,message);
                  },
                child: const Text(
                  'Get in',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: size.height * 0.030),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 1,
                    width: 40,
                    color:
                        const Color.fromARGB(155, 61, 60, 60),
                  ),
                  const Text('you can also start with'),
                  Container(
                    height: 1,
                    width: 40,
                    color:
                        const Color.fromARGB(155, 61, 60, 60),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.030),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(
                      color: const Color.fromARGB(
                          255, 61, 60, 60),
                      width: 2,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(
                            255, 118, 118, 118),
                        offset: Offset(1, 1),
                        blurRadius: 2,
                        spreadRadius: 1,
                      ),
                      BoxShadow(
                        color: Color.fromARGB(
                            255, 255, 255, 255),
                        offset: Offset(-1, -1),
                        blurRadius: 3,
                        spreadRadius: 1,
                      )
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: (){
                      inAccountGoogle(context);
                    },
                    child: Center(
                      child: Image.asset('assets/google_logo.png')
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.050),
              const Text('By signing in, you agree to our'),
              SizedBox(height: size.height * 0.001),
              TextButton(
                onPressed: () {},
                child: const Text('Terms and Conditions')
              ),
              SizedBox(height: size.height * 0.22),
            ],
          ),
        ),
      ),
    );
  }
}
void inAccountGoogle(BuildContext context) async{
  showLoading(context: context);
  var result = await signInWithGoogleAccount();
  String message = result.$1;
  bool success = result.$2;

  if(success){
    context.pushReplacement('/dashboard');
    return;
  }
  showMessage(context,message);
}

void showMessage(BuildContext context, String message){
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
                  child:  Text(message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 22),
                  )
                )
              )
            )
          )
        )
      )
    );
}