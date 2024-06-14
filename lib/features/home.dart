import 'package:flutter/material.dart';
import 'package:personal_nursing/features/blood_pressure/blood_pressure_details.dart';
import 'package:personal_nursing/features/device/new_device_screen.dart';
import 'package:personal_nursing/features/device/your_device_screen.dart';
import 'package:personal_nursing/features/heart_rate/heart_rate_details.dart';
import 'package:personal_nursing/features/reminder/reminder_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: size.height * .05,
            color: Colors.green,
          ),
          Container(
            margin: const EdgeInsetsDirectional.only(bottom: 15),
            padding: const EdgeInsetsDirectional.all(18),
            color: Colors.green,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Home',
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
          SizedBox(
            width: size.width * .8,
            child: const TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * .12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const YourdeviceScreen(),
                    ),
                  );                },
                child: Container(
                  width: size.width * .3,
                  height: size.height * .1,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(2),
                      topRight: Radius.circular(2),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Your Device',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NewDeviceScreen(),
                    ),
                  );
                },
                child: Container(
                  width: size.width * .3,
                  height: size.height * .1,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                      bottomLeft: Radius.circular(2),
                      topLeft: Radius.circular(2),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Add New \n Device',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.height * .05,
          ),
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BloodPressureDetails(),
                    ),
                  );
                },
                child: const Column(
                  children: [
                    CircleAvatar(
                      child: ImageIcon(
                        AssetImage('assets/images/virus.png'),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'blood pressure',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReminderScreen(),
                    ),
                  );
                },
                child: const Column(
                  children: [
                    CircleAvatar(
                      child: ImageIcon(
                        AssetImage('assets/images/clock.png'),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Reminder',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
                     ),
          InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HeartRateDetails(),
                ),
              );

            },
            child: const Center(
              child: Column(
                children: [
                  CircleAvatar(
                    child: ImageIcon(
                      AssetImage('assets/images/heart-rate.png'),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'HeartRate',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
