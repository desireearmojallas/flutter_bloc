// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_bloc_tutorial/features/home/bloc/home_bloc.dart';
import 'package:flutter_bloc_tutorial/features/home/models/home_product_data_model.dart';

class ProductTileWidget extends StatefulWidget {
  final ProductDataModel productDataModel;
  final HomeBloc homeBloc;
  const ProductTileWidget({
    super.key,
    required this.productDataModel,
    required this.homeBloc,
  });

  @override
  State<ProductTileWidget> createState() => _ProductTileWidgetState();
}

class _ProductTileWidgetState extends State<ProductTileWidget> {
  bool isInCart = false;
  bool isInWishlist = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.productDataModel.imageUrl))),
          ),
          const SizedBox(height: 20),
          Text(
            widget.productDataModel.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(widget.productDataModel.description),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${widget.productDataModel.price}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      widget.homeBloc.add(HomeProductWishlistButtonClickedEvent(
                          clickedProduct: widget.productDataModel));
                      setState(() {
                        isInWishlist = !isInWishlist;
                      });
                    },
                    icon: Icon(
                        isInWishlist ? Icons.favorite : Icons.favorite_border,
                        color: isInWishlist ? Colors.red : null),
                  ),
                  IconButton(
                    onPressed: () {
                      widget.homeBloc.add(HomeProductCartButtonClickedEvent(
                          clickedProduct: widget.productDataModel));
                      setState(() {
                        isInCart = !isInCart;
                      });
                    },
                    icon: Icon(
                        isInCart
                            ? Icons.shopping_bag
                            : Icons.shopping_bag_outlined,
                        color: isInCart ? Colors.blue : null),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
