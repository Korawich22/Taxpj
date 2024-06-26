import 'package:flutter/material.dart';
import 'package:taxcal/p4_married_mix.dart';

class P3marmix extends StatefulWidget {
  final String income;
  final Function(bool) notifyFatherCheckboxSelected;
  final Function(bool) notifyMotherCheckboxSelected;
  final Function(bool) notifyDisFatherCheckboxSelected;
  final Function(bool) notifyDisMotherCheckboxSelected;
  final Function(bool) notifyOtherCheckboxSelected;

  const P3marmix({
    Key? key,
    required this.income,
    required this.notifyFatherCheckboxSelected,
    required this.notifyMotherCheckboxSelected,
    required this.notifyDisFatherCheckboxSelected,
    required this.notifyDisMotherCheckboxSelected,
    required this.notifyOtherCheckboxSelected,
  }) : super(key: key);

  @override
  _P3marmixState createState() => _P3marmixState();
}

class _P3marmixState extends State<P3marmix> {
  final _homeLoanController = TextEditingController();
  final _socialSecurityController = TextEditingController();
  final _childbirthController = TextEditingController();
  final _childFrom2561Controller = TextEditingController();
  final _childBefore2561Controller = TextEditingController();
  List<String> selectedParentalCare = [];
  List<String> selectedDisabledCare = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70), // Adjust the height as needed
        child: AppBar(
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
            scale: 0.7,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFFFB902),
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Color(0xFF0C3A2D),
                size: 28,
              ),
            ),
          ),
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(17), // Adjust the radius as needed
              bottomRight: Radius.circular(17), // Adjust the radius as needed
            ),
          ),
      ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionTitle('Parental Care Allowance'),
            buildCareOptions(
              ['Father', 'Mother'],
              selectedParentalCare,
              (String? value) {
                setState(() {
                  if (selectedParentalCare.contains(value)) {
                    selectedParentalCare.remove(value);
                  } else {
                    selectedParentalCare.add(value!);
                    if (value == 'Father') {
                      widget.notifyFatherCheckboxSelected(true);
                    }
                  }
                });
              },
            ),
            buildDescription(
              '** 30,000 baht each (Parents must be over 60 years old and have income not exceeding 30,000 baht per year)',
            ),
            const SizedBox(height: 20),
            buildSectionTitle('Disabled/incapacitated Care Allowance'),
            buildCareOptions(
              ['Father', 'Mother', 'Other'],
              selectedDisabledCare,
              (String? value) {
                setState(() {
                  if (selectedDisabledCare.contains(value)) {
                    selectedDisabledCare.remove(value);
                  } else {
                    selectedDisabledCare.add(value!);
                  }
                });
              },
            ),
            buildDescription(
              '** 60,000 baht per person (Must have a disabled person identification card and have no income)',
            ),
            const SizedBox(height: 20),
            buildHomelone(
              _homeLoanController,
              'Home Loan',
              'Not exceed 100,000 Baht',
            ),
            const SizedBox(height: 20),
            buildSocialFund(
              _socialSecurityController,
              'Social Security Fund',
              'Not exceed 9,000 Baht',
            ),
            const SizedBox(height: 20),
            buildNextButton(),
          ],
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildCareOptions(List<String> options, List<String> selectedValues,
      Function(String?) onChanged) {
    return Column(
      children: options
          .map(
            (option) => CheckboxListTile(
              title: Text(option),
              value: selectedValues.contains(option),
              onChanged: (value) => onChanged(option),
            ),
          )
          .toList(),
    );
  }

  Widget buildDescription(String description) {
    return Text(
      description,
      style: const TextStyle(
        fontSize: 12,
        color: Colors.grey,
      ),
    );
  }

  Widget buildHomelone(
    TextEditingController controller,
    String labelText,
    String helperText,
  ) {
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
        helperText: helperText,
      ),
      onChanged: (value) {
        if (value.isNotEmpty && isNumeric(value)) {
          double amount = double.parse(value);
          if (amount > 100000) {
            controller.text = '100000';
          }
        } else if (value.isNotEmpty) {
          // Show warning popup for invalid input
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Invalid Input'),
                content: const Text('Please enter a valid numeric value.'),
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
      },
    );
  }

  Widget buildSocialFund(
    TextEditingController controller,
    String labelText,
    String helperText,
  ) {
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
        helperText: helperText,
      ),
      onChanged: (value) {
        if (value.isNotEmpty && isNumeric(value)) {
          double amount = double.parse(value);
          if (amount > 9000) {
            controller.text = '9000';
          }
        } else if (value.isNotEmpty) {
          // Show warning popup for invalid input
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Invalid Input'),
                content: const Text('Please enter a valid numeric value.'),
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
      },
    );
  }

  Widget buildNextButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          String homeLoan = _homeLoanController.text.trim();
          String socialSecurity = _socialSecurityController.text.trim();
          bool isValid = true;

          if (homeLoan.isNotEmpty) {
            if (!isNumeric(homeLoan)) {
              isValid = false;
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Invalid Input"),
                    content: const Text(
                        "Please enter a valid numeric value for Hoam Loan."),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("OK"),
                      ),
                    ],
                  );
                },
              );
            } else if (double.parse(homeLoan) > 100000) {
              isValid = false;
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Invalid Input"),
                    content:
                        const Text("Home Loan must not exceed 100,000 baht."),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("OK"),
                      ),
                    ],
                  );
                },
              );
            }
          }

          if (socialSecurity.isNotEmpty) {
            if (!isNumeric(socialSecurity)) {
              isValid = false;
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Invalid Input"),
                    content: const Text(
                        "Please enter a valid numeric value for Social Security Fund."),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("OK"),
                      ),
                    ],
                  );
                },
              );
            } else if (double.parse(socialSecurity) > 9000) {
              isValid = false;
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Invalid Input"),
                    content: const Text(
                        "Social Security Fund must not exceed 9,000 baht."),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("OK"),
                      ),
                    ],
                  );
                },
              );
            }
          }

          if (isValid) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => P4marmix(
                  income: widget.income,
                  homeLoan: _homeLoanController.text,
                  socialSecurity: _socialSecurityController.text,
                  childbirth: _childbirthController.text,
                  isFatherSelected: selectedParentalCare.contains('Father'),
                  isMotherSelected: selectedParentalCare.contains('Mother'),
                  isDisFatherSelected: selectedDisabledCare.contains('Father'),
                  isDisMotherSelected: selectedDisabledCare.contains('Mother'),
                  isOtherSelected: selectedDisabledCare.contains('Other'),
                  childFrom2561: _childFrom2561Controller.text,
                  childBefore2561: _childBefore2561Controller.text,
                ),
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6D9674),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 3,
        ),
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'NEXT',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
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

bool isNumeric(String value) {
  return double.tryParse(value) != null;
}
