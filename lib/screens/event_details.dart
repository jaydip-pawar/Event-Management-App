import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetails extends StatelessWidget {
  final String venue, name, about, registerLink, additionalInfo;
  final Timestamp dateTime;
  final List<dynamic> url;

  const EventDetails(
      {Key? key,
      required this.venue,
      required this.name,
      required this.about,
      required this.registerLink,
      required this.dateTime,
      required this.additionalInfo,
      required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(color: Color(0xff102733)),
          ),
          Container(
            padding:
                const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: <Widget>[
                    Image.asset(
                      "assets/logo.png",
                      height: 28,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Row(
                      children: const <Widget>[
                        Text(
                          "GDSC",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          "EVENT",
                          style: TextStyle(
                            color: Color(0xffFCCD00),
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  height: MediaQuery.of(context).size.height * 0.83,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                            height: 200.0,
                            enableInfiniteScroll: false,
                          ),
                          items: url.map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration:
                                      BoxDecoration(color: Color(0xff102733)),
                                  child: Image.network(
                                    i,
                                    fit: BoxFit.fill,
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.watch_later_outlined,
                                size: 18,
                                color: Colors.white60,
                              ),
                              Text(
                                dateTime.toDate().toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white60,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 18,
                                color: Colors.white60,
                              ),
                              Text(
                                venue,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white60,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "about",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.89,
                          height: 150,
                          padding: const EdgeInsets.all(10),
                          color: const Color(0xff29404E),
                          child: Text(
                            about,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              color: Colors.white60,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Additional Information",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.89,
                          height: 150,
                          padding: const EdgeInsets.all(10),
                          color: const Color(0xff29404E),
                          child: Text(
                            additionalInfo,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              color: Colors.white60,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          width: double.infinity,
                          child: MaterialButton(
                            onPressed: () async {
                              if (await canLaunchUrl(Uri.parse(registerLink))) {
                                await launchUrl(Uri.parse(registerLink));
                              } else {
                                throw "Could not launch $registerLink";
                              }
                            },
                            height: 45,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            color: const Color(0xffFCCD00),
                            child: const Text(
                              "Register to the event",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
