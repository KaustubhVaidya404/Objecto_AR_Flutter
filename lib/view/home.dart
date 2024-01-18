import 'package:ar_flutter/models/ar_object.dart';
import 'package:ar_flutter/models/display_card_model.dart';
import 'package:ar_flutter/view/object_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<DisplayCardModel> displaycard = [
    DisplayCardModel('Duck', false, ARObjects.duck),
    DisplayCardModel('Avacado', false, ARObjects.avacado),
    DisplayCardModel('Carbonfiber', false, ARObjects.carbonfiber),
    DisplayCardModel('Fox', false, ARObjects.fox),
    DisplayCardModel('Sheenchair', false, ARObjects.sheenchair),
    DisplayCardModel('Latern', false, ARObjects.latern),
    DisplayCardModel('Buggy', false, ARObjects.buggy),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'AR Vision',
          style: TextStyle(color: Colors.black, fontSize: 35),
        ),
      ),
      body: Column(children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              children: displaycard
                  .map(
                    (e) => InkWell(
                      onTap: () => onTap(e),
                      child: Card(
                        color: e.isActive ? Colors.green : null,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const SizedBox(height: 10),
                            Text(
                              e.title,
                              style: TextStyle(
                                  fontSize: 20,
                                  color:
                                      e.isActive ? Colors.white : Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        )
      ]),
    );
  }

  void onTap(DisplayCardModel e) {
    setState(() {
      e.isActive = !e.isActive;
    });
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ARObjectScreen(
                  object: e.object,
                ))).then((value) {
      setState(() {
        e.isActive = !e.isActive;
      });
    });
  }
}
