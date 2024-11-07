import 'package:cms_chat_app/components/charts.dart';
import 'package:cms_chat_app/components/custom_card.dart';
import 'package:flutter/material.dart';

class StatisticsScreen extends StatefulWidget {
  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Statistics"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Bar Chart
            buildChartCard(
              'Bar Chart',
              buildLineChart(
                [
                  {'x': 0, 'y': 10},
                  {'x': 1, 'y': 15},
                  {'x': 2, 'y': 7},
                  {'x': 3, 'y': 20},
                ],
                Colors.blue,
                ['Label 1', 'Label 2', 'Label 3', 'Label 4'],
              ),
            ),
            SizedBox(height: 20),
            buildCustomCard(
              Icons.comment,
              Colors.greenAccent,
              'Bình luận',
              68,
              'Trung bình: 6.18/ngày',
            ),
          ],
        ),
      ),
    );
  }
}
