// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:mvvm/data/response/status.dart';

import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/home_view_model.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  HomeViewViewModel  homeViewViewModel = HomeViewViewModel();
  
  @override
  void initState() {
    homeViewViewModel.fetchMoviesListApi();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final userPrefernece = Provider.of<UserViewModel>(context);
    return WillPopScope(
      onWillPop: () async {
        // إعادة false لتعطيل زر الرجوع
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            InkWell(
                onTap: (){
                  userPrefernece.remove().then((value){
                    Navigator.pushNamed(context, RoutesName.login);
                  });
                },
                child: const Center(child: Text('Logout'))),
            const SizedBox(width: 20,)
          ],
        ),
        body: ChangeNotifierProvider<HomeViewViewModel>(
          create: (BuildContext context) => homeViewViewModel,
          child: Consumer<HomeViewViewModel>(
              builder: (context, value, _){
                switch(value.moviesList.status){
                  case Status.LOADING:
                    return const Center(child: CircularProgressIndicator());
                  case Status.ERROR:
                    return Center(child: Text(value.moviesList.message.toString()));
                  case Status.COMPLETED:
                    return ListView.builder(
                        itemCount: value.moviesList.data!.movies!.length,
                        itemBuilder: (context,index){
                      return Card(
                        color: Colors.white,
                        child: ListTile(
      
                          leading: Image.network(
      
                              value.moviesList.data!.movies![index].posterurl.toString(),
                          errorBuilder: (context, error, stack){
                                return const Icon(Icons.error, color: Colors.red,);
                          },
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                          ),
                          title: Text(value.moviesList.data!.movies![index].title.toString()),
                          subtitle: Text(value.moviesList.data!.movies![index].year.toString()),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(Utils.averageRating(value.moviesList.data!.movies![index].ratings!).toStringAsFixed(1)),
                              const Icon(Icons.star , color: Colors.yellow,)
                            ],
                          ),
                        ),
                      );
                    });
      
                  case null:
                    break;
                }
                return Container();
              }),
        ) ,
      ),
    );
  }
}
