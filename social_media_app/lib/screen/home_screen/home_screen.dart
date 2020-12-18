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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Stories",
                  style: kTextButton.copyWith(fontSize: 22, color: Colors.grey),
                ),
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
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.red,
                            width: 4,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(100),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          child: Image.network(
                            'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.red,
                            width: 4,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(100),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          child: Image.network(
                            'https://cdn.fastly.picmonkey.com/contentful/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=800&q=70',
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.red,
                            width: 4,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(100),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          child: Image.network(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTD8u1Nmrk78DSX0v2i_wTgS6tW5yvHSD7o6g&usqp=CAU',
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.red,
                            width: 4,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(100),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(100),
                          ),
                          child: Image.network(
                            'https://monteluke.com.au/wp-content/gallery/linkedin-profile-pictures/cache/3.JPG-nggid03125-ngg0dyn-591x591-00f0w010c010r110f110r010t010.JPG',
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
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
                      child: Expanded(
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
                                  padding: const EdgeInsets.only(
                                      left: 0, right: 0, top: 10, bottom: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                    ),
                                    height: 450,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: ListTile(
                                            title: Text(
                                              'Tom Smith',
                                              style: kTextButton,
                                            ),
                                            subtitle: Text(
                                              'Iceland',
                                              style: kTextButton.copyWith(
                                                  color: Colors.grey),
                                            ),
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
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.3),
                                                  spreadRadius: 5,
                                                  blurRadius: 10,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
                                                )
                                              ]),
                                          child: ClipRRect(
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
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20, left: 50),
                                          child: Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Text(
                                                '965 likes',
                                                style: kTextButton.copyWith(
                                                    color: Colors.grey,
                                                    fontSize: 20),
                                              )),
                                        )
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
