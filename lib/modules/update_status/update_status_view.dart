import 'package:flutter/material.dart';
import 'package:flutter_chat_app/controller/auth_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_app/modules/update_status/update_status_controller.dart';

class UpdateStatusView extends StatelessWidget {
  final UpdateStatusController _controller = Get.put(UpdateStatusController());

  final authCtrl = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    _controller.statusCtrl.text = authCtrl.user.value.status!;
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
          onPressed: () => Get.back(),
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
                textInputAction: TextInputAction.done,
                onEditingComplete: () {
                  authCtrl.updateStatus(_controller.statusCtrl.text);
                },
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
                onPressed: () {
                  authCtrl.updateStatus(_controller.statusCtrl.text);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
