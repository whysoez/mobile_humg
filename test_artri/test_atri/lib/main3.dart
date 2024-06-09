
import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        ArticleDetail.routeName: (context) => const ArticleDetail()
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyCustomForm1(),
    );
  }
}

// Define a custom Form widget.
class MyCustomForm1 extends StatefulWidget {
  const MyCustomForm1({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm1> {
  List<Article> dataShow = [
    new Article(1, 'content', 'title', 'author', 'image', 'publishDate'),
    new Article(1, 'content', 'title', 'author', 'image', 'publishDate'),
    new Article(1, 'content', 'title', 'author', 'image', 'publishDate'),
    new Article(1, 'content', 'title', 'author', 'image', 'publishDate'),
    new Article(1, 'content', 'title', 'author', 'image', 'publishDate'),
    new Article(1, 'content', 'title', 'author', 'image', 'publishDate'),
    new Article(1, 'content', 'title', 'author', 'image', 'publishDate'),
    new Article(1, 'content', 'title', 'author', 'image', 'publishDate'),
    new Article(2, 'content2', 'title', 'author', 'image', 'publishDate')
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      backgroundColor: Colors.white,
      body: GridView.count(
        childAspectRatio: 0.75,
        crossAxisCount: 2,
        children: dataShow.map((e) => ArticleCard(item: e)).toList(),
      ),
    );
  }
}

class ArticleCard extends StatelessWidget {
  const ArticleCard({super.key, required this.item});
  final Article item;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, ArticleDetail.routeName, arguments: item);
      },
      splashColor: Colors.red,
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Container(
                child: Image.asset("assets/audi_a8.jpg"),
                height: 150,
              ),
              Text(item.title,
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold
              )),
              SizedBox(height: 4,),
              Text(item.content,
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.normal
              )),
              Text(item.publishDate,
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.normal
              )),
            ],
          ),)
        ),
      ),
    );
  }
}

class ArticleDetail extends StatelessWidget {
  const ArticleDetail({super.key});
  static const routeName = '/Detail';
  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)!.settings.arguments as Article;
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      body: Center(child: Text(item.content)),
    );
  }
}

class Article {
  int id;
  String title;
  String author;
  String content;
  String image;
  String publishDate;
  Article(this.id, this.content, this.title, this.author, this.image,
      this.publishDate);
}
