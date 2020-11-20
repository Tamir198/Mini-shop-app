import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const String routName = "EditProductScreenRout";

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final FocusNode _priceFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  final FocusNode _imageUrlFocusNode = FocusNode();

  bool isInitialized = true,
      _isLoading = false;

  Map<String, String> _initValues = {
    'title': ' ',
    'description': ' ',
    'price': ' ',
    'imageUrl': ' ',
  };

  //GlobalKey allowing interaction with the state of the form widget
  final _form = GlobalKey<FormState>();

  final TextEditingController _imageUrlController = TextEditingController();

  Product _editedProduct =
  Product(title: '',
      price: 0,
      imageUrl: '',
      description: '',
      id: null);

  @override
  void initState() {
    //Passing pointer and not updateImageUrl because i want flutter to execute
    //the function when _imageUrlFocusNode losing focus
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isInitialized) {
      final String productId = ModalRoute
          .of(context)
          .settings
          .arguments;
      if (productId != null) {
        _editedProduct = Provider.of<Products>(context, listen: false)
            .findProductById(productId);

        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          'imageUrl': '',
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    } else
      isInitialized = false;
    super.didChangeDependencies();
  }

  //Focus nodes must be cleared or they will stay in memory
  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  //When the image url loses focus, update the image preview
  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

   _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    if (_editedProduct.id != null) {
      await Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    } else {
      try {
         Provider.of<Products>(context, listen: false)
            .addProduct(_editedProduct);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('An error occurred!'),
            content: Text('Something went wrong.'),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
        );
      }
    }
    setState(() {
      _isLoading = true;
    });
    // Navigator.of(context).pop();
  }


@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text("Edit product")),
    body: _isLoading
        ? Center(child: CircularProgressIndicator())
        : Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _form,
        child: ListView(children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: "Title"),
            //What icon will be displayed on the bottom of the soft keyboard
            textInputAction: TextInputAction.next,
            initialValue: _initValues['title'],
            onFieldSubmitted: (value) {
              //When the next button in keyboard is pressed change the focus to another text input
              FocusScope.of(context).requestFocus(_priceFocusNode);
            },
            onSaved: (value) {
              _editedProduct = Product(
                  title: value,
                  price: _editedProduct.price,
                  id: _editedProduct.id,
                  isFavorite: _editedProduct.isFavorite,
                  imageUrl: _editedProduct.imageUrl,
                  description: _editedProduct.description);
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Cannot submit empty text';
              }
              //When returning null there was not error
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Price"),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            focusNode: _priceFocusNode,
            initialValue: _initValues['price'],
            onFieldSubmitted: (value) {
              FocusScope.of(context)
                  .requestFocus(_descriptionFocusNode);
            },
            onSaved: (value) {
              _editedProduct = Product(
                  title: _editedProduct.title,
                  price: double.parse(value),
                  id: _editedProduct.id,
                  isFavorite: _editedProduct.isFavorite,
                  imageUrl: _editedProduct.imageUrl,
                  description: _editedProduct.description);
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Cannot submit empty text';
              }
              if (double.tryParse(value) == null) {
                return 'Number is not valid';
              }
              if (double.tryParse(value) <= 0) {
                return 'Number Must not be negative';
              }
              //When returning null there was not error
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Description"),
            maxLines: 3,
            keyboardType: TextInputType.multiline,
            focusNode: _descriptionFocusNode,
            initialValue: _initValues['description'],
            onSaved: (value) {
              _editedProduct = Product(
                  title: _editedProduct.title,
                  price: _editedProduct.price,
                  id: _editedProduct.id,
                  isFavorite: _editedProduct.isFavorite,
                  imageUrl: _editedProduct.imageUrl,
                  description: value);
            },
            validator: (value) {
              if (value
                  .trim()
                  .isEmpty) {
                return 'Description cannot be empty';
              }
              //When returning null there was not error
              return null;
            },
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                  width: 100,
                  height: 100,
                  margin: EdgeInsets.only(top: 8, right: 10),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey)),
                  child: _imageUrlController.text.isEmpty
                      ? Text("Enter url")
                      : FittedBox(
                      child:
                      Image.network(_imageUrlController.text),
                      fit: BoxFit.cover)),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Image url'),
                  keyboardType: TextInputType.url,
                  textInputAction: TextInputAction.done,
                  //Without it the image preview will not work
                  onFieldSubmitted: (_) =>
                      setState(() {
                        _saveForm();
                      }),
                  //Get data of the input before the form is submitted
                  controller: _imageUrlController,
                  focusNode: _imageUrlFocusNode,

                  onSaved: (value) {
                    _editedProduct = Product(
                        title: _editedProduct.title,
                        price: _editedProduct.price,
                        id: _editedProduct.id,
                        isFavorite: _editedProduct.isFavorite,
                        imageUrl: value,
                        description: _editedProduct.description);
                  },

                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Cannot submit empty text';
                    }
                    //When returning null there was not error
                    return null;
                  },
                ),
              )
            ],
          ),
          Divider(height: 10),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
            iconSize: 50,
          ),
        ]),
      ),
    ),
  );
}}
