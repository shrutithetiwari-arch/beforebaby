import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FinanceIntakePage extends ConsumerStatefulWidget {
  const FinanceIntakePage({Key? key}) : super(key: key);

  @override
  ConsumerState<FinanceIntakePage> createState() => _FinanceIntakePageState();
}

class _FinanceIntakePageState extends ConsumerState<FinanceIntakePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController monthlyIncomeController;
  late TextEditingController monthlyExpensesController;
  late TextEditingController emergencyFundController;
  late TextEditingController savingsController;
  late TextEditingController debtController;

  String? _selectedEmploymentStatus;
  String? _selectedFinancialStability;
  bool _hasHealthInsurance = false;
  bool _hasLifeInsurance = false;

  final employmentStatuses = ['Unemployed', 'Employed', 'Self-employed', 'Freelancer', 'Student'];
  final financialStabilities = ['Very Unstable', 'Unstable', 'Moderate', 'Stable', 'Very Stable'];

  @override
  void initState() {
    super.initState();
    monthlyIncomeController = TextEditingController();
    monthlyExpensesController = TextEditingController();
    emergencyFundController = TextEditingController();
    savingsController = TextEditingController();
    debtController = TextEditingController();
  }

  @override
  void dispose() {
    monthlyIncomeController.dispose();
    monthlyExpensesController.dispose();
    emergencyFundController.dispose();
    savingsController.dispose();
    debtController.dispose();
    super.dispose();
  }

  String? _validateCurrency(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    final amount = double.tryParse(value);
    if (amount == null || amount < 0) {
      return 'Please enter a valid amount';
    }
    return null;
  }

  String? _validateEmployment(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select employment status';
    }
    return null;
  }

  String? _validateFinancialStability(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select financial stability';
    }
    return null;
  }

  double calculateSavingsRate(double income, double expenses) {
    if (income == 0) return 0;
    return ((income - expenses) / income) * 100;
  }

  int calculateMonthsOfEmergencyFund(double emergencyFund, double monthlyExpenses) {
    if (monthlyExpenses == 0) return 0;
    return (emergencyFund / monthlyExpenses).toInt();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Financial Assessment'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Financial Assessment',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Help us understand your financial situation',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Employment & Income',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedEmploymentStatus,
                decoration: InputDecoration(
                  hintText: 'Select employment status',
                  prefixIcon: const Icon(Icons.work),
                ),
                items: employmentStatuses.map((String status) {
                  return DropdownMenuItem<String>(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedEmploymentStatus = newValue;
                  });
                },
                validator: _validateEmployment,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: monthlyIncomeController,
                decoration: InputDecoration(
                  labelText: 'Monthly Income (₹)',
                  hintText: 'e.g., 50000',
                  prefixIcon: const Icon(Icons.attach_money),
                ),
                keyboardType: TextInputType.number,
                validator: (value) => _validateCurrency(value, 'Monthly income'),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: monthlyExpensesController,
                decoration: InputDecoration(
                  labelText: 'Monthly Expenses (₹)',
                  hintText: 'e.g., 30000',
                  prefixIcon: const Icon(Icons.trending_down),
                ),
                keyboardType: TextInputType.number,
                validator: (value) => _validateCurrency(value, 'Monthly expenses'),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 24),
              _buildFinancialMetricsCard(context),
              const SizedBox(height: 24),
              Text(
                'Savings & Assets',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: emergencyFundController,
                decoration: InputDecoration(
                  labelText: 'Emergency Fund (₹)',
                  hintText: 'e.g., 150000',
                  prefixIcon: const Icon(Icons.savings),
                ),
                keyboardType: TextInputType.number,
                validator: (value) => _validateCurrency(value, 'Emergency fund'),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: savingsController,
                decoration: InputDecoration(
                  labelText: 'Total Savings (₹)',
                  hintText: 'e.g., 300000',
                  prefixIcon: const Icon(Icons.account_balance),
                ),
                keyboardType: TextInputType.number,
                validator: (value) => _validateCurrency(value, 'Total savings'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: debtController,
                decoration: InputDecoration(
                  labelText: 'Total Debt (₹)',
                  hintText: 'e.g., 50000',
                  prefixIcon: const Icon(Icons.credit_card),
                ),
                keyboardType: TextInputType.number,
                validator: (value) => _validateCurrency(value, 'Total debt'),
              ),
              const SizedBox(height: 24),
              Text(
                'Financial Situation',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedFinancialStability,
                decoration: InputDecoration(
                  hintText: 'Select financial stability',
                  prefixIcon: const Icon(Icons.trending_up),
                ),
                items: financialStabilities.map((String status) {
                  return DropdownMenuItem<String>(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedFinancialStability = newValue;
                  });
                },
                validator: _validateFinancialStability,
              ),
              const SizedBox(height: 24),
              CheckboxListTile(
                value: _hasHealthInsurance,
                onChanged: (bool? value) {
                  setState(() {
                    _hasHealthInsurance = value ?? false;
                  });
                },
                title: const Text('I have health insurance'),
              ),
              CheckboxListTile(
                value: _hasLifeInsurance,
                onChanged: (bool? value) {
                  setState(() {
                    _hasLifeInsurance = value ?? false;
                  });
                },
                title: const Text('I have life insurance'),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Financial information saved!')),
                      );
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text('Save Financial Information'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFinancialMetricsCard(BuildContext context) {
    final income = double.tryParse(monthlyIncomeController.text) ?? 0;
    final expenses = double.tryParse(monthlyExpensesController.text) ?? 0;
    final emergencyFund = double.tryParse(emergencyFundController.text) ?? 0;

    if (income == 0 || expenses == 0) {
      return const SizedBox.shrink();
    }

    final savingsRate = calculateSavingsRate(income, expenses);
    final emergencyMonths = calculateMonthsOfEmergencyFund(emergencyFund, expenses);
    final monthlySavings = income - expenses;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Financial Metrics',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildMetricRow(
              context,
              'Monthly Savings',
              '₹${monthlySavings.toStringAsFixed(0)}',
              monthlySavings > 0 ? Colors.green : Colors.red,
            ),
            const SizedBox(height: 12),
            _buildMetricRow(
              context,
              'Savings Rate',
              '${savingsRate.toStringAsFixed(1)}%',
              savingsRate >= 20 ? Colors.green : Colors.orange,
            ),
            const SizedBox(height: 12),
            _buildMetricRow(
              context,
              'Emergency Fund Coverage',
              '$emergencyMonths months',
              emergencyMonths >= 6 ? Colors.green : Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricRow(
    BuildContext context,
    String label,
    String value,
    Color color,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
