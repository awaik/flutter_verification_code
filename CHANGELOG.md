# 1.1.7

Made by https://github.com/avraham-mayer

- If backspace pressed in empty box, move to previous box

# 1.1.6

Made by https://github.com/ebrahim-2

- Add filled property to activate input background color when fillColor has a value

If true the decoration's container is filled with fillColor.

When InputDecorator.isHovering is true, the hoverColor is also blended into the final fill color.

Typically this field set to true if border is an UnderlineInputBorder.

The decoration's container is the area which is filled if filled is true and bordered per the border. It's the area adjacent to icon and above the widgets that contain helperText, errorText, and counterText.

This property is false by default.

# 1.1.5

- Fixed https://github.com/awaik/flutter_verification_code/issues/33, thank to https://github.com/Xorn4400

# 1.1.4

- Added `margin` and `padding` parameters https://github.com/awaik/flutter_verification_code/issues/35
- Example updated

# 1.1.3+1

- Fixed `isSecure` parameter, thanks to https://github.com/heltonrosa


# 1.1.3

- Added fullBorder property. If true - displays boxes instead of underlined placeholders.
- Added final `Stream<bool>? pasteStream;` property. When it receives true, pastes the
clipboard content. With this property is possible to add button or another functionality
outside this widget, that initiates pasting from clipboard.
Look animated example in the readme.md

# 1.1.2

- Added cursorColor property. If this is null it will default to the ambient.

# 1.1.1

- Added option to move with left and right arrow keys. (Changes made by https://github.com/rajrushilmakkar)

# 1.1.0

- Support copy/paste of entire code. (Changes made by https://github.com/yonatann)

# 1.0.4

- Option to allow only number input from keyboard(flutter web) (Changes made by https://github.com/rajrushilmakkar)

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