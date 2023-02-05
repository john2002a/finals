import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royals/views/reglogin.view.dart';

void main() {
  runApp(const Home());
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final pagecontrol = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  // Navigator.pop(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const Log()),
                  // );
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
              image: AssetImage("assets/images/homebg1.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: PageView(
            controller: pagecontrol,
            scrollDirection: Axis.vertical,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Image.asset('assets/images/royal.png'),
              ),
              // ignore: avoid_unnecessary_containers
              Container(
                child: GlassmorphicFlexContainer(
                  borderRadius: 10,
                  blur: 20,
                  padding: const EdgeInsets.fromLTRB(20, 100, 20, 50),
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
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: Text(
                          'We style you like a blue blooded royalty. \n',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.rochester(
                            color: const Color(0xffffebcc),
                            fontSize: 20,
                            wordSpacing: 0.8,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                        child: Text(
                          '''
                  Royals Salon offers world-class hairdressing, fueled by Filipino passion. It has been there for over 20 years; it was established back in 2002, offering only haircuts, but now we offer a lot of services that can guarantee your satisfaction. At Royals Salon, pampering our guests with the best services is our highest priority. We aim to provide a memorable experience that leaves you feeling beautiful and refreshed. Your decision to visit us is a choice that we deeply appreciate, and we look forward to serving your hair and beauty needs.
                  ''',
                          textAlign: TextAlign.justify,
                          style: GoogleFonts.lato(
                            color: const Color(0xffffebcc),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 40),
                        child: const Text(
                          'Swipe down for services offered',
                          style: TextStyle(fontSize: 13, color: Colors.white),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_downward_sharp,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: PageView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    GlassmorphicFlexContainer(
                      borderRadius: 10,
                      blur: 8,
                      padding: const EdgeInsets.fromLTRB(20, 100, 20, 50),
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
                          const Color(0xFFffffff).withOpacity(0.1),
                          const Color((0xFFFFFFFF)).withOpacity(0.1),
                        ],
                      ),
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Image.asset(
                                'assets/images/hair.png',
                                height: 300,
                                width: 300,
                              ),
                            ),
                            Text(
                              'HAIR SERVICES',
                              style: GoogleFonts.lato(
                                fontSize: 20,
                                color: Colors.white,
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                'Hair Cut, Color, Rebond, Treatment, Keratin Mask, Highlights',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.lato(
                                  fontSize: 12,
                                  color: Colors.white,
                                  letterSpacing: 1.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                              height: 20,
                            ),
                            FloatingActionButton.extended(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Reglog()),
                                );
                              },
                              label: const Text(
                                'BOOK NOW',
                                style: TextStyle(),
                              ),
                              backgroundColor: const Color(0xff59b89d),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
