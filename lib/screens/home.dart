import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_assessment/data/data.dart';
import 'package:gdsc_assessment/provider/date_provider.dart';
import 'package:gdsc_assessment/screens/add_event.dart';
import 'package:gdsc_assessment/screens/event_details.dart';
import 'package:gdsc_assessment/widgets/all_event_tile.dart';
import 'package:gdsc_assessment/widgets/date_tile.dart';
import 'package:provider/provider.dart';

import '../models/date_model.dart';
import '../models/events_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<DateModel> dates = <DateModel>[];
  List<EventsModel> events = <EventsModel>[];
  String month = DateTime.now().month <= 9
      ? "0${DateTime.now().month}"
      : DateTime.now().month.toString();

  @override
  void initState() {
    super.initState();
    dates = getDates();
    events = getEvents();
  }

  @override
  Widget build(BuildContext context) {
    final dateProvider = Provider.of<DateProvider>(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(color: Color(0xff102733)),
          ),
          Container(
            padding:
                const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
                              fontWeight: FontWeight.w800),
                        ),
                        Text(
                          "EVENT",
                          style: TextStyle(
                              color: Color(0xffFCCD00),
                              fontSize: 22,
                              fontWeight: FontWeight.w800),
                        )
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const AddEvent()));
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text(
                          "Hello,",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 21),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          "Let's explore what’s happening nearby",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),

                /// Dates
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                      itemCount: dates.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return DateTile(
                          weekDay: dates[index].weekDay,
                          date: dates[index].date,
                        );
                      }),
                ),

                /// Events
                const SizedBox(
                  height: 26,
                ),
                const Text(
                  "All Events",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                const SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection(
                            "${dateProvider.todayDateIs}-$month-${DateTime.now().year}")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => EventDetails(
                                      url: snapshot.data!.docs[index]['photos'],
                                      venue: snapshot.data!.docs[index]['venue'],
                                      name: snapshot.data!.docs[index]['name'],
                                      about: snapshot.data!.docs[index]['about'],
                                      registerLink: snapshot.data!.docs[index]['register_link'],
                                      dateTime: snapshot.data!.docs[index]['time'],
                                      additionalInfo: snapshot.data!.docs[index]['additional_info'],
                                    )));
                              },
                              child: AllEventTile(
                                desc: snapshot.data!.docs[index]['name'],
                                imgeAssetPath: snapshot.data!.docs[index]
                                    ['photos'][0],
                                date: snapshot.data!.docs[index]['time']
                                    .toDate()
                                    .toString(),
                                address: snapshot.data!.docs[index]['venue'],
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
