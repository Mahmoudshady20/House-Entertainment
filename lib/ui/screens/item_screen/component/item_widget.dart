import 'package:flutter/material.dart';
import 'package:houseenterainment/database/model/item.dart';
import 'package:houseenterainment/database/mydatabase.dart';
import 'package:houseenterainment/provider/auth_provider.dart';
import 'package:houseenterainment/provider/category_provider.dart';
import 'package:houseenterainment/provider/item_provider.dart';
import 'package:houseenterainment/ui/component/utils/dialog_utils.dart';
import 'package:houseenterainment/ui/screens/item_screen/edit_item/item_edit.dart';
import 'package:provider/provider.dart';
import '../../../component/utils/date_utils.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({super.key, required this.item});
  final Item item;
  @override
  Widget build(BuildContext context) {
    AuthProviderr authProviderr = Provider.of<AuthProviderr>(context);
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);
    ItemProvider itemProvider = Provider.of<ItemProvider>(context);
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Product Name : ${item.productName ?? ''}',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 22,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height *.005,
          ),
          Text(
            'Wholesale Price : ${item.wholesalePrice ?? ''}',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 22,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height *.005,
          ),
          Text(
            'Customer Price : ${item.customerPrice ?? ''}',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 22,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height *.005,
          ),
          Text(
            'Expiry Date :- ${MyDateUtils.formatTaskDate(item.expiryDate ?? DateTime.now())}',
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height *.005,
          ),
          Row(
            children: [
              Text(
                'Quantity : ${item.quantity ?? ''}  ',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 22,
                ),
              ),
              Text(
                item.weightUnit ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 22,
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height *.005,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              /// widget for edit
              InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () {
                  DialogUtils.showWarning(
                      context, 'Do you want to edit the Category?',
                      postActionName: 'ok', posAction: () async {
                    itemProvider.updateItem(item);
                    Navigator.pushNamed(context, ItemEdit.routeName);
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * .2,
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
                onTap: () async {
                  DialogUtils.showWarning(
                      context, 'Do you want to delete the Category?',
                      postActionName: 'ok', posAction: () async {
                    await MyDataBase.deleteItem(authProviderr.myUser?.id ?? '',
                        categoryProvider.categories?.id ?? '', item);
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * .2,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.black),
                  ),
                  child: const Icon(Icons.delete),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
