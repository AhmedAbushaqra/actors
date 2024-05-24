import 'package:actors/Api/api_services/populars.dart';
import 'package:actors/models/popular_model.dart';
import 'package:actors/screens/populars/popular_details_screen.dart';
import 'package:flutter/material.dart';
import 'widgets/popular_widget.dart';

class PopularScreen extends StatefulWidget {
  const PopularScreen({super.key, });

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  List<PopularModel> popular = [];
  int pageNumber = 1;
  bool hasNextPage = true;
  bool isFirstLoadRunning = false;
  bool isLoadMoreRunning = false;
  late ScrollController _controller;
  bool showContainer = false;

  @override
  void initState() {
    getDataFunction(true);
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
                    onRefresh: refresh,
                    child: isFirstLoadRunning
                        ? const Center(
                      child: CircularProgressIndicator(),
                    )
                        : ListView.builder(
                      padding: const EdgeInsets.only(bottom: 50),
                      controller: _controller,
                      itemCount: popular.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => PopularDetailsScreen(popular: popular[index])));
                          },
                          child: PopularWidget(
                              popular: popular[index]
                          ),
                        );
                      },
                    ),
                  ),
                ),
                if (isLoadMoreRunning)
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 40),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                if (!hasNextPage)
                  Container(),
              ],
            ),

    );
  }

  void getDataFunction (bool loadFirst) async{
    if (loadFirst == true){
      setState(() {
        hasNextPage = true;
        isFirstLoadRunning = true;
        pageNumber = 1;
      });
    }
    try{
      var response =  await Populars().get(page: pageNumber);
      setState((){

        if (response.containsKey('popular')) {
          if (response['popular'].length > 0) {
            if (pageNumber == 1) {
              popular = response['popular'];
            } else {
              popular.addAll(response['popular']);
            }
          }else {
            hasNextPage = false;
          }
        }
      });
    }catch(err){
      setState(() {
        isFirstLoadRunning = false;
        isLoadMoreRunning = false;
      });
      //print(err);
    }
    setState(() {
      isFirstLoadRunning = false;
      isLoadMoreRunning = false;
    });

  }

  Future refresh() async {
    getDataFunction(true);
  }

  Future _loadMore() async {
    if (
    isFirstLoadRunning==false &&
        isLoadMoreRunning==false &&
        _controller.position.extentAfter < 300)
    {
      setState(() {
        pageNumber += 1;
        isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      getDataFunction(false);
    }

  }



}

