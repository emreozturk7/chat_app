import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_app/modules/update_status/update_status_controller.dart';

class UpdateStatusView extends StatelessWidget {
  const UpdateStatusView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    final UpdateStatusController _controller =
        Get.put(UpdateStatusController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Update Status',
          style: TextStyle(color: Colors.blue),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _controller.statusCtrl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  labelText: 'Input Status Here',
                ),
              ),
              SizedBox(height: deviceSize.height / 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: deviceSize / 15,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: Text('UPDATE'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
