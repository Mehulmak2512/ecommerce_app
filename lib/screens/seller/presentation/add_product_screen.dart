import 'dart:io';
import 'package:ecommerce_app/common/custom_appbar_background.dart';
import 'package:ecommerce_app/common/custom_textfield.dart';
import 'package:ecommerce_app/constants/constant_colors.dart';
import 'package:ecommerce_app/screens/seller/controller/seller_dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class AddProductScreen extends HookConsumerWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;


    final productNameController = useTextEditingController();
    final productPriceController = useTextEditingController();
    final productQuantityController = useTextEditingController();
    final isLoading = useValueNotifier(false);
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final imageFile = useValueNotifier<File?>(null);
    var imageUrl = useState<String?>(null);

    useEffect(() {
      productNameController.text = arg?["name"].toString() ?? "";
      productPriceController.text = arg?["price"].toString() ?? "";
      productQuantityController.text = arg?["quantity"].toString() ?? "";
      imageUrl.value = arg?["image_url"].toString();
      return;
    }, []);

    void pickImage() async {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedFile?.path != null) {
        imageFile.value = File(pickedFile!.path);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
        arg == null ?  "Add Product" : "Update Product",
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, letterSpacing: 1.2, color: ConstantColors.white),
        ),
        centerTitle: true,
        flexibleSpace: const CustomAppBarBackground(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  CustomTextField(
                    labelText: "Product Name",
                    errorText: "product name",
                    controller: productNameController,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomTextField(
                    labelText: "Product price",
                    errorText: "product price",
                    controller: productPriceController,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomTextField(
                    labelText: "Product Quantity",
                    errorText: "product Quantity",
                    controller: productQuantityController,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () {
                      pickImage();
                    },
                    child: ValueListenableBuilder(
                      valueListenable: imageFile,
                      builder: (BuildContext context, value, Widget? child) {
                        return Builder(builder: (context) {
                          return ValueListenableBuilder(
                            valueListenable: imageUrl,
                            builder: (context, imageValue, child) {
                              return Container(
                                height: 200,
                                width: double.infinity,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(color: ConstantColors.grey),
                                  borderRadius: BorderRadius.circular(20),
                                  image: value != null
                                      ? DecorationImage(image: FileImage(value), fit: BoxFit.contain)
                                      : imageValue != null
                                          ? DecorationImage(image: NetworkImage(imageValue), fit: BoxFit.contain)
                                          : null,
                                ),
                                child: value != null || imageValue != null
                                    ? null
                                    : Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.add,
                                            color: ConstantColors.grey,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Click here to pick a image",
                                            style: TextStyle(
                                              fontSize: 19,
                                              color: ConstantColors.grey,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        ],
                                      ),
                              );
                            },
                          );
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 55,
                  ),
                  ValueListenableBuilder(
                    valueListenable: isLoading,
                    builder: (context, value, child) {
                      return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: ConstantColors.pinkAccentShade200,
                              fixedSize: const Size(double.maxFinite, 50),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                          onPressed: () {
                            if (formKey.currentState?.validate() ?? false) {
                              isLoading.value = true;

                              if (arg == null) {
                                if (imageFile.value == null) {
                                  isLoading.value = false;
                                  Fluttertoast.showToast(msg: "Please pick a image");
                                  return;
                                }
                                ref
                                    .read(sellerDashBoardControllerProvider.notifier)
                                    .addProduct(
                                      name: productNameController.text,
                                      price: productPriceController.text,
                                      quantity: int.parse(productQuantityController.text),
                                      image: imageFile.value,
                                    )
                                    .then((value) {
                                  Navigator.pop(context);
                                }).whenComplete(() {
                                  isLoading.value = false;
                                });
                              } else {
                                final data = {
                                  "id": arg["id"].toString(),
                                  "name": productNameController.text.toString(),
                                  "price": productPriceController.text.toString(),
                                  "quantity": int.parse(productQuantityController.text),
                                };
                                ref.read(sellerDashBoardControllerProvider.notifier).updateProduct(data: data,imageUrl:  imageUrl.value,imageFile:  imageFile.value).catchError((e) {
                                  Fluttertoast.showToast(msg: "something went wrong");
                                }).then((value) {
                                  Navigator.pop(context);
                                }).whenComplete(() {
                                  isLoading.value = false;
                                });
                              }
                            }
                          },
                          child: value
                              ? const CircularProgressIndicator(
                                  color: ConstantColors.white,
                                )
                              : Text(
                                  "Save",
                                  style: TextStyle(
                                      color: ConstantColors.white, fontWeight: FontWeight.bold, letterSpacing: 1.1, fontSize: 18),
                                ));
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
