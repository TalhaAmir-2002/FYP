import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../theme/color.dart';
import '../utils/data.dart';
import '../widgets/category_item.dart';
import '../widgets/custom_textbox.dart';
import '../widgets/icon_box.dart';
import '../widgets/property_item.dart';
class favs extends StatefulWidget {
  const favs({super.key});

  @override
  State<favs> createState() => _favsState();
}

class _favsState extends State<favs> {
  List favorites = populars.where((index) => index['is_favorited'] == true).toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 10,),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top:25.0,left: 8),
                child: Text('Favorites',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 28,
                ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20,),
          _buildSearch(),
          const SizedBox(height: 20,),
          _buildCategories(),
          const SizedBox(height: 20,),
          _buildPopulars()
        ],
      ),
    );

  }
  int _selectedCategory = 0;
  Widget _buildCategories() {
    List<Widget> lists = List.generate(
      categories.length,
          (index) => CategoryItem(
        data: categories[index],
        selected: index == _selectedCategory,
        onTap: () {
          setState(() {
            _selectedCategory = index;
          });
        },
      ),
    );
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(bottom: 5, left: 15),
      child: Row(children: lists),
    );
  }
  Widget _buildPopulars() {
    return Expanded(
      child: CarouselSlider(
        options: CarouselOptions(
            enlargeCenterPage: true,
            disableCenter: false,
            viewportFraction: 0.5,
            scrollDirection: Axis.vertical
        ),
        items: List.generate(
          favorites.length,
              (index) => PropertyItem(
                data: favorites[index],
              ),
        ),
      ),
    );
  }
}
Widget _buildSearch() {
  return const Padding(
    padding: EdgeInsets.symmetric(horizontal: 15),
    child: Row(
      children: [
        Expanded(
          child: CustomTextBox(
            hint: "Search",
            prefix: Icon(Icons.search, color: Colors.grey),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        IconBox(
          bgColor: AppColor.secondary,
          radius: 10,
          child: Icon(Icons.filter_list_rounded, color: Colors.white),
        )
      ],
    ),
  );
}
