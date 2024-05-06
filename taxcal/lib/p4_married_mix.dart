import 'package:flutter/material.dart';
import 'married_mix_cal.dart';

class P4marmix extends StatefulWidget {
  final String income;
  final String homeLoan;
  final String socialSecurity;
  final String childbirth;
  final String childFrom2561;
  final String childBefore2561;
  final bool isFatherSelected;
  final bool isMotherSelected;
  final bool isDisFatherSelected;
  final bool isDisMotherSelected;
  final bool isOtherSelected;

  const P4marmix({
    Key? key,
    required this.income,
    required this.homeLoan,
    required this.socialSecurity,
    required this.childbirth,
    required this.isFatherSelected,
    required this.isMotherSelected,
    required this.isDisFatherSelected,
    required this.isDisMotherSelected,
    required this.isOtherSelected,
    required this.childFrom2561,
    required this.childBefore2561,
  });

  @override
  _P4marmixState createState() => _P4marmixState();
}

class _P4marmixState extends State<P4marmix> {
  final _lifehealthInsuController = TextEditingController();
  final _healthInsuParentController = TextEditingController();
  final _childbirthController = TextEditingController();
  final _childFrom2561Controller = TextEditingController();
  final _childBefore2561Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70), // Adjust the height as needed
        child: AppBar(
          backgroundColor: const Color(0xFF0C3A2D),
          title: const Text(
            'Back',
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
            const SizedBox(height: 20),
            buildLifeOrInsu(
              _lifehealthInsuController,
              'Life and/or health insurance premiums',
              'Life insurance and health insurance together must not exceed 100,000 baht',
            ),
            const SizedBox(height: 20),
            buildHealthInsu(
              _healthInsuParentController,
              'Health insurance premiums for parents',
              'Must not exceed than 15,000 baht',
            ),
            const SizedBox(height: 20),
            childbirth(
              _childbirthController,
              'Prenatal care and childbirth costs',
              'Must not exceed than 60,000 baht',
            ),
            const SizedBox(height: 20),
            childFrom2561(
              _childFrom2561Controller,
              'Number of your children born SINCE B.E.2561',
              'From B.E.2561, until now (Deduction 60,000 baht)',
            ),
            const SizedBox(height: 20),
            childBefore2561(
              _childBefore2561Controller,
              'Number of your children born BEFORE B.E.2561',
              'From B.E.2560, going back (Deduction 30,000 baht)',
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

  Widget buildDescription(String description) {
    return Text(
      description,
      style: const TextStyle(
        fontSize: 12,
        color: Colors.grey,
      ),
    );
  }

  Widget buildLifeOrInsu(
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
        if (value.isNotEmpty) {
          if (isNumeric(value)) {
            double amount = double.parse(value);
            if (amount > 100000) {
              controller.text = '100000';
            }
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Invalid Input"),
                  content: const Text("Please enter a valid numeric value."),
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
      },
    );
  }

  Widget buildHealthInsu(
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
        if (value.isNotEmpty) {
          if (isNumeric(value)) {
            double amount = double.parse(value);
            if (amount > 15000) {
              controller.text = '15000';
            }
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Invalid Input"),
                  content: const Text("Please enter a valid numeric value."),
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
      },
    );
  }

  Widget childbirth(
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
        if (value.isNotEmpty) {
          if (isNumeric(value)) {
            double amount = double.parse(value);
            if (amount > 60000) {
              controller.text = '60000';
            }
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Invalid Input"),
                  content: const Text("Please enter a valid numeric value."),
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
      },
    );
  }

  Widget childFrom2561(
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
        if (value.isNotEmpty) {
          if (isNumeric(value)) {
            double amount = double.parse(value);
            if (amount > 7) {
              controller.text = '7';
            }
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Invalid Input"),
                  content: const Text("Please enter a valid numeric value."),
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
      },
    );
  }

  Widget childBefore2561(
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
        if (value.isNotEmpty) {
          if (isNumeric(value)) {
            double amount = double.parse(value);
            if (amount > 7) {
              controller.text = '7';
            }
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Invalid Input"),
                  content: const Text("Please enter a valid numeric value."),
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
      },
    );
  }

  Widget buildNextButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          String lifeHealthInsurance = _lifehealthInsuController.text.trim();
          String healthInsuranceParent =
              _healthInsuParentController.text.trim();
          String childbirth = _childbirthController.text.trim();
          String childFrom2561 = _childFrom2561Controller.text.trim();
          String childBefore2561 = _childBefore2561Controller.text.trim();
          bool isValid = true;

          if (lifeHealthInsurance.isNotEmpty) {
            if (!isNumeric(lifeHealthInsurance)) {
              isValid = false;
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Invalid Input"),
                    content: const Text(
                        "Please enter a valid numeric value for Life and/or health insurance premiums."),
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
            } else if (double.parse(lifeHealthInsurance) > 100000) {
              isValid = false;
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Invalid Input"),
                    content: const Text(
                        "Life and/or health insurance premiums must not exceed 100,000 baht."),
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

          if (healthInsuranceParent.isNotEmpty) {
            if (!isNumeric(healthInsuranceParent)) {
              isValid = false;
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Invalid Input"),
                    content: const Text(
                        "Please enter a valid numeric value for Health insurance premiums for parents."),
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
            } else if (double.parse(healthInsuranceParent) > 15000) {
              isValid = false;
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Invalid Input"),
                    content: const Text(
                        "Health insurance premiums for parents must not exceed 15,000 baht."),
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

          if (childbirth.isNotEmpty) {
            if (!isNumeric(childbirth)) {
              isValid = false;
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Invalid Input"),
                    content: const Text(
                        "Please enter a valid numeric value for Prenatal care and childbirth costs."),
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
            } else if (double.parse(childbirth) > 60000) {
              isValid = false;
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Invalid Input"),
                    content: const Text(
                        "Prenatal care and childbirth costs must not exceed 60,000 baht."),
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

          if (childFrom2561.isNotEmpty) {
            if (!isNumeric(childFrom2561)) {
              isValid = false;
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Invalid Input"),
                    content: const Text(
                        "Please enter a valid numeric value for Number of your children born SINCE B.E.2561."),
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
            } else if (double.parse(childFrom2561) > 7) {
              isValid = false;
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Invalid Input"),
                    content: const Text(
                        "Number of your children born SINCE B.E.2561 must not exceed 7 person."),
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

          if (childBefore2561.isNotEmpty) {
            if (!isNumeric(childBefore2561)) {
              isValid = false;
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Invalid Input"),
                    content: const Text(
                        "Please enter a valid numeric value for Number of your children born BEFORE B.E.2561"),
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
            } else if (double.parse(childBefore2561) > 7) {
              isValid = false;
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Invalid Input"),
                    content: const Text(
                        "Number of your children born BEFORE B.E.2561 must not exceed 7 person."),
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
                builder: (context) => Marmixcal(
                  income: widget.income,
                  lifeHealthInsurance: lifeHealthInsurance,
                  healthInsuranceParent: healthInsuranceParent,
                  homeLoan: widget.homeLoan,
                  childbirth: childbirth,
                  socialSecurity: widget.socialSecurity,
                  isFatherSelected: widget.isFatherSelected,
                  isMotherSelected: widget.isMotherSelected,
                  isDisFatherSelected: widget.isDisFatherSelected,
                  isDisMotherSelected: widget.isDisMotherSelected,
                  isOtherSelected: widget.isOtherSelected,
                  childFrom2561: childFrom2561,
                  childBefore2561: childBefore2561,
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
            'CALCULATE',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white),
          ),
        ),
      ),
    );
  }

  bool isNumeric(String value) {
    return double.tryParse(value) != null;
  }
}
