import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image/network.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:social_media_app/bloc/display_post/display_post_bloc.dart';
import 'package:social_media_app/constants/style.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  var uid, url, name;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DisplayPostBloc>(context).add(DisplayData());

    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {}),
        actions: [
          IconButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              onPressed: () {})
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(150)),
                  child: FadeInImage(
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                    placeholder: AssetImage('assets/images/default.jpg'),
                    image: NetworkImageWithRetry(
                        'https://lh3.googleusercontent.com/-MOUT_o-S9Ds/WKHIY46CSBE/AAAAAAAAAZw/d2jjaDvVPuk_NfowP7Q9XmAMT0H5Zr8vwCEwYChgbKtMDAL1OcqzKOwydyDZLsB-unZwOP1Z3hSUS-YSC9GDbqX5_NgtKLQQKFqzHdi-u0sb5NpCD3fWE5EAGUzjb4vWhdrZxpRn7C1LeuV-EshhS9_CXeb8k1YrOySOxsOeDaGmGQ2dTKO6ceBPF7ZtfLGv96oQKGPZdSS4vGBKW5OFeLK7KclUlS3H0pAIw5Q0t_A3fAQcngS0BZmC3shxKwrLfLONAS0dGRJvsW8wbFmGbemy-EMD9jHi4Mth48UkY3az1CHdMstjPRg0El4ZHld2UObzK_EY55pmM2UKSG9qXFVTSjSRD2xjfIUarHs9aonGik0ifjnLqiWnHqO9fiT0Nurvcs6AIj1UzhKjmWnqwZ2ZhF7WnU3MYzctK9fPS_E4TpGTR6VtpfOElEHV_3U4A8LttD6Olb0qQfAyy_OzZ5HEw7J13GCStn9-PR44RLwDL3epPp8QpItrWTRHpS9nM2tkX-NHdKKuyyFR72BBxZKB1YG4sHlJ3_hrj6qR9ZZdPsRXF_w1buPhanaVJXKbo5yf5iks0615wnjnmu0Q9xZTELVP96p59vSf9Ipnk8ks2CvUNN5knJy082wGS52eGZ-PR1qTH0Tw1sqDq3yDPEQ1A0Vow3K7s_gU/w163-h110-p/6386606076506294289'),
                    // image: NetworkImageWithRetry(
                    //     "${state.post[index]["url"]}"),
                  ),
                ),
                Text(
                  'Ethan Vasquez',
                  style: kTextButton.copyWith(fontSize: 22),
                ),
                Text(
                  'Manila Philippines',
                  style: kTextButton.copyWith(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          '53',
                          style: kTextButton.copyWith(fontSize: 22),
                        ),
                        Text('Photos'),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '223k',
                          style: kTextButton.copyWith(fontSize: 22),
                        ),
                        Text('Followers'),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '117',
                          style: kTextButton.copyWith(fontSize: 22),
                        ),
                        Text(
                          'Following',
                        ),
                      ],
                    ),
                  ],
                ),

                //post list builder
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
                          height: 700,
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        (orientation == Orientation.portrait)
                                            ? 2
                                            : 3),
                            itemCount:
                                state.post == null ? 0 : state.post.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
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
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)),
                                          child: FadeInImage(
                                            width: 200,
                                            height: 200,
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
      ),
    );
  }
}
