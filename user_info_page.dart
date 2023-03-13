import 'package:flutter/material.dart';
import 'custom_widget.dart';
import '../model/user.dart';

// ignore: must_be_immutable
class UserInfoPage extends StatelessWidget {
    UserInfoPage({super.key, required this.userInfo});

User userInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("User Info"),
          centerTitle: true,
        ),
        body: Card(
          margin: const EdgeInsets.all(16),
          child: Column(children:  [
            ListTile(
              title: Text(
                // ignore: unnecessary_string_interpolations
                "${userInfo.name}",
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              // ignore: unnecessary_string_interpolations
              subtitle: Text("${userInfo.story}"),
              leading: const Icon(
                Icons.person,
                color: Colors.black,
              ),
              // ignore: unnecessary_string_interpolations
              trailing: Text("${userInfo.country}"),
            ),
            CustomText(userInfo.phone, icon: const Icon(Icons.phone, color: Colors.black)),
            CustomText(userInfo.email, icon: const Icon(Icons.email, color: Colors.black)),
          ]),
        ));
  }
}
