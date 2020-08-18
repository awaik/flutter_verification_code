import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.green,
          primaryColor: Colors.red,
          accentColor: Colors.orange,
          hintColor: Colors.green),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _onEditing = true;
  String _code;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Example verify code')),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Enter your code',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ),
          VerificationCode(
            textStyle: TextStyle(fontSize: 20.0, color: Colors.red[900]),
            keyboardType: TextInputType.number,
            // in case underline color is null it will use primaryColor: Colors.red from Theme
            underlineColor: Colors.amber,
            length: 4,
            // clearAll is NOT required, you can delete it
            // takes any widget, so you can implement your design
            clearAll: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'clear all',
                style: TextStyle(
                    fontSize: 14.0,
                    decoration: TextDecoration.underline,
                    color: Colors.blue[700]),
              ),
            ),
            onCompleted: (String value) {
              setState(() {
                _code = value;
              });
            },
            onEditing: (bool value) {
              setState(() {
                _onEditing = value;
              });
              if (!_onEditing) FocusScope.of(context).unfocus();
            },
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: _onEditing
                  ? Text('Please enter full code')
                  : Text('Your code: $_code'),
            ),
          )
        ],
      ),
    );
  }
}
