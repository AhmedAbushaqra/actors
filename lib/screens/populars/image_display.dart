import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ImageDisplay extends StatefulWidget {
  final String image;
  const ImageDisplay({super.key,required this.image});

  @override
  State<ImageDisplay> createState() => _ImageDisplayState();
}

class _ImageDisplayState extends State<ImageDisplay> {
  bool saved = false;
  bool saving = false;

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
                onTap: () {
                  if (!saved) {
                    fetchAndSaveImage(widget.image);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    child: saving?const CircularProgressIndicator():Row(
                      children: [
                        Text(saved ? "Saved" : "Save",
                          style: const TextStyle(fontWeight: FontWeight.w900),),
                        const SizedBox(width: 10,),
                        Icon(
                          saved ? Icons.download_done : Icons.save, size: 28,),
                      ],
                    ),
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

  Future<void> fetchAndSaveImage(String url) async {
    setState(() {
      saving = true;
    });
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final directory = await getApplicationDocumentsDirectory();
        final path = '${directory.path}/downloaded_image.jpg';

        final file = File(path);
        await file.writeAsBytes(response.bodyBytes);

        print('Image saved to $path');
        setState(() {
          saved = true;
        });
      } else {
        throw Exception('Failed to load image');
      }
    } catch (e) {
      print('Error: $e');
    }
    setState(() {
      saving = false;
    });
  }
}
