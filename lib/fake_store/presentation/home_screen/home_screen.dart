// import 'dart:developer';
// import 'package:demo/fake_store/core/appbar.dart';
// import 'package:demo/fake_store/presentation/home_screen/controller/home_screen_controller.dart';
// import 'package:demo/fake_store/presentation/home_screen/widget/item_widget.dart';
// import 'package:demo/fake_store/presentation/item_view.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       fetchData();
//     });
//   }

//   void fetchData() {
//     Provider.of<HomeScreenController>(context, listen: false)
//         .fetchData(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: GLAppBar(
//         title: "SHOP",
//       ),
//       body: Consumer<HomeScreenController>(
//         builder: (context, hcontrol, child) {
//           if (hcontrol.isLoading) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           if (hcontrol.homeScreenModel.data == null ||
//               hcontrol.homeScreenModel.data!.isEmpty) {
//             return const Center(
//               child: Text("No items available"),
//             );
//           }

//           return ListView.builder(
//             itemCount: hcontrol.homeScreenModel.data!.length,
//             itemBuilder: (context, index) {
//               var item = hcontrol.homeScreenModel.data![index];
//               return SizedBox(
//                 child: InkWell(
//                   onTap: () {
//                     log("Item tapped");
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => ItemViewScreen(
//                           title:
//                               hcontrol.homeScreenModel.data?[index].title ?? "",
//                           price:
//                               hcontrol.homeScreenModel.data?[index].price ?? 0,
//                           description: hcontrol
//                                   .homeScreenModel.data?[index].description ??
//                               "",
//                           imageUrl:
//                               hcontrol.homeScreenModel.data?[index].image ?? "",
//                         ),
//                       ),
//                     );
//                   },
//                   child: ItemCard(
//                     title: hcontrol.homeScreenModel.data?[index].title ?? "",
//                     price: hcontrol.homeScreenModel.data?[index].price ?? 0,
//                     imageUrl: hcontrol.homeScreenModel.data?[index].image ?? "",
//                     rating: hcontrol.homeScreenModel.data![index].rating?.rate,
//                     size: size,
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:demo/fake_store/core/loading.dart';
import 'package:demo/fake_store/presentation/cart.dart';
import 'package:demo/fake_store/presentation/cart_contrller.dart';
import 'package:demo/fake_store/presentation/home_screen/controller/home_screen_controller.dart';
import 'package:demo/fake_store/presentation/home_screen/widget/item_widget.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:badges/badges.dart' as badges;



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<HomeScreenController>().fetchProducts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.table_restaurant),
          ),
        ),
        title: const Text('Fake Store Api'),
        actions: [
          Consumer<CartController>(
            builder: (context, cart, child) {
              return IconButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartScreen(),
                    )),
                icon: badges.Badge(
                  badgeAnimation: const badges.BadgeAnimation.scale(),
                  badgeContent: Text(
                    cart.totalCartCount.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: Colors.white),
                  ),
                  showBadge: cart.totalCartCount > 0,
                  child: const Icon(Icons.shopping_cart_rounded),
                ),
              );
            },
          ),
          const SizedBox(width: 20),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://images.pexels.com/photos/428328/pexels-photo-428328.jpeg?auto=compress&cs=tinysrgb&w=600'),
              ),
              accountName: Text('Antony Aiwin'),
              accountEmail: Text('antonyaiwin@gmail.com'),
            ),
            ...List.generate(
              10,
              (index) => const ListTile(
                title: Text('Settings'),
                leading: Icon(Icons.settings),
                trailing: Icon(Icons.arrow_right),
              ),
            ),
          ],
        ),
      ),
      body: Consumer<HomeScreenController>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return const Center(
              child: CustomLoadingIndicator(),
            );
          } else if (value.productList.isEmpty) {
            return const Center(
              child: Text('No data found'),
            );
          }
          return GridView.builder(
            padding: const EdgeInsets.all(15),
            itemBuilder: (context, index) {
              var item = value.productList[index];
              return ProductCard(item: item);
            },
            itemCount: value.productList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 9 / 12,
            ),
          );
        },
      ),
    );
  }
}