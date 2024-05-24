import 'package:actors/models/popular_model.dart';
import 'package:flutter/material.dart';

class PopularWidget extends StatelessWidget {
  final PopularModel popular;

  const PopularWidget({super.key,
    required this.popular
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Rounded corners
        side: BorderSide(
          color: const Color(0xff1A9BCA).withOpacity(0.4),
          width: 1, // Border width
        ),
      ),
      margin: const EdgeInsets.only(top: 7,right: 30,left: 30,bottom: 7),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          height: 70,
          width: 70,
          child: Center(
            child: Text(popular.name!),
          ),
        ),
      ),
    );
  }
}