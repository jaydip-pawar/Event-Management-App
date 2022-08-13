import 'package:flutter/material.dart';
import 'package:gdsc_assessment/provider/event_provider.dart';
import 'package:gdsc_assessment/widgets/custom_textfield.dart';
import 'package:gdsc_assessment/widgets/image_picker_widget.dart';
import 'package:provider/provider.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({Key? key}) : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final TextEditingController _venueController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _registerLinkController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _additionalInfoController = TextEditingController();

  late int year;
  late int month;
  late int day;
  late int hour;
  late int min;

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2040),
    ).then((selectedDate) {
      if (selectedDate != null) {
        setState(() {
          _dateController.text =
              "${selectedDate.day}-${selectedDate.month <= 9 ? "0${selectedDate.month}" : selectedDate.month}-${selectedDate.year}";
          day = selectedDate.day;
          month = selectedDate.month;
          year = selectedDate.year;
        });
      }
    });
  }

  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((selectedTime) {
      if (selectedTime != null) {
        final formattedTime =
            MaterialLocalizations.of(context).formatTimeOfDay(selectedTime);
        _timeController.text = formattedTime;
        min = selectedTime.minute;
        hour = selectedTime.hour;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(color: Color(0xff102733)),
          ),
          Container(
            padding:
                const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 13),
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
                        eventProvider.addEvent(
                          context,
                          _venueController.text,
                          _nameController.text,
                          _aboutController.text,
                          _registerLinkController.text,
                          _dateController.text,
                          DateTime.parse(
                              "$year-${month <= 9 ? "0$month" : month}-$day ${hour <= 9 ? "0$hour" : hour}:${min <= 9 ? "0$min" : min}"),
                          _additionalInfoController.text,
                        );
                        eventProvider.clearUrl();
                      },
                      icon: const Icon(
                        Icons.done_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomTextField(
                          hintText: "Venue",
                          keyboardType: TextInputType.streetAddress,
                          textCapitalization: TextCapitalization.sentences,
                          maxLines: 2,
                          controller: _venueController,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomTextField(
                          hintText: "Name",
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.words,
                          maxLines: 1,
                          controller: _nameController,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomTextField(
                          hintText: "About",
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.sentences,
                          maxLines: 5,
                          controller: _aboutController,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomTextField(
                          hintText: "Register link",
                          keyboardType: TextInputType.url,
                          textCapitalization: TextCapitalization.none,
                          maxLines: 1,
                          controller: _registerLinkController,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: _showDatePicker,
                          child: TextField(
                            controller: _dateController,
                            decoration: InputDecoration(
                              suffixIcon: const Icon(
                                  Icons.calendar_month_outlined,
                                  color: Colors.white70),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none),
                              filled: true,
                              fillColor: const Color(0xff29404E),
                              hintText: "Event Date",
                              hintStyle: const TextStyle(color: Colors.white54),
                            ),
                            style: const TextStyle(color: Colors.white70),
                            enabled: false,
                            mouseCursor: SystemMouseCursors.click,
                          ),
                        ), // Date
                        const SizedBox(height: 15),
                        GestureDetector(
                          onTap: () => _showTimePicker(),
                          child: TextField(
                            controller: _timeController,
                            decoration: InputDecoration(
                              suffixIcon: const Icon(Icons.access_time,
                                  color: Colors.white70),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none),
                              filled: true,
                              fillColor: const Color(0xff29404E),
                              hintText: "Event Time",
                              hintStyle: const TextStyle(color: Colors.white54),
                            ),
                            style: const TextStyle(color: Colors.white70),
                            enabled: false,
                            mouseCursor: SystemMouseCursors.click,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomTextField(
                          hintText: "Additional Information",
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.sentences,
                          maxLines: 5,
                          controller: _additionalInfoController,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        if (eventProvider.eventImages.isNotEmpty)
                          Container(
                            // width: MediaQuery.of(context).size.width * 0.8,
                            height: 130,
                            decoration: BoxDecoration(
                              color: const Color(0xff29404E),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: eventProvider.eventImages.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      Image.network(eventProvider.eventImages[index]),
                                      const SizedBox(width: 10)
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: MaterialButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const ImagePickerWidget();
                                  });
                            },
                            height: 45,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            color: const Color(0xffFCCD00),
                            child: const Text(
                              "Upload image",
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
