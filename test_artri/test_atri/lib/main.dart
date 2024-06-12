
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:test_atri/details.dart';
import 'package:test_atri/fetchNews.dart';
import 'package:test_atri/listwidget.dart';
import 'package:test_atri/main2.dart';
import 'package:test_atri/main3.dart';
import 'package:test_atri/main4.dart';
import 'package:test_atri/shared/listitem.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
with SingleTickerProviderStateMixin {

LocalStorage storage = LocalStorage("newsapp");
int countInstance = 0;

void showItemsStorage(String key){
  NewsItem item = NewsItem.fromJson(jsonDecode(key) as Map<String, dynamic>);
  print('${item.newsTitle}; ${item.author}; ${item.date}');
}

void editItemsStorage(NewsItem itemOld, NewsItem itemNew){
  storage.deleteItem('${itemOld.type}${itemOld.newsTitle}${itemNew.date}');
  storage.setItem('${itemNew.type}${itemNew.newsTitle}${itemNew.date}', '${json.encode(itemNew.ToJson())}');
}

NewsItem getItems(int index) {
  var index1 = storage.getItem('key').toString().split(';');
  var test2 = storage.getItem('key').toString().split(';')[index];
  var test = storage.getItem(storage.getItem('key').toString().split(';')[index]);
  var atest = jsonDecode(test);
  NewsItem result = NewsItem("imgUrl", "newsTitle", "author", "date", "type", "content");
  if(test != null){
  result = NewsItem.fromJson(jsonDecode(test) as Map<String, dynamic>);
  }
  return result;
}

List<NewsItem> initNews(){
  List<NewsItem> result = [];
  var atest = storage.getItem('key');
  if(atest != null && atest != ""){
  int lengthNews = storage.getItem('key').toString().split(';').length;
  for(int i = 0; i< lengthNews; i++){
    result.add(getItems(i));
  }
  }
  return result;
}

// List<NewsItem> checkUpdateNews(){
//   var items = initNews();
//   if(items.length != countInstance){
//     listItems = items;
//     countInstance = items.length;
//   }
//   return items;
// }

List<NewsItem> listItems = [];

  List<Tab> _tabList = [
    Tab(child: Text("Top"),),
    Tab(child: Text("Popular"),),
    Tab(child: Text("Trending"),),
    Tab(child: Text("Editor Choice"),),
    Tab(child: Text("Category"),),
    Tab(child: Text("Sport"),),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _tabList.length);
    storage.ready.whenComplete(() => setState(() {
      listItems = initNews();
      countInstance = listItems.length;
    }));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120.0,
        leading: IconButton(onPressed: (){

        }, icon: Icon(Icons.menu, color: Colors.black,)),
        actions: [Container(
          decoration: BoxDecoration(
            borderRadius:  BorderRadius.circular(50),
            gradient: const LinearGradient(colors: [Colors.grey, Colors.blue])
          ),
          child: IconButton(onPressed:() {
            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyCustomForm(newsItem: NewsItem("", "", "", "", "",""), typeInput: 0, storage: storage,)));
          }, icon: Icon(Icons.add,
          color: Colors.black,
          size: 30,
          )),
        )],
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("News App", style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold
        ),),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(30),
          child: TabBar(tabs: _tabList,
          indicatorColor: Colors.black,
          labelColor: Colors.black,
          isScrollable: true,
          controller: _tabController,
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Padding(padding: EdgeInsets.all(8.0),
          child: Container(
            child: ListView.builder(
              itemCount: countInstance,
              itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  var test = storage.getItem(storage.getItem('key').toString().split(';')[index]);
                  NewsItem dataItem = NewsItem.fromJson(jsonDecode(test) as Map<String, dynamic>);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(item: dataItem,
                   tag: dataItem.newsTitle,
                   storage: storage,)));
                },
                child: listWidget(initNews()[index]),
              );
            }),
            
          ),
          ),
          Padding(padding: EdgeInsets.all(8.0),
          child: Container(),),
          Padding(padding: EdgeInsets.all(8.0),
          child: Container(),),
          Padding(padding: EdgeInsets.all(8.0),
          child: Container(),),
          Padding(padding: EdgeInsets.all(8.0),
          child: Container(),),
          Padding(padding: EdgeInsets.all(8.0),
          child: Container(),),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => setState(() {
        countInstance = initNews().length;
      }),
      child: Icon(Icons.refresh),),
    );
  }
}