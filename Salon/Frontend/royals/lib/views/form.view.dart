// ignore_for_file: unused_local_variable, avoid_print, use_build_context_synchronously, avoid_unnecessary_containers

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:royals/views/home.view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:royals/views/history.veiw.dart';
import 'package:royals/views/reglogin.view.dart';
import 'package:royals/helpers/api.helper.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:royals/controllers/token.controller.dart';

void main() {
  runApp(const Forms());
}

class Forms extends StatefulWidget {
  const Forms({super.key});

  @override
  State<Forms> createState() => _FormsState();
}

class _FormsState extends State<Forms> {
  TextEditingController dateInput = TextEditingController();
  TextEditingController timeInput = TextEditingController();
  TextEditingController serviceSelected = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int serviceId = 0;
  final tokenHandler = Get.put(tokenHolder());
  tokenHolder tokenFind = Get.find<tokenHolder>();
  tokenHolder idFind = Get.find<tokenHolder>();
  var sam = "";
  var samm = "";

  logout() async {
    String log = Logout;

    final response = await http.post(Uri.parse(log),
        body: {'Authorization': 'Bearer ${tokenFind.usertoken}'});
  }

  getService() async {
    String service = Selected;

    var response = await http.post(Uri.parse(service), body: {
      'service_id': '$serviceId',
      'user_id': '${idFind.userId}',
      'booking_date': '$sam $samm'
    });
    var idd = idFind.userId;
    log(response.body);
    log("response $response");
    log("$idd");
    log("$serviceId");
    log("$sam $samm");
  }

