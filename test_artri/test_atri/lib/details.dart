import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:test_atri/main.dart';
import 'package:test_atri/main4.dart';
import 'package:test_atri/shared/listitem.dart';

class DetailsScreen extends StatelessWidget {
  final String tag;
  final NewsItem item;
  final LocalStorage storage;

  DetailsScreen({required this.item, required this.tag, required this.storage}) : super();

// LocalStorage storage = LocalStorage("newsapp");
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                        tag: '${item.newsTitle}',
                        child: Image.network(item.imgUrl)),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          Text(
                            item.newsTitle,
                            style: TextStyle(
                                fontSize: 23, fontWeight: FontWeight.normal),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              Icon(Icons.person),
                              Text(
                                item.author,
                                style: TextStyle(fontSize: 12.0),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Icon(Icons.date_range),
                              Text(
                                item.date,
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            item.content,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyCustomForm(newsItem: item, typeInput: 1, storage: storage,)));
                        },
                        child: Text("Edit News"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: ElevatedButton(
                        onPressed: () {
                          var keyUpdate = storage.getItem('key').toString().replaceAll('${item.type}${item.newsTitle}${item.date}', "").replaceAll(';;', ";");
                          if(keyUpdate == ';'){
                            keyUpdate = "";
                          }
                          storage.setItem("key", keyUpdate);
                          storage.deleteItem('${item.type}${item.newsTitle}${item.date}');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyApp()));
                        },
                        child: Text("Delete News"),
                      ),
                    )
                  ]),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
