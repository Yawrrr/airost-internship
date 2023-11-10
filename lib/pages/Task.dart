// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helep_v1/models/services_model.dart';

class Task extends StatefulWidget {
  const Task({super.key});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  int _selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.popAndPushNamed(context, '/createTask');
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(
          'Task',
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
              switch (index) {
                case 0:
                  Navigator.pushReplacementNamed(context, '/');
                  break;
                case 1:
                  Navigator.pushReplacementNamed(context, '/task');
                  break;
                case 2:
                  Navigator.pushReplacementNamed(context, '/messages');
                  break;
                case 3:
                  Navigator.pushReplacementNamed(context, '/heleper');
                  break;
                case 4:
                  Navigator.pushReplacementNamed(context, '/profile');
                  break;
              }
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/vectors/Home.svg'),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(_selectedIndex == 1
                    ? 'assets/vectors/Task_filled.svg'
                    : 'assets/vectors/Task.svg'),
                label: 'Tasks'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/vectors/Messages.svg'),
                label: 'Messages'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/vectors/Helepers.svg'),
                label: 'Helepers'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/vectors/Profile.svg'),
                label: 'Profile')
          ]),
    );
  }
}

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => CreateTaskState();
}

class CreateTaskState extends State<CreateTask> {
  int _currentStep = 0;
  String _ServiceDropDown = 'Select an service';
  String _AreaDropDown = 'Select Area';
  List<ServiceModel> instance = ServiceModel.getService();
  TextEditingController textcontroller = TextEditingController();
  TextEditingController timecontroller = TextEditingController();

  var serviceName = [
    'Select an service',
    'Ride',
    'Express',
    'Food',
  ];

  var area = [
    'Select Area',
    'Within UTM',
    'Without UTM',
  ];

  List<Step> steplist() => [
        Step(
            title: Text('Select category'),
            isActive: _currentStep >= 0,
            state: _currentStep <= 0 ? StepState.editing : StepState.complete,
            content: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      child: DropdownButton<String>(
                        items: serviceName.map((String name) {
                          return DropdownMenuItem(
                            child: Text(name),
                            value: name,
                          );
                        }).toList(),
                        onChanged: (String? NewValue) {
                          setState(() {
                            _ServiceDropDown = NewValue!;
                          });
                        },
                        value: _ServiceDropDown,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      child: DropdownButton<String>(
                        items: area.map((String name) {
                          return DropdownMenuItem(
                            child: Text(name),
                            value: name,
                          );
                        }).toList(),
                        onChanged: (String? NewValue) {
                          setState(() {
                            _AreaDropDown = NewValue!;
                          });
                        },
                        value: _AreaDropDown,
                      ),
                    ),
                  ),
                ],
              ),
            )),
        Step(
            title: Text('Task Details'),
            isActive: _currentStep >= 1,
            state: _currentStep == 1 ? StepState.editing : StepState.indexed,
            content: Center(
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                          flex: 5,
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              labelText: 'From',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          )),
                      Container(
                        width: 50,
                        height: 50,
                        child: Icon(Icons.arrow_forward),
                      ),
                      Flexible(
                          flex: 6,
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none),
                              labelText: 'To',
                            ),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Container(width: 60, child: Text('Date:')),
                      Flexible(
                          child: TextField(
                        controller: textcontroller,
                        onTap: () {
                          _selectDate();
                        },
                        decoration: InputDecoration(
                            filled: true,
                            labelText: 'dd/mm/yy',
                            prefixIcon: Icon(Icons.calendar_today),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(40)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(40))),
                        readOnly: true,
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Container(width: 60, child: Text('Time:')),
                      Flexible(
                          child: TextField(
                        controller: timecontroller,
                        onTap: () {
                          _selectTime();
                        },
                        decoration: InputDecoration(
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          labelText: '',
                        ),
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Container(width: 60, child: Text('Pax:')),
                      Flexible(
                          child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(30)),
                          labelText: 'No of Passengers',
                          labelStyle: TextStyle(),
                        ),
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Container(width: 60, child: Text('Remarks:')),
                      Flexible(
                          child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(30)),
                          labelText: '',
                        ),
                      ))
                    ],
                  ),
                  // SizedBox(
                  //   height: 12,
                  // ),
                  // TextField(
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(),
                  //     labelText: 'Area',
                  //   ),
                  // )
                ],
              ),
            ))
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create task'),
      ),
      body: Stepper(
        steps: steplist(),
        type: StepperType.horizontal,
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep < steplist().length - 1) {
            setState(() {
              _currentStep += 1;
            });
          } else if (_currentStep == steplist().length - 1) {
            setState(() {
              Navigator.pushReplacementNamed(context, '/task');
            });
          }
        },
        onStepCancel: () {
          if (_currentStep == 0) {
            Navigator.pop(context);
          } else if (_currentStep >= 0) {
            setState(() {
              _currentStep -= 1;
            });
          }
        },
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime(2100));

    if (_picked != null) {
      setState(() {
        textcontroller.text = _picked.toString().split(" ")[0];
      });
    }
  }

  Future<void> _selectTime() async {
    TimeOfDay? _picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (_picked != null) {
      setState(() {
        timecontroller.text = _picked.format(context);
      });
    }
  }
}
