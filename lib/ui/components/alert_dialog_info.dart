import 'package:arbocanoas/res/owner_colors.dart';
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
          Container(color: OwnerColors.colorPrimaryDark, child: Padding(
            padding: const EdgeInsets.all(Dimens.paddingApplication),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )),
                Row(children: [

                  Image.asset('images/tree_icon.png', height: 48,),

                  SizedBox(width: Dimens.marginApplication),
                  Text(
                    widget.title!,
                    style: TextStyle(
                        fontSize: Dimens.textSize7,
                        fontFamily: 'Inter',
                        color: Colors.white,
                    fontWeight: FontWeight.w900),
                  ),
                ],),

                SizedBox(height: Dimens.marginApplication),
                Container(width: double.infinity, child:
                Text(
                  widget.content!,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: Dimens.textSize5,
                      fontFamily: 'Inter',
                      color: Colors.white),
                )),
                SizedBox(height: Dimens.marginApplication),

              ],
            ),
          )),
        ]);
  }
}
