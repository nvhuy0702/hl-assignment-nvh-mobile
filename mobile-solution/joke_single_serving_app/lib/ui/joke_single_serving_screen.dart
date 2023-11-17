import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joke_single_serving_app/bloc/joke_single_bloc.dart';
import 'package:joke_single_serving_app/database/vote_database.dart';
import 'package:joke_single_serving_app/database/vote_model.dart';
import 'package:joke_single_serving_app/widget/button_bottom.dart';

class JokeSingleServingScreen extends StatefulWidget {
  const JokeSingleServingScreen({super.key});

  @override
  State<JokeSingleServingScreen> createState() =>
      _JokeSingleServingScreenState();
}

class _JokeSingleServingScreenState extends State<JokeSingleServingScreen> {
  final bloc = JokeSingleBloc();
  late List<Vote> notes;

  @override
  void initState() {
    super.initState();
    bloc.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomView(),
      appBar: AppBar(
        leading: _leadingLogo(),
        actions: [_actionView()],
      ),
      body: _contentView(),
    );
  }

  Row _actionView() {
    return Row(
      children: [
        RichText(
          textAlign: TextAlign.end,
          text: const TextSpan(
            text: 'Handcrafted by\n ',
            style: TextStyle(color: Colors.grey),
            children: <TextSpan>[
              TextSpan(
                text: 'Jim HLS',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Image.asset(
            "asset/images/avatar.png",
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }

  Padding _leadingLogo() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Image.asset(
        "asset/images/logo.png",
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _contentView() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 32),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Color(0xFF2cb464),
            ),
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                text: 'A joke a day keeps the doctor away\n',
                style: TextStyle(
                  fontSize: 20,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '\n',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  TextSpan(
                    text:
                        'If you joke wrong way, your teeth have to pay. (Serious)',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          BlocConsumer<JokeSingleBloc, JokeSingleState>(
            listener: (context, state) {},
            bloc: bloc,
            builder: (context, state) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
                child: Text(bloc.randomizedContent.isEmpty
                    ? 'No content'
                    : bloc.randomizedContent[bloc.currentIndex]),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _bottomView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 32, left: 16, right: 16, bottom: 32),
          child: Row(
            children: [
              ButtonBottom(
                onPressed: showNextContent,
                colorButton: const Color(0xFF2c7edb),
                titleButton: "This is funny!",
              ),
              const SizedBox(
                width: 16,
              ),
              ButtonBottom(
                onPressed: showNextContent,
                colorButton: const Color(0xFF29b363),
                titleButton: "This is not funny.",
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 1,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              text:
                  'This app is created as part of Hl solutions program. The materials contained on this website are provided for general information only an ddo not constitute any form of advice. HLS assumes no response for the accuracy of any particular statement and accepts no liability for any loss or damage which may arise from reliance on the information contained on this site.\n ',
              style: TextStyle(color: Colors.grey),
              children: [
                TextSpan(
                  text: '\n',
                ),
                TextSpan(
                  text: 'Copyright 2021 HLS',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void showNextContent() async {
    setState(() {
      if (bloc.currentIndex < bloc.randomizedContent.length - 1) {
        bloc.currentIndex++;
        addVote();
      } else {
        showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Notification'),
              content: const SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(
                        "That's all the jokes for today! Come back another day!"),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }
  Future addVote() async {
    final vote = Vote(
      funny: "funny"
    );
     VotesDatabase.instance.create(vote);
  }
}
