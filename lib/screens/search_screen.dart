import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_page/db/functions/functions.dart';
import 'package:login_page/db/model/model.dart';
import 'package:login_page/screens/details_screen.dart';
import 'package:login_page/screens/edit_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<StudentModel> searchlist = studentListNotifier.value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Column(
          children: [
            CupertinoSearchTextField(
              onChanged: (value) {
                setState(() {
                  search(value);
                });
              },
            ),
            Expanded(
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    final data = searchlist[index];
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
                                    content: const Text(
                                        'Are you sure want to delete'),
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
                                          deleteStudentDetailsFromDatabase(
                                              data.key);
                                          Navigator.of(context).pop();
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
                  itemCount: searchlist.length),
            ),
          ],
        ),
      ),
    );
  }

  search(String value) {
    searchlist = studentListNotifier.value
        .where(
          (element) => element.name.toLowerCase().contains(
                value.toLowerCase(),
              ),
        )
        .toList();
  }
}
