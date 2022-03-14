import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/products.dart';
import '../Providers/product.dart';

class EditProdcutScreen extends StatefulWidget {
  static const routename = '/editProdcutScreen';
  const EditProdcutScreen({Key? key}) : super(key: key);

  @override
  State<EditProdcutScreen> createState() => _EditProdcutScreenState();
}

class _EditProdcutScreenState extends State<EditProdcutScreen> {
  final urlcontroller = TextEditingController();
  final imageUrulfoucsnode = FocusNode();
  final formkey = GlobalKey<FormState>();
  var enteredProdct =
      Product(title: '', id: '', price: 0, description: '', imageUrl: '');
  var initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': ''
  };
  @override
  void initState() {
    imageUrulfoucsnode.addListener(updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    imageUrulfoucsnode.removeListener(updateImageUrl);
    imageUrulfoucsnode.dispose();
    urlcontroller.dispose();
    super.dispose();
  }

  void updateImageUrl() {
    if (!imageUrulfoucsnode.hasFocus) {
      if (urlcontroller.text.isEmpty ||
          (!urlcontroller.text.startsWith('http') &&
              !urlcontroller.text.startsWith('https'))) {
        return;
      }
      setState(() {});
    }
  }

  void submitForm() {
    final isValid = formkey.currentState!.validate();
    if (!isValid) {
      return;
    }
    formkey.currentState!.save();
    if (enteredProdct.id != '') {
      Provider.of<Products>(context, listen: false)
          .updateProdcut(enteredProdct.id, enteredProdct);
    } else {
      Provider.of<Products>(context, listen: false).addProduct(enteredProdct);
    }

    Navigator.of(context).pop();
  }

  var isInit = true;

  @override
  void didChangeDependencies() {
    if (isInit) {
      final prodid = ModalRoute.of(context)!.settings.arguments as String?;
      if (prodid != null) {
        enteredProdct =
            Provider.of<Products>(context, listen: false).findbyID(prodid);
        initValues = {
          'title': enteredProdct.title,
          'description': enteredProdct.description,
          'price': enteredProdct.price.toString(),
          'imageUrl': ''
        };
        urlcontroller.text = enteredProdct.imageUrl;
      }
    }
    isInit = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: submitForm,
        child: const Icon(Icons.save),
      ),
      appBar: AppBar(
        title: const Text('Edit Prodcut'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formkey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: initValues['title'],
                decoration: const InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) return 'Please Enter a value';
                },
                onSaved: (value) {
                  enteredProdct = Product(
                      isFavorite: enteredProdct.isFavorite,
                      title: value!,
                      id: enteredProdct.id,
                      price: enteredProdct.price,
                      description: enteredProdct.description,
                      imageUrl: enteredProdct.imageUrl);
                },
              ),
              TextFormField(
                initialValue: initValues['price'],
                decoration: const InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter a Price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please Enter a valid Price';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Please Enter a nubmber greater than 0';
                  }
                  return null;
                },
                onSaved: (value) {
                  enteredProdct = Product(
                      isFavorite: enteredProdct.isFavorite,
                      title: enteredProdct.title,
                      id: enteredProdct.id,
                      price: double.parse(value!),
                      description: enteredProdct.description,
                      imageUrl: enteredProdct.imageUrl);
                },
              ),
              TextFormField(
                initialValue: initValues['description'],
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
                maxLength: 300,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter a value';
                  }
                  if (value.length < 10) {
                    return 'Description should be more than 10 letters';
                  }
                  return null;
                },
                onSaved: (value) {
                  enteredProdct = Product(
                      isFavorite: enteredProdct.isFavorite,
                      title: enteredProdct.title,
                      id: enteredProdct.id,
                      price: enteredProdct.price,
                      description: value!,
                      imageUrl: enteredProdct.imageUrl);
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(top: 8, right: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey)),
                      child: urlcontroller.text.isEmpty
                          ? const Text('Enter a URL')
                          : FittedBox(
                              fit: BoxFit.contain,
                              child: Image.network(urlcontroller.text),
                            )),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: urlcontroller,
                      focusNode: imageUrulfoucsnode,
                      onFieldSubmitted: (_) => submitForm(),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter an URL';
                        }
                        if (!value.startsWith('http') &&
                            !value.startsWith('https')) {
                          return 'Please enter a valid URL';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        enteredProdct = Product(
                            title: enteredProdct.title,
                            id: enteredProdct.id,
                            price: enteredProdct.price,
                            description: enteredProdct.description,
                            imageUrl: value!);
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
