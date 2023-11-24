import 'package:flutter/material.dart';
import 'package:group_application/home.dart';

class Group extends StatefulWidget {
  const Group({super.key});

  @override
  State<Group> createState() => _GroupState();
}

int index = 0;

class _GroupState extends State<Group> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < list.length; i++)
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Center(
              child: Card(
                color: const Color.fromARGB(185, 63, 134, 216),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: 250,
                    child: Column(
                      children: [
                        Text(
                          "Group # ${i + 1}",
                          style: const TextStyle(
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                  color: Colors.black,
                                  blurRadius: 2.0,
                                  offset: Offset(2.0, 2.0))
                            ],
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 15),
                        for (var value in list[i])
                          Column(
                            children: [
                              Text(
                                value,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        const SizedBox(height: 20),
        TextButton(
            onPressed: () {
              setState(() {
                isGroupReady = false;
              });
            },
            style: TextButton.styleFrom(
                shadowColor: Colors.black,
                backgroundColor: Colors.amber,
                fixedSize: const Size(200, 45)),
            child: const Text(
              "Go Back",
              style: TextStyle(color: Colors.white, fontSize: 25, shadows: [
                Shadow(color: Colors.black, blurRadius: 2, offset: Offset(2, 2))
              ]),
            ))
      ],
    );
  }

}
