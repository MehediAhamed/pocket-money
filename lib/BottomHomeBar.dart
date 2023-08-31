import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:pocketmoney/AddData.dart';
import 'package:pocketmoney/ProgressBar.dart';
import 'CustomAppBar.dart';

class BottomHomeBar extends StatefulWidget {
  const BottomHomeBar({super.key, required this.title});

  final String title;

  @override
  _BottomHomeBarState createState() => _BottomHomeBarState();
}

class _BottomHomeBarState extends State<BottomHomeBar> {




  int _currentIndex = 0;

  bool _isIncome = false;

  bool isExpenseSelected = true;
  late String enteredAmount = ' ';
  late String enteredRemark = ' ';
  late DateTime selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);


  List<String> dropdownCatDataDB = ['Food'];
   dynamic ExpenseDataDB ;
   int ChildCount=0;
   int Itemcount=0;
  String selectedCatOption=' ';

  var dataOperation = AddData();
  @override
  void initState() {
    super.initState();
    //dataOperation.insertCategoryData("Rent");
    //dataOperation.insertCategoryData("Cloth");

    dataOperation.retrieveCategoryData().then((data) {
      setState(() {
        dropdownCatDataDB = data;
      });
    });

    dataOperation.retrieveDataExpense().then((data) {
      setState(() {
        ExpenseDataDB = data;
      });
    });


   setCount();
  }
