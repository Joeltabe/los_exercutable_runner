import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Animated logo or image
              Container(
                margin: EdgeInsets.only(top: 50.0),
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: Duration(seconds: 1),
                  builder: (BuildContext context, double value, Widget? child) {
                    return Opacity(
                      opacity: value,
                      child: child,
                    );
                  },
                  child:
                      Image.asset('assets/logo.png', width: 150, height: 150),
                ),
              ),
              SizedBox(height: 20.0),
              // App information
              Text(
                'Los Executable Runner',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              Text(
                'Version 1.0.0',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 20.0),
              // App description
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'This app allows you to run Windows executables on Linux using Wine.',
                  style: TextStyle(fontSize: 18.0),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20.0),
              // Policies section
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Text(
                      'Policies',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Please make sure to review and comply with the following policies:',
                      style: TextStyle(fontSize: 16.0),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      '1. Terms of Service\n\n2. Privacy Policy\n\n3. End User License Agreement',
                      style: TextStyle(fontSize: 16.0),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
