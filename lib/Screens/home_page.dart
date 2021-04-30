import 'dart:ffi';

import 'package:budget_app/Data/data.dart';
import 'package:budget_app/Models/category_model.dart';
import 'package:budget_app/Models/expense_model.dart';
import 'package:budget_app/Screens/category_screen.dart';
import 'package:budget_app/Widgets/bar_chart.dart';
import 'package:budget_app/Widgets/color_maker.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _buildCatergory(Category category, double totalAmountSpent) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return CategoryScreen(
            category: category,
          );
        }));
      },
      child: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  category.name,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                Text(
                  "\$${(category.maxAmount - totalAmountSpent).toStringAsFixed(2)}/\$${category.maxAmount}",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final double maxBarWidth = constraints.maxWidth;
                final double percent = (category.maxAmount - totalAmountSpent) /
                    category.maxAmount;
                double barWidth = percent * maxBarWidth;
                if (barWidth < 0) {
                  barWidth = 0;
                }
                return Stack(
                  children: [
                    Container(
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Container(
                      height: 20,
                      width: barWidth,
                      decoration: BoxDecoration(
                        color: getColor(context, percent),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    //  double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            forceElevated: true,
            centerTitle: true,
            expandedHeight: deviceHeight / 8,
            leading: IconButton(
              icon: Icon(
                Icons.settings,
                size: 30,
              ),
              onPressed: () {},
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Weekly Budget'),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.add,
                  size: 30,
                ),
                onPressed: () {},
              )
            ],
          ),
          SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              if (index == 0) {
                return Container(
                  // height: deviceHeight / 3,
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 2),
                          blurRadius: 6),
                    ],
                  ),
                  child: BarChart(
                    expenses: weeklySpending,
                  ),
                );
              } else {
                final Category category = categories[index - 1];
                double totalAmountSpent = 0;
                category.expenses.forEach((Expense expense) {
                  totalAmountSpent += expense.cost;
                });
                return _buildCatergory(category, totalAmountSpent);
              }
            }, childCount: 1 + categories.length),
          ),
        ],
      ),
    );
  }
}
