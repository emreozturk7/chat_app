import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemChat extends StatelessWidget {
  const ItemChat({
    Key? key,
    required this.isSender,
    required this.message,
    required this.time,
  }) : super(key: key);

  final bool isSender;
  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.red[900],
              borderRadius: isSender
                  ? BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    )
                  : BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
            ),
            padding: EdgeInsets.all(15),
            child: Text(
              message,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(DateFormat.jm().format(DateTime.parse(time))),
        ],
      ),
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
    );
  }
}
