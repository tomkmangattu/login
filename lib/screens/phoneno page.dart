import 'package:flutter/material.dart';
import 'package:login/screens/phoneAuth%20page.dart';

class PhoneNoScreen extends StatefulWidget {
  final bool user;
  const PhoneNoScreen({required this.user, Key? key}) : super(key: key);

  @override
  _PhoneNoScreenState createState() => _PhoneNoScreenState();
}

class _PhoneNoScreenState extends State<PhoneNoScreen> {
  String _phoneNo = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                'Please Enter Your Phone Number to Proceed...',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Form(
                key: _formKey,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  //  autofocus: true,
                  onChanged: (String value) {
                    _phoneNo = value;
                  },
                  validator: _validator,
                  decoration: InputDecoration(
                    prefixText: '+91 ',
                    labelText: 'Enter 10 digit mobile number',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _proceed,
        child: Icon(
          Icons.arrow_forward_ios,
        ),
      ),
    );
  }

  void _proceed() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => PhoneAuthScreen(phoneNo: _phoneNo)),
      );
    }
  }

  String? _validator(String? value) {
    if (value != null) {
      if (value.length == 10) return null;
      return 'Please Enter 10 digit mobile number';
    } else {
      return 'Please Enter your Phone Number';
    }
  }
}
