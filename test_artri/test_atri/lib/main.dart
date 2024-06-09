
import 'package:flutter/material.dart';
import 'package:test_atri/details.dart';
import 'package:test_atri/listwidget.dart';
import 'package:test_atri/main2.dart';
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

List<NewsItem> listItems = [
  NewsItem(
    "https://2.imimg.com/data2/DR/CR/MY-3998144/sports-products-500x500.jpg",
    "lorem news",
    "lorem content",
    "20 Jan 2020"
  ),
  NewsItem(
    "https://riseuplabs.com/wp-content/uploads/2021/06/ecommerce-app-development-article-inner-thumbnail.webp",
    "lorem news",
    "lorem content",
    "20 Jan 2020"
  ),
  NewsItem(
    "https://2.imimg.com/data2/DR/CR/MY-3998144/sports-products-500x500.jpg",
    "lorem news",
    "lorem content",
    "20 Jan 2020"
  ),
  NewsItem(
    "https://2.imimg.com/data2/DR/CR/MY-3998144/sports-products-500x500.jpg",
    "lorem news",
    "lorem content",
    "20 Jan 2020"
  ),
  NewsItem(
    "https://2.imimg.com/data2/DR/CR/MY-3998144/sports-products-500x500.jpg",
    "lorem news",
    "lorem content",
    "20 Jan 2020"
  )
];

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
  void initState(){
    super.initState();
    _tabController = TabController(vsync: this, length: _tabList.length);
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
              itemCount: listItems.length,
              itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(item: listItems[index], tag: listItems[index].newsTitle)));
                },
                child: listWidget(listItems[index]),
              );
            }),
          ),),
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
          Padding(padding: EdgeInsets.all(8.0),
          child: Container(),),
        ],
      ),
    );
  }
}