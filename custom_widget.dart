import 'package:flutter/material.dart';


class CustomText extends StatelessWidget {
  final String text;
  final Icon? icon;
  CustomText(this.text, {super.key, required this.icon,});
  @override
  Widget build(BuildContext context) {
    return ListTile(
              title: Text(
                "${text}",
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              leading: text.isEmpty? null : icon,
    );
  }

}

class CustomName extends StatelessWidget {
  final String name;
  final Icon? icon;
  final String country;
  final String story;
  
  CustomName(this.name, this.country, this.story, {super.key, required this.icon,});
  @override
  Widget build(BuildContext context) {
    return ListTile(
              title: Text(
                // ignore: unnecessary_string_interpolations
                "${name}",
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              // ignore: unnecessary_string_interpolations
              subtitle: Text("${story}"),
              leading: name.isEmpty? null : icon,
              // ignore: unnecessary_string_interpolations
              trailing: Text("${country.isEmpty? " " : country}"),
            );
  }
}