  @override
  void initState() {
    timeInput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Padding(
              padding: const EdgeInsets.only(left: 120),
              child: ElevatedButton(
                onPressed: () {
                  logout();
                  Navigator.pop(
                    context,
                    MaterialPageRoute(builder: (context) => const Reglog()),
                  );
                },
                style: ElevatedButton.styleFrom(
                    elevation: 4,
                    backgroundColor: const Color(0xff59b89d),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: const Text(
                  'LOGOUT',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                ),
              ),
            )
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
            padding: const EdgeInsets.fromLTRB(20, 65, 20, 35),
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
                  child: Column(
                    children: [
                      const SizedBox(height: 2),
                      Text(
                        'Select Service',
                        style: GoogleFonts.lato(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 20),
                      ),
                      RadioListTile(
                        visualDensity: const VisualDensity(vertical: -3),
                        title: Text(
                          "Haircut (₱500)",
                          style: GoogleFonts.lato(
                              color: Colors.white, fontSize: 15),
                        ),
                        value: 1,
                        groupValue: serviceId,
                        onChanged: (value) {
                          setState(() {
                            serviceId = value!;
                            serviceSelected.text = serviceId.toString();
                          });
                        },
                      ),
                      RadioListTile(
                        visualDensity: const VisualDensity(vertical: -3),
                        title: Text(
                            "Full Head Hair Color with Keratin Mask (₱1000)",
                            style: GoogleFonts.lato(
                                color: Colors.white, fontSize: 15)),
                        value: 2,
                        groupValue: serviceId,
                        onChanged: (value) {
                          setState(() {
                            serviceId = value!;
                          });
                        },
                      ),
                      RadioListTile(
                        visualDensity: const VisualDensity(vertical: -3),
                        title: Text(
                          "Brazilian Blow Dry Treatment (₱1000)",
                          style: GoogleFonts.lato(
                              color: Colors.white, fontSize: 15),
                        ),
                        value: 3,
                        groupValue: serviceId,
                        onChanged: (value) {
                          setState(() {
                            serviceId = value!;
                          });
                        },
                      ),
                      RadioListTile(
                        visualDensity: const VisualDensity(vertical: -3),
                        title: Text(
                          "Silky Hair Rebond with Keratin Mask (₱2000)",
                          style: GoogleFonts.lato(
                              color: Colors.white, fontSize: 15),
                        ),
                        value: 4,
                        groupValue: serviceId,
                        onChanged: (value) {
                          setState(() {
                            serviceId = value!;
                          });
                        },
                      ),
                      RadioListTile(
                        visualDensity: const VisualDensity(vertical: -3),
                        title: Text(
                          "Hair Color with Highlights and Keratin Mask (₱2000)",
                          style: GoogleFonts.lato(
                              color: Colors.white, fontSize: 15),
                        ),
                        value: 5,
                        groupValue: serviceId,
                        onChanged: (value) {
                          setState(() {
                            serviceId = value!;
                          });
                        },
                      ),
                      RadioListTile(
                        visualDensity: const VisualDensity(vertical: -3),
                        title: Text(
                          "Silky Hair Rebond with Color and Keratin Mask (₱2500)",
                          style: GoogleFonts.lato(
                              color: Colors.white, fontSize: 15),
                        ),
                        value: 6,
                        groupValue: serviceId,
                        onChanged: (value) {
                          setState(() {
                            serviceId = value!;
                          });
                        },
                      ),
                      RadioListTile(
                        visualDensity: const VisualDensity(vertical: -3),
                        title: Text(
                          "Silky Hair Rebond with Color and Brazilian Treatment (₱3000)",
                          style: GoogleFonts.lato(
                              color: Colors.white, fontSize: 15),
                        ),
                        value: 7,
                        groupValue: serviceId,
                        onChanged: (value) {
                          setState(() {
                            serviceId = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                        child: TextFormField(
                          controller: dateInput,
                          validator: (date) {
                            if (date == null || date.isEmpty) {
                              return 'Please select date';
                            }
                            return null;
                          },
                          style: TextStyle(
                              color: Colors.white.withOpacity(.8),
                              fontSize: 14),
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.calendar_today,
                              color: Colors.white,
                            ),
                            labelText: "Select Date",
                            labelStyle: TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white70)),
                            hintText: 'yyyy-mm-dd',
                            hintStyle:
                                TextStyle(color: Colors.white60, fontSize: 14),
                          ),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: const ColorScheme.light(
                                        primary: Color(0xff423250),
                                        onPrimary: Colors.white,
                                        onSurface: Colors.black,
                                      ),
                                      textButtonTheme: TextButtonThemeData(
                                        style: TextButton.styleFrom(
                                          foregroundColor:
                                              const Color(0xff59b89d),
                                        ),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101));
                            if (pickedDate != null) {
                              print(pickedDate);
                              // dateInput = pickedDate as TextEditingController;
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              print(formattedDate);
                              setState(() {
                                dateInput.text = formattedDate;
                                sam = formattedDate;
                              });
                            } else {
                              print("Date is not selected");
                            }
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
                        child: TextFormField(
                          validator: (time) {
                            if (time == null || time.isEmpty) {
                              return 'Please select time';
                            }
                            return null;
                          },
                          controller: timeInput,
                          style: TextStyle(
                              color: Colors.white.withOpacity(.8),
                              fontSize: 14),
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.alarm_rounded,
                              color: Colors.white,
                            ),
                            labelText: "Select Time",
                            labelStyle: TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white70)),
                            hintText: 'hh:mm',
                            hintStyle:
                                TextStyle(color: Colors.white60, fontSize: 14),
                          ),
                          readOnly:
                              true, //set it true, so that user will not able to edit text
                          onTap: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              initialTime: TimeOfDay.now(),
                              context: context,
                            );

                            if (pickedTime != null) {
                              print(pickedTime.format(context));
                              DateTime parsedTime = DateFormat('HH:mm')
                                  .parse(pickedTime.format(context).toString());
                              //converting to DateTime so that we can further format on different pattern.
                              print(parsedTime);
                              String formattedTime =
                                  DateFormat('HH:mm').format(parsedTime);
                              print(formattedTime);
                              //DateFormat() is from intl package, you can format the time on any pattern you need.

                              setState(() {
                                timeInput.text =
                                    formattedTime; //set the value of text field.
                                samm = formattedTime;
                              });
                            } else {
                              print("Time is not selected");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () => {
                    if (_formKey.currentState!.validate())
                      {
                        serviceSelected.clear(),
                        dateInput.clear(),
                        timeInput.clear(),
                        getService(),
                        _bookDialogue(context),
                      }
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 4,
                      backgroundColor: const Color(0xff59b89d),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 70),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                  child: const Text(
                    'BOOK NOW',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                        fontSize: 15),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const History()),
                      );
                    },
                    child: Text(
                      'View Bookings History',
                      style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 12,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.0),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _bookDialogue(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
            child: Image.asset(
              'assets/images/booked.png',
              fit: BoxFit.contain,
              height: 70,
            ),
          ),
          content: const Text(
            'BOOKED SUCCESSFULY',
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
