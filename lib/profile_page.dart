import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late User _user;
  List<Map<String, dynamic>> _userBookings = [];

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadUserBookings();
  }

  Future<void> _loadUserData() async {
    _user = _auth.currentUser!;
  }

  Future<void> _loadUserBookings() async {
    CollectionReference userBookingsCollection =
        _firestore.collection('user-bookings');

    QuerySnapshot bookingSnapshot = await userBookingsCollection
        .where('userId', isEqualTo: _user.uid)
        .get();

    _userBookings = bookingSnapshot.docs
        .map((doc) => {
              'bookingId': doc.id,
              ...doc.data() as Map<String, dynamic>,
            })
        .toList();

    setState(() {});
  }

  Future<void> _deleteAccount() async {
    // Add your logic to delete the user's account
  }

  Future<void> _deleteBooking(String bookingId) async {
    try {
      await _firestore.collection('user-bookings').doc(bookingId).delete();
      _userBookings.removeWhere((booking) => booking['bookingId'] == bookingId);
      setState(() {});
    } catch (error) {
      print('Error deleting booking: $error');
    }
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.green[800],
        actions: [
          IconButton(
            onPressed: _logout,
            icon: Icon(Icons.exit_to_app),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(_user.photoURL ??
                        'https://images.unsplash.com/photo-1511367461989-f85a21fda167?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8dXNlciUyMHByb2ZpbGUlMjBpY29ufGVufDB8fDB8fHww'),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _user.displayName ?? 'Zibe Honored Customer',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[900]),
                        ),
                        SizedBox(height: 5),
                        Text(
                          _user.email ?? '',
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Add your logic for editing user details
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green[800],
                              ),
                              child: Text('Edit Profile'),
                            ),
                            SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: _deleteAccount,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(255, 0, 0, 0),
                              ),
                              child: Text('Delete'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              SizedBox(height: 24),
              Text(
                'Bookings:',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[800]),
              ),
              SizedBox(height: 16),
              Column(
                children: _userBookings.map((booking) {
                  return Card(
                    elevation: 5.0,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(
                          'Place: ${booking['placeName'] ?? 'Reserve again'} \n| From: ${booking['fromDate'] ?? ''} To: ${booking['toDate'] ?? ''}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Visitors: ${booking['visitors'] ?? ''}'),
                          Text('Contact: ${booking['contact'] ?? ''}'),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              // Add your logic for editing the booking
                            },
                            color: Colors.green[800],
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _deleteBooking(booking['bookingId']);
                            },
                            color: Colors.green[900],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
