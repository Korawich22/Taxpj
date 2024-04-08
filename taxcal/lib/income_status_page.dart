import 'package:flutter/material.dart';
import 'package:taxcal/p3_single.dart';
import 'package:taxcal/p3_widdow.dart';
// Update with your actual project name and file path

class IncomeStatusPage extends StatefulWidget {
  const IncomeStatusPage({Key? key}) : super(key: key);

  @override
  _IncomeStatusPageState createState() => _IncomeStatusPageState();
}

class _IncomeStatusPageState extends State<IncomeStatusPage> {
  final _incomeController = TextEditingController();
  String selectedStatus = ''; // Initialize with empty string

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0C3A2D), // Green color for the app bar
        title: const Text(
          'Start Taxation',
          style: TextStyle(
            fontFamily: 'Poppins', // Use Poppins font
            color: Colors.white, // White color for the text
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Transform.scale(
            scale: 0.8, // Adjust the scale factor as needed
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFFFB902), // Yellow color for the back button
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Color(0xFF0C3A2D), // White color for the back arrow
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
                height: 40), // Increased space between dropdown and button
            ElevatedButton(
              onPressed: () {
                if (selectedStatus.isEmpty) {
                  showWarningDialog(context, 'Please select a status.');
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
                backgroundColor:
                    const Color(0xFF6D9674), // Green color for the button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                minimumSize:
                    const Size(double.infinity, 60), // Full width button
              ),
              child: const Text(
                'NEXT',
                style: TextStyle(
                  fontFamily: 'Poppins', // Use Poppins font
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white, // White color for the text
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
        border:
            Border.all(color: const Color(0xFFFFB902)), // Yellow border color
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            labelText: 'Select Status',
            labelStyle: TextStyle(
              fontFamily: 'Poppins', // Use Poppins font
              color: Color.fromARGB(255, 0, 0, 0), // Yellow color for the label
            ),
            border: InputBorder.none,
          ),
          value: selectedStatus,
          onChanged: (String? value) {
            setState(() {
              selectedStatus = value ?? '';
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
