import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../../constants.dart';

class AddTodoPage extends StatefulWidget {
  static const String id = "/addTodo";

  @override
  _AddTodoPageState createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  // Form Key
  GlobalKey<FormState> _formKey;

  //true if the date & time is selected
  bool _timeDone = false;

  //true if add button is clicked
  bool _isClicked = false;

  //Custom style of Date & Time picker
  final DatePickerTheme _pickerTheme = DatePickerTheme(
    doneStyle: TextStyle(color: greenColor),
    cancelStyle: TextStyle(color: Colors.red),
  );

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _isClicked = false;
    _timeDone = false;
  }

  String _validate(value) {
    if (value.isEmpty) return "*Required";
    return null;
  }

  Widget _validateTime() {
    if (_isClicked && !_timeDone) {
      return Text(
        "*required",
        style: TextStyle(color: Colors.red, fontSize: 18.0),
        textAlign: TextAlign.center,
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Todo item"),
        centerTitle: true,
        backgroundColor: greenColor,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          children: <Widget>[
            //Title input
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: TextFormField(
                decoration: inputDecoration.copyWith(
                  labelText: "title",
                  prefixIcon: Icon(Icons.title, color: greenColor),
                  hintText: "The title of Todo item...",
                ),
                validator: _validate,
                onChanged: (_) {
                  if (_isClicked) {
                    setState(() {
                      _formKey.currentState.validate();
                    });
                  }
                },
              ),
            ),
            // Description input
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: TextFormField(
                decoration: inputDecoration.copyWith(
                  labelText: "Description",
                  prefixIcon: Icon(Icons.description, color: greenColor),
                  hintText: "The Description of Todo item...",
                  hintMaxLines: 2,
                ),
                maxLines: 2,
                validator: _validate,
                onChanged: (_) {
                  if (_isClicked) {
                    setState(() {
                      _formKey.currentState.validate();
                    });
                  }
                },
              ),
            ),
            // Date & Time picker
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: FlatButton(
                onPressed: () {
                  DatePicker.showDateTimePicker(
                    context,
                    currentTime: DateTime.now(),
                    minTime: DateTime(2020, 01, 01),
                    maxTime: DateTime(2050, 01, 01),
                    locale: LocaleType.fr,
                    onConfirm: (date) {
                      setState(() {
                        _timeDone = true;
                      });
                    },
                    theme: _pickerTheme,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("Select Date and Time", style: TextStyle(fontSize: 18.0)),
                    Icon(Icons.date_range, color: greenColor, size: 40.0),
                  ],
                ),
              ),
            ),
            //text validation of time & date
            _validateTime(),
            // Add item button
            InkWell(
              onTap: () {
                setState(() {
                  _isClicked = true;
                });
                _formKey.currentState.validate();
              },
              child: Container(
                margin: const EdgeInsets.only(top: 40.0),
                padding: const EdgeInsets.all(20.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: greenColor,
                ),
                child: Text(
                  "Add Item",
                  style: whiteText.copyWith(fontSize: 20.0, letterSpacing: 1.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
