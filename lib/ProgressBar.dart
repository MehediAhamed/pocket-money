import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:pocketmoney/AddData.dart';

class ProgressBar extends StatefulWidget {
  @override
  _ProgressBar createState() => _ProgressBar();
}

class _ProgressBar extends State<ProgressBar> {
  dynamic BudgetAmount;
  var dataOperation = AddData();
  @override
  void initState() {
    super.initState();
    dataOperation
        .getBudgetForThisMonth(
            DateTime.now().month.toString(), DateTime.now().year.toString())
        .then((data) {
      setState(() {
        for (var val in data)
        BudgetAmount = val['Amount'];
      });
    });
    setValue();
  }
  void setValue()
  {
    if (BudgetAmount == null) {
      BudgetAmount = 0;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30, horizontal: 25),
      //child:Text('Fer'),
      decoration: BoxDecoration(
        //color: Color(0xFF880D39),

        //borderRadius: BorderRadius.circular(0),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(1),
            offset: Offset(2, 2),
            blurRadius: 5,
          ),
        ],
      ),

      child: Column(
        children: [
          Text('Budget'),
          FAProgressBar(
            size: 26,
            maxValue: double.parse(BudgetAmount.toString()) ,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
            changeProgressColor: Colors.pink,
            backgroundColor: Colors.black12,
            //progressColor: Colors.lightBlue,
            animatedDuration: const Duration(milliseconds: 300),
            currentValue: 1200,
            displayText: '/$BudgetAmount',

            displayTextStyle: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontStyle: FontStyle.italic,
            ),
            progressGradient: LinearGradient(
              colors: [
                Colors.red,
                Colors.pink,
                Color(0xFF1B1F98),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
