import 'package:flutter/material.dart';
import 'package:houseenterainment/database/model/categories.dart';
import 'package:houseenterainment/database/mydatabase.dart';
import 'package:houseenterainment/provider/auth_provider.dart';
import 'package:houseenterainment/provider/category_provider.dart';
import 'package:houseenterainment/ui/component/utils/dialog_utils.dart';
import 'package:houseenterainment/ui/screens/category_screen/category_edit/category_edit.dart';
import 'package:houseenterainment/ui/screens/item_screen/item_view.dart';
import 'package:provider/provider.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key,required this.categories});
  final Categories categories;
  @override
  Widget build(BuildContext context) {
    AuthProviderr authProviderr = Provider.of<AuthProviderr>(context);
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      height: MediaQuery.of(context).size.height *.2,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(categories.name ?? '',style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 24,
          ),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              /// widget for edit
              InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: (){
                  DialogUtils.showWarning(context, 'Do you want to edit the Category?',postActionName: 'ok',posAction: () async{
                    categoryProvider.updateCategory(categories);
                    Navigator.pushNamed(context, CategoryEdit.routeName);
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * .13,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.black),
                  ),
                  child: const Icon(Icons.edit),
                ),
              ),
              /// widget for delete
              InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () async{
                  DialogUtils.showWarning(context, 'Do you want to delete the Category?',postActionName: 'ok',posAction: () async{
                    await MyDataBase.deleteCategory(authProviderr.myUser?.id ?? '', categories);
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * .13,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.black),
                  ),
                  child: const Icon(Icons.delete),
                ),
              ),
              /// widget for go item page
              InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: (){
                  categoryProvider.updateCategory(categories);
                  Navigator.pushNamed(context, ItemScreen.routeName);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * .13,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.black),
                  ),
                  child: const Icon(Icons.arrow_forward),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
