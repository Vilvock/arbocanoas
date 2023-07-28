import 'package:arbocanoas/res/owner_colors.dart';
import 'package:flutter/material.dart';

import '../../model/tree.dart';
import '../../res/dimens.dart';

class InfoAlertDialog extends StatefulWidget {
  String? title;
  String? content;
  Tree? tree;

  InfoAlertDialog({
    Key? key,
    this.title,
    this.content,
    this.tree
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimens.textSize5,
                      fontFamily: 'Inter',
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                          "Espécie: "),
                      TextSpan(
                          text:
                          widget.tree!.especie!,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimens.textSize5,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w800)),
                    ],
                  ),
                ),
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimens.textSize5,
                      fontFamily: 'Inter',
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                          "Dapt: "),
                      TextSpan(
                          text:
                          widget.tree!.dapt.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimens.textSize5,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w800)),
                    ],
                  ),
                ),
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimens.textSize5,
                      fontFamily: 'Inter',
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                          "H(m): "),
                      TextSpan(
                          text:
                          widget.tree!.h_m.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimens.textSize5,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w800)),
                    ],
                  ),
                ),
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimens.textSize5,
                      fontFamily: 'Inter',
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                          "DC(m): "),
                      TextSpan(
                          text:
                          widget.tree!.dc_m.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimens.textSize5,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w800)),
                    ],
                  ),
                ),
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimens.textSize5,
                      fontFamily: 'Inter',
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                          "Local: "),
                      TextSpan(
                          text:
                          widget.tree!.local,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimens.textSize5,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w800)),
                    ],
                  ),
                ),
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimens.textSize5,
                      fontFamily: 'Inter',
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                          "Efs: "),
                      TextSpan(
                          text:
                          widget.tree!.efs.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimens.textSize5,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w800)),
                    ],
                  ),
                ),
                Visibility(visible: widget.tree!.conflito1.toString() != "",child:
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimens.textSize5,
                      fontFamily: 'Inter',
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                          "Conflito 1: "),
                      TextSpan(
                          text:
                          widget.tree!.conflito1.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimens.textSize5,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w800)),
                    ],
                  ),
                )),
                Visibility(visible: widget.tree!.conflito2.toString() != "",child:
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimens.textSize5,
                      fontFamily: 'Inter',
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                          "Conflito 2: "),
                      TextSpan(
                          text:
                          widget.tree!.conflito2.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimens.textSize5,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w800)),
                    ],
                  ),
                )),
                Visibility(visible: widget.tree!.conflito3.toString() != "",child:
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimens.textSize5,
                      fontFamily: 'Inter',
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                          "Conflito 3: "),
                      TextSpan(
                          text:
                          widget.tree!.conflito3.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimens.textSize5,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w800)),
                    ],
                  ),
                )),
                Visibility(visible: widget.tree!.conflito4.toString() != "",child:
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimens.textSize5,
                      fontFamily: 'Inter',
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                          "Conflito 4: "),
                      TextSpan(
                          text:
                          widget.tree!.conflito4.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimens.textSize5,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w800)),
                    ],
                  ),
                )),
                Visibility(visible: widget.tree!.conflito5.toString() != "",child:
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimens.textSize5,
                      fontFamily: 'Inter',
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                          "Conflito 5: "),
                      TextSpan(
                          text:
                          widget.tree!.conflito5.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimens.textSize5,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w800)),
                    ],
                  ),
                )),
                Visibility(visible: widget.tree!.risco1.toString() != "",child:
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimens.textSize5,
                      fontFamily: 'Inter',
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                          "Risco 1: "),
                      TextSpan(
                          text:
                          widget.tree!.risco1.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimens.textSize5,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w800)),
                    ],
                  ),
                )),
                Visibility(visible: widget.tree!.risco2.toString() != "",child:
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimens.textSize5,
                      fontFamily: 'Inter',
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                          "Risco 2: "),
                      TextSpan(
                          text:
                          widget.tree!.risco2.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimens.textSize5,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w800)),
                    ],
                  ),
                )),
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimens.textSize5,
                      fontFamily: 'Inter',
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                          "Esq: "),
                      TextSpan(
                          text:
                          widget.tree!.esq.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimens.textSize5,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w800)),
                    ],
                  ),
                ),
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimens.textSize5,
                      fontFamily: 'Inter',
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                          "Pos: "),
                      TextSpan(
                          text:
                          widget.tree!.pos.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimens.textSize5,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w800)),
                    ],
                  ),
                ),
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimens.textSize5,
                      fontFamily: 'Inter',
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                          "Pass: "),
                      TextSpan(
                          text:
                          widget.tree!.pass.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimens.textSize5,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w800)),
                    ],
                  ),
                ),
                Visibility(visible: widget.tree!.manejo != "",child:
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimens.textSize5,
                      fontFamily: 'Inter',
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                          "Manejo: "),
                      TextSpan(
                          text:
                          widget.tree!.manejo,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimens.textSize5,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w800)),
                    ],
                  ),
                )),
                Visibility(visible: widget.tree!.bairro != "",child:
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimens.textSize5,
                      fontFamily: 'Inter',
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                          "Bairro: "),
                      TextSpan(
                          text:
                          widget.tree!.bairro,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimens.textSize5,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w800)),
                    ],
                  ),
                )),
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimens.textSize5,
                      fontFamily: 'Inter',
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                          "Latitude: "),
                      TextSpan(
                          text:
                          widget.tree!.latitude.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimens.textSize5,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w800)),
                    ],
                  ),
                ),
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimens.textSize5,
                      fontFamily: 'Inter',
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                          "Longitude: "),
                      TextSpan(
                          text:
                          widget.tree!.longitude.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimens.textSize5,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w800)),
                    ],
                  ),
                ),
                // Container(width: double.infinity, child:
                // Text(
                //   widget.content!,
                //   textAlign: TextAlign.start,
                //   style: TextStyle(
                //       fontSize: Dimens.textSize5,
                //       fontFamily: 'Inter',
                //       color: Colors.white),
                // )),
                SizedBox(height: Dimens.marginApplication),

              ],
            ),
          )),
        ]);
  }
}
