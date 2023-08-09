import 'package:arbocanoas/res/owner_colors.dart';
import 'package:flutter/material.dart';

import '../../model/tree.dart';
import '../../res/dimens.dart';
import '../../res/styles.dart';

class FilterAlertDialog extends StatefulWidget {
  TextEditingController speciesController;
  TextEditingController localController;
  TextEditingController managementController;
  TextEditingController nbhController;

  FilterAlertDialog(
      {Key? key,
      required this.speciesController,
      required this.localController,
      required this.managementController,
      required this.nbhController});

  // DialogGeneric({Key? key}) : super(key: key);

  @override
  State<FilterAlertDialog> createState() => _FilterAlertDialogState();
}

class _FilterAlertDialogState extends State<FilterAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                color: OwnerColors.colorPrimaryDark,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      Dimens.paddingApplication,
                      Dimens.paddingApplication,
                      Dimens.paddingApplication,
                      MediaQuery.of(context).viewInsets.bottom +
                          Dimens.paddingApplication),
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

                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                widget.speciesController.text = "";
                                widget.localController.text = "";
                                widget.managementController.text = "";
                                widget.nbhController.text = "";

                              });
                            },
                            child: Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(Dimens
                                      .minRadiusApplication),
                                ),
                                child: Container(
                                    padding: EdgeInsets.all(Dimens
                                        .minPaddingApplication),
                                    child: Text(
                                      "Limpar filtros",
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize:
                                        Dimens.textSize5,
                                        color: OwnerColors.colorPrimaryDark,
                                      ),
                                    ))),
                          ),
                        ),
                      ),
                      Text(
                        "Filtro avançado",
                        style: TextStyle(
                            fontSize: Dimens.textSize7,
                            fontFamily: 'Inter',
                            color: Colors.white,
                            fontWeight: FontWeight.w900),
                      ),
                      SizedBox(height: Dimens.marginApplication),
                      TextField(
                        controller: widget.speciesController,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: OwnerColors.colorPrimary, width: 1.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          hintText: 'Espécie',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(Dimens.radiusApplication),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.all(
                              Dimens.textFieldPaddingApplication),
                        ),
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: Dimens.textSize5,
                        ),
                      ),
                      SizedBox(height: Dimens.marginApplication),
                      TextField(
                        controller: widget.localController,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: OwnerColors.colorPrimary, width: 1.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          hintText: 'Local',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(Dimens.radiusApplication),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.all(
                              Dimens.textFieldPaddingApplication),
                        ),
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: Dimens.textSize5,
                        ),
                      ),
                      SizedBox(height: Dimens.marginApplication),
                      TextField(
                        controller: widget.managementController,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: OwnerColors.colorPrimary, width: 1.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          hintText: 'Manejo',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(Dimens.radiusApplication),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.all(
                              Dimens.textFieldPaddingApplication),
                        ),
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: Dimens.textSize5,
                        ),
                      ),
                      SizedBox(height: Dimens.marginApplication),
                      TextField(
                        controller: widget.nbhController,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: OwnerColors.colorPrimary, width: 1.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          hintText: 'Bairro',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(Dimens.radiusApplication),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.all(
                              Dimens.textFieldPaddingApplication),
                        ),
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: Dimens.textSize5,
                        ),
                      ),
                      SizedBox(height: Dimens.marginApplication),
                      Container(
                        margin: EdgeInsets.only(top: Dimens.marginApplication),
                        width: double.infinity,
                        child: ElevatedButton(
                          style: Styles().styleDefaultButton,
                          onPressed: () {
                            if (widget.speciesController.text.isEmpty &&
                                widget.localController.text.isEmpty &&
                                widget.managementController.text.isEmpty &&
                                widget.nbhController.text.isEmpty) {
                              return;
                            }

                            Navigator.of(context).pop(true);
                          },
                          child: Text("Filtrar",
                              style: Styles().styleDefaultTextButton),
                        ),
                      ),
                    ],
                  ),
                ))
          ]),
    );
  }
}
