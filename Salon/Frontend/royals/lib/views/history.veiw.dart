// ignore_for_file: non_constant_identifier_names, unused_element

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:royals/views/home.view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royals/helpers/api.helper.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:royals/controllers/token.controller.dart';
import 'dart:async';

void main() {
  runApp(const History());
}

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _ShowBookings {
  String? name;
  String? phone_number;
  String? service;
  String? price;
  String? booking_date;
  String? booking_status;
  String? cancellation_note;

  _ShowBookings(
      {this.name,
      this.phone_number,
      this.service,
      this.price,
      this.booking_date,
      this.booking_status,
      this.cancellation_note});

  _ShowBookings.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone_number = json['phone_number'].toString();
    service = json['service'];
    price = json['price'].toString();
    booking_date = json['booking_date'].toString();
    booking_status = json['booking_status'];
    cancellation_note = json['cancellation_note'];
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
    return data;
  }
}

class _HistoryState extends State<History> {
  TextEditingController dateInput = TextEditingController();
  String? listServices;
  List listItem = ["Cut", "Color", "Perm"];
  final tokenHandler = Get.put(tokenHolder());
  tokenHolder idFind = Get.find<tokenHolder>();
  final ScrollController _scrollController = ScrollController();

  showHistory() async {
    String dispHistory = ShowHistory;

    var response = await http.post(Uri.parse(dispHistory), body: {
      // 'showID': '${idFind.userId}'
      'showID': '5',
    });

    var idd = idFind.userId;
    log(response.body);
    log('$idd');
  }

  Future<List<_ShowBookings>> fetchAlbum() async {
    String showUserHistory = ShowHistory;
    final response = await http.post(Uri.parse(showUserHistory), body: {
      'showID': '${idFind.userId}',
      // 'showID': '4',
    });

    if (response.statusCode == 200) {
      final List result = json.decode(response.body);
      return result.map((e) => _ShowBookings.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
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
                              // onTap: () => _bookDialogue(context),
                              leading: const CircleAvatar(
                                backgroundColor: Color(0xff423250),
                                backgroundImage: AssetImage(
                                  'assets/images/hair.png',
                                ),
                              ),
                              title:
                                  Text("Name: ${snapshot.data![index].name}"),
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
        ),
      ),
    );
  }
}
