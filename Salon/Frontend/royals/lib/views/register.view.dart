import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:royals/views/home.view.dart';
import 'package:royals/views/reglogin.view.dart';
import 'package:royals/helpers/api.helper.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

void main() {
  runApp(const Reg());
}

class Reg extends StatefulWidget {
  const Reg({super.key});

  @override
  State<Reg> createState() => _RegState();
}

class _RegState extends State<Reg> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _regKey = GlobalKey<FormState>();
  late String errormsg;
  late bool error, showprogress;

  regUser() async {
    String regUrl = Register; //"http://192.168.137.194:8000/api/create-user";

    var response = await http.post(Uri.parse(regUrl), body: {
      'name': nameController.text,
      'email': emailController.text,
      'phone_number': phoneController.text,
      'password': passwordController.text
    });
    log(response.body);
    log("reponse $response");
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
                    height: 100,
                    width: 100,
                  ),
                ),
                Form(
                  key: _regKey,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: TextFormField(
                          controller: nameController,
                          validator: (pass) {
                            if (pass == null || pass.isEmpty) {
                              return 'Please enter your full name';
                            }
                            return null;
                          },
                          style: TextStyle(
                              color: Colors.white.withOpacity(.8),
                              fontSize: 14),
                          decoration: const InputDecoration(
                              icon: Icon(
                                Icons.account_box_rounded,
                                color: Colors.white,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white70)),
                              hintText: 'Full Name',
                              hintStyle: TextStyle(
                                  color: Colors.white60, fontSize: 14)),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: TextFormField(
                          controller: emailController,
                          validator: (pass) {
                            if (pass == null || pass.isEmpty) {
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
                          controller: phoneController,
                          validator: (pass) {
                            if (pass == null || pass.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              color: Colors.white.withOpacity(.8),
                              fontSize: 14),
                          decoration: const InputDecoration(
                              icon: Icon(
                                Icons.phone,
                                color: Colors.white,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white70)),
                              hintText: 'Phone Number',
                              hintStyle: TextStyle(
                                  color: Colors.white60, fontSize: 14)),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: TextFormField(
                          controller: passwordController,
                          validator: (pass) {
                            if (pass == null || pass.isEmpty) {
                              return 'Please enter a password';
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
                          if (_regKey.currentState!.validate()) {
                            regUser();
                            Navigator.pop(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Reglog()),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 4,
                            backgroundColor: const Color(0xff59b89d),
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 100),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50))),
                        child: const Text('SIGN UP'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
