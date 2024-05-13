import 'package:flutter/material.dart';
import 'package:houseenterainment/database/model/categories.dart';
import 'package:houseenterainment/database/mydatabase.dart';
import 'package:houseenterainment/provider/auth_provider.dart';
import 'package:houseenterainment/ui/component/shared/custom_form_field.dart';
import 'package:houseenterainment/ui/component/utils/dialog_utils.dart';
import 'package:provider/provider.dart';

class ShowCategoryBottomSheet extends StatefulWidget {
  const ShowCategoryBottomSheet({super.key});

  @override
  State<ShowCategoryBottomSheet> createState() => _ShowCategoryBottomSheetState();
}

class _ShowCategoryBottomSheetState extends State<ShowCategoryBottomSheet> {
  final TextEditingController nameController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.55,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
        color: Colors.white
      ),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            CustomFormField(label: 'Category Name', controller: nameController, validator: (text){
              if(text!.trim().isEmpty){
                return 'Please enter valid Name';
              }
              if(text.isEmpty){
                return 'Please enter Name';
              }
              return null;
            },
              radius: 15,
            ),
            Container(
              margin: const EdgeInsets.all(12),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: const Color(0xFF0B6EFE),
                  borderRadius: BorderRadius.circular(12)),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                onPressed:(){
                  addCategory();
                },
                child: const Text(
                  'Add Category',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  addCategory() async{
    if(formKey.currentState!.validate() == false){
      return;
    }
    try {
      DialogUtils.showLoadingDialog(context, 'Loading...');
      AuthProviderr authProvider = Provider.of<AuthProviderr>(context,listen: false);
      Categories categories = Categories(name: nameController.text);
      await MyDataBase.addCategory(authProvider.myUser?.id ?? '', categories);
      DialogUtils.hideDialog(context);
      DialogUtils.showSuccess(context, 'Category Add Successfully',dismissible: true);
    } on Exception catch (e){
      DialogUtils.showFailed(context, e.toString());
    }
    // Navigator.pop(context);
  }
}
