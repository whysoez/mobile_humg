import 'package:flutter/material.dart';
import 'package:test_atri/shared/listitem.dart';

class DetailsScreen extends StatelessWidget {
  final String tag;
  final NewsItem item;

  DetailsScreen({required this.item, required this.tag})
      : super();

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
                    Image.network(item.imgUrl),
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
                                item.author,
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            item.newsTitle,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.normal
                            ),
                          )
                        ],
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
