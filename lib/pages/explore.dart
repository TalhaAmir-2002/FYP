import 'package:flutter/material.dart';
import 'package:fyp_frontend/pages/property.dart';
import 'package:fyp_frontend/theme/color.dart';
import 'package:fyp_frontend/utils/data.dart';
import 'package:fyp_frontend/widgets/broker_item.dart';
import 'package:fyp_frontend/widgets/company_item.dart';
import 'package:fyp_frontend/widgets/custom_textbox.dart';
import 'package:fyp_frontend/widgets/icon_box.dart';
import 'package:fyp_frontend/widgets/recommend_item.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: AppColor.appBgColor,
          pinned: true,
          snap: true,
          floating: true,
          title: _buildHeader(),
        ),
        SliverToBoxAdapter(child: _buildBody())
      ],
    );
  }

  _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: CustomTextBox(
            hint: "Search",
            prefix: Icon(Icons.search, color: Colors.grey),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        IconBox(
          child: Icon(Icons.filter_list_rounded, color: Colors.white),
          bgColor: AppColor.secondary,
          radius: 10,
        )
      ],
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              "Matched Properties",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _buildRecommended(),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              "Companies",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _buildCompanies(),
          const SizedBox(
            height: 20,
          ),
          _buildBrokers(),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }

  _buildRecommended() {
    List<Widget> lists = List.generate(
      recommended.length,
      (index) => GestureDetector(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => property(index: index) ,
            ),);
        },
        child: RecommendItem(
          data: recommended[index],
        ),
      ),
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(bottom: 5, left: 15),
      child: Row(children: lists),
    );
  }

  int _selectedCategory = 0;
  _buildCompanies() {
    List<Widget> lists = List.generate(
      companies.length,
      (index) => CompanyItem(
        data: companies[index],
        color: AppColor.listColors[index % 10],
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
      padding: EdgeInsets.only(bottom: 5, left: 15),
      child: Row(children: lists),
    );
  }

  _buildBrokers() {
    List<Widget> lists = List.generate(
      brokers.length,
      (index) => BrokerItem(
        data: brokers[index],
      ),
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(children: lists),
    );
  }
}
