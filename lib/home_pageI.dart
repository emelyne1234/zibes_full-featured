import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/read/get_user_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:crud/update_page.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var user = FirebaseAuth.instance.currentUser!;

  // document IDs
  List<String> docIDs = [];

  // get docIDs
  Future<void> getDocId() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('users').get();

      setState(() {
        docIDs = snapshot.docs.map((document) => document.id).toList();
      });
    } catch (e) {
      print("Error getting document IDs: $e");
    }
  }

  Future<void> deleteUser(String docId) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(docId).delete();
      getDocId();
    } catch (e) {
      print("Error deleting user: $e");
    }
  }

  Future<void> updateUser(String docId) async {
    try {
      // Retrieve current user data
      DocumentSnapshot userSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(docId).get();
      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;

      // Open the update dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return UpdateUserDialog(
            currentFirstName: userData['firstname'],
            currentSecondName: userData['secondname'],
            currentEmail: userData['email'],
            onUpdate: (Map<String, dynamic>? info) {
              print("onUpdate callback: $info");

              if (info != null) {
                print("Updating user with data: $info");

                // Update the user in Firestore with the new data
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(docId)
                    .update(info);

                print("User data updated successfully");
                // Refresh the data
                getDocId();
              } else {
                print("User did not press the update button");
              }
            },
          );
        },
      );
    } catch (e) {
      print("Error updating user: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          user.email!,
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
            child: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: FutureBuilder(
                future: getDocId(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: docIDs.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: GetUserName(documentId: docIDs[index]),
                        tileColor: Colors.green[100],
                        // Add delete and update buttons
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                deleteUser(docIDs[index]);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                updateUser(docIDs[index]);
                              },
                            ),
                          ],
                        ),
                      );
                    },
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
