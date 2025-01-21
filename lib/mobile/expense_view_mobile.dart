import 'package:budget_app/components/appBar.dart';
import 'package:budget_app/components/drawer.dart';
import 'package:budget_app/components/materialButton.dart';
import 'package:budget_app/components/totalOutput.dart';
import 'package:budget_app/model.dart';
import 'package:budget_app/view_model.dart';
import 'package:budget_app/components/textTheme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ExpenseViewMobile extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvider = ref.watch(viewModel);
    final deviceWidth = MediaQuery.of(context).size.width;

    int totalExpense = 0;
    int totalIncome = 0;
    int budgetLeft = totalIncome - totalExpense;
    TotalExpenseCalculate(context, ref, totalExpense);
    TotalIncomeCalculate(context, ref, totalIncome);
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(deviceWidth, 55.0),
          child: MyAppbar(
            title: Poppins(
              text: "Dashboard",
              size: 20.0,
              color: Colors.white,
            ),
          )),
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
                width: 155.0,
                child: Materialbutton(
                    onpressFunction: () async {
                      await viewModelProvider.addExpense(context);
                    },
                    buttontext: "+  Add Expense",
                    textSize: 18.0),
              )
            ],
          )
        ],
      ),
    ));
  }
}
