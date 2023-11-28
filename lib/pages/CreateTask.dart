import 'package:flutter/material.dart';
import 'package:helep_v1/Components/my_button.dart';
import 'package:helep_v1/models/services_model.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create task'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Task Details',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 24,
              ),
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
              SizedBox(
                height: 12,
              ),
              Mybutton(
                  onTap: () {
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
