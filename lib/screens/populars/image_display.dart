import 'package:flutter/material.dart';

class ImageDisplay extends StatefulWidget {
  final String image;
  const ImageDisplay({super.key,required this.image});

  @override
  State<ImageDisplay> createState() => _ImageDisplayState();
}

class _ImageDisplayState extends State<ImageDisplay> {
  bool saved =false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: (){
                  if(!saved){}
                },
                child: SizedBox(
                  child: Row(
                    children: [
                      Text(saved?"Saved":"Save",style: const TextStyle(fontWeight: FontWeight.w900),),
                      const SizedBox(width: 10,),
                      Icon(saved?Icons.download_done:Icons.save,size: 28,),
                    ],
                  ),
                ),
              ),
            ],
          ),


          Image.network(
            "https://image.tmdb.org/t/p/w500/${widget.image}",
            //fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }
}
