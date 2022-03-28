import 'package:flutter/material.dart';
import 'package:flutter_chat_app/routes/app_pages.dart';
import 'package:get/get.dart';

class DateView extends StatelessWidget {
  const DateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.CONTACTS_VIEW),
        child: Icon(
          Icons.search,
          size: 30,
          color: Colors.white,
        ),
        backgroundColor: Colors.red[900],
      ),
      body: Center(
        child: Column(
          children: [
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
      ),
    );
  }
}
