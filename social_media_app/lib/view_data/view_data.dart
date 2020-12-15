import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image/network.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:social_media_app/bloc/display_post/display_post_bloc.dart';
import 'package:social_media_app/bloc/upload_image/upload_image_bloc.dart';
import 'package:social_media_app/constants/style.dart';

class ViewData extends StatefulWidget {
  @override
  _ViewDataState createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  var uid, url, name;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DisplayPostBloc>(context).add(DisplayData());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          'View',
          style: kTextButton.copyWith(color: Colors.white),
        ),
      ),
      body: BlocBuilder<DisplayPostBloc, DisplayPostState>(
        builder: (context, state) {
          if (state is DisplayPostLoading) {
            return Center(
              child: SpinKitFadingCircle(
                color: Colors.grey,
                size: 50.0,
              ),
            );
          } else if (state is DisplayPostFetch) {
            return Container(
              child: ListView.builder(
                itemCount: state.post == null ? 0 : state.post.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: InkWell(
                      onTap: () {
                        url = (state.post[index]["url"]);
                        name = (state.post[index]["name"]);
                        uid = "${state.post[index].id}";

                        url = "${state.post[index]["url"]}";

                        print(url);
                        print(name);
                      },
                      child: Card(
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                                child: FadeInImage(
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  placeholder:
                                      AssetImage('assets/images/default.jpg'),
                                  image: NetworkImageWithRetry(
                                      "${state.post[index]["url"]}"),
                                ),
                              ),
                              // backgroundImage: NetworkImage("${state.post[index]["url"]}"),
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.redAccent,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return Text('');
        },
      ),
      bottomSheet: InkWell(
        onTap: () {
          BlocProvider.of<DisplayPostBloc>(context).add(DisplayData());
        },
        child: Container(
          width: double.infinity,
          height: 50,
          color: Colors.blue,
          child: Center(
            child: Text(
              'Refresh',
              style: kTextButton.copyWith(color: Colors.white, fontSize: 22),
            ),
          ),
        ),
      ),
    );
  }
}
