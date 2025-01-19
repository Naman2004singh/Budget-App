import 'package:budget_app/view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

TotalExpenseCalculate(BuildContext context, WidgetRef ref, int expense) {
  final viewModelProvider = ref.watch(viewModel);
  for (int i = 0; i < viewModelProvider.expenseAmount.length; i++) {
    expense = expense + int.parse(viewModelProvider.expenseAmount[i]);
  }
}

TotalIncomeCalculate(BuildContext context, WidgetRef ref, int income) {
  final viewModelProvider = ref.watch(viewModel);
  for (int i = 0; i < viewModelProvider.incomeAmount.length; i++) {
    income = income + int.parse(viewModelProvider.incomeAmount[i]);
  }
}
