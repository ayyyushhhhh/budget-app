import 'package:budget_app/Models/expense_model.dart';
import 'package:flutter/material.dart';

class BarChart extends StatelessWidget {
  final List<double> expenses;

  const BarChart({@required this.expenses});

  @override
  Widget build(BuildContext context) {
    double mostExpensive = 0;
    expenses.forEach((double price) {
      if (price > mostExpensive) {
        mostExpensive = price;
      }
    });
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Text(
            'Weekly Spending',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1.2),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: 30,
                ),
                onPressed: () {},
              ),
              Text(
                'April 24,2021 - April 30,2021',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward,
                  size: 30,
                ),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Bar(
                amountSpend: expenses[0],
                label: 'Sun',
                mostExpensive: mostExpensive,
              ),
              Bar(
                amountSpend: expenses[1],
                label: 'Mon',
                mostExpensive: mostExpensive,
              ),
              Bar(
                amountSpend: expenses[2],
                label: 'Tue',
                mostExpensive: mostExpensive,
              ),
              Bar(
                amountSpend: expenses[3],
                label: 'Wed',
                mostExpensive: mostExpensive,
              ),
              Bar(
                amountSpend: expenses[4],
                label: 'Thr',
                mostExpensive: mostExpensive,
              ),
              Bar(
                amountSpend: expenses[5],
                label: 'Fri',
                mostExpensive: mostExpensive,
              ),
              Bar(
                amountSpend: expenses[6],
                label: 'Sat',
                mostExpensive: mostExpensive,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Bar extends StatelessWidget {
  final String label;
  final double amountSpend;
  final double mostExpensive;

  Bar(
      {@required this.label,
      @required this.amountSpend,
      @required this.mostExpensive});

  final double _maxBarHeight = 150;
  @override
  Widget build(BuildContext context) {
    final double barheight = amountSpend / mostExpensive * _maxBarHeight;
    return Column(
      children: [
        Text(
          "\$" + amountSpend.toStringAsFixed(2),
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        SizedBox(
          height: 6,
        ),
        Container(
          height: barheight,
          width: 18,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        SizedBox(
          height: 6,
        ),
        Text(label,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
      ],
    );
  }
}
