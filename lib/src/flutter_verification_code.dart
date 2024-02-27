import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VerificationCode extends StatefulWidget {
  /// is completed
  final ValueChanged<String> onCompleted;

  /// is in process of editing
  final ValueChanged<bool> onEditing;

  /// keyboard type
  final TextInputType keyboardType;

  /// quantity of boxes
  final int length;

  /// cursorColor :)
  final Color? cursorColor;

  /// size of box for code
  final double itemSize;

  /// the color for underline, in case underline color is null it will use primaryColor from Theme
  final Color? underlineColor;

  /// the color for underline when not focused, grey by default
  final Color? underlineUnfocusedColor;

  /// display rectangular border instead of underlined
  final bool fullBorder;

  /// the color for TextField background
  final Color? fillColor;

  /// the line width for underline
  final double? underlineWidth;

  /// style of the input text
  final TextStyle textStyle;

  /// auto focus when screen appears
  final bool autofocus;

  ///takes any widget, display it, when tap on that element - clear all fields
  final Widget? clearAll;

  ///display button for the paste from clipboard functionality
  final Stream<bool>? pasteStream;

  /// to secure the TextField
  final bool isSecure;

  ///accept only digit inputs from keyboard
  final bool digitsOnly;

  /// padding between boxes
  final EdgeInsets margin;

  /// padding inside boxes
  final EdgeInsets? padding;

  /// Decoration of enable full borders
  final OutlineInputBorder ? fullBorderEnabledDecoration ;
  
  /// Decoration of Focused full borders
  final OutlineInputBorder ? fullBorderFocusedDecoration ;

  const VerificationCode({
    Key? key,
    required this.onCompleted,
    required this.onEditing,
    this.keyboardType = TextInputType.number,
    this.length = 4,
    this.cursorColor,
    this.itemSize = 50,
    this.underlineColor,
    this.underlineUnfocusedColor,
    this.fullBorder = false,
    this.fullBorderEnabledDecoration ,
    this.fullBorderFocusedDecoration,
    this.fillColor,
    this.underlineWidth,
    this.textStyle = const TextStyle(fontSize: 25.0),
    this.autofocus = false,
    this.clearAll,
    this.pasteStream,
    this.isSecure = false,
    this.digitsOnly = false,
    this.margin = EdgeInsets.zero,
    this.padding,
  }) : super(key: key);

  @override
  _VerificationCodeState createState() => _VerificationCodeState();
}

class _VerificationCodeState extends State<VerificationCode> {
  final List<FocusNode> _listFocusNode = <FocusNode>[];
  final List<FocusNode> _listFocusNodeKeyListener = <FocusNode>[];
  final List<TextEditingController> _listControllerText =
      <TextEditingController>[];
  final List<String> _code = [];
  int _currentIndex = 0;

