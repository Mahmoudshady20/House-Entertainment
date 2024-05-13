import 'package:flutter/material.dart';
import 'package:houseenterainment/provider/category_provider.dart';
import 'package:houseenterainment/ui/component/shared/email_background.dart';
import 'package:provider/provider.dart';

import '../../../../database/model/item.dart';
import '../../../../database/mydatabase.dart';
import '../../../../provider/auth_provider.dart';
import '../../../component/shared/custom_form_field.dart';
import '../../../component/utils/date_utils.dart';
import '../../../component/utils/dialog_utils.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});
  static const String routeName = 'addItem';

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
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
    return AllBackground(
      padding: 0,
        child: Scaffold(
          backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: const Text('Add Item'),
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
                      child: Text('Add new Item',
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
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter Item name';
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
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter Consumer Price';
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
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter Wholesale Price';
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
                        if (value == null || value.trim().isEmpty) {
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
                        if (value == null || value.trim().isEmpty) {
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
                          child: Text(MyDateUtils.formatTaskDate(expiredDate),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 24)))),
                      const SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                      onPressed: () {
                        addItemButton();
                      },
                      child: const Text('add'))
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

  void addItemButton() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    AuthProviderr authProvider =
        Provider.of<AuthProviderr>(context, listen: false);
    CategoryProvider categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    DialogUtils.showLoadingDialog(context, 'Loading...');
    Item item = Item(
        productName: nameController.text,
        weightUnit: quantityUnitController.text,
        customerPrice: double.parse(consumerController.text),
        wholesalePrice: double.parse(wholesaleController.text),
        quantity: double.parse(quantityController.text),
        expiryDate: MyDateUtils.dateOnly(expiredDate));
    await MyDataBase.addItem(authProvider.myUser?.id ?? '',
        categoryProvider.categories?.id ?? '', item);
    DialogUtils.hideDialog(context);
    DialogUtils.showSuccess(context, 'Item Added Successfully',
        dismissible: false,postActionName: 'ok', posAction: () {
          Navigator.pop(context);
        });

  }
}
