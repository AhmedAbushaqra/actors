import 'package:actors/models/popular_model.dart';
import 'package:flutter/material.dart';

class PopularWidget extends StatelessWidget {
  final PopularModel popular;
  final Color? color;

  const PopularWidget({super.key,
    required this.popular,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: color ?? Colors.white,
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
          child: Row(
            children: [
              Container(
                height: 158,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500/${popular.image}',
                    height: 158,
                    fit: BoxFit.cover,
                    errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.asset(
                          'assets/images/no-user.png',
                          fit: BoxFit.fill,
                          width: 58,
                          height: 58,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 10,),
              SizedBox(
                width: 170,
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(popular.name!,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w900),),
                    Text('Profession: ${popular.profession}'),
                    Text('Gender: ${popular.gender == 1?"Female":"Male"}'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}