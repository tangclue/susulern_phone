import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:susulern_phone/Constants/gaps.dart';
import 'package:susulern_phone/Constants/sizes.dart';

import '../problems/problems.dart';

class ProblemHintScreen extends StatefulWidget {
  const ProblemHintScreen({super.key, required this.index});
  final int index;

  @override
  State<ProblemHintScreen> createState() => _ProblemHintScreenState();
}

class _ProblemHintScreenState extends State<ProblemHintScreen> {
  int hintIndex = 0;
  int hintMax = 0;

  String _problem = "";
  List _listImages = [];
  List _listChices = [];
  List _listHints = [];

  void _onHintPressed(context) {
    if (hintIndex < hintMax) {
      hintIndex++;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    hintMax = Problems.listHints[widget.index - 1].length;
    setState(() {});

    _problem = Problems.listProblem[widget.index - 1];
    _listImages = Problems.listImages[widget.index - 1];
    _listChices = Problems.listChoices[widget.index - 1];
    _listHints = Problems.listHints[widget.index - 1];
  }

  void clearExpressions() {
    _problem = "";
    _listImages = [];
    _listChices = [];
    _listHints = [];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          clearExpressions();
          return Future.value(true);
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("문제 ${widget.index}"),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: Sizes.size48, horizontal: Sizes.size24),
            child: Scrollbar(
              child: SingleChildScrollView(
                child: Column(children: [
                  const FractionallySizedBox(
                    widthFactor: 1,
                  ),
                  Gaps.v20,
                  SizedBox(
                    height: Sizes.size80 * 3,
                    child: TeXView(
                      loadingWidgetBuilder: (context) {
                        return const Center(child: CircularProgressIndicator());
                      },
                      child: TeXViewDocument(
                        _problem,
                      ),
                    ),
                  ),
                  Gaps.v20,
                  for (var image in _listImages)
                    Column(
                      children: [image, Gaps.v20],
                    ),
                  for (var i = 0; i < _listChices.length; i++)
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TeXView(
                            child: TeXViewDocument(
                              Problems.listChoicesNumber[i] +
                                  Problems.gap +
                                  _listChices[i],
                            ),
                          ),
                        ),
                        Gaps.v20,
                      ],
                    ),
                  Gaps.v20,
                  for (var hint in _listHints)
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: hintIndex > _listHints.indexOf(hint) ? 1 : 0,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 100,
                            child: TeXView(
                              child: TeXViewDocument(
                                hint,
                              ),
                            ),
                          ),
                          Gaps.v20,
                        ],
                      ),
                    ),
                ]),
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
              child: CupertinoButton(
            color: Colors.amber,
            onPressed: () {
              _onHintPressed(context);
            },
            child: Text("Hint! ($hintIndex / $hintMax)"),
          )),
        ));
  }
}
