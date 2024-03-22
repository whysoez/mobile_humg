import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyCustomForm(),
    );
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final lastname = TextEditingController();
  final khoa = TextEditingController();
  final lop = TextEditingController();
  final place = TextEditingController();
  final phone = TextEditingController();

  final LocalStorage storage = LocalStorage('storage.json');

  int _index = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    setState(() {
      // name.value = TextEditingValue(text: storage.getItem('ho'));
      // lastname.value =TextEditingValue(text: storage.getItem('ten'));
      // khoa.value = TextEditingValue(text: storage.getItem('khoa'));
      // lop.value = TextEditingValue(text: storage.getItem('lop'));
      // place.value = TextEditingValue(text: storage.getItem('quequan'));
      // khoa.value = TextEditingValue(text: storage.getItem('phone'));
    });
  }

  void getLocalStorage() {
    setState(() {
      name.value = TextEditingValue(text: storage.getItem('ho'));
      lastname.value = TextEditingValue(text: storage.getItem('ten'));
      khoa.value = TextEditingValue(text: storage.getItem('khoa'));
      lop.value = TextEditingValue(text: storage.getItem('lop'));
      place.value = TextEditingValue(text: storage.getItem('quequan'));
      khoa.value = TextEditingValue(text: storage.getItem('phone'));
    });
  }

  void setLocalStorage() {
    storage.setItem('ho', name.text);
    storage.setItem('ten', lastname.text);
    storage.setItem('khoa', khoa.text);
    storage.setItem('lop', lop.text);
    storage.setItem('quequan', place.text);
    storage.setItem('phone', phone.text);
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("create profile"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Stepper(
                    currentStep: _index,
                    onStepCancel: () {
                      if (_index > 0) {
                        setState(() {
                          _index -= 1;
                        });
                      }
                    },
                    onStepContinue: () {
                      if (_index < 2) {
                        setState(() {
                          _index += 1;
                        });
                      }
                    },
                    onStepTapped: (int index) {
                      setState(() {
                        _index = index;
                      });
                    },
                    steps: <Step>[
                      Step(
                        title: const Text('Step 1'),
                        content: Container(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 16),
                                  child: TextField(
                                    controller: name,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Nhập họ và tên đệm:',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 16),
                                  child: TextField(
                                    controller: lastname,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Nhập tên:',
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                      Step(
                          title: const Text('Step 2'),
                          content: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 16),
                                child: TextField(
                                  controller: khoa,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Nhập khoa:',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 16),
                                child: TextField(
                                  controller: lop,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Nhập lớp:',
                                  ),
                                ),
                              ),
                            ],
                          )),
                      Step(
                          title: const Text('Step 3'),
                          content: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 16),
                                child: TextField(
                                  controller: place,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Nhập quê quán:',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 16),
                                child: TextField(
                                  controller: phone,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Nhập sđt:',
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(content: Text(nameController.text)),
                          // );
                          String data =
                              '${name.text} ${lastname.text}\n${khoa.text} ${lop.text}\n${phone.text} ${place.text}';
                          setLocalStorage();
                          getLocalStorage();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShowProfile(
                                        data: data,
                                      )));
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(content: Text(nameController.text)),
                          // );
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const FetchData()));
                        }
                      },
                      child: const Text('Redirect to FetchData Page'),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ShowProfile extends StatefulWidget {
  const ShowProfile({super.key, required this.data});
  final String data;

  @override
  // ignore: no_logic_in_create_state
  State<ShowProfile> createState() => ShowProfileState(content: data);
}

class ShowProfileState extends State<ShowProfile> {
  ShowProfileState({required this.content});
  String content;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home profile"),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Text(
            content,
            selectionColor: const Color.fromARGB(255, 100, 100, 100),
            style: const TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontSize: 26),
          ),

          // ElevatedButton(
          //   onPressed: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => const MyCustomForm()));
          //   },
          //   child: const Text("Back form"),
          // )
        ],
      )),
    );
  }
}

Future<Album> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'userId': int userId,
        'id': int id,
        'title': String title,
      } =>
        Album(
          userId: userId,
          id: id,
          title: title,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}

class FetchData extends StatefulWidget {
  const FetchData({super.key});

  @override
  State<FetchData> createState() => _MyAppState();
}

class _MyAppState extends State<FetchData> {
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.title);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
