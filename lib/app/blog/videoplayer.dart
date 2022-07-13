// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:line_icons/line_icons.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../api/DatabaseServices.dart';

class VideoApp extends StatefulWidget {
  const VideoApp(this.id, this.judul, this.kreator, this.ditonton, this.like,
      this.banyakkomentar, this.link, this.thumbnail, this.posting,
      {Key? key})
      : super(key: key);

  final String? id;
  final String? judul, kreator;
  final int like, banyakkomentar, ditonton;
  final String link, thumbnail;
  final bool posting;

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;
  bool fullscreen = false;
  bool perlihatkan = true;
  bool likevideo = false;
  int tinggijudul = 60;

  TextEditingController controllerkomentar = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.link)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference video = firestore.collection('videopembelajaran');

    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final UserEmail = user?.email;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: fullscreen
                ? MediaQuery.of(context).size.width
                : MediaQuery.of(context).size.width,
            height: fullscreen
                ? perlihatkan
                    ? MediaQuery.of(context).size.height - 16
                    : MediaQuery.of(context).size.height
                : MediaQuery.of(context).size.width * 9 / 16,
            child: InkWell(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    child: _controller.value.isInitialized
                        ? AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller),
                          )
                        : Container(),
                  ),
                  perlihatkan
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              _controller.value.isPlaying
                                  ? _controller.pause()
                                  : _controller.play();
                            });
                          },
                          icon: Icon(
                            _controller.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: Colors.grey,
                            size: 48,
                          ),
                        )
                      : Container(),
                  Positioned(
                      bottom: 8,
                      right: 8,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            fullscreen
                                ? SystemChrome.setPreferredOrientations(
                                    [DeviceOrientation.portraitUp])
                                : SystemChrome.setPreferredOrientations([
                                    DeviceOrientation.landscapeLeft,
                                    DeviceOrientation.landscapeRight
                                  ]);
                            fullscreen ? fullscreen = false : fullscreen = true;
                          });
                        },
                        icon: Icon(
                          !fullscreen
                              ? Icons.fullscreen
                              : Icons.fullscreen_exit,
                          color: Colors.black,
                          size: 24,
                        ),
                      )),
                  Positioned(
                      top: 8,
                      left: 8,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            Navigator.pop(context);
                          });
                        },
                        icon: const Icon(
                          Icons.arrow_back_outlined,
                          color: Colors.black,
                          size: 24,
                        ),
                      )),
                ],
              ),
              onTap: () {
                setState(() {
                  perlihatkan ? perlihatkan = false : perlihatkan = true;
                });
              },
            ),
          ),
          perlihatkan
              ? VideoProgressIndicator(
                  _controller, //controller
                  allowScrubbing: true,
                  colors: const VideoProgressColors(
                    playedColor: Colors.red,
                    bufferedColor: Colors.grey,
                    backgroundColor: Colors.black,
                  ),
                )
              : Container(),
          !fullscreen
              ? Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                    right: 8,
                    top: 8,
                    bottom: 8,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: tinggijudul.toDouble(),
                            width: MediaQuery.of(context).size.width - 70,
                            child: Text(
                              widget.judul!,
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w500),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  (tinggijudul == 60)
                                      ? tinggijudul = 170
                                      : tinggijudul = 60;
                                });
                              },
                              icon: (tinggijudul == 60)
                                  ? const Icon(
                                      Icons.arrow_drop_down,
                                      size: 36,
                                    )
                                  : const Icon(
                                      Icons.arrow_drop_up,
                                      size: 36,
                                    )),
                        ],
                      ),
                      Text('${widget.ditonton} x ditonton'),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(
                              height: 1,
                              thickness: 1,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.kreator!,
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500),
                                ),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Positioned(
                                      child: StreamBuilder<DocumentSnapshot>(
                                        stream:
                                            video.doc(widget.id).snapshots(),
                                        builder:
                                            (context, AsyncSnapshot snapshot) {
                                          if (snapshot.hasData) {
                                            Map<String, dynamic> data =
                                                snapshot.data!.data()
                                                    as Map<String, dynamic>;

                                            int jmllike;
                                            jmllike = data['like'];
                                            jmllike += 1000000;

                                            return IconButton(
                                                onPressed: () {
                                                  (likevideo)
                                                      ? likevideo = false
                                                      : likevideo = true;
                                                  setState(() {});
                                                  (likevideo)
                                                      ? DatabaseServices
                                                          .likesvideoup(
                                                              widget.id)
                                                      : DatabaseServices
                                                          .likesvideodown(
                                                              widget.id);
                                                  DatabaseServices
                                                      .listuserlikevideo(
                                                          widget.id,
                                                          UserEmail,
                                                          jmllike.toString(),
                                                          likevideo);
                                                },
                                                icon: (likevideo)
                                                    ? const Icon(
                                                        LineIcons.heartAlt,
                                                        color: Colors.red,
                                                      )
                                                    : const Icon(
                                                        LineIcons.heart,
                                                        size: 24,
                                                      ));
                                          }
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        },
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      child: StreamBuilder<DocumentSnapshot>(
                                        stream:
                                            video.doc(widget.id).snapshots(),
                                        builder:
                                            (context, AsyncSnapshot snapshot) {
                                          if (snapshot.hasData) {
                                            Map<String, dynamic> data =
                                                snapshot.data!.data()
                                                    as Map<String, dynamic>;

                                            int jmllike;
                                            jmllike = data['like'];

                                            return Text(
                                              jmllike.toString(),
                                              style: const TextStyle(fontSize: 12),
                                            );
                                          }
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Divider(
                              height: 1,
                              thickness: 1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
          Expanded(
            child: ListView(
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: video
                      .doc(widget.id.toString())
                      .collection('komentar')
                      .snapshots(),
                  builder: (_, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                          children: snapshot.data.docs
                              .map<Widget>((e) => KomentarCard(
                                    e.data()['id'],
                                    e.data()['email'],
                                    e.data()['komentar'],
                                  ))
                              .toList());
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Center(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 12,
              right: 12,
              top: 8,
              bottom: 8,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'komentar',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 24,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        controller: controllerkomentar,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    StreamBuilder<DocumentSnapshot>(
                      stream: video.doc(widget.id).snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          Map<String, dynamic> data =
                              snapshot.data!.data() as Map<String, dynamic>;

                          int idkomentar;
                          idkomentar = data['banyakkomentar'];
                          String idvideo = data['id'];

                          idkomentar += 1000000;

                          return SizedBox(
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: IconButton(
                                  onPressed: () {


                                    DatabaseServices
                                        .naikkanbanyakkomentarvideoditonton(
                                            idvideo);
                                    DatabaseServices
                                        .postingkomentarvideoditonton(
                                            idvideo,
                                            UserEmail,
                                            idkomentar.toString(),
                                            controllerkomentar.text);
                                    controllerkomentar.text = '';
                                  },
                                  icon: const Icon(Icons.send)));
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    _controller.dispose();
  }
}

class KomentarCard extends StatelessWidget {
  final String? id;
  final String? email;
  final String? komentar;

  // ignore: prefer_const_constructors_in_immutables
  KomentarCard(
    this.id,
    this.email,
    this.komentar, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference user = firestore.collection('user');

    return Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.width * 0.2,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: StreamBuilder<DocumentSnapshot>(
                      stream: user.doc(email!).snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          Map<String, dynamic> data =
                              snapshot.data!.data() as Map<String, dynamic>;

                          String pic;
                          pic = data['imageurl'];

                          return Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            elevation: 10,
                            child: Ink.image(
                              image: NetworkImage(
                                pic,
                              ),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              fit: BoxFit.cover,
                            ),
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Text(
                            email!,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(komentar!),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
