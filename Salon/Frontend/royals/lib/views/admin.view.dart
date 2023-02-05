// ignore_for_file: non_constant_identifier_names, unused_element, unused_local_variable, library_private_types_in_public_api, avoid_unnecessary_containers

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:royals/views/home.view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royals/views/reglogin.view.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:royals/controllers/token.controller.dart';
import 'package:royals/helpers/api.helper.dart';
import 'dart:async';

void main() {
  runApp(const Admin());
}

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _ShowBookings {
  String? name;
  String? phone_number;
  String? service;
  String? price;
  String? booking_date;
  String? booking_status;
  String? cancellation_note;
  String? id;
  String? user_id;
  String? service_id;

  _ShowBookings({
    this.name,
    this.phone_number,
    this.service,
    this.price,
    this.booking_date,
    this.booking_status,
    this.cancellation_note,
    this.id,
    this.user_id,
    this.service_id,
  });

  _ShowBookings.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone_number = json['phone_number'].toString();
    service = json['service'];
    price = json['price'].toString();
    booking_date = json['booking_date'].toString();
    booking_status = json['booking_status'];
    cancellation_note = json['cancellation_note'];
    id = json['id'].toString();
    user_id = json['user_id'].toString();
    service_id = json['service_id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone_number'] = phone_number;
    data['service'] = service;
    data['price'] = price;
    data['booking_date'] = booking_date;
    data['booking_status'] = booking_status;
    data['cancellation_note'] = cancellation_note;
    data['id'] = id;
    data['user_id'] = user_id;
    data['servcie_id'] = service_id;
    return data;
  }
}

Future<List<_ShowBookings>> fetchAlbum() async {
  final idHandler = Get.put(tokenHolder());
  String showHistory = getHistory;
  final response = await http.get(Uri.parse(showHistory));

  if (response.statusCode == 200) {
    final List result = json.decode(response.body);
    var jsondata = json.decode(response.body);
    return result.map((e) => _ShowBookings.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load data');
  }
}

class _AdminState extends State<Admin> {
  bool show = false; //for stetState alert dialog
  final tokenHandler = Get.put(tokenHolder());
  tokenHolder tokenFind = Get.find<tokenHolder>(); //for the user ID
  final ScrollController _scrollController =
      ScrollController(); // for list scrolling
  TextEditingController cancelNoteController =
      TextEditingController(); //for cancellation note
  String? bookingStatus; //holds booking status string value
  final _formKey = GlobalKey<FormState>();
  late String note;
  late String status;
  late String indexID;
  late String userID;
  late String serviceID;

  logout() async {
    String log = Logout;

    final response = await http.post(Uri.parse(log),
        body: {'Authorization': 'Bearer ${tokenFind.usertoken}'});
  }

  changeStatus() async {
    String change = changeStat;

    final response = await http.post(Uri.parse(change), body: {
      'id': indexID,
      'user_id': userID,
      'service_id': serviceID,
      'cancellation_note': note, //cancelNoteController.text,
      'booking_status': status
    });
    log(response.body);
  }

  Future<void> _bookDialogue(BuildContext context) {
    // bool show = false;
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          // insetPadding: const EdgeInsets.symmetric(
          //   horizontal: 50.0,
          //   vertical: 200.0,
          // ),
          contentPadding: const EdgeInsets.all(25),
          title: const Text(
            "Change Booking Status",
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 10),
                const Text(
                  "Cancel booking?",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        minLines: 1,
                        maxLines: 4,
                        controller: cancelNoteController,
                        validator: (note) {
                          if (note == null || note.isEmpty) {
                            return 'Please add a note';
                          }
                          return null;
                        },
                        style: TextStyle(
                            color: Colors.black.withOpacity(.8), fontSize: 14),
                        decoration: const InputDecoration(
                            // icon: Icon(
                            //   Icons.note_add_outlined,
                            //   color: Colors.green,
                            // ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            hintText: 'Add Cancellation Note',
                            hintStyle:
                                TextStyle(color: Colors.black, fontSize: 14)),
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xff59b89d)),
                          textStyle: Theme.of(context).textTheme.labelLarge,
                        ),
                        child: const Text(
                          'Cancel Booking',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            note = cancelNoteController.text;
                            status = "cancelled";
                            changeStatus();
                            // Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Admin()),
                            );
                            cancelNoteController.clear();
                          }
                        },
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    backgroundColor: const Color(0xff59b89d),
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('Accept Booking'),
                  onPressed: () {
                    note = "none";
                    status = "approved";
                    changeStatus();
                    // Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Admin()),
                    );
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text(
                'Back',
                style: TextStyle(
                    fontWeight: FontWeight.w900, color: Color(0xff59b89d)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            Container(
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
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      letterSpacing: 0.5),
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
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  "ADMINISTRATOR",
                  style: GoogleFonts.lato(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5),
                ),
              ),
              GlassmorphicFlexContainer(
                borderRadius: 10,
                blur: 20,
                padding: const EdgeInsets.fromLTRB(20, 25, 20, 40),
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
                child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: <Widget>[
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        'Bookings',
                        style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0),
                      ),
                    ),
                    Scrollbar(
                      child: FutureBuilder<List<_ShowBookings>>(
                        future: fetchAlbum(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              controller: _scrollController,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          width: 2, color: Colors.black),
                                      borderRadius: BorderRadius.circular(20)),
                                  onTap: () {
                                    indexID = snapshot.data![index].id!;
                                    userID = snapshot.data![index].user_id!;
                                    serviceID =
                                        snapshot.data![index].service_id!;
                                    _bookDialogue(context);
                                    // _ShowDial(context);
                                  },
                                  leading: const CircleAvatar(
                                    backgroundColor: Color(0xff423250),
                                    backgroundImage: AssetImage(
                                      'assets/images/hair.png',
                                    ),
                                  ),
                                  title: Text(
                                    "Name: ${snapshot.data![index].name}",
                                  ),
                                  subtitle: Text(
                                      "Booking Schedule: ${snapshot.data![index].booking_date}\nService: ${snapshot.data![index].service}\nPrice: ${snapshot.data![index].price}\nStatus: ${snapshot.data![index].booking_status}\nCancellation Note: ${snapshot.data![index].cancellation_note}"),
                                );
                              },
                            );
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }
                          return const CircularProgressIndicator();
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _ShowDial(BuildContext context) {
    return showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 20,
              height: MediaQuery.of(context).size.height - 300,
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const Text('Return'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
