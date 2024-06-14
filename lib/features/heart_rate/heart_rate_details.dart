import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> updateHeartRate(String userId, int heartRate) async {
    try {
      // Update the user's document with the new heart rate
      await _db.collection('users').doc(userId).update({
        'heartRate': heartRate,
        'lastUpdated': FieldValue.serverTimestamp(), // Timestamp of the update
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<DocumentSnapshot> getHeartRate(String userId) {
    // Retrieve the user's document which includes the heart rate
    return _db.collection('users').doc(userId).snapshots();
  }
}

class HeartRateDetails extends StatelessWidget {
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    User? user = FirebaseAuth.instance.currentUser;
    String userId = user?.uid ?? 'unknown';

    String userName = user != null ? user.displayName ?? 'User' : 'User';

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
                  'Heart Rate',
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
            stream: _firestoreService.getHeartRate(userId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              }
              if (snapshot.hasData && snapshot.data!.data() != null) {
                var data = snapshot.data!.data() as Map<String, dynamic>;
                var heartRate = data['heartRate'] ?? 'No data'; // Handle potential null
                return Text('Latest Heart Rate: $heartRate');
              } else {
                return Text('No heart rate data available');
              }
            },
          ),
          SizedBox(height: size.height * .05),
          SizedBox(
            width: size.width * .4,
            child: ElevatedButton(
              onPressed: () {
                // Assume a new heart rate is measured, e.g., 72 bpm
                int newHeartRate = 72;
                _firestoreService.updateHeartRate(userId, newHeartRate);
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
