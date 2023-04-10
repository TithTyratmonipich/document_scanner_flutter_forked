import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextDialog extends StatefulWidget {
  final String title;
  final String confirmButtonTitle;
  final String cancelButtonTitle;
  final Function(String) onPress1;
  final VoidCallback onPress2;

  TextDialog({
    Key? key,
    required this.title,
    required this.confirmButtonTitle,
    required this.cancelButtonTitle,
    required this.onPress1,
    required this.onPress2,
  }) : super(key: key);

  @override
  _TextDialogState createState() => _TextDialogState();
}

class _TextDialogState extends State<TextDialog> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? _showIOSDialog(
            context,
            widget.title,
            widget.onPress1,
            widget.onPress2,
            textEditingController,
          )
        : _showAndroidDialog(
            context,
            widget.title,
            widget.onPress1,
            widget.onPress2,
            textEditingController,
          );
  }

  CupertinoAlertDialog _showIOSDialog(
    BuildContext context,
    String title,
    Function(String) onPress1,
    VoidCallback onPress2,
    TextEditingController textEditingController,
  ) {
    return CupertinoAlertDialog(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.3,
        ),
      ),
      content: Card(
        color: Colors.transparent,
        elevation: 0,
        child: Container(
          height: 75,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: textEditingController,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 10),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () => onPress1(textEditingController.text),
          child: Text(
            widget.confirmButtonTitle,
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
        ),
        CupertinoDialogAction(
          onPressed: onPress2,
          child: Text(
            widget.cancelButtonTitle,
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }

  AlertDialog _showAndroidDialog(
    BuildContext context,
    String title,
    Function(String) onPress1,
    VoidCallback onPress2,
    TextEditingController textEditingController,
  ) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.3,
        ),
      ),
      content: Container(
        height: 75,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: textEditingController,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 10),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1, color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => onPress1(textEditingController.text),
          child: Text(
            widget.confirmButtonTitle,
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
        ),
        TextButton(
          onPressed: onPress2,
          child: Text(
            widget.cancelButtonTitle,
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
