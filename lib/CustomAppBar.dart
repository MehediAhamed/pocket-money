import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

import 'AddData.dart';
import 'package:intl/intl.dart';


class CustomSliverAppBar extends StatefulWidget {


  @override
  _CustomSliverAppBarState createState() => _CustomSliverAppBarState();
}


class _CustomSliverAppBarState extends State<CustomSliverAppBar>  {


  String month = DateFormat.MMMM().format(DateTime.now());

  dynamic BudgetAmount;
  var dataOperation = AddData();
  @override
  void initState() {
    super.initState();
    dataOperation.getBudgetForThisMonth(DateTime.now().month.toString(), DateTime.now().year.toString()).then((data) {
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
    return SliverAppBar(
      backgroundColor: Color(0xFF880D39),
      expandedHeight: 170,
      actions: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 8, 10, 0),
              child: IconButton(
                icon: Icon(
                  Icons.calendar_month_outlined,
                  size: 30,
                ),
                color: Colors.white, // Add your desired icon here
                onPressed: () {
                  _showInputDialog(context); // Handle icon button press
                },
              ),
            ),
          ],
        ),
        SizedBox(
            child: Padding(
          padding: EdgeInsets.fromLTRB(0, 8, 10, 0),
          child: IconButton(
            icon: Icon(
              Icons.settings,
              size: 30,
            ),
            color: Colors.white, // Add your desired icon here
            onPressed: () {
              _showInputDialog(context);
            },
          ),
        )),
      ],
      // Other properties...
      centerTitle: true,
      // Disable centering of the title

      flexibleSpace: FlexibleSpaceBar(
        background: Image.asset(
          'assets/images/geom.png',
          fit: BoxFit.cover,
        ),
        centerTitle: true,
        titlePadding: EdgeInsets.zero,
        title: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                children: [
                      Text('$month', style: TextStyle(
                        fontSize: 15,

                        color: Color(0xFF04063B),
                        backgroundColor: Colors.amber,
                        fontFamily: 'Varela',
                      ),),
                      Text(
                        "Budget: $BudgetAmount",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          backgroundColor: Colors.orange,
                          fontFamily: 'Varela',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height:40,),


            ],
          ),


      ),
    );
  }

  void _showInputDialog(BuildContext context) {
    String budgetMonth = '';
    String budgetAmount = '';
    String budgetYear = DateTime.now().year.toString();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                'Enter Month, Year & Amount',
                style:
                    TextStyle(fontFamily: 'Varela', color: Color(0xFF04063B)),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        ' Month:   ',
                        style: TextStyle(
                          fontFamily: 'Varela',
                          color: Color(0xFF880D39),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      DropdownButton<String>(
                        value: budgetMonth.isNotEmpty ? budgetMonth : null,
                        onChanged: (String? newValue) {
                          setState(() {
                            budgetMonth = newValue!;
                          });
                        },
                        items: <DropdownMenuItem<String>>[
                          DropdownMenuItem<String>(
                            value: 'January',
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add_box_outlined,
                                  color: Color(0xFF04063B),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'January',
                                  style: TextStyle(
                                    color: Color(0xFF04063B),
                                    fontFamily: 'Varela',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: 'February',
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add_box_outlined,
                                  color: Color(0xFF880D39),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'February',
                                  style: TextStyle(
                                    color: Color(0xFF880D39),
                                    fontFamily: 'Varela',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: 'March',
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add_box_outlined,
                                  color: Color(0xFF04063B),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'March',
                                  style: TextStyle(
                                    color: Color(0xFF04063B),
                                    fontFamily: 'Varela',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: 'April',
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add_box_outlined,
                                  color: Color(0xFF880D39),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'April',
                                  style: TextStyle(
                                    color: Color(0xFF880D39),
                                    fontFamily: 'Varela',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: 'May',
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add_box_outlined,
                                  color: Color(0xFF04063B),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'May',
                                  style: TextStyle(
                                    color: Color(0xFF04063B),
                                    fontFamily: 'Varela',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: 'June',
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add_box_outlined,
                                  color: Color(0xFF880D39),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'June',
                                  style: TextStyle(
                                    color: Color(0xFF880D39),
                                    fontFamily: 'Varela',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: 'July',
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add_box_outlined,
                                  color: Color(0xFF04063B),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'July',
                                  style: TextStyle(
                                    color: Color(0xFF04063B),
                                    fontFamily: 'Varela',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: 'August',
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add_box_outlined,
                                  color: Color(0xFF880D39),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'August',
                                  style: TextStyle(
                                    color: Color(0xFF880D39),
                                    fontFamily: 'Varela',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: 'September',
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add_box_outlined,
                                  color: Color(0xFF04063B),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'September',
                                  style: TextStyle(
                                    color: Color(0xFF04063B),
                                    fontFamily: 'Varela',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: 'October',
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add_box_outlined,
                                  color: Color(0xFF880D39),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'October',
                                  style: TextStyle(
                                    color: Color(0xFF880D39),
                                    fontFamily: 'Varela',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: 'November',
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add_box_outlined,
                                  color: Color(0xFF04063B),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'November',
                                  style: TextStyle(
                                    color: Color(0xFF04063B),
                                    fontFamily: 'Varela',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: 'December',
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add_box_outlined,
                                  color: Color(0xFF880D39),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'December',
                                  style: TextStyle(
                                    color: Color(0xFF880D39),
                                    fontFamily: 'Varela',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        '  Year:     ',
                        style: TextStyle(
                          color: Color(0xFF880D39),
                          fontFamily: 'Varela',
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            DateTime.now().year.toString(),
                            style: TextStyle(
                              color: Color(0xFF04063B),
                              fontFamily: 'Varela',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        'Amount:  ',
                        style: TextStyle(
                          color: Color(0xFF880D39),
                          fontFamily: 'Varela',
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          cursorColor: Color(0xFF04063B),
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            budgetAmount = value;
                          },
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              actions: <Widget>[
                MaterialButton(
                  color: Color(0xFF04063B),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                MaterialButton(
                  child: Text(
                    'OK',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Color(0xFF04063B),
                  onPressed: () {
                    // Handle OK button press
                    // You can use the selectedMonth and enteredAmount variables
                    print('Selected Year: $budgetYear');
                    print('Entered Amount: $budgetAmount');
                    dataOperation.storeDataBudget(double.parse(budgetAmount), DateTime.now().month.toString(),DateTime.now().year.toString());
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
