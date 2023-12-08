// ignore_for_file: no_leading_underscores_for_local_identifiers, file_names

import 'package:flutter/material.dart';
import 'package:helep_v1/Components/my_button.dart';
import 'package:helep_v1/models/services_model.dart';
import 'package:helep_v1/services/task/task_service.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => CreateTaskState();
}

class CreateTaskState extends State<CreateTask> {
  List<ServiceModel> instance = ServiceModel.getService();
  TextEditingController datecontroller = TextEditingController();
  TextEditingController timecontroller = TextEditingController();
  TextEditingController fromcontroller = TextEditingController();
  TextEditingController tocontroller = TextEditingController();
  TextEditingController paxcontroller = TextEditingController();
  TextEditingController remarkcontroller = TextEditingController();
  final TaskService _taskService = TaskService();

  void createTask() async {
    //send only if all textfield is not empty except for remarks
    if (fromcontroller.text.isNotEmpty &&
        tocontroller.text.isNotEmpty &&
        datecontroller.text.isNotEmpty &&
        timecontroller.text.isNotEmpty &&
        paxcontroller.text.isNotEmpty) {
      await _taskService.createTask(
          fromcontroller.text,
          tocontroller.text,
          datecontroller.text,
          timecontroller.text,
          paxcontroller.text,
          remarkcontroller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create task'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Task Details',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Flexible(
                      flex: 5,
                      child: TextField(
                        controller: fromcontroller,
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
                  const SizedBox(
                    width: 50,
                    height: 50,
                    child: Icon(Icons.arrow_forward),
                  ),
                  Flexible(
                      flex: 6,
                      child: TextField(
                        controller: tocontroller,
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
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  const SizedBox(width: 60, child: Text('Date:')),
                  Flexible(
                      child: TextField(
                    controller: datecontroller,
                    onTap: () {
                      _selectDate();
                    },
                    decoration: InputDecoration(
                        filled: true,
                        labelText: 'dd/mm/yy',
                        prefixIcon: const Icon(Icons.calendar_today),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(40)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(40))),
                    readOnly: true,
                  ))
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  const SizedBox(width: 60, child: Text('Time:')),
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
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  const SizedBox(width: 60, child: Text('Pax:')),
                  Flexible(
                      child: TextField(
                    controller: paxcontroller,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(30)),
                      labelText: 'No of Passengers',
                      labelStyle: const TextStyle(),
                    ),
                  ))
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  const SizedBox(width: 60, child: Text('Remarks:')),
                  Flexible(
                      child: TextField(
                    controller: remarkcontroller,
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
              const SizedBox(
                height: 12,
              ),
              Mybutton(
                  onTap: () {
                    createTask();
                    Navigator.pop(context);
                  },
                  text: 'Submit'),
            ],
          ),
        ),
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
        datecontroller.text = _picked.toString().split(" ")[0];
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
