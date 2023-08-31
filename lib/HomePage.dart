import 'package:flutter/material.dart';
import 'package:pocketmoney/BottomHomeBar.dart';
import 'package:pocketmoney/CustomAppBar.dart';

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
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //
      //   title: Text(widget.title),
      // ),


      // appBar: CustomAppBar(
      //   title: widget.title,
      //   strings: ['String 1', 'String 2', 'String 3'],
      //   onMonthCycleChanged: (index) {
      //     // Handle month cycle change here
      //   },
      // ),

      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   title: Text(
      //     widget.title,
      //     style: TextStyle(
      //       color: Colors.white,
      //       fontSize: 20,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      //   leading: IconButton(
      //     icon: Icon(Icons.menu),
      //     onPressed: () {
      //       // Handle menu button press
      //     },
      //   ),
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.search),
      //       onPressed: () {
      //         // Handle search button press
      //       },
      //     ),
      //     IconButton(
      //       icon: Icon(Icons.notifications),
      //       onPressed: () {
      //         // Handle notifications button press
      //       },
      //     ),
      //   ],
      //   elevation: 4,
      //   toolbarHeight: 80,
      //   centerTitle: true,
      //   automaticallyImplyLeading: false,
      // ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              // style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomHomeBar(title: " ",),
    );
  }
}
