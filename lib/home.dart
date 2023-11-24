import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

List<String> nameList = [];
List<List> list = [];
List<int> addedIndex = [];

bool isGroupReady = false;

int noOfGroup = 0;
int noOfName = 0;
int maximum = 0;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //-------------variables---------------
  bool isGroupSet = false;
  bool isTextFiledDisable = false;
  bool isAddButtonEnabled = false;
  bool isRemoveButtonEnabled = false;
  bool isErrorCheck = false;

  final dilogBoxTextFieldController_1 = TextEditingController();
  final dilogBoxTextFieldController_2 = TextEditingController();
  final noOfGController = TextEditingController();
  final noOfNController = TextEditingController();
  final maximumController = TextEditingController();
  List<TextEditingController> nameController = [];
  @override
  Widget build(BuildContext context) {
    return isGroupReady
        ? Column(
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
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        shadows: [
                          Shadow(
                              color: Colors.black,
                              blurRadius: 2,
                              offset: Offset(2, 2))
                        ]),
                  ))
            ],
          )
        : Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                child: TextField(
                  controller: noOfGController,
                  onChanged: (value) {
                    updateButtonState();
                  },
                  readOnly: isTextFiledDisable,
                  decoration: InputDecoration(
                    labelText: "Enter Number of Groups :",
                    errorText: isErrorCheck ? _errorTextNoGroup : null,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                child: TextField(
                  controller: maximumController,
                  readOnly: isTextFiledDisable,
                  onChanged: (value) {
                    updateButtonState();
                  },
                  decoration: InputDecoration(
                      errorText: isErrorCheck ? _errorTextNoMaximum : null,
                      labelText: "Maximum No.of member in a Group :"),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                child: TextField(
                  controller: noOfNController,
                  onChanged: (value) {
                    updateButtonState();
                  },
                  decoration: InputDecoration(
                      errorText: isErrorCheck ? _errorTextNoNameList : null,
                      labelText: "Enter Number of Name List :"),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),

              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                //----------------------------------'Add Name' - Button--------------------------------
                Container(
                  margin: const EdgeInsets.only(right: 20, bottom: 20),
                  child: TextButton(
                    onPressed: isAddButtonEnabled
                        ? () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Enter Name'),
                                content: SingleChildScrollView(
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        for (int i = 0; i < noOfName; i++)
                                          TextField(
                                            controller: nameController[i],
                                            decoration: InputDecoration(
                                              // ignore: prefer_interpolation_to_compose_strings
                                              labelText: "Name #${i + 1}",
                                            ),
                                          )
                                      ]),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        for (int i = 0; i < noOfName; i++) {
                                          nameList.add(nameController[i].text);
                                        }
                                        updateButtonState();
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: const Text('ADD'),
                                  ),
                                ],
                              ),
                            )
                        : null,
                    style: TextButton.styleFrom(
                        fixedSize: const Size(100, 30),
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white),
                    child: const Text('Add Name'),
                  ),
                ),
                //----------------------------------------'Remove' - Button---------------------------------------
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: TextButton(
                    onPressed: isRemoveButtonEnabled
                        ? () {
                            setState(() {
                              nameList.removeLast();
                              updateButtonState();
                            });
                          }
                        : null,
                    style: TextButton.styleFrom(
                        fixedSize: const Size(100, 30),
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white),
                    child: const Text('Remove'),
                  ),
                )
              ]),
              for (int i = 0; i < nameList.length; i++)
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  color: const Color.fromARGB(94, 144, 158, 222),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 130,
                          child: Text('${i + 1}. ${nameList[i]}',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600)),
                        ),
                        if (i + 1 < nameList.length)
                          SizedBox(
                            width: 130,
                            child: Text('${i + 2}. ${nameList[++i]}',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600)),
                          )
                      ],
                    ),
                  ),
                ),
              //---------------------------------'Generate The Groups' - Button-------------------------------
              Container(
                margin: const EdgeInsets.only(bottom: 5, top: 10),
                child: TextButton(
                    onPressed: () {
                      setState(() {
                        if (nameList.length > noOfName) {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Remove Names'),
                              content: const Text(
                                  'Name list Lenght gereter Than Number of List...'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel'),
                                ),
                              ],
                            ),
                          );
                        } else if (_errorTextNoGroup == null &&
                            _errorTextNoNameList == null &&
                            _errorTextNoMaximum == null) {
                          isErrorCheck = false;
                          generateGroup();
                        } else {
                          isErrorCheck = true;
                        }
                      });
                    },
                    style: TextButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 46, 109, 180),
                        foregroundColor: Colors.white,
                        shadowColor: const Color.fromARGB(255, 13, 0, 255),
                        fixedSize: const Size(300, 60)),
                    child: const Text("Generate The Groups",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w700))),
              ),
            ],
          );
  }

  void updateButtonState() {
    setState(() {
      isAddButtonEnabled = noOfGController.text.isNotEmpty &
          noOfNController.text.isNotEmpty &
          maximumController.text.isNotEmpty;
      isRemoveButtonEnabled = nameList.isNotEmpty;
      if (isAddButtonEnabled) {
        noOfGroup = int.parse(noOfGController.text);
        noOfName = int.parse(noOfNController.text);
        maximum = int.parse(maximumController.text);
        nameController =
            List.generate(noOfName, (index) => TextEditingController());
        isTextFiledDisable = true;
      } else {
        isTextFiledDisable = false;
      }

      //-------------------------create String list and add to list for number of group entered------------------------
      if (isAddButtonEnabled) {
        for (int i = 0; i < noOfGroup; i++) {
          list.add(List<String>.empty());
        }
      } else {
        list.clear();
      }
    });
  }

