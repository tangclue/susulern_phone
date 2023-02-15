import 'package:flutter/material.dart';
import 'package:susulern_phone/Constants/gaps.dart';
import 'package:susulern_phone/Constants/sizes.dart';
import 'package:susulern_phone/Screens/problem_hint_screen.dart';
import 'package:susulern_phone/problems/problems.dart';

import '../widgets/select_problem_button.dart';

class ProblemSelectScreen extends StatefulWidget {
  const ProblemSelectScreen({Key? key}) : super(key: key);

  @override
  State<ProblemSelectScreen> createState() => _ProblemSelectScreenState();
}

class _ProblemSelectScreenState extends State<ProblemSelectScreen> {
  void _onTapProbplem(context, index) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ProblemHintScreen(
              index: index,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("문제를 골라주세요!"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: Sizes.size48, horizontal: Sizes.size24),
        child: SingleChildScrollView(
          child: Column(children: [
            for (var index = 1;
                index < Problems.listProblem.length + 1;
                index++)
              Column(children: [
                SelectProblemButton(
                  function: _onTapProbplem,
                  text: "문제",
                  index: index,
                ),
                Gaps.v16,
              ]),
          ]),
        ),
      ),
    );
  }
}
