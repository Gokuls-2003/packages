import 'package:bmi/bmi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BmiCalculatorPage extends HookWidget {
  void _update({
    ValueNotifier<TextEditingValue>? weightController,
    ValueNotifier<TextEditingValue>? heightController,
    ValueNotifier<TextEditingValue>? bmiController,
  }) {
    final weight = double.tryParse(weightController!.value.text);
    final height = double.tryParse(heightController!.value.text);
    if (weight != null && height != null) {
      final bmi = calculateBMI(weight, height);
      final formatted = formattedBmi(bmi);
      bmiController!.value = TextEditingValue(text: formatted);
    } else {
      bmiController!.value = TextEditingValue(text: '');
    }
  }

  @override
  Widget build(BuildContext context) {
    final weightController = useTextEditingController();
    final heightController = useTextEditingController();
    final bmiController = useTextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: weightController,
              decoration: InputDecoration(labelText: 'Weight (kg)'),
              keyboardType: TextInputType.number,
              onChanged: (_) => _update(
                  weightController: weightController,
                  heightController: heightController,
                  bmiController: bmiController),
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
            ),
            TextField(
              controller: heightController,
              decoration: InputDecoration(labelText: 'Height (m)'),
              keyboardType: TextInputType.number,
              onChanged: (_) => _update(
                  weightController: weightController,
                  heightController: heightController,
                  bmiController: bmiController),
            ),
            TextField(
              controller: bmiController,
              decoration: InputDecoration(labelText: 'BMI'),
              readOnly: true,
            ),
          ],
        ),
      ),
    );
  }
}
