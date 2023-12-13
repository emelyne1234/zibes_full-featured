import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:crud/place.dart';

class BookingPage extends StatefulWidget {
  final Place place;

  const BookingPage({Key? key, required this.place}) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  TextEditingController _fromDateController = TextEditingController();
  TextEditingController _toDateController = TextEditingController();
  TextEditingController _visitorController = TextEditingController();
  TextEditingController _contactNumberController = TextEditingController();

  DateTime? _fromDate;
  DateTime? _toDate;

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)), // One year from now
    );

    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        if (isFromDate) {
          _fromDate = pickedDate;
          _fromDateController.text =
              DateFormat('yyyy-MM-dd').format(pickedDate);
        } else {
          _toDate = pickedDate;
          _toDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book ${widget.place.name}'),
        backgroundColor: Colors.green[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Select Booking Dates:',
              style: TextStyle(fontSize: 18),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _fromDateController,
                    onTap: () => _selectDate(context, true),
                    decoration: InputDecoration(
                      labelText: 'From Date',
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _toDateController,
                    onTap: () => _selectDate(context, false),
                    decoration: InputDecoration(
                      labelText: 'To Date',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Number of Visitors:',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: _visitorController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Visitors'),
            ),
            SizedBox(height: 16),
            Text(
              'Contact Number:',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: _contactNumberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: 'Contact Number'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 10, 79, 13)),
                minimumSize: MaterialStateProperty.all<Size>(Size(200.0, 50.0)),
              ),
              onPressed: () {
                // Implement the logic to save booking to Firestore
                // You can use _fromDate, _toDate, _visitorController.text, and _contactNumberController.text
                // Also, consider adding validation before saving.
              },
              child: Text(
                'Book Now',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
