import 'package:flutter/material.dart';
import 'package:plant_detection/features/home/presentation/widgets/category_item.dart';

class CategoryListView extends StatelessWidget {
  const CategoryListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          CategoryItem(
            imagePath:
                'assets/apple-black-silhouette-with-a-leaf_64px.png',
            label: "APPLE",
          ),
          CategoryItem(
            imagePath: 'assets/tomato_32px.png',
            label: "TOMATO",
          ),
          CategoryItem(
            imagePath: 'assets/cucumber_32px.png',
            label: "CUCUMBER",
          ),
          CategoryItem(
            imagePath: 'assets/corn_32px.png',
            label: "CORN",
          ),
          CategoryItem(
            imagePath: 'assets/menu_24px.png',
            label: "OTHER",
          ),
        ],
      ),
    );
  }
}
