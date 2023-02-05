// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:royals/views/home.view.dart';
import 'package:royals/views/form.view.dart';
import 'package:royals/views/register.view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:royals/helpers/api.helper.dart';
import 'dart:developer';
import 'package:royals/controllers/token.controller.dart';
import 'package:get/get.dart';
import 'package:royals/views/admin.view.dart';

void main() {
  runApp(const Reglog());
}

class Reglog extends StatefulWidget {
  const Reglog({super.key});

  @override
  State<Reglog> createState() => _ReglogState();
}

class _ReglogState extends State<Reglog> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  late String errormsg;
  late bool error, showprogress;
  final tokenHandler = Get.put(tokenHolder());

  startLogin() async {
    String apiurl = Login;

    var response = await http.post(Uri.parse(apiurl), body: {
      'email': emailController.text, //get the email text
      'password': passwordController.text, //get password text
    });

    log(response.body);
    log("reponse $response");

    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      // log(jsondata);
      if (jsondata["error"] == false) {
        setState(() {
          showprogress = false; //don't show progress indicator
          error = true;
          errormsg = jsondata["message"]; //["user"]["id"];
        });
        Fluttertoast.showToast(
            msg: 'Invalid Credentials',
            textColor: Colors.white,
            fontSize: 16.0,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.amber,
            timeInSecForIosWeb: 2);
      } else {
        if (jsondata["success"]) {
          setState(() {
            error = false;
            showprogress = false;
          });
          //save the data returned from server
          int id = jsondata["user"]["id"];
          // String name = jsondata["user"]["name"];
          // String email = jsondata["user"]["email"];
          String token = jsondata["access_token"];
          String userType = jsondata["user"]["user_type"];
          tokenHandler.getToken(token);
          tokenHandler.getUserId(id);
          // print(name);
          if (userType == 'admin') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Admin()),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Forms()),
            );
          }
        } else {
          showprogress = false; //don't show progress indicator
          error = true;
          errormsg = "Something went wrong.";
        }
      }
    } else {
      setState(() {
        showprogress = false; //don't show progress indicator
        error = true;
        errormsg = "Error during connecting to server.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              },
              child: Image.asset(
                'assets/images/ABLogo.png',
                fit: BoxFit.contain,
                height: 70,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xff423250),
      ),
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/homebg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: GlassmorphicFlexContainer(
            borderRadius: 10,
            blur: 20,
            padding: const EdgeInsets.fromLTRB(20, 80, 20, 50),
            alignment: Alignment.bottomCenter,
            border: 2,
            linearGradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFFffffff).withOpacity(0.1),
                  const Color(0xFFFFFFFF).withOpacity(0.05),
                ],
                stops: const [
                  0.1,
                  1,
                ]),
            borderGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFFffffff).withOpacity(0.2),
                const Color((0xFFFFFFFF)).withOpacity(0.5),
              ],
            ),
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Image.asset(
                    'assets/images/royal.png',
                    height: 140,
                    width: 140,
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: TextFormField(
                          controller: emailController,
                          validator: (email) {
                            if (email == null || email.isEmpty) {
                              return 'Please enter email address';
                            }
                            return null;
                          },
                          style: TextStyle(
                              color: Colors.white.withOpacity(.8),
                              fontSize: 14),
                          decoration: const InputDecoration(
                              icon: Icon(
                                Icons.email,
                                color: Colors.white,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white70)),
                              hintText: 'Email Address',
                              hintStyle: TextStyle(
                                  color: Colors.white60, fontSize: 14)),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: _obscureText,
                          validator: (pass) {
                            if (pass == null || pass.isEmpty) {
                              return 'Please enter password';
                            }
                            return null;
                          },
                          style: TextStyle(
                              color: Colors.white.withOpacity(.8),
                              fontSize: 14),
                          decoration: const InputDecoration(
                              icon: Icon(
                                Icons.lock,
                                color: Colors.white,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white70)),
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                  color: Colors.white60, fontSize: 14)),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            startLogin();
                            // emailController.clear();
                            passwordController.clear();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 4,
                            backgroundColor: const Color(0xff59b89d),
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 100),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50))),
                        child: const Text('SIGN IN'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 100),
                          shape: const StadiumBorder(),
                          side: const BorderSide(
                              width: 3, color: Color(0xff59b89d)),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Reg()),
                          );
                        },
                        child: const Text(
                          'SIGN UP',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
