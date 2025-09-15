import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class LiveDataPage extends StatefulWidget {
  const LiveDataPage({super.key});

  @override
  State<LiveDataPage> createState() => _LiveDataPageState();
}

class _LiveDataPageState extends State<LiveDataPage> {
  final List<FlSpot> _dataPoints = [];
  int _xValue = 0;
  Timer? _timer;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _startGeneratingData();
  }

  void _startGeneratingData() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        final double ppm =
            200 + _random.nextInt(300).toDouble(); // random ppm between 200–500
        _dataPoints.add(FlSpot(_xValue.toDouble(), ppm));
        _xValue++;

        // keep only last 10 points for smooth chart
        if (_dataPoints.length > 10) {
          _dataPoints.removeAt(0);
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Live PPM Data"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: LineChart(
          LineChartData(
            minY: 0,
            maxY: 600,
            gridData: FlGridData(show: true),
            borderData: FlBorderData(show: true),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: _dataPoints,
                isCurved: true,
                color: Colors.green,
                barWidth: 3,
                belowBarData: BarAreaData(
                  show: true,
                  color: Colors.green.withOpacity(0.2),
                ),
                dotData: FlDotData(show: false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
