# flutter_verification_code [![Pub](https://img.shields.io/pub/v/flutter_verification_code.svg)](https://pub.dev/packages/flutter_verification_code)

- A Flutter package that help you create a verification input.

- Based on https://github.com/tiny-express/flutter_verification_code_input.

- Added state change in case user delete char after complete fill, take a look an example on [Stackoverflow](https://stackoverflow.com/questions/59005381/how-to-know-when-user-delete-the-input-in-verificationcodeinput-flutter/59006077#59006077)

After install, in your Dart code, you can use:

```dart
import 'package:flutter_verification_code/flutter_verification_code.dart';
```

## Usage

```dart
  VerificationCode(
      keyboardType: TextInputType.number,
      length: 4,
      autofocus: true,
      onCompleted: (String value) {
        //...
        print(value);
      },
  )
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

## Showcase


![Showcase|100x100, 10%](show_case1.gif)


