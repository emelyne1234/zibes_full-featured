import 'package:crud/home_pageI.dart';
import 'package:flutter/material.dart';

class UpdateUserDialog extends StatefulWidget {
  final Function(Map<String, dynamic>?) onUpdate;
  final String currentFirstName;
  final String currentSecondName;
  final String currentEmail;

  const UpdateUserDialog({
    Key? key,
    required this.onUpdate,
    required this.currentFirstName,
    required this.currentSecondName,
    required this.currentEmail,
  }) : super(key: key);

  @override
  _UpdateUserDialogState createState() => _UpdateUserDialogState();
}

class _UpdateUserDialogState extends State<UpdateUserDialog> {
  late TextEditingController _firstNameController;
  late TextEditingController _secondNameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.currentFirstName);
    _secondNameController =
        TextEditingController(text: widget.currentSecondName);
    _emailController = TextEditingController(text: widget.currentEmail);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Update User'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _firstNameController,
            decoration: const InputDecoration(labelText: 'First Name'),
          ),
          TextField(
            controller: _secondNameController,
            decoration: const InputDecoration(labelText: 'Second Name'),
          ),
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            String updatedFirstName = _firstNameController.text;
            String updatedSecondName = _secondNameController.text;
            String updatedEmail = _emailController.text;

            // Perform the update
            Map<String, dynamic> updatedInfo = {
              'firstname': updatedFirstName,
              'secondname': updatedSecondName,
              'email': updatedEmail,
            };

            // Send the updated information back to the caller
            widget.onUpdate(updatedInfo);

            Navigator.of(context).pop();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (BuildContext context) => HomePage()),
            ); // Close the dialog
          },
          child: const Text('Update'),
        ),
      ],
    );
  }
}
