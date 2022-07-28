import 'package:flutter/material.dart';
import 'package:flutter_chat_app/controller/auth_controller.dart';
import 'package:flutter_chat_app/core/context_extensions.dart';
import 'package:flutter_chat_app/modules/contacts/contacts_controller.dart';
import 'package:flutter_chat_app/modules/contacts/contacts_view.dart';
import 'package:flutter_chat_app/modules/date/date_controller.dart';
import 'package:flutter_chat_app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';

class DateView extends StatefulWidget {
  const DateView({Key? key}) : super(key: key);

  @override
  State<DateView> createState() => _DateViewState();
}

class _DateViewState extends State<DateView> {
  final ContactsController _controller = Get.put(ContactsController());
  final DateController _dateViewController = Get.put(DateController());
  final authCtrl = Get.find<AuthController>();

  double? _height;
  double? _width;

  String? _setTime, _setDate;

  String? _hour, _minute, _time;

  String? dateTime;

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(
        () {
          selectedDate = picked;
          _dateController.text = DateFormat.yMd().format(selectedDate);
        },
      );
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      setState(
        () {
          selectedTime = picked;
          _hour = selectedTime.hour.toString();
          _minute = selectedTime.minute.toString();
          _time = _hour! + ' : ' + _minute!;
          _timeController.text = _time!;
          _timeController.text = formatDate(
              DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
              [hh, ':', nn, " ", am]).toString();
        },
      );
    }
  }

  Future<void> _selectFriend(BuildContext context) async {}

  @override
  void initState() {
    _dateController.text = DateFormat.yMd().format(DateTime.now());

    _timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    dateTime = DateFormat.yMd().format(DateTime.now());

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.START_CONVERSATION),
        child: Icon(
          Icons.search,
          size: 30,
          color: Colors.white,
        ),
        backgroundColor: Colors.red[900],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Material(
                  elevation: 5,
                  child: Container(
                    margin: EdgeInsets.only(top: context.mediaQueryPadding.top),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black38,
                        ),
                      ),
                    ),
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(Icons.arrow_back_ios),
                          ),
                        ),
                        Spacer(flex: 2),
                        Expanded(
                          flex: 17,
                          child: Text(
                            'Buluşma Ayarla',
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: context.dynamicHeight(0.025)),
            Column(
              children: [
                Text(
                  'Buluşma tarihini seç',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: context.dynamicHeight(0.01)),
                InkWell(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: Container(
                    width: context.dynamicWidth(0.75),
                    height: context.dynamicHeight(0.1),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    child: TextFormField(
                      style: TextStyle(fontSize: 40),
                      textAlign: TextAlign.center,
                      enabled: false,
                      keyboardType: TextInputType.text,
                      controller: _dateController,
                      onSaved: (val) {
                        _setDate = val;
                      },
                      decoration: InputDecoration(
                        disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: context.dynamicHeight(0.025)),
            Column(
              children: [
                Text(
                  'Buluşma saatini seç',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: context.dynamicHeight(0.01)),
                InkWell(
                  onTap: () {
                    _selectTime(context);
                  },
                  child: Container(
                    width: context.dynamicWidth(0.75),
                    height: context.dynamicHeight(0.1),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    child: TextFormField(
                      style: TextStyle(fontSize: 40),
                      textAlign: TextAlign.center,
                      onSaved: (val) {
                        _setTime = val;
                      },
                      enabled: false,
                      keyboardType: TextInputType.text,
                      controller: _timeController,
                      decoration: InputDecoration(
                        disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: context.dynamicHeight(0.025)),
            Column(
              children: [
                Text(
                  'Buluşmak istediğin kişiyi seç',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: context.dynamicHeight(0.01)),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => ContactsView(),
                    );
                  },
                  child: Container(
                    width: context.dynamicWidth(0.75),
                    height: context.dynamicHeight(0.1),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    child: TextFormField(
                      style: TextStyle(fontSize: 40),
                      textAlign: TextAlign.center,
                      enabled: false,
                      controller: _controller.receiverName.value,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: context.dynamicHeight(0.025)),
            InkWell(
              child: Container(
                width: context.dynamicWidth(0.75),
                height: context.dynamicHeight(0.075),
                padding: context.paddingLow,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(context.mediumValue),
                ),
                child: Row(
                  children: const [
                    Spacer(),
                    Expanded(
                      flex: 1,
                      child: Icon(Icons.send),
                    ),
                    Spacer(),
                    Expanded(
                      flex: 12,
                      child: Text(
                        'Buluşma isteği gönder',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () async {
                _dateViewController.addNewMeet(
                  senderEmail: authCtrl.user.value.email.toString(),
                  receiverEmail: _controller.receiverEmail.value,
                  date: _dateController.value.text.toString(),
                  hour: _timeController.value.text.toString(),
                  senderName: authCtrl.user.value.name.toString(),
                  receiverName: _controller.receiverName.value.text,
                  receiverPhotoUrl: _controller.receiverPhotoUrl.value,
                  senderPhotoUrl: authCtrl.user.value.photoUrl.toString(),
                  status: 'Waiting',
                );
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
