// import 'package:flutter/material.dart';
import 'package:demo/fake_store/core/loading.dart';
import 'package:demo/fake_store/presentation/cart_contrller.dart';
import 'package:demo/fake_store/presentation/home_screen/model/home_screen_model.dart';
import 'package:demo/fake_store/presentation/home_screen/widget/add.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class CartItemCard extends StatelessWidget {
  const CartItemCard({
    super.key,
    required this.item,
  });

  final ProductModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusDirectional.circular(15),
      ),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                item.image,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return const Center(
                    child: CustomLoadingIndicator(),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        context.read<CartController>().deleteItemFromCart(item);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Item removed from cart'),
                        ));
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
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
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
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
        ],
      ),
    );
  }
}