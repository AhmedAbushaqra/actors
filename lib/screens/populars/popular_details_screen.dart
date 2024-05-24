import 'package:actors/models/popular_model.dart';
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
    );
  }
}
