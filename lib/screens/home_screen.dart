import 'dart:io';

import 'package:flutter/material.dart';
import 'package:login_page/screens/add_screen.dart';
import 'package:login_page/screens/details_screen.dart';
import 'package:login_page/screens/edit_screen.dart';
import 'package:login_page/screens/search_screen.dart';
import '../db/functions/functions.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  @override
  Widget build(BuildContext context) {
    getAllStudentDetailsFromDatabase();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const SearchScreen(),
                ),
              );
            },
            icon: const Icon(Icons.search, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemBuilder: (context, index) {
                  final data = studentListNotifier.value[index];
                  // ignore: unused_local_variable
                  File? image;

                  return Container(
                    color: const Color.fromARGB(255, 9, 82, 37),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: ClipOval(
                          child: Image.file(
                            File(data.imgpath),
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ),
                      title: Text(
                        data.name,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ScreenDetails(student: data),
                        ),
                      ),
                      subtitle: Text(
                        data.number,
                        style: const TextStyle(color: Colors.white),
                      ),
                      trailing: PopupMenuButton(
                        color: Colors.white,
                        onSelected: (value) {
                          if (value == 'edit') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ScreenUpdate(
                                  id: data.key,
                                  name: data.name,
                                  number: data.number,
                                  place: data.place,
                                  image: data.imgpath,
                                  email: data.email,
                                ),
                              ),
                            );
                          } else if (value == 'delete') {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Delete'),
                                  content:
                                      const Text('Are you sure want to delete'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text(
                                        'Delete',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          deleteStudentDetailsFromDatabase(
                                              data.key);
                                          Navigator.of(context).pop();
                                          getAllStudentDetailsFromDatabase();
                                        });
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return [
                            const PopupMenuItem(
                              value: 'edit',
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.edit,
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: 8),
                                  Text('Edit'),
                                ],
                              ),
                            ),
                            const PopupMenuItem<String>(
                              value: 'delete',
                              child: Row(
                                children: [
                                  Icon(Icons.delete),
                                  SizedBox(width: 8),
                                  Text('Delete'),
                                ],
                              ),
                            ),
                          ];
                        },
                      ),
                    ),
                  );
                },
                itemCount: studentListNotifier.value.length),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ScreenList(),
            ),
          );
        },
        child: const ColorFiltered(
          colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
