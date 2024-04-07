import 'package:flutter/material.dart';
import 'package:taxcal/first_page.dart';

class Singcal extends StatefulWidget {
  final String income;
  final String lifeHealthInsurance;
  final String healthInsuranceParent;
  final String homeLoan;
  final String socialSecurity;
  final bool isFatherSelected;
  final bool isMotherSelected;
  final bool isDisFatherSelected;
  final bool isDisMotherSelected;
  final bool isOtherSelected;

  const Singcal({
    Key? key,
    required this.income,
    required this.lifeHealthInsurance,
    required this.healthInsuranceParent,
    required this.homeLoan,
    required this.socialSecurity,
    required this.isFatherSelected,
    required this.isMotherSelected,
    required this.isDisFatherSelected,
    required this.isDisMotherSelected,
    required this.isOtherSelected,
  }) : super(key: key);

  @override
  _SingcalState createState() => _SingcalState();
}

class _SingcalState extends State<Singcal> {
  double calculatedTax = 0.0; // Initialize with 0

  @override
  void initState() {
    super.initState();
    // Perform calculations when the page is initialized
    calculateTax();
  }

  void calculateTax() {
    // Example calculation logic
    double income = double.parse(widget.income);
    double lifeHealthInsurance = double.parse(widget.lifeHealthInsurance);
    double healthInsuranceParent = double.parse(widget.healthInsuranceParent);
    double homeLoan = double.parse(widget.homeLoan);
    double socialSecurity = double.parse(widget.socialSecurity);

    // Perform your tax calculation here based on the received data
    // This is just an example calculation, replace it with your actual calculation logic
    double totalDeductions = lifeHealthInsurance +
        healthInsuranceParent +
        homeLoan +
        socialSecurity +
        (widget.isFatherSelected
            ? 30000
            : 0) + // Add 30000 if Father checkbox is selected
        (widget.isMotherSelected ? 30000 : 0) +
        (widget.isDisFatherSelected ? 60000 : 0) +
        (widget.isDisMotherSelected ? 60000 : 0) +
        (widget.isOtherSelected ? 60000 : 0);

    calculatedTax = income - totalDeductions; // Example calculation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'TAXES TO BE PAID: \$${calculatedTax.toStringAsFixed(2)}', // Display calculated tax
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      color: Color(0xFF998E8E),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 250,
                    height: 250,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFFFB902),
                    ),
                    child: const Center(
                      child: Text(
                        '\$0', // Placeholder text for tax amount
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '** This tax calculator is considered a preliminary calculation only by using data from tax year 2023. Our application does not guarantee the accuracy of the data and results. For additional deductions in tax year 2023, please check further from the announcement of the Revenue Department.',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FirstPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6D9674),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      minimumSize: const Size(double.infinity, 60),
                    ),
                    child: const Text(
                      'GOT IT!',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FirstPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6D9674),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      minimumSize: const Size(double.infinity, 60),
                    ),
                    child: const Text(
                      'FIND PLACE',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
