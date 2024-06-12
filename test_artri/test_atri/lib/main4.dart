import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:test_atri/details.dart';
import 'package:test_atri/fetchPlaceholder.dart';
import 'package:test_atri/shared/listitem.dart';

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  final NewsItem newsItem;
  final int typeInput;
  final LocalStorage storage;
  const MyCustomForm(
      {required this.newsItem, required this.typeInput, required this.storage})
      : super();

  @override
  MyCustomFormState createState() {
    return MyCustomFormState(newsItem, typeInput, storage);
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
  NewsItem item = NewsItem("", "", "", "", "", "");
  int typeEdit = 0;
  LocalStorage storage = LocalStorage("newsapp");
  final _formKey = GlobalKey<FormState>();
  final type = TextEditingController();
  final title = TextEditingController();
  final content = TextEditingController();
  final author = TextEditingController();
  final image = TextEditingController();

  MyCustomFormState(NewsItem newsItem, int typeInput, LocalStorage lstorage) {
    this.item = newsItem;
    this.typeEdit = typeInput;
    this.storage = lstorage;
  }

  int _index = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void addItemsToLocalStorage(NewsItem item) {
    String keys = '';
    var test = storage.getItem('key');
    if (storage.getItem('key') != null && storage.getItem('key') != "") {
      keys = '${storage.getItem('key')};';
    }
    storage.deleteItem('key');
    keys = '${keys}${item.type}${item.newsTitle}${item.date}';
    storage.setItem('key', keys);
    String itemNews = jsonEncode(item.ToJson());
    storage.setItem('${item.type}${item.newsTitle}${item.date}', '${itemNews}');
  }

  String getType() {
    if (typeEdit == 0) {
      return "Create News";
    } else {
      return "Edit News";
    }
  }

  void _loadData() async {
    setState(() {
      type.value = TextEditingValue(text: item.type);
      title.value = TextEditingValue(text: item.newsTitle);
      content.value = TextEditingValue(text: item.content);
      author.value = TextEditingValue(text: item.author);
      image.value = TextEditingValue(text: item.imgUrl);
    });
  }

  void getLocalStorage() {
    setState(() {
      // name.value = TextEditingValue(text: storage.getItem('ho'));
      // lastname.value = TextEditingValue(text: storage.getItem('ten'));
      // khoa.value = TextEditingValue(text: storage.getItem('khoa'));
      // lop.value = TextEditingValue(text: storage.getItem('lop'));
      // place.value = TextEditingValue(text: storage.getItem('quequan'));
      // khoa.value = TextEditingValue(text: storage.getItem('phone'));
    });
  }

  void setLocalStorage() {
    // storage.setItem('ho', name.text);
    // storage.setItem('ten', lastname.text);
    // storage.setItem('khoa', khoa.text);
    // storage.setItem('lop', lop.text);
    // storage.setItem('quequan', place.text);
    // storage.setItem('phone', phone.text);
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Create News"),
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
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Thể loại bài viết",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      TextField(
                                        controller: type,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Nhập thể loại bài viết:',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 16),
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Tiêu đề bài viết",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      TextField(
                                        controller: title,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Nhập tiêu đề bài viết:',
                                        ),
                                      ),
                                    ],
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
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Nội dung bài viết",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    TextField(
                                      controller: content,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'Nhập nội dung bài viết:',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 16),
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Tên tác giả muốn hiển thị",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    TextField(
                                      controller: author,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText:
                                            'Nhập tên tác giả muốn hiển thị:',
                                      ),
                                    ),
                                  ],
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
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Hình ảnh",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    TextField(
                                      controller: image,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'Hình ảnh',
                                      ),
                                    ),
                                  ],
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
                          if (typeEdit == 1) {
                            var keyUpdate = storage.getItem('key').toString().replaceAll('${item.type}${item.newsTitle}${item.date}', "").replaceAll(';;', ";");
                          if(keyUpdate == ';'){
                            keyUpdate = "";
                          }
                          storage.setItem("key", keyUpdate);
                            storage.deleteItem(
                                '${item.type}${item.newsTitle}${item.date}');
                          }

                          DateTime now = new DateTime.now();
                          DateTime date =
                              new DateTime(now.year, now.month, now.day);
                          var outputFormat = DateFormat('MM/dd/yyyy');
                          var outputDate = outputFormat.format(date);
                          NewsItem itemAdd = NewsItem(image.text, title.text,
                              author.text, outputDate, type.text, content.text);
                          addItemsToLocalStorage(itemAdd);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailsScreen(
                                        item: itemAdd,
                                        tag: itemAdd.newsTitle,
                                        storage: storage,
                                      )));
                        }
                      },
                      child: Text(getType()),
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

// Future<Album> fetchAlbum() async {
//   final response = await http
//       .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }
// }

// class Album {
//   final int userId;
//   final int id;
//   final String title;

//   const Album({
//     required this.userId,
//     required this.id,
//     required this.title,
//   });

//   factory Album.fromJson(Map<String, dynamic> json) {
//     return switch (json) {
//       {
//         'userId': int userId,
//         'id': int id,
//         'title': String title,
//       } =>
//         Album(
//           userId: userId,
//           id: id,
//           title: title,
//         ),
//       _ => throw const FormatException('Failed to load album.'),
//     };
//   }
// }

// class FetchData extends StatefulWidget {
//   const FetchData({super.key});

//   @override
//   State<FetchData> createState() => _MyAppState();
// }

// class _MyAppState extends State<FetchData> {
//   late Future<Album> futureAlbum;

//   @override
//   void initState() {
//     super.initState();
//     futureAlbum = fetchAlbum();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Fetch Data Example',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Fetch Data Example'),
//         ),
//         body: Center(
//           child: FutureBuilder<Album>(
//             future: futureAlbum,
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return Text(snapshot.data!.title);
//               } else if (snapshot.hasError) {
//                 return Text('${snapshot.error}');
//               }

//               // By default, show a loading spinner.
//               return const CircularProgressIndicator();
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
