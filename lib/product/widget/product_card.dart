import 'package:fake_store_app/feature/home/model/product_model.dart';
import 'package:fake_store_app/product/padding/page_padding.dart';
import 'package:fake_store_app/product/utility/image/project_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key, this.model}) : super(key: key);

  final ProductModel? model;
  @override
  Widget build(BuildContext context) {
    if (model == null) const SizedBox.shrink();

    return Padding(
      padding: PagePadding.all(),
      child: Card(
        child: ListTile(
          contentPadding: PagePadding.all(),
          title: SizedBox(
              height: context.dynamicHeight(0.5),
              child: ProjectNetworkImage.network(src: model?.image)),
          subtitle: Text(model.toString(), style: context.textTheme.headline6),
        ),
      ),
    );
  }
}
