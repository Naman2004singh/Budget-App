import 'package:budget_app/components/budgetList.dart';
import 'package:budget_app/components/drawer.dart';
import 'package:budget_app/components/materialButton.dart';
import 'package:budget_app/components/textTheme.dart';
import 'package:budget_app/components/totalOutput.dart';
import 'package:budget_app/view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

bool isLoading = true;

class ExpenseViewWeb extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvider = ref.watch(viewModel);
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    if (isLoading) {
      viewModelProvider.incomeStream();
      viewModelProvider.expensesStream();
      isLoading = true;
    }

    int totalExpense = 0;
    int totalIncome = 0;

    for (int i = 0; i < viewModelProvider.expenseAmount.length; i++) {
      totalExpense =
          totalExpense + int.parse(viewModelProvider.expenseAmount[i]);
    }

    for (int i = 0; i < viewModelProvider.incomeAmount.length; i++) {
      totalIncome = totalIncome + int.parse(viewModelProvider.incomeAmount[i]);
    }

    int budgetLeft = totalIncome - totalExpense;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white, size: 30.0),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: OpenSans(
          text: "Dashboard",
          size: 25,
          color: Colors.white,
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await viewModelProvider.reset();
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      drawer: MyDrawer(),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        children: [
          SizedBox(
            height: 40.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                "assets/login_image.png",
                height: 400,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Materialbutton(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 18.0),
                      onpressFunction: () async {
                        await viewModelProvider.addExpense(context);
                      },
                      buttontext: "+  Add Expense",
                      textSize: 18.0),
                  SizedBox(
                    height: 25.0,
                  ),
                  Materialbutton(
                      padding: EdgeInsets.symmetric(
                          horizontal: 23.0, vertical: 18.0),
                      onpressFunction: () async {
                        await viewModelProvider.addIncome(context);
                      },
                      buttontext: "+  Add income",
                      textSize: 18.0),
                ],
              ),
              Totaloutput(
                  deviceWidth: 450,
                  text1: budgetLeft.toString(),
                  text2: totalExpense.toString(),
                  text3: totalIncome.toString())
            ],
          ),
          SizedBox(
            height: 60.0,
          ),
          Divider(
            indent: 180.0,
            endIndent: 180.0,
            color: Colors.grey,
            thickness: 2.0,
          ),
          SizedBox(
            height: 50.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //Expense list
              Budgetlist(
                  containerWidth: deviceWidth / 4.5,
                  containerSmallWidth: deviceWidth / 2.3,
                  containerHeight: deviceHeight / 2.2,
                  smallContainerHeight: deviceHeight / 3.1,
                  textHeading: "Expenses",
                  headingSize: 28.0,
                  itemcountNumber: viewModelProvider.expenseAmount.length,
                  budgetName: viewModelProvider.expenseName,
                  budgetAmount: viewModelProvider.expenseAmount),
              // Income list
              Budgetlist(
                  containerWidth: deviceWidth / 4.5,
                  containerSmallWidth: deviceWidth / 2.3,
                  containerHeight: deviceHeight / 2.2,
                  smallContainerHeight: deviceHeight / 3.1,
                  textHeading: "Income",
                  headingSize: 28.0,
                  itemcountNumber: viewModelProvider.incomeAmount.length,
                  budgetName: viewModelProvider.incomeName,
                  budgetAmount: viewModelProvider.incomeAmount),
            ],
          )
        ],
      ),
    );
  }
}