  @override
  void initState() {
    _listFocusNode.clear();
    _listFocusNodeKeyListener.clear();
    for (var i = 0; i < widget.length; i++) {
      _listFocusNode.add(FocusNode());
      _listFocusNodeKeyListener.add(FocusNode());
      _listControllerText.add(TextEditingController());
      _code.add('');
    }
    if (widget.pasteStream != null) {
      widget.pasteStream!.listen((val) {
        if (val) {
          _pasteFromClipboard();
        }
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    for (final val in _listControllerText) {
      val.dispose();
    }
    for (final val in _listFocusNode) {
      val.dispose();
    }
    super.dispose();
  }

  String _getInputVerify() {
    String verifyCode = "";
    for (var i = 0; i < widget.length; i++) {
      for (var index = 0; index < _listControllerText[i].text.length; index++) {
        if (_listControllerText[i].text[index] != "") {
          verifyCode += _listControllerText[i].text[index];
        }
      }
    }
    return verifyCode;
  }

  Widget _buildInputItem(int index) {
    final padding =
        widget.padding ?? EdgeInsets.all(((widget.itemSize * 2) / 10));

    final underlinedDecoration = InputDecoration(
      fillColor: widget.fillColor,
      filled: widget.fillColor != null ? true : false,
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: widget.underlineUnfocusedColor ?? Colors.grey,
          width: widget.underlineWidth ?? 1,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: widget.underlineColor ?? Theme.of(context).primaryColor,
          width: widget.underlineWidth ?? 1,
        ),
      ),
      counterText: "",
      contentPadding: padding,
      errorMaxLines: 1,
    );

    final fullDecoration = InputDecoration(
      fillColor: widget.fillColor,
      filled: widget.fillColor != null ? true : false,
      enabledBorder: widget.fullBorderEnabledDecoration ?? OutlineInputBorder(
        borderSide:  BorderSide(
          color: widget.underlineUnfocusedColor ?? Colors.grey,
          width: widget.underlineWidth ?? 1,
        ),
      ),
      focusedBorder: widget.fullBorderFocusedDecoration ?? OutlineInputBorder(
        borderSide: BorderSide(
          color: widget.underlineColor ?? Theme.of(context).primaryColor,
          width: widget.underlineWidth ?? 1,
        ),
      ),
      counterText: "",
      contentPadding: padding,
      errorMaxLines: 1,
    );

    return RawKeyboardListener(
      focusNode: _listFocusNodeKeyListener[index],
      onKey: (event) {
        if (event.runtimeType == RawKeyUpEvent) {
          if (event.data.logicalKey == LogicalKeyboardKey.backspace &&
              _listControllerText[index].text.isEmpty) {
            if (index > 0) {
              _listControllerText[index - 1].clear();
            }
            _prev(index);
          }
          if (event.data.logicalKey == LogicalKeyboardKey.arrowLeft) {
            _prev(index);
          } else if (event.data.logicalKey == LogicalKeyboardKey.arrowRight) {
            _next(index);
          }
        }
      },
      child: TextField(
        keyboardType: widget.keyboardType,
        inputFormatters: widget.digitsOnly
            ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
            : null,
        maxLines: 1,
        maxLength: widget.length - index,
        controller: _listControllerText[index],
        focusNode: _listFocusNode[index],
        showCursor: true,
        cursorColor: widget.cursorColor,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        autocorrect: false,
        textAlign: TextAlign.center,
        autofocus: widget.autofocus,
        obscureText: widget.isSecure,
        style: widget.textStyle,
        decoration: widget.fullBorder ? fullDecoration : underlinedDecoration,
        onChanged: (String value) {
          if ((_currentIndex + 1) == widget.length && value.isNotEmpty) {
            widget.onEditing(false);
          } else {
            widget.onEditing(true);
          }

          if (value.isEmpty && index >= 0) {
            _prev(index);
            return;
          }

          if (value.isNotEmpty) {
            String _value = value;
            int _index = index;

            while (_value.isNotEmpty && _index < widget.length) {
              _listControllerText[_index].value = TextEditingValue(
                text: _value[0],
                selection: TextSelection.fromPosition(
                  TextPosition(
                    affinity: TextAffinity.downstream,
                    offset: _listControllerText[_index].text.length,
                  ),
                ),
              );
              _next(_index++);
              _value = _value.substring(1);
            }

            if (_listControllerText[widget.length - 1].value.text.length == 1 &&
                _getInputVerify().length == widget.length) {
              widget.onEditing(false);
              widget.onCompleted(_getInputVerify());
            }
          }
        },
      ),
    );
  }

  void _next(int index) {
    if (index != widget.length - 1) {
      setState(() {
        _currentIndex = index + 1;
      });
      FocusScope.of(context).requestFocus(_listFocusNode[_currentIndex]);
    }
  }

  void _prev(int index) {
    if (index > 0) {
      setState(() {
        if (_listControllerText[index].text.isEmpty) {}
        _currentIndex = index - 1;
      });
      FocusScope.of(context).requestFocus(FocusNode());
      FocusScope.of(context).requestFocus(_listFocusNode[_currentIndex]);
    }
  }

  List<Widget> _buildListWidget() {
    List<Widget> listWidget = [];
    for (int index = 0; index < widget.length; index++) {
      double left = (index == 0) ? 0.0 : (widget.itemSize / 10);
      listWidget.add(Padding(
        padding: widget.margin,
        child: Container(
            height: widget.itemSize,
            width: widget.itemSize,
            margin: EdgeInsets.only(left: left),
            child: _buildInputItem(index)),
      ));
    }
    return listWidget;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildListWidget(),
            ),
            widget.clearAll != null
                ? _clearAllWidget(widget.clearAll)
                : const SizedBox(),
          ],
        ));
  }

  void _pasteFromClipboard() async {
    final txt = await _fromClipboard();
    final int txtLength = txt.length;

    widget.onEditing(true);
    for (var i = 0; i < widget.length; i++) {
      _listControllerText[i].text = txtLength > i ? txt[i] : '';
    }
    setState(() {
      _currentIndex = widget.length - 1;
      if (txtLength >= widget.length) {
        widget.onCompleted(_getInputVerify());
      }
      FocusScope.of(context).requestFocus(_listFocusNode[widget.length - 1]);
    });
    widget.onEditing(false);
  }

  Future<String> _fromClipboard() async {
    ClipboardData? cdata = await Clipboard.getData(Clipboard.kTextPlain);
    return cdata?.text ?? '';
  }

  Widget _clearAllWidget(child) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        widget.onEditing(true);
        for (var i = 0; i < widget.length; i++) {
          _listControllerText[i].text = '';
        }
        setState(() {
          _currentIndex = 0;
          FocusScope.of(context).requestFocus(_listFocusNode[0]);
        });
        widget.onEditing(false);
      },
      child: child,
    );
  }
}
