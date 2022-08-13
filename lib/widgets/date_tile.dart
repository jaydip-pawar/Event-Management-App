import 'package:flutter/material.dart';
import 'package:gdsc_assessment/provider/date_provider.dart';
import 'package:provider/provider.dart';

class DateTile extends StatefulWidget {
  final String? weekDay;
  final String date;

  const DateTile(
      {Key? key,
        required this.weekDay,
        required this.date})
      : super(key: key);

  @override
  State<DateTile> createState() => _DateTileState();
}

class _DateTileState extends State<DateTile> {
  @override
  Widget build(BuildContext context) {
    final dateProvider = Provider.of<DateProvider>(context);
    bool isSelected = dateProvider.todayDateIs == widget.date;
    return GestureDetector(
      onTap: () {
        setState(() {
          dateProvider.changeSelectedDate(widget.date.toString());
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: isSelected ? const Color(0xffFCCD00) : Colors.transparent,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              widget.date,
              style: TextStyle(
                  color: isSelected ? Colors.black : Colors.white,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.weekDay!,
              style: TextStyle(
                  color: isSelected ? Colors.black : Colors.white,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}