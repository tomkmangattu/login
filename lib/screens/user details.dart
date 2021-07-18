import 'package:flutter/material.dart';
import 'package:login/screens/home%20page.dart';

class UserDetails extends StatefulWidget {
  static const String id = 'user Info';
  const UserDetails({Key? key}) : super(key: key);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _firstName = '';
  String _lastName = '';
  String _email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            _formField(
              'first name',
              Icons.person,
              TextInputType.name,
              _onFistNameChange,
            ),
            _formField(
              'last name',
              Icons.person,
              TextInputType.name,
              _onLastNameChange,
            ),
            _formField(
              'email id',
              Icons.email,
              TextInputType.emailAddress,
              _onEmailIdChange,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _proceed,
        child: Icon(Icons.arrow_forward_ios),
      ),
    );
  }

  void _proceed() {
    if (_formKey.currentState!.validate()) {
      Navigator.popAndPushNamed(context, HomePage.id);
    }
  }

  void _onFistNameChange(String value) {
    _firstName = value;
    // print(value);
  }

  void _onLastNameChange(String value) {
    _firstName = value;
  }

  void _onEmailIdChange(String value) {
    _firstName = value;
  }

  String? _validator(String? value) {
    if (value != null) {
      if (value.length == 0) return 'Field Cannot be empty';
      return null;
    }
    return 'Field Cannot be empty';
  }

  Padding _formField(final String text, final IconData icon, TextInputType type,
      Function(String) onChange) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: type,
        onChanged: onChange,
        validator: _validator,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: text,
          focusedBorder: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(),
          errorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
        ),
      ),
    );
  }
}
