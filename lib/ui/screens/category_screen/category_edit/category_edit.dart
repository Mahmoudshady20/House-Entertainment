import 'package:flutter/material.dart';
import 'package:houseenterainment/database/model/categories.dart';
import 'package:houseenterainment/database/mydatabase.dart';
import 'package:houseenterainment/provider/auth_provider.dart';
import 'package:houseenterainment/ui/component/shared/custom_form_field.dart';
import 'package:houseenterainment/ui/component/shared/email_background.dart';
import 'package:provider/provider.dart';

import '../../../../provider/category_provider.dart';

class CategoryEdit extends StatelessWidget {
  CategoryEdit({super.key});
  static const String routeName = 'editCategory';
  final TextEditingController nameEditController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AuthProviderr authProviderr = Provider.of<AuthProviderr>(context);
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);
    nameEditController.text = categoryProvider.categories?.name ?? '';
    return AllBackground(
        padding: 0,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
                'Edit Category ${categoryProvider.categories?.name ?? ''}'),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CustomFormField(
                  radius: 18,
                  label: 'Name',
                  controller: nameEditController,
                  validator: (text) {
                    if (text!.trim().isEmpty) {
                      return 'Please enter valid Name';
                    }
                    if (text.isEmpty) {
                      return 'Please enter Name';
                    }
                    return null;
                  },
                ),
                Container(
                  margin: const EdgeInsets.all(12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12)),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                    onPressed: (){
                      Categories categories = Categories(
                          name: nameEditController.text,
                          id: categoryProvider.categories!.id
                      );
                      categoryProvider.updateCategory(categories);
                      MyDataBase.editCategory(authProviderr.myUser!.id ?? '', categoryProvider.categories!);
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
