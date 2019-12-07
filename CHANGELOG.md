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