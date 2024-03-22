import 'package:flutter/material.dart';

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
      home: ImageState(),
    );
  }
}

// ignore: must_be_immutable
class ImageState extends StatefulWidget {
  ImageState({super.key});
  String imgUrl = '';


  // @override
  // Widget build(BuildContext context) {
  //   // return Image.asset('assets/audi_a8.jpg', width: 400, height: 400);
  //   return Image.network(imgUrl
  //   ,width: 400
  //   ,height: 400,);
  //   }
    
      @override
      State<ImageState> createState() => ImageCreate();
}

class ImageCreate extends State<ImageState>{
  String imageUrl = 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg';
  
  void initState(){
    Future.delayed(const Duration(seconds: 5),
    SetImageUrl);
  }
  void SetImageUrl(){
    setState(() {
      imageUrl = 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Image.network(imageUrl);
  }

}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Image.asset('../asset/audi_a8.jpg', width: 400, height: 400)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
    ));
  }
}