Future<void> setCount()
async {
  ChildCount = await dataOperation.lengthExpense() as int;
  if(ChildCount==null)
    {
      ChildCount=1;
    }

Itemcount = await dataOperation.lengthCategory() as int;
  if(Itemcount==null)
  {
    Itemcount=1;
  }

  if(dropdownCatDataDB==null)
    {
      dropdownCatDataDB=['Food'];
    }

}




  void reset() {

    enteredAmount = ' ';
    enteredRemark = ' ';
    late DateTime selectedDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  }



  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });



    // Perform action based on the selected index
    switch (_currentIndex) {
      case 0:
        openBrowser();
        break;
        break;
      case 1:
        // Action for the second tab
        break;
      case 2:
        _Categories();

        break;
    }
  }

  @override

  Widget build(BuildContext context) {

      return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            CustomSliverAppBar(),

            SliverToBoxAdapter(
              child: ProgressBar(),
            ),

            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  String Exdate = ExpenseDataDB[index]['Date'];
                  Exdate = Exdate.substring(0, 10);
                  String Excategory = ExpenseDataDB[index]['Category'];
                  String Expense = ExpenseDataDB[index]['Amount'];
                  String ExRemark = ExpenseDataDB[index]['Remark'];
                  //String income=ExpenseDataDB[index]['Date'];

                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Color(0xFF880D39),
                      borderRadius: BorderRadius.circular(0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(1),
                          offset: Offset(2, 2),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          title: Row(
                            children: [ Text(
                              '$Exdate ',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Varela',
                              ),
                            ),
                              SizedBox(width: 50,),
                              Column(
                                children: [
                                  SizedBox(height: 14,),
                                  Text(

                                      '    $Excategory',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Varela',
                                        fontSize: 19,
                                      ),
                                    textAlign: TextAlign.left ,
                                    ),


                                ],
                              ),
                            ],

                          ),
                          subtitle: Text(
                            'Expense: $Expense',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Varela',
                              fontSize: 18,
                            ),
                          ),
                          leading: Icon(Icons.ac_unit_outlined,
                              size: 35, color: Colors.white),

                          trailing: Icon(Icons.delete_outline_outlined,
                              size: 35, color: Colors.white),
                          onTap: () {
                            // Handle item tap
                          },
                        ),
                      ],
                    ),
                  );
                },
                childCount: ChildCount,
              ),
            ),


          ],
        ),

        backgroundColor: Color(0x757070),
        bottomNavigationBar: BottomNavigationBar(
          //backgroundColor: Color(0xFF880D39),
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          selectedItemColor: Color(0xFF880D39),

          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.import_export),
              label: 'Export',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart),
              label: 'Chart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Categories',
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Increment',
          onPressed: _newTransaction,
          child: const Icon(Icons.add),
          backgroundColor: Color(0xFF0B0E6C),
        ),
      );

  }

  void _newTransaction() async {
    reset();

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              title: Column(
                children: [
                  SizedBox(
                    height: 8.0,
                    width: 80,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isExpenseSelected = true;
                          });
                        },
                        child: Text('Expense'),
                        style: ElevatedButton.styleFrom(
                          primary:
                              isExpenseSelected ? Colors.amber : Colors.grey,
                        ),
                      ),
                      SizedBox(width: 30.0),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isExpenseSelected = false;
                          });
                        },
                        child: Text('Income'),
                        style: ElevatedButton.styleFrom(
                          primary:
                              !isExpenseSelected ? Colors.amber : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month_outlined,
                          color: Color(0xFF880D39),
                        ),
                        SizedBox(width: 30.0),
                        GestureDetector(
                          onTap: () async {
                            final pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime(DateTime.now().year,
                                  DateTime.now().month, DateTime.now().day),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );

                            if (pickedDate != null) {
                              setState(() {
                                selectedDate = DateTime(pickedDate.year,
                                    pickedDate.month, pickedDate.day);
                              });
                            }
                          },
                          child: Text(
                            selectedDate != null
                                ? selectedDate.toString()
                                : 'Select Date',
                            style: TextStyle(
                              color: selectedDate != null
                                  ? Colors.black
                                  : Colors.grey,
                            fontFamily: 'Varela',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        Icon(
                          Icons.currency_exchange_outlined,
                          color: Color(0xFF880D39),
                        ),
                        SizedBox(width: 30.0),
                        Expanded(
                          child: TextField(
                            onChanged: (value) {
                              enteredAmount = value;
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Amount',
                            ),

                            style: TextStyle(
                              color: Color(0xFF04063B),
                              fontFamily: 'Varela',),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        Icon(
                          Icons.description_outlined,
                          color: Color(0xFF880D39),
                        ),
                        SizedBox(width: 30.0),
                        Expanded(
                          child: TextField(
                            onChanged: (value) {
                              enteredRemark = value;
                            },
                            decoration: InputDecoration(
                              labelText: 'Remark',
                            ),
                            style: TextStyle(
                              color: Color(0xFF04063B),
                              fontFamily: 'Varela',),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        Icon(
                          Icons.category,
                          color: Color(0xFF880D39),
                        ),
                        SizedBox(width: 30.0),

                        DropdownButton<String>(
                          value: selectedCatOption,
                          onChanged: (newValue) {
                            setState(() {
                              selectedCatOption = newValue!;
                            });
                          },
                          items: dropdownCatDataDB.map<DropdownMenuItem<String>>((value)  {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,
                                style: TextStyle(
                                color: Color(0xFF04063B),
                            fontFamily: 'Varela',),)
                            );
                          }).toList(),
                        ),




                      ],
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Color(0xFF880D39),
                    ),
                  ),
                ),
                MaterialButton(
                  color: enteredAmount != null &&
                          enteredRemark != null &&
                          selectedDate != null &&
                          selectedCatOption!= null
                      ? Color(0xFF04063B)
                      : Colors.green,
                  child: Text('Enter', style: TextStyle(color: Colors.white)),
                  onPressed: enteredAmount != null &&
                          enteredRemark != null &&
                          selectedDate != null &&
                          selectedCatOption!= null
                      ? () async {
                          print('Amount: $enteredAmount');
                          print('Remark: $enteredRemark');
                          print('Date: $selectedDate');

                          String option='income';
                          if(isExpenseSelected==true)
                            {
                              option='expense';
                            }
                          //await dataOperation.deleteTable();
                          await dataOperation.storeDataExpense(
                              option,
                              selectedCatOption,
                              double.parse(enteredAmount),
                              enteredRemark,
                              selectedDate.month.toString(),
                              selectedDate.year.toString(),
                              selectedDate.toString());
                          Navigator.of(context).pop();
                          print("Category : $selectedCatOption");
                        }
                      : null,
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _Categories() async {
    String categoryName = ' ';


    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Categories',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Varela',
                ),
              ),
              backgroundColor: Color(0xFF880D39),
            ),
            body: Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(1),
                    offset: Offset(2, 2),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: ListView.builder(
                itemCount: Itemcount, //Itemcount,
                itemBuilder: (context, index) {
                  String item = dropdownCatDataDB[index];
                  return ListTile(

                    title: Center(child: Text(item)),

                    leading: Icon(Icons.add_box_outlined,
                        size: 35, color: Color(0xFF04063B)),
                    trailing: Icon(Icons.delete_outline_outlined,
                        size: 35, color: Color(0xFF04063B)),
                  );
                },
              ),
            ),
            floatingActionButton: MaterialButton(
              color: Color(0xFF880D39),
              //shape:,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        'Add Category',
                        style: TextStyle(color: Color(0xFF880D39)),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            //controller: _categoryController,
                            decoration: InputDecoration(
                              labelText: 'Category Name (Food, Cloth...)',
                            ),
                            onChanged: (value) {
                              categoryName = value;
                            },
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: Color(0xFF880D39),
                            ),
                          ),
                        ),
                        MaterialButton(
                          color: Color(0xFF04063B),
                          onPressed: () {
                            dataOperation.insertCategoryData(categoryName);
                            Navigator.pop(context);
                            initState();
                          },
                          child: Text(
                            'Add',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Icon(
                Icons.add,
                size: 40,
                color: Colors.white,
              ),
            ),
          );
        });
  }

  void _Chart() async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (BuildContext context, setState) {
            return Center(
              child: Text(
                'Home Screen',
                style: TextStyle(fontSize: 24),
              ),
            );
          });
        });
  }

  void _Export() async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (BuildContext context, setState) {
            return Center(
              child: Text(
                'Home Screen',
                style: TextStyle(fontSize: 24),
              ),
            );
          });
        });
  }

  void openBrowser() async {
    const url = 'https://www.google.com'; // Replace with your desired URL
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


}
