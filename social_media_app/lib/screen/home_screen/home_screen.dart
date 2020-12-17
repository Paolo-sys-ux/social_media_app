import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image/network.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:social_media_app/bloc/display_post/display_post_bloc.dart';
import 'package:social_media_app/constants/style.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var uid, url, name;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DisplayPostBloc>(context).add(DisplayData());

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                "Stories",
                style: kTextButton.copyWith(fontSize: 22),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        child: Image.asset(
                          'assets/images/default.jpg',
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        child: Image.asset(
                          'assets/images/default.jpg',
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        child: Image.asset(
                          'assets/images/default.jpg',
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        child: Image.asset(
                          'assets/images/default.jpg',
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, right: 50, left: 50),
                child: Divider(
                  height: 1,
                  thickness: 2,
                  color: Color(0xFFD3D3D3),
                ),
              ),
              BlocBuilder<DisplayPostBloc, DisplayPostState>(
                builder: (context, state) {
                  if (state is DisplayPostLoading) {
                    return Align(
                      alignment: Alignment.center,
                      child: SpinKitFadingCircle(
                        color: Colors.grey,
                        size: 50.0,
                      ),
                    );
                  } else if (state is DisplayPostFetch) {
                    return Container(
                      child: SizedBox(
                        height: 500,
                        child: ListView.builder(
                          itemCount: state.post == null ? 0 : state.post.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: InkWell(
                                onTap: () {
                                  url = (state.post[index]["url"]);
                                  name = (state.post[index]["name"]);
                                  uid = "${state.post[index].id}";

                                  url = "${state.post[index]["url"]}";

                                  print(url);
                                  print(name);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFFeceff1),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                    height: 400,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: ListTile(
                                            leading: CircleAvatar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(300)),
                                                child: FadeInImage(
                                                  width: 300,
                                                  height: 300,
                                                  fit: BoxFit.cover,
                                                  placeholder: AssetImage(
                                                      'assets/images/default.jpg'),
                                                  image: NetworkImageWithRetry(
                                                      "${state.post[index]["url"]}"),
                                                ),
                                              ),
                                              // backgroundImage: NetworkImage("${state.post[index]["url"]}"),
                                            ),
                                            trailing: IconButton(
                                              icon: Icon(
                                                Icons.more_vert,
                                                color: Colors.black,
                                              ),
                                              onPressed: () {},
                                            ),
                                          ),
                                        ),
                                        ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)),
                                          child: FadeInImage(
                                            width: 300,
                                            height: 300,
                                            fit: BoxFit.cover,
                                            placeholder: AssetImage(
                                                'assets/images/default.jpg'),
                                            image: NetworkImageWithRetry(
                                                "${state.post[index]["url"]}"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
