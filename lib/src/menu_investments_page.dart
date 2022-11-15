import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'widget/base_page.dart';
import 'widget/const/color_palette.dart';
import 'widget/const/page_name.dart';
import 'widget/entry_label.dart';
import 'widget/padded_row.dart';
import 'widget/page_title.dart';

class InvestmentsPage extends StatefulWidget {
  const InvestmentsPage({super.key});

  @override
  State<InvestmentsPage> createState() => _InvestmentsPageState();
}

class _InvestmentsPageState extends State<InvestmentsPage> {
  @override
  void initState() {
    super.initState();
    PageName.get(AppPage.investments)!.isAlive = true;
  }

  @override
  void dispose() {
    PageName.get(AppPage.investments)!.isAlive = false;
    super.dispose();
  }

  int c = 0; // color scheme index
  Widget _myPosition() {
    final canvasColor = Theme.of(context).canvasColor;
    final contextSize = MediaQuery.of(context).size;
    final sW = contextSize.width;
    // final sH = contextSize.height;
    final maxW = sW; // min(sW, sH);
    final barW = .005 * maxW;
    final chartPad = 20 * barW;

    final LineChartBarData datum = LineChartBarData(
      isCurved: true,
      preventCurveOverShooting: true,
      dotData: FlDotData(show: false),
      color: AppColor.chartScheme[c].up,
      barWidth: barW,
      spots: const [
        FlSpot(3, 0.0),
        FlSpot(4, 1.9),
        FlSpot(5, -6.9),
        FlSpot(6, -4.0),
        FlSpot(7, 4.0),
        FlSpot(8, 6.9),
      ],
      showingIndicators: [0, 1, 2, 3, 4, 5],
      belowBarData: BarAreaData(
        color: AppColor.chartScheme[c].upArea,
        applyCutOffY: true,
        show: true,
        cutOffY: 0,
      ),
      aboveBarData: BarAreaData(
        color: AppColor.chartScheme[c].downArea,
        applyCutOffY: true,
        show: true,
        cutOffY: 0,
      ),
    );
    final List<LineChartBarData> data = [datum];

    return Container(
      width: sW,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: canvasColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const EntryLabel('Portfolio performance'),
              Padding(
                padding: const EdgeInsets.only(right: 6),
                child: Row(
                  children: [0, 1, 2]
                      .map(
                        (e) => Row(
                          children: [
                            InkWell(
                              onTap: () => setState(
                                () {
                                  c = e;
                                },
                              ),
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: AppColor.chartScheme[e].axis,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
          Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: maxW),
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: AspectRatio(
                  aspectRatio: 2,
                  child: LineChart(
                    LineChartData(
                      lineBarsData: data,
                      lineTouchData: LineTouchData(
                        enabled: false,
                        getTouchedSpotIndicator: (barData, spotIndexes) =>
                            spotIndexes
                                .map(
                                  (index) => TouchedSpotIndicatorData(
                                    FlLine(
                                      color:
                                          AppColor.chartScheme[c].verticalLines,
                                      strokeWidth:
                                          index == 0 || index == 5 ? 0 : barW,
                                    ),
                                    FlDotData(
                                      getDotPainter:
                                          (spot, percent, barData, index) =>
                                              FlDotCirclePainter(
                                        color: c == 0
                                            ? AppColor.deep
                                            : c == 1
                                                ? AppColor.chartScheme[c]
                                                    .verticalLines
                                                : AppColor.chartScheme[c].up,
                                        strokeWidth: 0,
                                        radius: 2 * barW,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                        touchTooltipData: LineTouchTooltipData(
                          tooltipBgColor: AppColor.chartScheme[c].tooltipBg,
                          tooltipMargin: 5 * barW,
                          tooltipPadding: const EdgeInsets.all(5),
                          getTooltipItems: (lineBarsSpot) => lineBarsSpot
                              .map(
                                (lineBarSpot) => LineTooltipItem(
                                  '${lineBarSpot.y}%',
                                  TextStyle(
                                    color: AppColor.chartScheme[c].tooltipText,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      showingTooltipIndicators: [5]
                          .map(
                            (index) => ShowingTooltipIndicators(
                              [
                                LineBarSpot(
                                  datum,
                                  data.indexOf(datum),
                                  datum.spots[index],
                                ),
                              ],
                            ),
                          )
                          .toList(),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            getTitlesWidget: (value, meta) => Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Text(
                                  value == meta.min || value == meta.max
                                      ? ''
                                      : '${value.round()}%',
                                  style: TextStyle(
                                    color: value > 0
                                        ? AppColor.chartScheme[c].positiveNumber
                                        : value < 0
                                            ? AppColor
                                                .chartScheme[c].negativeNumber
                                            : AppColor
                                                .chartScheme[c].neutralNumber,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                            reservedSize: chartPad,
                            showTitles: true,
                          ),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(
                            getTitlesWidget: (value, meta) => Container(),
                            reservedSize: .5 * chartPad,
                            showTitles: true,
                          ),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(
                            getTitlesWidget: (value, meta) => Container(),
                            reservedSize: chartPad,
                            showTitles: true,
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            getTitlesWidget: (value, _) {
                              List<String> m = [
                                'Jan',
                                'Feb',
                                'Mar',
                                'Apr',
                                'May',
                                'Jun',
                                'Jul',
                                'Aug',
                                'Sep',
                                'Oct',
                                'Nov',
                                'Dec',
                              ];
                              return Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  m[value.truncate() - 1],
                                  style: TextStyle(
                                    color: AppColor.chartScheme[c].axisText,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            },
                            interval: 1,
                            showTitles: true,
                            reservedSize: chartPad,
                          ),
                        ),
                      ),
                      borderData: FlBorderData(
                        border: Border(
                          left: BorderSide(
                            color: AppColor.chartScheme[c].axis,
                            width: barW,
                          ),
                          bottom: BorderSide(
                            color: AppColor.chartScheme[c].axis,
                            width: barW,
                          ),
                        ),
                      ),
                      gridData: FlGridData(
                        drawHorizontalLine: true,
                        drawVerticalLine: false,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _investmentProducts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const EntryLabel('Investment products'),
        PaddedRow(
          'Gold',
          Icon(
            Icons.account_balance_outlined,
            color: Colors.yellow.shade900,
          ),
          tapAction: () {},
        ),
        const Divider(),
        PaddedRow(
          'Government Bonds',
          Icon(
            Icons.account_balance_outlined,
            color: Colors.blue.shade800,
          ),
          tapAction: () {},
        ),
        const Divider(),
        PaddedRow(
          'Mutual Funds',
          Icon(
            Icons.account_balance_outlined,
            color: Colors.green.shade700,
          ),
          tapAction: () {},
        ),
        const Divider(),
        PaddedRow(
          'Stocks',
          Icon(
            Icons.account_balance_outlined,
            color: Colors.red.shade600,
          ),
          tapAction: () {},
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      const PageTitle('my', 'investments'),
      [
        _myPosition(),
        _investmentProducts(),
      ],
    );
  }
}
