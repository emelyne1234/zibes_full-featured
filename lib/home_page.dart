import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:crud/booking_page.dart';
import 'package:crud/place.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserHomePage extends StatefulWidget {
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  TextEditingController _searchController = TextEditingController();

  List<Place> places = placesList;
  List<Place> filteredPlaces = [];

  @override
  void initState() {
    super.initState();
    filteredPlaces.addAll(placesList);
  }

  void _filterPlaces(String query) {
    query = query.toLowerCase();
    setState(() {
      filteredPlaces = places
          .where((place) => place.name.toLowerCase().contains(query))
          .toList();
    });
  }

  void _navigateToBookingPage(Place place) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookingPage(place: place),
      ),
    );
  }

  void _logoutUser() {
    FirebaseAuth.instance.signOut();
  }

  void _navigateToUserProfile() {
    // Implement navigation to user profile page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recommended Places'),
        backgroundColor: Colors.green[800],
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: _navigateToUserProfile,
            tooltip: 'User Profile',
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: _logoutUser,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: _filterPlaces,
              decoration: InputDecoration(
                labelText: 'Search Places',
                prefixIcon: Icon(Icons.search),
                fillColor: const Color.fromARGB(255, 238, 245, 238),
                filled: true,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredPlaces.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Navigate to detailed view
                      // You can implement this based on your requirements
                    },
                    child: Card(
                      elevation: 5.0,
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: filteredPlaces[index].images[0],
                              height: 200,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      filteredPlaces[index].name,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green[900],
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.book),
                                      color: Colors.green[800],
                                      iconSize: 35.0,
                                      onPressed: () {
                                        _navigateToBookingPage(
                                            filteredPlaces[index]);
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Text(
                                  filteredPlaces[index].description,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.green[900],
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Price: \$${filteredPlaces[index].price} USD / Person',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.green[900],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
