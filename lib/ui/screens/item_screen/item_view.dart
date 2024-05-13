import 'package:flutter/material.dart';
import 'package:houseenterainment/provider/auth_provider.dart';
import 'package:houseenterainment/provider/category_provider.dart';
import 'package:houseenterainment/ui/component/shared/email_background.dart';
import 'package:houseenterainment/ui/screens/item_screen/add_item/add_item_screen.dart';
import 'package:houseenterainment/ui/screens/item_screen/component/item_widget.dart';
import 'package:provider/provider.dart';

import '../../../database/mydatabase.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen({super.key});
  static const String routeName = 'itemScreen';

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  @override
  Widget build(BuildContext context) {
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);
    AuthProviderr authProviderr = Provider.of<AuthProviderr>(context);
    return AllBackground(
        padding: 0,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            title: Text(categoryProvider.categories?.name ?? ''),
            backgroundColor: const Color(0xFF0099FF),
          ),
          floatingActionButton: FloatingActionButton(
            shape: const StadiumBorder(
                side: BorderSide(color: Colors.white, width: 5)),
            onPressed: () {
              Navigator.pushNamed(context, AddItemScreen.routeName);
            },
            child: const Icon(Icons.add, size: 28),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          body: StreamBuilder(
            stream: MyDataBase.getItems(authProviderr.myUser?.id ?? '', categoryProvider.categories?.id ?? ''),
            builder: (context, snapshot) {
              if(snapshot.hasError){
                return Text(snapshot.error.toString());
              }
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator(),);
              }
              var itemList = snapshot.data?.docs.map((doc) => doc.data()).toList();
              return ListView.builder(itemBuilder: (context, index) => ItemWidget(item: itemList![index]),itemCount: itemList?.length ?? 0,);
            },
          ),
        ),
    );
  }
}
