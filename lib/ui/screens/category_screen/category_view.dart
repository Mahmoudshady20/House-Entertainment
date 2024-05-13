import 'package:flutter/material.dart';
import 'package:houseenterainment/database/mydatabase.dart';
import 'package:houseenterainment/provider/auth_provider.dart';
import 'package:houseenterainment/ui/component/shared/email_background.dart';
import 'package:houseenterainment/ui/component/utils/dialog_utils.dart';
import 'package:houseenterainment/ui/screens/category_screen/component/category_item.dart';
import 'package:houseenterainment/ui/screens/category_screen/component/show_bottomsheet.dart';
import 'package:houseenterainment/ui/screens/login_screen/login_view.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});
  static const String routeName = 'categoryScreen';

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    AuthProviderr authProvider = Provider.of<AuthProviderr>(context);
    return AllBackground(
      padding: 0,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          title: const Text('bayt altasali'),
          backgroundColor: const Color(0xFF0099FF),
        ),
        floatingActionButton: FloatingActionButton(
          shape: const StadiumBorder(
              side: BorderSide(color: Colors.white, width: 5)),
          onPressed: () {
            addCategoryBottomSheet();
          },
          child: const Icon(Icons.add, size: 28),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: StreamBuilder(
          stream: MyDataBase.getCategories(authProvider.myUser!.id ?? ''),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            var categoriesList =
                snapshot.data?.docs.map((doc) => doc.data()).toList();
            return ListView.builder(
              itemBuilder: (context, index) =>
                  CategoryItem(categories: categoriesList![index]),
              itemCount: categoriesList?.length ?? 0,
            );
          },
        ),
        drawer: Drawer(
          child: Column(
            children: [
              Image.asset('assets/images/logo.png'),
              Text(
                'Hello ${authProvider.myUser?.name}',
                style: TextStyle(

                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .06,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.phone,
                    size: 24,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '01025823719',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              InkWell(
                onTap: () {
                  DialogUtils.showWarning(context, 'Do you want LogOut?!',
                      postActionName: 'ok', posAction: () async {
                        authProvider.signOut();
                        Navigator.pushReplacementNamed(
                            context, LoginScreen.routeName);
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.logout,
                        size: 24,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'LogOut',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
//01025823719
  void addCategoryBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) => const ShowCategoryBottomSheet(),
        showDragHandle: true,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        useSafeArea: true,
        isDismissible: true);
  }
}
