import 'dart:convert';

import 'package:actors/Api/api_services/populars.dart';
import 'package:actors/common/shared_preferences.dart';
import 'package:actors/models/popular_model.dart';
import 'package:actors/providers/popular_provider.dart';
import 'package:actors/screens/populars/popular_details_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/popular_widget.dart';

class PopularScreen extends StatefulWidget {
  const PopularScreen({super.key, });

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {

  late ScrollController _controller;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PopularProvider>(context, listen: false).getDataFunction(true);;
    });
    _controller = ScrollController()..addListener(_loadMore);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final popularProvider = Provider.of<PopularProvider>(context);
    return Scaffold(
        backgroundColor: const Color(0xffDFF1F8),
        appBar: AppBar(
          title: const Text("Popular People"),
          centerTitle: true,
        ),
        body: Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: popularProvider.refresh,
                    child: popularProvider.isFirstLoadRunning
                        ? const Center(
                      child: CircularProgressIndicator(),
                    )
                        : ListView.builder(
                      padding: const EdgeInsets.only(bottom: 50),
                      controller: _controller,
                      itemCount: popularProvider.popular.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => PopularDetailsScreen(popular: popularProvider.popular[index])));
                          },
                          child: PopularWidget(
                              popular: popularProvider.popular[index]
                          ),
                        );
                      },
                    ),
                  ),
                ),
                if (popularProvider.isLoadMoreRunning)
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 40),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                if (!popularProvider.hasNextPage)
                  Container(),
              ],
            ),

    );
  }

  _loadMore(){
    if(_controller.position.extentAfter < 300){
      Provider.of<PopularProvider>(context,listen: false).loadMore();
    }
  }

}

