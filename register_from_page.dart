import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Pages/user_info_page.dart';
import 'custom_widget.dart';
import '../model/user.dart';

class RegisterFromPage extends StatefulWidget {
  const RegisterFromPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterFromPageState createState() => _RegisterFromPageState();
}

class _RegisterFromPageState extends State<RegisterFromPage> {
  bool _hidepass = true;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _storyController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  final List<String> _countries = ["Russia", "Germany", "England", "France"];
  String? _selectedCountries;

  final _nameFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _passFocus = FocusNode();

  User newUser = User();

  @override //очищаем переменные
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _storyController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    _nameFocus.dispose();
    _phoneFocus.dispose();
    _passFocus.dispose();
    super.dispose();
  }

  //вспомогательный метод, который меняет один фокус на другой
  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("Register Form"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              focusNode: _nameFocus,
              autofocus: true,
              onFieldSubmitted: (_) {
                _fieldFocusChange(context, _nameFocus, _phoneFocus);
              },
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Full name *",
                hintText: "What do people call you?",
                prefixIcon: const Icon(Icons.person),
                suffixIcon: GestureDetector(
                  onTap: () {
                  _nameController.clear();
                },
                child: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
              ),
              validator: _validateName,
              onSaved: (value) {
                newUser.name = value!;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              focusNode: _phoneFocus,
              onFieldSubmitted: (_) {
                _fieldFocusChange(context, _phoneFocus, _passFocus);
              },
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: "Phone number *",
                hintText: "Enter phone number",
                helperText: "Phone format: + 7 (XXX)XXX-XXXX",
                prefixIcon: const Icon(Icons.phone),
                suffixIcon: GestureDetector(
                  onLongPress: () {
                  _phoneController.clear();
                },
                child: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
              ),
              keyboardType: TextInputType.phone,
              inputFormatters: [
                //FilteringTextInputFormatter.digitsOnly
                FilteringTextInputFormatter(RegExp(r'[()\d -]{1,15}$'),
                    allow: true),
              ],
              // validator: (value) => _validatePhoneNumber(value!)
              //     ? null
              //     : "Phone number must be entered as (###)###-####",
              onSaved: (value) {
                newUser.phone = value!;
              },    
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                hintText: "Enter a email adress",
                icon: Icon(Icons.mail),
              ),
              keyboardType: TextInputType.emailAddress,
             // validator: _validateEmail,
              onSaved: (value) {
                newUser.email = value!;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            DropdownButtonFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(Icons.map),
                labelText: "Country?",
              ),
              items: _countries.map((country) {
                return DropdownMenuItem(
                  value: country,
                  child: Text(country),
                );
              }).toList(),
              onChanged: (country) {
                // ignore: avoid_print
                print(country);
                setState(() {
                  _selectedCountries = country!;
                  newUser.country = country;
                });
              },
              value: _selectedCountries,
              // validator: (val) {
              //   return val == null ? "Please select a country" : null;
              // },
              
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _storyController,
              decoration: const InputDecoration(
                labelText: "Life Story",
                hintText: "Tell us about yoursefl",
                helperText: "keep it short, this is just a demo",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              inputFormatters: [
                LengthLimitingTextInputFormatter(100),
              ],
              onSaved: (value) {
                newUser.story = value!;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              focusNode: _passFocus,
              controller: _passController,
              obscureText: _hidepass,
              maxLength: 8,
              decoration: InputDecoration(
                labelText: "Password *",
                hintText: "Enter the password",
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _hidepass = !_hidepass;
                      });
                    },
                    icon: Icon(
                        _hidepass ? Icons.visibility : Icons.visibility_off)),
                icon: const Icon(Icons.security),
              ),
              validator: _validatePassword,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _confirmPassController,
              obscureText: _hidepass,
              maxLength: 8,
              decoration: const InputDecoration(
                labelText: "Confirm Password *",
                hintText: "Confirm the password",
                icon: Icon(Icons.border_color),
              ),
              validator: _validatePassword,
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.green),
              ),
              onPressed: _submitForm,
              child: const Text(
                "Submit Form",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      _showDialog(name: _nameController.text);
      // ignore: avoid_print
      print("Form is valid");
      // ignore: avoid_print
      print("Name : ${_nameController.text}");
      // ignore: avoid_print
      print("Phone : ${_phoneController.text}");
      // ignore: avoid_print
      print("Email : ${_emailController.text}");
      // ignore: avoid_print
      print("Country : $_selectedCountries");
      // ignore: avoid_print
      print("Story: ${_storyController.text}");
      // ignore: avoid_print
      print("Password : ${_passController.text}");
      // ignore: avoid_print
      print("Confirm Password : ${_confirmPassController.text}");
    } else {
      _showMessage(message: "Form is not valid! Please review and correct!");
    }
  }

  String? _validateName(String? value) {
    // ignore: no_leading_underscores_for_local_identifier, no_leading_underscores_for_local_identifiers
    final _nameExp = RegExp(r'^[A-Za-z ]+$');
    if (value!.isEmpty) {
      return "Name is reqired.";
    } else if (!_nameExp.hasMatch(value)) {
      return "Please enter alphabetical characters.";
    }
    return null;
  }

  // ignore: unused_element
  bool _validatePhoneNumber(String input) {
    final phoneExp = RegExp(r'^\(\d\d\d\)\d\d\d\-\d\d\d\d$');
    return phoneExp.hasMatch(input);
  }

  // ignore: unused_element
  String? _validateEmail(String? value) {
    if (value == null) {
      return "Email cannot be empty";
    } else if (!_emailController.text.contains("@")) {
      return "Invalid email addres";
    } else {
      return null;
    }
  }

  String? _validatePassword(String? value) {
    if (_passController.text.length != 8) {
      return "8 character required  for password";
    } else if (_confirmPassController.text != _passController.text) {
      return "Password does not match";
    } else {
      return null;
    }
  }

  void _showMessage({String? message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        backgroundColor: Colors.red,
        content: Text(
          message!,
          style: const TextStyle(
              color: Colors.blue, fontWeight: FontWeight.w600, fontSize: 18.0),
        ),
      ),
    );
  }

  void _showDialog({String? name}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              "Reristration successful",
              style: TextStyle(color: Colors.green),
            ),
            content: Text(
              "$name is now a verified register form",
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // ignore: prefer_const_constructors
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UserInfoPage(userInfo: newUser,)));
                },
                
                child: const Text(
                  "Verified",
                  style: TextStyle(color: Colors.green),
                ),
              )
            ],
          );
        });
  }
}
