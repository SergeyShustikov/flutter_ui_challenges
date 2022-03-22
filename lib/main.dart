import 'package:challenges/challenge_1/challenge_1.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChallengeList(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ChallengeDescription {
  final String title;
  final Widget page;
  final Widget description;

  ChallengeDescription(this.title, this.page, this.description);
}

class ChallengeList extends StatelessWidget {
  final List<ChallengeDescription> challenges = [
    ChallengeDescription("Challenge #1", const Challenge_1(), const Text("Charmeleon cards")),
  ];

  ChallengeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter challenges"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(challenges[index].title),
            subtitle: challenges[index].description,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => challenges[index].page,
              ));
            },
          );
        },
        itemCount: challenges.length,
      ),
    );
  }
}
