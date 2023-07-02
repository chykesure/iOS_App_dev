import 'package:flutter/material.dart';
import 'dart:async';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'mainpage.dart'; // Import the homepage.dart file
import 'package:flutter/services.dart'
    show FilteringTextInputFormatter, rootBundle;
import 'dart:convert';


void main() {
  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const MaterialColor customPrimarySwatch = MaterialColor(
      0xFFF7D3D3,
      <int, Color>{
        50: Color(0xFFFFF0F0),
        100: Color(0xFFFFD9D9),
        200: Color(0xFFFFC0C0),
        300: Color(0xFFFFA7A7),
        400: Color(0xFFFF8E8E),
        500: Color(0xFFFF7575),
        600: Color(0xFFFF6B6B),
        700: Color(0xFFFF6161),
        800: Color(0xFFFF5757),
        900: Color(0xFFFF4848),
      },
    );

    return MaterialApp(
      title: 'Homepage',
      theme: ThemeData(
        primarySwatch: customPrimarySwatch,
        scaffoldBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        //backgroundColor: Color(0xFFF6C9CB),
      ),
      home: HomePage(),
      routes: {
        '/memopage': (context) => const MemoPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Uncomment one of the following options based on your preference.

    // Option 1: Keep the original animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    // Option 2: Use a loading GIF
    Timer(const Duration(seconds: 5), () {
      Navigator.pushNamed(context, '/memopage');
    });
  }

  @override
  void dispose() {
    _controller.stop(); // Stop the animation controller
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'images/logo.png',
              width: 250,
              height: 250,
            ),
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                // Uncomment one of the following options based on your preference.

                // Option 1: Keep the original animation

                // Option 2: Use a loading GIF
                return SpinKitFadingCircle(
                  color: Colors.white,
                  size: 50.0,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CountryCode {
  final String code;
  final String name;

  CountryCode({required this.code, required this.name});
}

class MemoPage extends StatelessWidget {
  const MemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: YourWidget(),
    );
  }
}

class YourWidget extends StatefulWidget {
  @override
  _YourWidgetState createState() => _YourWidgetState();
}

class _YourWidgetState extends State<YourWidget> {
  List<CountryCode> countryCodes = [];
  CountryCode? selectedCountryCode; // Track the selected country code

  @override
  void initState() {
    super.initState();
    fetchCountryCodes();
  }

  Future<void> fetchCountryCodes() async {
    final countryCodeData =
        await rootBundle.loadString('assets/country_codes.json');
    final List<dynamic> jsonList = json.decode(countryCodeData);

    final List<CountryCode> codes = jsonList
        .map((json) => CountryCode(code: json['code'], name: json['name']))
        .toList();

    setState(() {
      countryCodes = codes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      'images/logo.png',
                      width: 200,
                      height: 200,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              inputDecorationTheme: InputDecorationTheme(
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF410101)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF410101)),
                                ),
                              ),
                            ),
                            child: Container(
                              width: 150,
                              child: DropdownButtonFormField<CountryCode>(
                                decoration: InputDecoration(
                                  labelText: '+234',
                                  labelStyle: TextStyle(
                                    color: Color(0xFF410101),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 2,
                                    horizontal: 8,
                                  ),
                                ),
                                value: selectedCountryCode,
                                items: countryCodes.map((code) {
                                  return DropdownMenuItem<CountryCode>(
                                    value: code,
                                    child: Text(code.code),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedCountryCode = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          flex: 2,
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              inputDecorationTheme: InputDecorationTheme(
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF410101)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF410101)),
                                ),
                              ),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Phone Number',
                                labelStyle: TextStyle(
                                  color: Color(0xFF410101),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 2,
                                  horizontal: 8,
                                ),
                              ),
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text.rich(
                    TextSpan(
                      text: 'If you sign up, ',
                      style: TextStyle(
                        color: Color(0xFF410101),
                        fontSize: 9,
                        fontFamily: 'Lato',
                      ),
                      children: [
                        TextSpan(
                          text: 'Terms & Condition and Privacy policy',
                          style: TextStyle(
                            color: Color(0xFF410101),
                            fontSize: 9,
                            fontFamily: 'Lato',
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        TextSpan(
                          text: ' apply.',
                          style: TextStyle(
                            color: Color(0xFF410101),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: 230,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OTPPage(),
                          ),
                        );
                      },
                      child: Text('Continue'),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyAppp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OTP Verification',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OTPPage(),
    );
  }
}

class OTPPage extends StatefulWidget {
  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final TextEditingController otpController1 = TextEditingController();
  final TextEditingController otpController2 = TextEditingController();
  final TextEditingController otpController3 = TextEditingController();
  final TextEditingController otpController4 = TextEditingController();

  void showSuccessModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('OTP verification successful!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Dashboard()),
                );
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildOtpBox(otpController1),
                  buildOtpBox(otpController2),
                  buildOtpBox(otpController3),
                  buildOtpBox(otpController4),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Handle OTP verification logic here
                  String otp = otpController1.text +
                      otpController2.text +
                      otpController3.text +
                      otpController4.text;
                  // Validate OTP and proceed accordingly
                  if (otp == '1234') {
                    showSuccessModal(context);
                  } else {
                    // Show error message or perform other actions
                  }
                },
                child: Text('Verify OTP'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOtpBox(TextEditingController controller) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        maxLength: 1,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ],
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(borderSide: BorderSide.none),
          counterText: '',
        ),
      ),
    );
  }
}
