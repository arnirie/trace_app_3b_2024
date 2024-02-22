import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:trace_app_3b/screens/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showPassword = true;
  final email = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void toggleShowPassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  void login() async {
    if (formKey.currentState!.validate()) {
      //proceed to login
      EasyLoading.show(status: 'Processing...');
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.text, password: password.text)
          .then((value) {
        //open HomeScreen
        EasyLoading.dismiss();
        Navigator.of(context).push(
          CupertinoPageRoute(builder: (_) => HomeScreen()),
        );
      }).catchError((error) {
        print(error);
        EasyLoading.showError('Incorrect Username and/or Password');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/login_back.webp'),
            alignment: Alignment.bottomCenter,
            opacity: 0.5,
          ),
        ),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Gap(22),
              const Text('Enter your username and password to continue'),
              const Gap(8),
              TextFormField(
                controller: email,
                decoration: InputDecoration(
                  label: const Text('Email Address'),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required. Please enter your email address.';
                  } //return string - invalid
                  if (!EmailValidator.validate(value)) {
                    return 'Please enter a valid email.';
                  }
                  return null; //valid
                },
              ),
              const Gap(8),
              TextFormField(
                controller: password,
                obscureText: showPassword,
                decoration: InputDecoration(
                  label: const Text('Password'),
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: toggleShowPassword,
                    icon: Icon(
                        showPassword ? Icons.visibility : Icons.visibility_off),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required. Please enter your password.';
                  } //return string - invalid
                  return null; //valid
                },
              ),
              const Gap(8),
              ElevatedButton(
                onPressed: login,
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
