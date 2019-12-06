# flutter_verification_code

- A Flutter package that help you create a verification input.

- Based on https://github.com/tiny-express/flutter_verification_code_input.

- Added state change in case user delete char after complete fill, take a look an example on [Stackoverflow](https://stackoverflow.com/questions/59005381/how-to-know-when-user-delete-the-input-in-verificationcodeinput-flutter/59006077#59006077)

## Installing

```yaml
  flutter_verification_code:
    git:
      url: https://github.com/awaik/flutter_verification_code.git
    version: ^0.1.3
```

```dart
import 'flutter_verification_code.dart';
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
Center(
              child: (_onEditing != true)
                  ? Text('Your code: $_code')
                  : Text('Please enter full code'),
            ),
```

## Showcase


![Showcase|100x100, 10%](show_case1.gif)


