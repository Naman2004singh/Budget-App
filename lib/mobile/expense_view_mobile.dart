import 'package:budget_app/components/budgetList.dart';
import 'package:budget_app/components/drawer.dart';
import 'package:budget_app/components/materialButton.dart';
import 'package:budget_app/components/textTheme.dart';
import 'package:budget_app/components/totalOutput.dart';
import 'package:budget_app/view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

bool isLoading = true;

class ExpenseViewMobile extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvider = ref.watch(viewModel);
    final deviceWidth = MediaQuery.of(context).size.width;

    if (isLoading) {
      viewModelProvider.incomeStream();
      viewModelProvider.expensesStream();
      isLoading = false;
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

    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white, size: 30.0),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: OpenSans(
          text: "Dashboard",
          size: 25.0,
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
          Column(
            children: [
              SizedBox(
                height: 40.0,
              ),
              Totaloutput(
                deviceWidth: deviceWidth / 1.2,
                text1: budgetLeft.toString(),
                text2: totalExpense.toString(),
                text3: totalIncome.toString(),
              )
            ],
          ),
          SizedBox(
            height: 40.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 40.0,
                width: 163.0,
                // Add expense button
                child: Materialbutton(
                    onpressFunction: () async {
                      await viewModelProvider.addExpense(context);
                    },
                    buttontext: "+  Add Expense",
                    textSize: 18.0),
              ),
              SizedBox(
                width: 10.0,
              ),
              SizedBox(
                width: 155.0,
                height: 40.0,
                child: Materialbutton(
                    onpressFunction: () async {
                      await viewModelProvider.addIncome(context);
                    },
                    buttontext: "+  Add income",
                    textSize: 18.0),
              )
            ],
          ),
          SizedBox(
            height: 30.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Expense list
              Budgetlist(
                  containerWidth: deviceWidth / 2.5,
                  containerSmallWidth: deviceWidth / 2.7,
                  textHeading: "Expenses",
                  headingSize: 18.0,
                  itemcountNumber: viewModelProvider.expenseAmount.length,
                  budgetName: viewModelProvider.expenseName,
                  budgetAmount: viewModelProvider.expenseAmount),
              // Income list
              Budgetlist(
                  containerWidth: deviceWidth / 2.5,
                  containerSmallWidth: deviceWidth / 2.7,
                  textHeading: "Income",
                  headingSize: 18.0,
                  itemcountNumber: viewModelProvider.incomeAmount.length,
                  budgetName: viewModelProvider.incomeName,
                  budgetAmount: viewModelProvider.incomeAmount)
            ],
          )
        ],
      ),
    ));
  }
}
