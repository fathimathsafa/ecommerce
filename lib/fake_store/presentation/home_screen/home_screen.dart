import 'dart:developer';
import 'package:demo/fake_store/core/appbar.dart';
import 'package:demo/fake_store/presentation/home_screen/controller/home_screen_controller.dart';
import 'package:demo/fake_store/presentation/home_screen/widget/item_widget.dart';
import 'package:demo/fake_store/presentation/item_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData();
    });
  }

  void fetchData() {
    Provider.of<HomeScreenController>(context, listen: false)
        .fetchData(context);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: GLAppBar(
        title: "SHOP",
      ),
      body: Consumer<HomeScreenController>(
        builder: (context, hcontrol, child) {
          if (hcontrol.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (hcontrol.homeScreenModel.data == null ||
              hcontrol.homeScreenModel.data!.isEmpty) {
            return const Center(
              child: Text("No items available"),
            );
          }

          return ListView.builder(
            itemCount: hcontrol.homeScreenModel.data!.length,
            itemBuilder: (context, index) {
              var item = hcontrol.homeScreenModel.data![index];
              return SizedBox(
                child: InkWell(
                  onTap: () {
                    log("Item tapped");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItemViewScreen(
                          title:
                              hcontrol.homeScreenModel.data?[index].title ?? "",
                          price:
                              hcontrol.homeScreenModel.data?[index].price ?? 0,
                          description: hcontrol
                                  .homeScreenModel.data?[index].description ??
                              "",
                          imageUrl:
                              hcontrol.homeScreenModel.data?[index].image ?? "",
                        ),
                      ),
                    );
                  },
                  child: ItemCard(
                    title: hcontrol.homeScreenModel.data?[index].title ?? "",
                    price: hcontrol.homeScreenModel.data?[index].price ?? 0,
                    imageUrl: hcontrol.homeScreenModel.data?[index].image ?? "",
                    rating: hcontrol.homeScreenModel.data![index].rating?.rate,
                    size: size,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
