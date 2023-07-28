// ignore_for_file: constant_identifier_names, use_key_in_widget_constructors, library_private_types_in_public_api
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum FormFieldType {
  Email,
  Name,
  Password,
}

class FormValidation extends StatefulWidget {
  final FormFieldType fieldType;
  final double formWidth;
  final TextEditingController controller;

  const FormValidation(
      {required this.fieldType,
      required this.formWidth,
      required this.controller});

  @override
  _FormValidationState createState() => _FormValidationState();
}

class _FormValidationState extends State<FormValidation> {
  final TextEditingController _controller = TextEditingController();
  bool _showError = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_validate);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _validate() {
    setState(() {
      _showError = _controller.text.isNotEmpty;
    });
  }

  String? _validateField(String value) {
    switch (widget.fieldType) {
      case FormFieldType.Email:
        return _validateEmail(value);
      case FormFieldType.Name:
        return _validateName(value);
      case FormFieldType.Password:
        return _validatePassword(value);
    }
  }

  String? _validateEmail(String value) {
    if (value.contains('@') && value.contains('.com')) {
      return null; // Valid email
    }
    return 'Geçersiz e-posta adresi';
  }

  String? _validateName(String value) {
    if (value.trim().isNotEmpty) {
      return null; // Valid name
    }
    return 'İsim Alanı Boş Bırakılamaz';
  }

  String? _validatePassword(String value) {
    if (value.length > 8) {
      return null; // Valid password
    }
    return 'Şifre en az 8 karakter olmalıdır';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.formWidth,
      child: Column(
        children: [
          TextField(
            controller: widget.controller,
            onChanged: (value) {
              setState(() {
                _showError = value.isNotEmpty;
              });
            },
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  width: 3,
                  color: Color.fromRGBO(57, 210, 192, 1),
                ),
              ),
              filled: true,
              fillColor: const Color.fromARGB(255, 255, 255, 255),
              hintText: _getHintText(),
              hintStyle: const TextStyle(
                color: Colors.grey,
              ),
              errorText: _showError ? _validateField(_controller.text) : null,
              // Set obscureText to true for the password field
            ),
            obscureText: widget.fieldType == FormFieldType.Password,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  String _getHintText() {
    switch (widget.fieldType) {
      case FormFieldType.Email:
        return 'E-Posta';
      case FormFieldType.Name:
        return 'Ad Soyad';
      case FormFieldType.Password:
        return 'Şifre';
    }
  }
}
