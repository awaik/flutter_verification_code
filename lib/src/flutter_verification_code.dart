import 'package:flutter/material.dart';

class VerificationCode extends StatefulWidget {
  final ValueChanged<String> onCompleted;
  final ValueChanged<bool> onEditing;
  final TextInputType keyboardType;
  final int length;
  final double itemSize;
  final BoxDecoration itemDecoration;
  final TextStyle textStyle;
  //TODO autofocus == true bug
  final bool autofocus;
  final Widget clearAll;

  VerificationCode({
    Key key,
    @required this.onCompleted,
    @required this.onEditing,
    this.keyboardType = TextInputType.number,
    this.length = 4,
    this.itemDecoration,
    this.itemSize = 50,
    this.textStyle = const TextStyle(fontSize: 25.0),
    this.autofocus = false,
    this.clearAll,
  })  : assert(length > 0),
        assert(itemSize > 0),
        assert(onCompleted != null),
        assert(onEditing != null),
        super(key: key);

  @override
  _VerificationCodeState createState() => _VerificationCodeState();
}

class _VerificationCodeState extends State<VerificationCode> {
  static final List<FocusNode> _listFocusNode = <FocusNode>[];
  final List<TextEditingController> _listControllerText =
      <TextEditingController>[];
  List<String> _code = List();
  int _currentIndex = 0;

  @override
  void initState() {
    _listFocusNode.clear();
    for (var i = 0; i < widget.length; i++) {
      _listFocusNode.add(FocusNode());
      _listControllerText.add(TextEditingController());
      _code.add('');
    }
    super.initState();
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
    bool border = (widget.itemDecoration == null);
    return TextField(
      keyboardType: widget.keyboardType,
      maxLines: 1,
      maxLength: 1,
//      enabled: _currentIndex == index,
      controller: _listControllerText[index],
      focusNode: _listFocusNode[index],
      showCursor: true,
      maxLengthEnforced: true,
      autocorrect: false,
      textAlign: TextAlign.center,
      autofocus: widget.autofocus,
      style: widget.textStyle,
      decoration: InputDecoration(
          border: (border ? null : InputBorder.none),
          counterText: "",
          contentPadding: EdgeInsets.all(((widget.itemSize * 2) / 10)),
          errorMaxLines: 1,
          fillColor: Colors.black),
//      textInputAction: TextInputAction.previous,
      onChanged: (String value) {
        if ((_currentIndex + 1) == widget.length && value.length > 0) {
          widget.onEditing(false);
        } else {
          widget.onEditing(true);
        }

        if (value.length > 0 && index < widget.length ||
            index == 0 && value.isNotEmpty) {
          if (index == widget.length - 1) {
            widget.onCompleted(_getInputVerify());
            return;
          }
          if (_listControllerText[index + 1].value.text.isEmpty) {
            _listControllerText[index + 1].value = TextEditingValue(text: "");
          }
          if (index < widget.length - 1) {
            _next(index);
          }

          return;
        }
        if (value.length == 0 && index >= 0) {
          _prev(index);
        }
      },
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
    List<Widget> listWidget = List();
    for (int index = 0; index < widget.length; index++) {
      double left = (index == 0) ? 0.0 : (widget.itemSize / 10);
      listWidget.add(Container(
          height: widget.itemSize,
          width: widget.itemSize,
          margin: EdgeInsets.only(left: left),
          decoration: widget.itemDecoration,
          child: _buildInputItem(index)));
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
                : Container(),
          ],
        ));
  }

  Widget _clearAllWidget(child) {
    return GestureDetector(
      onTap: () {
        widget.onEditing(true);
        for (var i = 0; i < widget.length; i++) {
          _listControllerText[i].text = '';
        }
        setState(() {
          _currentIndex = 0;
          FocusScope.of(context).requestFocus(_listFocusNode[0]);
        });
      },
      child: child,
    );
  }
}
