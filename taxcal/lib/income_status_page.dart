import 'package:flutter/material.dart';
import 'package:taxcal/p3_single.dart';
import 'package:taxcal/p3_widdow.dart';
import 'package:taxcal/p3_married_mix.dart';

class IncomeStatusPage extends StatefulWidget {
  const IncomeStatusPage({Key? key}) : super(key: key);

  @override
  _IncomeStatusPageState createState() => _IncomeStatusPageState();
}

class _IncomeStatusPageState extends State<IncomeStatusPage> {
  final _incomeController = TextEditingController();
  String selectedStatus = '';
  String? selectedMarriedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0C3A2D),
        title: const Text(
          'Start Taxation',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Transform.scale(
            scale: 0.8,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFFFB902),
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Color(0xFF0C3A2D),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            buildIncome(_incomeController, 'Income Per Year'),
            const SizedBox(height: 20),
            buildStatusDropdown(),
            const SizedBox(
              height: 20,
            ),
            if (selectedStatus == 'Married') ...[
              const SizedBox(height: 20),
              buildMarriedOptions(),
            ],
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                if (selectedStatus.isEmpty) {
                  showWarningDialog(context, 'Please select a status.');
                } else if (selectedStatus == 'Married' &&
                    selectedMarriedOption == null) {
                  showWarningDialog(
                      context, 'Please select a tax filing type.');
                } else if (_incomeController.text.isEmpty ||
                    !isNumeric(_incomeController.text)) {
                  showWarningDialog(context, 'Please enter a valid income.');
                } else {
                  if (selectedStatus == 'Single') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => P3single(
                          income: _incomeController.text,
                          notifyFatherCheckboxSelected: (value) {},
                          notifyMotherCheckboxSelected: (value) {},
                          notifyDisFatherCheckboxSelected: (value) {},
                          notifyDisMotherCheckboxSelected: (value) {},
                          notifyOtherCheckboxSelected: (value) {},
                        ),
                      ),
                    );
                  } else if (selectedStatus == 'Married') {
                    if (selectedMarriedOption == 'Filing Jointly') {
                      // Navigate to Filing Jointly page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => P3marmix(
                            income: _incomeController.text,
                            notifyFatherCheckboxSelected: (value) {},
                            notifyMotherCheckboxSelected: (value) {},
                            notifyDisFatherCheckboxSelected: (value) {},
                            notifyDisMotherCheckboxSelected: (value) {},
                            notifyOtherCheckboxSelected: (value) {},
                          ),
                        ),
                      );
                    } else if (selectedMarriedOption == 'Filing Separately') {
                      // Navigate to Filing Separately page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => P3widdow(
                            income: _incomeController.text,
                            notifyFatherCheckboxSelected: (value) {},
                            notifyMotherCheckboxSelected: (value) {},
                            notifyDisFatherCheckboxSelected: (value) {},
                            notifyDisMotherCheckboxSelected: (value) {},
                            notifyOtherCheckboxSelected: (value) {},
                          ),
                        ),
                      );
                    }
                  } else {
                    if (selectedStatus == 'Divorced/Widowed') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => P3widdow(
                            income: _incomeController.text,
                            notifyFatherCheckboxSelected: (value) {},
                            notifyMotherCheckboxSelected: (value) {},
                            notifyDisFatherCheckboxSelected: (value) {},
                            notifyDisMotherCheckboxSelected: (value) {},
                            notifyOtherCheckboxSelected: (value) {},
                          ),
                        ),
                      );
                    }
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6D9674),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                minimumSize: const Size(double.infinity, 60),
              ),
              child: const Text(
                'NEXT',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIncome(TextEditingController controller, String labelText) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          fontFamily: 'Poppins',
          color: Color.fromARGB(255, 0, 0, 0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFFFB902)),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFFFB902)),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter income';
        }
        if (!isNumeric(value)) {
          return 'Please enter a valid number';
        }
        return null;
      },
    );
  }

  Widget buildStatusDropdown() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFFFB902)),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            labelText: 'Select Status',
            labelStyle: TextStyle(
              fontFamily: 'Poppins',
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            border: InputBorder.none,
          ),
          value: selectedStatus,
          onChanged: (String? value) {
            setState(() {
              selectedStatus = value ?? '';
              selectedMarriedOption = null; // Reset the selected option
            });
          },
          items: <String>['', 'Single', 'Married', 'Divorced/Widowed']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget buildMarriedOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tax filing type',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                child: RadioListTile<String>(
                  title: const Text('Filing Jointly'),
                  value: 'Filing Jointly',
                  groupValue: selectedMarriedOption,
                  onChanged: (String? value) {
                    setState(() {
                      selectedMarriedOption = value;
                    });
                  },
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: RadioListTile<String>(
                  title: const Text('Filing Separately'),
                  value: 'Filing Separately',
                  groupValue: selectedMarriedOption,
                  onChanged: (String? value) {
                    setState(() {
                      selectedMarriedOption = value;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  bool isNumeric(String value) {
    return double.tryParse(value) != null;
  }

  void showWarningDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Warning'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
