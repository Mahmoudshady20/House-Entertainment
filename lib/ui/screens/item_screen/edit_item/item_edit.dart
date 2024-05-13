import 'package:flutter/material.dart';
import 'package:houseenterainment/database/mydatabase.dart';
import 'package:houseenterainment/provider/auth_provider.dart';
import 'package:houseenterainment/ui/component/shared/custom_form_field.dart';
import 'package:houseenterainment/ui/component/shared/email_background.dart';
import 'package:provider/provider.dart';

import '../../../../database/model/item.dart';
import '../../../../provider/category_provider.dart';
import '../../../../provider/item_provider.dart';
import '../../../component/utils/date_utils.dart';

class ItemEdit extends StatefulWidget {
  const ItemEdit({super.key});
  static const String routeName = 'itemCategory';

  @override
  State<ItemEdit> createState() => _ItemEditState();
}

class _ItemEditState extends State<ItemEdit> {
  TextEditingController nameController = TextEditingController();

  TextEditingController consumerController = TextEditingController();

  TextEditingController wholesaleController = TextEditingController();

  TextEditingController quantityController = TextEditingController();

  TextEditingController quantityUnitController = TextEditingController();

  DateTime productionDate = DateTime.now();

  DateTime expiredDate = DateTime.now();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AuthProviderr authProviderr = Provider.of<AuthProviderr>(context);
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);
    ItemProvider itemProvider = Provider.of<ItemProvider>(context);
    nameController.text = itemProvider.item?.productName ?? '';
    consumerController.text = itemProvider.item?.customerPrice.toString() ?? '';
    wholesaleController.text = itemProvider.item?.wholesalePrice.toString() ?? '';
    quantityUnitController.text = itemProvider.item?.weightUnit ?? '';
    quantityController.text = itemProvider.item?.quantity.toString() ?? '';
    return AllBackground(
        padding: 0,
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: const Text('Edit Item'),
            ),
            body: Container(
              margin: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Center(
                          child: Text('Edit Item',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 24))),
                      const Text('Item Name',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 18)),
                      CustomFormField(
                          label: 'Enter Item Name',
                          controller: nameController,
                          radius: 18,
                          validator: (value) {
                            if (value == null || value
                                .trim()
                                .isEmpty) {
                              return 'Please enter Item name';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 6,
                      ),
                      const Text('Wholesale Price',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 18)),
                      CustomFormField(
                          label: 'Enter Wholesale Price',
                          controller: wholesaleController,
                          textInputType: TextInputType.number,
                          radius: 18,
                          validator: (value) {
                            if (value == null || value
                                .trim()
                                .isEmpty) {
                              return 'Please enter Wholesale Price';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 6,
                      ),
                      const Text('Consumer Price',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 18)),
                      CustomFormField(
                          label: 'Enter Consumer Price',
                          controller: consumerController,
                          radius: 18,
                          textInputType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value
                                .trim()
                                .isEmpty) {
                              return 'Please enter Consumer Price';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 6,
                      ),
                      const Text('Quantity',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 18)),
                      CustomFormField(
                          label: 'Enter Quantity',
                          controller: quantityController,
                          radius: 18,
                          textInputType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value
                                .trim()
                                .isEmpty) {
                              return 'Please enter Quantity';
                            }
                            return null;
                          }),
                      const Text('Weight Unit',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 18)),
                      CustomFormField(
                          label: 'Weight Unit',
                          controller: quantityUnitController,
                          radius: 18,
                          validator: (value) {
                            if (value == null || value
                                .trim()
                                .isEmpty) {
                              return 'Please enter Weight Unit';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 6,
                      ),
                      const Text(
                        'Select Expiry Date',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                      InkWell(
                          onTap: () {
                            showExpiryDate();
                          },
                          child: Center(
                              child: Text(
                                  MyDateUtils.formatTaskDate(expiredDate),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 24)))),
                      const SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                          onPressed: () async{
                            Item item = Item(
                                productName: nameController.text,
                                id: itemProvider.item!.id,
                                weightUnit: quantityUnitController.text,
                                customerPrice: double.parse(consumerController.text),
                                wholesalePrice: double.parse(wholesaleController.text),
                                quantity: double.parse(quantityController.text),
                                expiryDate: MyDateUtils.dateOnly(expiredDate),
                            );
                            itemProvider.updateItem(item);
                            await MyDataBase.editItem(authProviderr.myUser!.id ?? '', categoryProvider.categories?.id ?? '', itemProvider.item!);
                            Navigator.pop(context);
                          },
                        child: const Text(
                          'Save',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),)
                    ],
                  ),
                ),
              ),
            )));
  }

  void showExpiryDate() async {
    var date = await showDatePicker(
        context: context,
        initialDate: expiredDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 1095)));
    if (date == null) {
      return;
    }
    expiredDate = date;
    setState(() {});
  }
}
