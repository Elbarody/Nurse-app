import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> updateBloodPressure(String userId, Map<String, int> bloodPressure) async {
    try {
      // Update the user's document with the new blood pressure
      await _db.collection('users').doc(userId).update({
        'bloodPressure': bloodPressure,
        'lastUpdated': FieldValue.serverTimestamp(), // Timestamp of the update
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<DocumentSnapshot> getBloodPressure(String userId) {
    // Retrieve the user's document which includes the blood pressure
    return _db.collection('users').doc(userId).snapshots();
  }
}

class BloodPressureDetails extends StatelessWidget {
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    User? user = FirebaseAuth.instance.currentUser;
    String userId = user?.uid ?? 'unknown';
    String userName = user != null ? user.displayName ?? 'Mohamed' : 'Mohamed';

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: size.height * .05,
            color: Colors.green,
          ),
          Container(
            margin: EdgeInsetsDirectional.only(bottom: 15),
            padding: const EdgeInsetsDirectional.all(18),
            color: Colors.green,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Blood Pressure',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: size.height * .05,
                  child: const Image(
                    image: AssetImage(
                      'assets/images/person.png',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Hey $userName,',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: size.height * .12),
          StreamBuilder<DocumentSnapshot>(
            stream: _firestoreService.getBloodPressure(userId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              }
              if (snapshot.hasData && snapshot.data!.data() != null) {
                var data = snapshot.data!.data() as Map<String, dynamic>;
                var bp = data['bloodPressure'] ?? {'systolic': 'No data', 'diastolic': 'No data'};
                return Text('Latest Blood Pressure: ${bp['systolic']} / ${bp['diastolic']}');
              } else {
                return Text('No blood pressure data available');
              }
            },
          ),
          SizedBox(height: size.height * .05),
          SizedBox(
            width: size.width * .4,
            child: ElevatedButton(
              onPressed: () {
                // Dummy blood pressure data, replace with actual data from your device or input
                Map<String, int> newBP = {'systolic': 120, 'diastolic': 80};
                _firestoreService.updateBloodPressure(userId, newBP);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text(
                'New Check',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
