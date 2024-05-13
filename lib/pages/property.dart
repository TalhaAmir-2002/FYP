import 'package:flutter/material.dart';
import 'package:fyp_frontend/theme/color.dart';

import '../utils/data.dart';
import '../widgets/category_item.dart';
import '../widgets/custom_image.dart';
import 'package:fyp_frontend/main.dart';

class property extends StatelessWidget {
  final int index;
  const property({required this.index ,super.key, });

  @override
  Widget build(BuildContext context) {

    final String pic=populars[index]['image'];
    final String name=populars[index]['name'];
    final String price=populars[index]['price'];
    final String location=populars[index]['location'];
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    CustomImage(
                      pic,
                      height: MediaQuery.sizeOf(context).height/2,
                      width: MediaQuery.sizeOf(context).width,
                      radius: 0,
                    ),
                    Positioned(
                      top: 340,
                      child: Container(
                        height: MediaQuery.sizeOf(context).height,
                        width: MediaQuery.sizeOf(context).width,
                        decoration: BoxDecoration(
                          color: AppColor.cardColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(name,
                                    style: const TextStyle(fontSize: 25,fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(price,
                                    style: const TextStyle(fontSize: 25,fontWeight: FontWeight.w500,color: Colors.blue),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ), Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on_outlined),
                      Text(
                        location,
                          style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w400),
                        ),
                    ],
                  ),
                ),
                _buildCategories(),
                const SizedBox(height: 20,),
            Container(
            padding: const EdgeInsets.all(10), // Reduced padding
            decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColor.cardColor,
            boxShadow: const [
            BoxShadow(
            color: AppColor.shadowColor,
            spreadRadius: 0.1,
            )
            ],
            ),
            width: MediaQuery.sizeOf(context).width - 50,
        child: Column(
          children: [
            Row(
              children: [
                CustomImage(profile,
                height: 55,
                  width: 55,
                  radius: 35,
                ),
                const Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 1.0,left: 10),
                      child: Text(
                        "Ryomen Sukuna",
                        style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 49),
                      child: Text(
                        "Owner",
                        style: TextStyle(fontSize: 13,fontWeight: FontWeight.w300),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: null,
                    child:Text("Get Schedule",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black
                      ),
                    ) ),
                ElevatedButton(
                    onPressed: null,
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Colors.greenAccent)
                    ),
                    child:Row(
                      children: [
                        Icon(Icons.call,color: Colors.white,),
                        Text("Call",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white
                          ),
                        ),
                      ],
                    ) )
              ],
            )
          ],
        ),
            )
              ],
            ),
          ]),
      ),
    );
  }
}
List<Map<String, dynamic>> items = [
  {'name': '2 Kitchen', 'icon': Icons.kitchen},
  {'name': '3 Bedroom', 'icon': Icons.bed},
  {'name': '1 Living Room', 'icon': Icons.living},
  {'name': '2 Bathroom', 'icon': Icons.bathroom_outlined}
];
Widget _buildCategories() {
  List<Widget> lists = List.generate(
    items.length,
        (index) => CategoryItem(
      data: items[index],
      onTap: () {
      },
    ),
  );
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    padding: const EdgeInsets.only(bottom: 5, left: 15),
    child: Row(children: lists),
  );
}