//--------------------------------generate group-----------------------------------
  void generateGroup() {
    list.clear();
    addedIndex.clear();
    for (int i = 0; i < noOfGroup; i++) {
      list.add([]);
    }

    int addedCount = 0;
    while (addedCount != nameList.length) {
      int index = Random().nextInt(nameList.length);
      int groupNum = Random().nextInt(noOfGroup);
      if (!addedIndex.contains(index)) {
        if (list[groupNum].length < maximum) {
          list[groupNum].add(nameList[index]);
          addedIndex.add(index);
          addedCount++;
        }
      }
    }

    for (int i = 0; i < list.length; i++) {
      if (list[i].length <= maximum / 2) {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text('Isuse With Group #${i + 1}'),
            content: const Text(
                'Less Members....\nIt Cannot Be group, Do you want add that members to rest of groups ?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    for (var value in list[i]) {
                      bool isEqual = true;
                      while (isEqual) {
                        int num = Random().nextInt(list.length);
                        if (i != num) {
                          list[num].add(value);
                          isEqual = false;
                        }
                      }
                    }
                    list.removeAt(i);
                  });
                  Navigator.pop(context);
                },
                child: const Text('ADD'),
              ),
            ],
          ),
        );
      }
    }
    setState(() {
      isGroupReady = true;
    });
  }

//-------------------------validations-----------------------------------
  String? get _errorTextNoNameList {
    //can get the text from  _noOfNController.value.text
    final nameList = noOfNController.value.text;

    if (nameList.isEmpty) {
      return 'Can\'t be empty';
    } else if (!(int.parse(noOfNController.value.text) <=
        int.parse(maximumController.value.text) *
            int.parse(noOfGController.value.text))) {
      int sum = int.parse(maximumController.value.text) *
          int.parse(noOfGController.value.text);
      return 'Number of Name List cannot be greate than $sum';
    }

    return null;
  }

  String? get _errorTextNoGroup {
    //get the text from  _controller.value.text
    final text = noOfGController.value.text;
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    return null;
  }

  String? get _errorTextNoMaximum {
    //get the text from  _maximumController.value.text
    final text = maximumController.value.text;
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    // return null if the text is valid
    return null;
  }
}
