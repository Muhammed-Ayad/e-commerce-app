import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants/constants.dart';
import '../../widgets/global_method.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class UploadProductForm extends StatefulWidget {
  @override
  _UploadProductFormState createState() => _UploadProductFormState();
}

class _UploadProductFormState extends State<UploadProductForm> {
  final _formKey = GlobalKey<FormState>();
  String? categoriesList;
  var _productTitle = '';
  var _productPrice = '';
  var _productDescription = '';
  var _productQuantity = '';
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  String? _categoryValue;
  String? _brandValue;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  var _pickedImage;
  bool _isLoading = false;
  String? url;
  var uuid = Uuid();

  void _trySubmit() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      _formKey.currentState!.save();
     
    }
    if (isValid) {
      _formKey.currentState!.save();
      try {
        if (_categoryController.text.isEmpty || _brandController.text.isEmpty) {
          GlobalMethods.showErrorDialog(
            error: 'Please Enter category and brand',
            context: context,
          );
        }
        if (_pickedImage == null) {
          GlobalMethods.showErrorDialog(
              error: 'Please pick an image', context: context);
        } else {
          setState(() {
            _isLoading = true;
          });
          final ref = FirebaseStorage.instance
              .ref()
              .child('productsImages')
              .child(_productTitle + '.jpg');
          await ref.putFile(_pickedImage!);
          url = await ref.getDownloadURL();

          final User? user = _auth.currentUser;
          final _uid = user!.uid;
          final productId = uuid.v4();
          await FirebaseFirestore.instance
              .collection('products')
              .doc(productId)
              .set({
            'id': productId,
            'title': _productTitle,
            'price': _productPrice,
            'image': url,
            'category': _categoryController.text,
            'brand': _brandController.text,
            'description': _productDescription,
            'quantity': _productQuantity,
            'userId': _uid,
            'createdAt': Timestamp.now(),
            'isFavorets': false,
          });
          Navigator.canPop(context) ? Navigator.pop(context) : null;
        }
      } catch (error) {
        GlobalMethods.showErrorDialog(error: 'error :$error', context: context);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

 

  void _pickImageCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 40,
    );
    final pickedImageFile = File(pickedImage!.path);
    _cropImage(pickedImageFile.path);
  }

  void _pickImageGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    final pickedImageFile = pickedImage == null ? null : File(pickedImage.path);
    _cropImage(pickedImageFile!.path);
  }

  void _cropImage(filePath) async {
    File? cropImage = await ImageCropper.cropImage(
        sourcePath: filePath, maxHeight: 1080, maxWidth: 1080);
    if (cropImage != null) {
      setState(() {
        _pickedImage = cropImage;
      });
    }
  }

  void _removeImage() {
    setState(() {
      _pickedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        bottomSheet: Container(
          height: kBottomNavigationBarHeight * 0.8,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Material(
            color: Theme.of(context).backgroundColor,
            child: _isLoading
                ? Center(
                    child: Container(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator()))
                : ElevatedButton.icon(
                    onPressed: _trySubmit,
                    icon: Icon(Icons.upload),
                    label: Text('Upload'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black45,
                    ),
                  ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 25,
              right: 15,
              left: 15,
              bottom: 70,
            ),
            child: Container(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 9),
                            child: TextFormField(
                              key: ValueKey('Title'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a Title';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: 'Product Title',
                              ),
                              onSaved: (value) {
                                _productTitle = value!;
                              },
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: TextFormField(
                            key: ValueKey('Price \$'),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Price is Empty';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Price \$',
                            ),
                            onSaved: (value) {
                              _productPrice = value!;
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: this._pickedImage == null
                              ? Container(
                                  margin: EdgeInsets.all(10),
                                  height: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1),
                                    borderRadius: BorderRadius.circular(4),
                                    color: Theme.of(context).backgroundColor,
                                  ),
                                )
                              : Container(
                                  margin: EdgeInsets.all(10),
                                  height: 200,
                                  width: 200,
                                  child: Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).backgroundColor,
                                    ),
                                    child: Image.file(
                                      this._pickedImage,
                                      fit: BoxFit.contain,
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FittedBox(
                              child: _gradintIcon(
                                function: _pickImageCamera,
                                iconData: Icons.camera,
                                title: 'Camera',
                                color: Colors.purple,
                              ),
                            ),
                            FittedBox(
                              child: _gradintIcon(
                                function: _pickImageGallery,
                                iconData: Icons.collections,
                                title: 'Gallery',
                                color: Colors.purple,
                              ),
                            ),
                            FittedBox(
                              child: _gradintIcon(
                                function: _removeImage,
                                iconData: Icons.delete,
                                title: 'Remove',
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    _textFormFields(
                      onTap: () {
                        showCategoryDialog(
                          controller: _categoryController,
                          titleList: 'Category',
                          size: size,
                          list: Constants.categoriesList,
                        );
                      },
                      labelText: 'Category',
                      controller: _categoryController,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    _textFormFields(
                      onTap: () {
                        showCategoryDialog(
                          controller: _brandController,
                          titleList: 'BrandsList',
                          size: size,
                          list: Constants.brandsList,
                        );
                      },
                      labelText: 'Brand',
                      controller: _brandController,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      key: ValueKey('Description'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'product description is required';
                        }
                        return null;
                      },
                      maxLines: 10,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        hintText: 'Product description',
                        border: OutlineInputBorder(),
                      ),
                      onSaved: (value) {
                        _productDescription = value!;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      key: ValueKey('Quantity'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Quantity is missed';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Quantity',
                      ),
                      onSaved: (value) {
                        _productQuantity = value!;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _textFormFields({
    required Function onTap,
    required String labelText,
    required TextEditingController controller,
  }) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: TextFormField(
        enabled: false,
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Field is missing';
          }
          return null;
        },
        style: TextStyle(
            color: Colors.purple,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            fontStyle: FontStyle.italic),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: labelText,
        ),
      ),
    );
  }

  void showCategoryDialog({
    required TextEditingController controller,
    required String titleList,
    required Size size,
    required List list,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              titleList,
              style: TextStyle(color: Colors.pink.shade300, fontSize: 20),
            ),
            content: Container(
              width: size.width * 0.9,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          controller.text = list[index];
                        });
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            color: Colors.red[200],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              list[index],
                              style: TextStyle(
                                  color: Color(0xFF00325A),
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                },
                child: Text('Close'),
              ),
            ],
          );
        });
  }

  Widget _gradintIcon({
    required IconData iconData,
    required String title,
    required Color color,
    required VoidCallback function,
  }) {
    return ElevatedButton.icon(
      onPressed: function,
      icon: Icon(
        iconData,
        color: color,
      ),
      label: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: Color(0xff000000000),
        elevation: 0.0,
      ),
    );
  }
}
