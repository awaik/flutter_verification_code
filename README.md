# flutter_verification_code [![Pub](https://img.shields.io/pub/v/flutter_verification_code.svg)](https://pub.dev/packages/flutter_verification_code)

- A Flutter package that help you create a verification input.

- Based on https://github.com/tiny-express/flutter_verification_code_input.

- Added state change in case user delete char after complete fill, take a look an example on [Stackoverflow](https://stackoverflow.com/questions/59005381/how-to-know-when-user-delete-the-input-in-verificationcodeinput-flutter/59006077#59006077)

- With version 1.1.0 supports copy/paste of entire code

After install, in your Dart code, you can use:

```dart
import 'package:flutter_verification_code/flutter_verification_code.dart';
```

## Usage

```dart
VerificationCode(
  textStyle: TextStyle(fontSize: 20.0, color: Colors.red[900]),
  underlineColor: Colors.amber,
  keyboardType: TextInputType.number,
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
  },
),
```

```dart
onEditing: (bool value) {
  setState(() {
    _onEditing = value;
  });
},
```

```dart
Center(
  child: (_onEditing != true)
      ? Text('Your code: $_code')
      : Text('Please enter full code'),
),
```

Full example is here https://github.com/awaik/flutter_verification_code/tree/master/example

## Showcase


![Showcase|100x100, 10%](show_case_v2.gif)


