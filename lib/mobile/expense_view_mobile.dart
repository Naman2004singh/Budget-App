import 'package:budget_app/view_model.dart';
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
    return SafeArea(child: Scaffold());
  }
}
