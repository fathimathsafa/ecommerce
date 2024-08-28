// import 'dart:core';

// import 'package:demo/fake_store/core/text.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:intl/intl.dart';

// // import 'package:news_app_with_api/controller/home-screen_controller.dart';
// import 'package:provider/provider.dart';


// class ItemCard extends StatelessWidget {
//   const ItemCard({
//     super.key,
//     required this.title,
//     required this.price,
//     required this.imageUrl,
//     required this.rating,
//     required this.size,
//   });

//   final String? title;
//   final double? price;
//   final String? imageUrl;
//   final double? rating;
//   final Size? size;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: Colors.white24,
//           border: Border.all(width: 0.5)),
//       margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
//       padding: EdgeInsets.only(left: 10),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Column(
//             children: [
//               SizedBox(
//                   height: 150,
//                   width: 90,
//                   child: Image(image: NetworkImage(imageUrl!))),
//             ],
//           ),
//           SizedBox(
//             width: 15,
//           ),
//           Flexible(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "$title",
//                   style: GLTextStyles.titleblack18,
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 4,
//                 ),
//                 SizedBox(
//                   height: 8,
//                 ),
//                 Text(
//                   "Price : $price",
//                   style: GLTextStyles.subtitleBlk14,
//                 ),
//                 Text(
//                   " ★  $rating",
//                   style: GLTextStyles.subtitleBlk14,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo/fake_store/core/loading.dart';
import 'package:demo/fake_store/presentation/cart_contrller.dart';
import 'package:demo/fake_store/presentation/home_screen/model/home_screen_model.dart';
import 'package:demo/fake_store/presentation/home_screen/widget/add.dart';
import 'package:demo/fake_store/presentation/item_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.item,
  });

  final ProductModel item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(item: item),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadiusDirectional.circular(15),
        ),
        child: Column(
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: CachedNetworkImage(
                  imageUrl: item.image,
                  errorWidget: (context, url, error) => const Center(
                    child: Icon(Icons.error),
                  ),
                  progressIndicatorBuilder: (context, url, progress) =>
                      const CustomLoadingIndicator(),
                ),
              ),
            ),
            Text(
              item.title,
              style: Theme.of(context).textTheme.titleMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 15,
                        ),
                        Text(item.rating.rate.toString()),
                      ],
                    ),
                    Text(
                      '\$${item.price}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                    ),
                  ],
                ),
                const Spacer(),
                Consumer<CartController>(
                  builder: (context, value, child) {
                    return AddToCartButton(
                      count: value.getItemCount(item.id),
                      onTap: () {
                        value.addItemToCart(item);
                      },
                      onAddTap: () {
                        value.addItemToCart(item);
                      },
                      onRemoveTap: () {
                        value.removeItemFromCart(item);
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}