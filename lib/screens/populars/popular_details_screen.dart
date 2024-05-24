import 'package:actors/models/popular_model.dart';
import 'package:actors/screens/populars/image_display.dart';
import 'package:actors/screens/populars/widgets/popular_widget.dart';
import 'package:flutter/material.dart';

class PopularDetailsScreen extends StatefulWidget {
  final PopularModel popular;
  const PopularDetailsScreen({super.key,required this.popular});

  @override
  State<PopularDetailsScreen> createState() => _PopularDetailsScreenState();
}

class _PopularDetailsScreenState extends State<PopularDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.popular.name!),
      ),

      body: Column(
        children: [
          PopularWidget(
              popular: widget.popular,
            color: const Color(0xffDFF1F8),
          ),
          const SizedBox(height: 30,),
          const Text('Most Popular with',style: TextStyle(
            fontWeight: FontWeight.w900,fontSize: 24
          ),
          ),
          const SizedBox(height: 20,),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(15),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.5,
                crossAxisSpacing: 15.0,
                mainAxisSpacing: 25.0,
              ),
              itemCount: widget.popular.works!.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ImageDisplay(image: "https://image.tmdb.org/t/p/w500/${widget.popular.works![index].workImage}",)));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.network(
                      "https://image.tmdb.org/t/p/w500/${widget.popular.works![index].workImage}",
                      fit: BoxFit.fill,
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
