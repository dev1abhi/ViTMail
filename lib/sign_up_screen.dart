import 'package:flutter/material.dart';
import 'package:sign_button/sign_button.dart';

class SignUpScreen extends StatelessWidget {
  final void Function() handleSignIn;

  const SignUpScreen({super.key, required this.handleSignIn});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(image: AssetImage('assets/images/logo1.jpg')),

              //google sign in button
              const SizedBox(height: 60,),
              SignInButton(
                  buttonType: ButtonType.google,
                  onPressed: handleSignIn,
                //want particular hex code color
                btnColor: const Color(0xff3c629d) ,
                btnTextColor: Colors.white,
              )


            ],
          ),
        ),
      ),
    );
  }
}
