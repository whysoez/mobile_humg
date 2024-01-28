import 'dart:js_util';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CounterPage(title: 'Counter Page'),
    );
  }
}

class MyObject{
  int value;
  MyObject({
    required this.value
  });
  

void increase(){
   value++;
}
void decrease(){
  value--;
}

int square(int n){
  int result = 1;
  for(int i = 0; i< n ; i++){
    result = result * value;
  }
  value = result;
  return result;
}

void reset(){
  value = 1;
}

int get _value => this.value;
set _value(int newValue){
  this.value = newValue;
}
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key, required this.title});
  final String title;

  @override
  State<CounterPage> createState() => CounterPageState();
}

class CounterPageState extends State<CounterPage> {
  int _value = 0;
  int n = 0;
  MyObject _myObject = new MyObject(value: 1);

void decrease(){
  setState(() {
    _myObject.decrease();
  });
}

  void increase() {
    setState(() {
    _myObject.increase();
    });
    }
    
    void square() {
    setState(() {
    _myObject.square(n);
    });
    }
    
    void reset() {
    setState(() {
    _myObject.reset();
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
              '${_myObject.value}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            TextField(
              keyboardType: TextInputType.number,
              cursorWidth: 1,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  )
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(
                    color: Colors.grey
                  )
                ),
                icon: Icon(Icons.square),
                hintText: 'Nhap so nguyen: '),
              onChanged: (value) {
                n = int.parse(value);
              },
            )
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                onPressed: decrease,
                tooltip: 'Decrease',
                child: const Icon(Icons.remove),
              ),
            ),Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                onPressed: increase,
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              ),
            ),Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                onPressed: square,
                tooltip: 'Square',
                child: const Icon(Icons.star),
              ),
            ),Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                onPressed: reset,
                tooltip: 'Reset Value',
                child: const Icon(Icons.restart_alt),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
