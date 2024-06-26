import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:taxcal/first_page.dart';
import 'package:url_launcher/url_launcher.dart';

class Marmixcal extends StatefulWidget {
  final String income;
  final String lifeHealthInsurance;
  final String healthInsuranceParent;
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

  const Marmixcal({
    Key? key,
    required this.income,
    required this.lifeHealthInsurance,
    required this.healthInsuranceParent,
    required this.homeLoan,
    required this.childbirth,
    required this.childFrom2561,
    required this.childBefore2561,
    required this.socialSecurity,
    required this.isFatherSelected,
    required this.isMotherSelected,
    required this.isDisFatherSelected,
    required this.isDisMotherSelected,
    required this.isOtherSelected,
  }) : super(key: key);

  @override
  _MarmixcalState createState() => _MarmixcalState();
}

class _MarmixcalState extends State<Marmixcal> {
  double totaldeducttion = 0.0; // Initialize with 0
  double taxcaculation = 0.0;
  bool calculationError = false;

  get currentPosition => null;

  @override
  void initState() {
    super.initState();
    // Perform calculations when the page is initialized
    calculateTax();
  }

  void calculateTax() {
    try {
      // Example calculation logic
      double income = double.parse(widget.income);
      double lifeHealthInsurance =
          double.tryParse(widget.lifeHealthInsurance) ?? 0;
      double healthInsuranceParent =
          double.tryParse(widget.healthInsuranceParent) ?? 0;
      double homeLoan = double.tryParse(widget.homeLoan) ?? 0;
      double socialSecurity = double.tryParse(widget.socialSecurity) ?? 0;
      double childbirth = double.tryParse(widget.childbirth) ?? 0;
      double childFrom2561 = double.tryParse(widget.childFrom2561) ?? 0;
      double childBefore2561 = double.tryParse(widget.childBefore2561) ?? 0;

      // Perform tax calculation here based on the received data

      double deductions = lifeHealthInsurance +
          healthInsuranceParent +
          homeLoan +
          socialSecurity +
          childbirth +
          (childFrom2561 * 60000) +
          (childBefore2561 * 30000) +
          (widget.isFatherSelected ? 30000 : 0) +
          (widget.isMotherSelected ? 30000 : 0) +
          (widget.isDisFatherSelected ? 60000 : 0) +
          (widget.isDisMotherSelected ? 60000 : 0) +
          (widget.isOtherSelected ? 60000 : 0);
      totaldeducttion = (income - deductions - 220000);
      calculationError = false;

      if (totaldeducttion >= 5000001) {
        taxcaculation = ((totaldeducttion - 5000000) * 0.35) + 126500;
      } else if (totaldeducttion >= 2000001 && totaldeducttion <= 5000000) {
        taxcaculation = ((totaldeducttion - 2000000) * 0.3) + 365000;
      } else if (totaldeducttion >= 1000001 && totaldeducttion <= 2000000) {
        taxcaculation = ((totaldeducttion - 1000000) * 0.25) + 115000;
      } else if (totaldeducttion >= 750001 && totaldeducttion <= 1000000) {
        taxcaculation = ((totaldeducttion - 750000) * 0.2) + 65000;
      } else if (totaldeducttion >= 500001 && totaldeducttion <= 750000) {
        taxcaculation = ((totaldeducttion - 500000) * 0.15) + 27500;
      } else if (totaldeducttion >= 300001 && totaldeducttion <= 500000) {
        taxcaculation = ((totaldeducttion - 300000) * 0.1) + 7500;
      } else if (totaldeducttion >= 150001 && totaldeducttion <= 300000) {
        taxcaculation = ((totaldeducttion - 150000) * 0.05) + 0;
      } else {
        taxcaculation = 0;
      }
    } catch (e) {
      print("Error calculating tax: $e");
      setState(() {
        calculationError = true;
      });
    }
  }

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
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 20),
              Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    width: 500, //width of NET INCOME fields
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[
                          200], // Change the color according to your preference
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0), // Add horizontal padding
                        child: Text(
                          'YOUR NET INCOME : ${totaldeducttion >= 0 ? totaldeducttion.toStringAsFixed(2) : '0.00'}', // Display the totaldeducttion value
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        calculationError
                            ? 'Error calculating tax'
                            : 'TAXES TO BE PAID', // Display calculated tax, ensuring it's not negative
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          color: calculationError
                              ? Colors.red
                              : const Color(0xFF998E8E),
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
                        child: Center(
                          child: Text(
                            '\฿${taxcaculation >= 0 ? taxcaculation.toStringAsFixed(2) : '0.00'}', // Placeholder text for tax amount
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
                        onPressed: () async {
                          // Get the current position
                          Position position =
                              await Geolocator.getCurrentPosition(
                            desiredAccuracy: LocationAccuracy.high,
                          );

                          // Launch Google Maps with the current position
                          double latitude = position.latitude;
                          double longitude = position.longitude;
                          String directionsUrl =
                              'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude';

                          launch(Uri.parse(directionsUrl).toString());
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
            ]),
          ),
        ));
  }
}
