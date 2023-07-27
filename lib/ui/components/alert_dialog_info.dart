import 'package:flutter/material.dart';

import '../../res/dimens.dart';

class InfoAlertDialog extends StatefulWidget {
  String? title;
  String? content;

  InfoAlertDialog({
    Key? key,
    this.title,
    this.content,
  });

  // DialogGeneric({Key? key}) : super(key: key);

  @override
  State<InfoAlertDialog> createState() => _InfoAlertDialogState();
}

class _InfoAlertDialogState extends State<InfoAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(Dimens.paddingApplication),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )),
                Text(
                  widget.title!,
                  style: TextStyle(
                      fontSize: Dimens.textSize7,
                      fontFamily: 'Inter',
                      color: Colors.black),
                ),
                SizedBox(height: Dimens.marginApplication),
                Text(
                  widget.content!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: Dimens.textSize5,
                      fontFamily: 'Inter',
                      color: Colors.black),
                ),
                SizedBox(height: Dimens.marginApplication),

              ],
            ),
          ),
        ]);
  }
}
