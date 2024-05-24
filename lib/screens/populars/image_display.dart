import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

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
        ],
      ),
    );
  }

  Future<void> requestPermission() async {
    if (await Permission.storage.request().isGranted) {
      print('Storage permission granted');
    } else {
      print('Storage permission denied');
    }
  }

  Future<void> fetchAndSaveImage(String url) async {
    setState(() {
      saving = true;
    });
    try {
      await requestPermission();
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.bodyBytes),
          quality: 60,
          name: 'downloaded_image',
        );
        if (result['isSuccess']) {
          print('Image saved to gallery');
          setState(() {
            saved = true;
          });
        } else {
          throw Exception('Failed to save image to gallery');
        }
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

