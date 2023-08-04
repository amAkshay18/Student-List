import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_page/db/functions/functions.dart';
import '../db/model/model.dart';

// ignore: must_be_immutable
class ScreenUpdate extends StatefulWidget {
  final int id;
  int num = 0;
  String name;
  String number;
  String place;
  String image;
  String email;
  ScreenUpdate(
      {super.key,
      required this.id,
      required this.name,
      required this.number,
      required this.image,
      required this.place,
      required this.email});

  @override
  State<ScreenUpdate> createState() => _ScreenUpdateState();
}

class _ScreenUpdateState extends State<ScreenUpdate> {
  final formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController place = TextEditingController();
  TextEditingController email = TextEditingController();

  String? _image;
  Future<void> pickImage() async {
    final imagepicked =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagepicked != null) {
      setState(() {
        _image = imagepicked.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    name.text = widget.name;
    number.text = widget.number;
    place.text = widget.place;
    final image = widget.image;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Edit'),
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
                        backgroundImage: _image == null
                            ? FileImage(File(image))
                            : FileImage(File(_image ?? image)),
                        radius: 60,
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
                          borderSide: BorderSide(color: Colors.teal, width: 1),
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
                          borderSide: BorderSide(color: Colors.teal, width: 1),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
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
                        labelText: 'Place',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal, width: 1),
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
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      onPressed: (() {
                        StudentModel student = StudentModel(
                            imgpath: _image ?? image,
                            number: number.text,
                            name: name.text,
                            place: place.text,
                            email: email.text);
                        updateStudentDetailsInDatabase(student, widget.id);
                        if (formKey.currentState!.validate()) {
                          Navigator.pop(context);
                        }
                      }),
                      child: const Text('Update'),
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
}
