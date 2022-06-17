import 'package:flutter/material.dart';
import 'package:flutter_chat_app/controller/auth_controller.dart';
import 'package:flutter_chat_app/core/context_extensions.dart';
import 'package:flutter_chat_app/modules/contacts/contacts_controller.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ContactsView extends StatelessWidget {
  final ContactsController _controller = Get.put(ContactsController());
  final authCtrl = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Obx(
      () => _controller.tempSearch.isEmpty
          ? Container(
              width: context.dynamicWidth(0.6),
              height: context.dynamicHeight(0.6),
              padding: context.paddingLow,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 10.0),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: TextField(
                      onChanged: (value) => _controller.searchContacts(
                        value,
                        authCtrl.user.value.email!,
                      ),
                      controller: _controller.searchCtrl,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                        hintText: 'Search',
                        contentPadding: context.paddingNormal,
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Lottie.asset("assets/lottie/empty.json"),
                    ),
                  ),
                ],
              ),
            )
          : Container(
              width: context.dynamicWidth(0.6),
              height: context.dynamicHeight(0.6),
              padding: context.paddingLow,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 10.0),
                  ),
                ],
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: _controller.tempSearch.length,
                itemBuilder: (context, index) => ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.black26,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child:
                          _controller.tempSearch[index]['photoUrl'] == 'noimage'
                              ? Image.asset(
                                  'assets/images/noimage.png',
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  _controller.tempSearch[index]['photoUrl'],
                                  fit: BoxFit.cover,
                                ),
                    ),
                  ),
                  title: Text(
                    '${_controller.tempSearch[index]['name']}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    '${_controller.tempSearch[index]['email']}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      print('${_controller.tempSearch[index]['email']}');
                      _controller.receiverEmail.value =
                          _controller.tempSearch[index]['email'];
                      _controller.receiverName.value.text =
                          _controller.tempSearch[index]['name'];
                      _controller.tempSearch.clear();
                      _controller.searchCtrl.clear();

                      Navigator.of(context, rootNavigator: true).pop(index);
                    },
                    child: Chip(
                      label: Text('Ekle'),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
