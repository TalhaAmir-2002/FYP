import 'package:flutter/material.dart';
import 'package:fyp_frontend/theme/color.dart';

import 'custom_image.dart';
import 'icon_box.dart';

class PropertyItem extends StatefulWidget {
  const PropertyItem({Key? key, required this.data}) : super(key: key);

  final data;

  @override
  State<PropertyItem> createState() => _PropertyItemState();
}

class _PropertyItemState extends State<PropertyItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 240,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: AppColor.shadowColor.withOpacity(0.1),
            spreadRadius: .5,
            blurRadius: 1,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Stack(
        children: [
          CustomImage(
            widget.data?["image"]??"https://w0.peakpx.com/wallpaper/369/634/HD-wallpaper-jujutsu-kaisen-ryomen-sukuna.jpg",
            width: double.infinity,
            height: 150,
            radius: 25,
          ),
          Positioned(
            right: 20,
            top: 130,
            child: _buildFavorite(),
          ),
          Positioned(
            left: 15,
            top: 160,
            child: _buildInfo(),
          ),
        ],
      ),
    );
  }

  Widget _buildFavorite() {
    return Column(
      children: [
        GestureDetector(
          onTap: (){
            setState(() {
              widget.data['is_favorited']? widget.data['is_favorited']= false: widget.data['is_favorited']=true;
            });
          },
          child: IconBox(
            bgColor: AppColor.red,
            child: Icon(
              widget.data["is_favorited"] ? Icons.favorite : Icons.favorite_border,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
        SizedBox(height: 10,),
        Container(
          width: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.green
          ),
          child: Center(
            child: Text(
              widget.data["type"],
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: Colors.white),

            ),
          ),
        )
      ],
    );
  }

  Widget _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.data["name"],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),

          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Icon(
              Icons.place_outlined,
              color: AppColor.darker,
              size: 13,
            ),
            const SizedBox(
              width: 3,
            ),
            Text(
              widget.data["location"],
              style: TextStyle(fontSize: 13, color: AppColor.darker),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          widget.data["price"],
          style: TextStyle(
            fontSize: 15,
            color: AppColor.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
