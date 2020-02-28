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