import 'package:demo/fake_store/presentation/login_controller.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign In",
          
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: size.height * .45,
                width: size.width * 0.9,
                child: Column(
                  children: [
                    Text(
                      "Desai Lead Management",
                     
                    ),
                    Text(
                      "As you enter your username and password, you're one step closer to unlocking the full potential of our website. Enter your credentials confidently, knowing that our robust security measures safeguard your information.",
                     
                      maxLines: 6,
                      textAlign: TextAlign.center,
                    ),
                   
                  ],
                ),
              ),
              Text("email"),
              TextFormField(
                controller:emailController ,
              ),

              
              Padding(
                padding: EdgeInsets.only(right: size.width * .72),
                child: const Text(
                  "Password",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              Consumer<LoginController>(builder: (context, controller, _) {
                return SizedBox(
                  width: size.width * 0.9,
                  child: TextFormField(
                    obscureText: controller.visibility,
                    obscuringCharacter: '*',
                    controller: passwordController,
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                        onPressed: () {
                          controller.onPressed();
                        },
                        icon: Icon(controller.visibility == true
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                      border: const OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Color(0xff1A3447)),
                      ),
                    ),
                  ),
                );
              }),
              SizedBox(
                height: size.width * .035,
              ),
              SizedBox(
                height: size.height * 0.085,
                width: size.width * 0.9,
                child: MaterialButton(
                  color: Colors.blue,
                  onPressed: () {
                    Provider.of<LoginController>(context, listen: false)
                        .onLogin(emailController.text.trim(),
                            passwordController.text.trim(), context);
                  },
                  child: Text(
                    "Login",
                    
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}