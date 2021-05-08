# 1.0.3

- Add fillColor option.

# 1.0.2

- can remove after fill the textfield, made by https://github.com/manofi21
- Add underlineUnfocusedColor to change color of boxes without focus and underlineWidth to change line width of the underline, made by https://github.com/tomaash 

# 1.0.1

- Fixed bug with multiple widgets on the screen https://github.com/awaik/flutter_verification_code/issues/14 - removed static definition.

# 1.0.0+1

- Fixed docs

# 1.0.0

- Null safety and Flutter 2.0

# 0.2.1

- Add option 'underlineColor' - in case underline color is null it will use primaryColor from Theme

# 0.2.0

- Add option 'clearAll' - for clear all user input. https://github.com/awaik/flutter_verification_code/issues/6

```
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
```

# 0.1.6+2

- Change onCompleted, onEditing option to @required for fixing issue https://github.com/awaik/flutter_verification_code/issues/5

# 0.1.6+1

- Removed color from constructor, thanks for finding and fixing https://github.com/almayahi

# 0.1.6

- Thanks for finding and fixing bug to https://github.com/mohammadPezesh1994 - "bug occur when create VerificationCode in stateful widget and after created"
- Fixed bug "Keyboard can not display on iOS". Thank for the issue to https://github.com/thienhaole92

# 0.1.5+1

- Improved README.MD

# 0.1.5

- Fixed bug that was connected with FocusNode() and appeared after big Flutter update.


# 0.1.4

- Improved description in README.md files for package and example.


# 0.1.3

- New show case
- `onEditing` can now be used for getting info about state of code completion
```dart
onEditing: (bool value) {
  setState(() {
    _onEditing = value;
  });
},
```