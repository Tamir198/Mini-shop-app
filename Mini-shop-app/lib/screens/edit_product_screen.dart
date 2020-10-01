import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  static const String routName = "EditProductScreenRout";

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  FocusNode _priceFocusNode = FocusNode();
  FocusNode _descriptionFocusNode = FocusNode();

  //Focus nodes must be cleared or they will stay in memory
  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit product")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: "Title"),
                //What icon will be displayed on the bottom of the soft keyboard
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (value) {
                  //When the next button in keyboard is pressed change the focus to another text input
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Price"),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
              ),
              TextFormField(
                  decoration: InputDecoration(labelText: "Description"),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  focusNode: _descriptionFocusNode),
            ],
          ),
        ),
      ),
    );
  }
}
