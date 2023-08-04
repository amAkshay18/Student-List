import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_page/db/functions/functions.dart';
import '../db/model/model.dart';

class ScreenList extends StatefulWidget {
  const ScreenList({super.key});

  @override
  State<ScreenList> createState() => _ScreenListState();
}

class _ScreenListState extends State<ScreenList> {
  final name = TextEditingController();
  final number = TextEditingController();
  final place = TextEditingController();
  final email = TextEditingController();
  final formKey = GlobalKey<FormState>();

  File? _image;
  Future<void> pickImage() async {
    final imagepicked =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    // ignore: unrelated_type_equality_checks
    if (_image != 'no-img') {
      setState(() {
        _image = File(imagepicked!.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add'),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => pickImage(),
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 60,
                        child: ClipOval(
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(60),
                            child: (_image != null)
                                ? Image.file(
                                    _image!,
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
                                    fit: BoxFit.cover,
                                    height: 100,
                                  ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: name,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.cyan, width: 1),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter name';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: number,
                      decoration: const InputDecoration(
                        labelText: 'Mobile Number',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.cyan, width: 1),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter your mobile number';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: place,
                      decoration: const InputDecoration(
                        labelText: 'place',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.cyan, width: 1),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter place';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: email,
                      decoration: const InputDecoration(
                        labelText: 'email',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.cyan, width: 1),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter email';
                        } else {
                          return null;
                        }
                      },
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                      ),
                      onPressed: (() {
                        if (formKey.currentState!.validate()) {
                          onClick();
                        }
                      }),
                      child: const Text('save'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onClick() async {
    final nameValue = name.text;
    final numberValue = number.text;
    final emailValue = email.text;
    final placeValue = place.text;
    if (nameValue.isEmpty ||
        numberValue.isEmpty ||
        emailValue.isEmpty ||
        placeValue.isEmpty) {
      return;
    }
    final student = StudentModel(
      imgpath: _image?.path ?? 'no-img',
      name: nameValue,
      number: numberValue,
      email: emailValue,
      place: placeValue,
    );
    addStudentDetailsToDatabase(student);
    Navigator.pop(context);
  }
}
