// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

const Color primaryColor = Color(0xffFFD5B9);
const Color cardInactiveColor = Color(0xffFBF0E9);
const Color secondaryColor = Color(0xff0E1F2F);
const Duration animationTime = Duration(milliseconds: 350);
const Curve animationCurve = Curves.easeInOutCubic;

class Challenge_1 extends StatefulWidget {
  const Challenge_1({Key? key}) : super(key: key);

  @override
  State<Challenge_1> createState() => _Challenge_1State();
}

class _Challenge_1State extends State<Challenge_1> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _ExpandedAppBar(),
    );
  }
}

class _ExpandedAppBar extends StatefulWidget {
  const _ExpandedAppBar();

  @override
  State<_ExpandedAppBar> createState() => _ExpandedAppBarState();
}

class _ExpandedAppBarState extends State<_ExpandedAppBar> with SingleTickerProviderStateMixin {
  bool _collapsed = false;
  late final AnimationController _controller = AnimationController(
    duration: animationTime,
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimationX = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(-1.0, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: animationCurve,
  ));

  late final Animation<double> _viewportAnimation = Tween<double>(
    begin: 0.6,
    end: 1,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: animationCurve,
  ));

  var _pageController = PageController(
    initialPage: 0,
    viewportFraction: 0.6,
  );

  int _currentPageIndex = 0;

  double _capacityScale = 0;

  Color _capacityColor = cardInactiveColor;
  bool _capacityAnimationStarted = false;
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.value > 0.9 && !_capacityAnimationStarted) {
        _capacityAnimationStarted = true;
        setState(() {
          _capacityScale = MediaQuery.of(context).size.width - 160;
          _capacityColor = secondaryColor;
        });
      }
      if (_controller.value < 0.1 && _capacityAnimationStarted) {
        _capacityAnimationStarted = false;
        setState(() {
          _capacityScale = 0;
          _capacityColor = cardInactiveColor;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1;
    var viewHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        AnimatedContainer(
          height: _collapsed ? viewHeight * 0.1184 : viewHeight * 0.28,
          margin: EdgeInsets.only(left: _collapsed ? 16 : 8),
          padding: const EdgeInsets.only(top: 12),
          decoration: const BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32),
            ),
          ),
          duration: animationTime,
          curve: animationCurve,
          child: Stack(
            children: [
              SlideTransition(
                position: _offsetAnimationX,
                child: AnimatedOpacity(
                  duration: animationTime,
                  opacity: _collapsed ? 0 : 1,
                  curve: animationCurve,
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 24),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "Upcoming \nevents",
                                style: Theme.of(context).textTheme.headline4?.copyWith(fontWeight: FontWeight.bold, color: Colors.black),
                              ),
                            ),
                            const SizedBox(width: 24),
                            const Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: Icon(Icons.search),
                            ),
                            const SizedBox(width: 84),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        height: 48,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: [
                            const SizedBox(width: 24),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                "Monday 17",
                                style: Theme.of(context).textTheme.bodyText1?.copyWith(color: primaryColor),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: secondaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                minimumSize: const Size(120, 48),
                              ),
                            ),
                            ...List.generate(
                              10,
                              (index) => Row(
                                children: [
                                  const SizedBox(width: 16),
                                  Center(
                                    child: Text(
                                      "Jun 7",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.copyWith(color: Theme.of(context).textTheme.bodyText1?.color?.withAlpha(25 * 3)),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: animationTime,
                left: _collapsed ? 16 : MediaQuery.of(context).size.width - 68,
                curve: animationCurve,
                top: _collapsed ? viewHeight / 30 : viewHeight / 20,
                child: AnimatedCrossFade(
                  firstCurve: animationCurve,
                  secondCurve: animationCurve,
                  firstChild: AnimatedContainer(
                    margin: const EdgeInsets.only(top: 12),
                    duration: animationTime,
                    curve: animationCurve,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(99),
                      border: Border.all(
                        width: 4,
                        color: Colors.white,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(99),
                      child: Image.asset(
                        "assets/images/challenge_1/woman.jpeg",
                        width: 44,
                        height: 44,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  duration: animationTime,
                  crossFadeState: _collapsed ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                  secondChild: Container(
                    margin: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(99),
                    ),
                    child: IconButton(
                      color: primaryColor,
                      onPressed: () {
                        startOpenAnimation();
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                left: _collapsed ? 150 : MediaQuery.of(context).size.width - 68,
                top: 40,
                duration: animationTime,
                curve: animationCurve,
                child: AnimatedOpacity(
                  duration: animationTime,
                  opacity: _collapsed ? 1 : 0,
                  curve: animationCurve,
                  child: const Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(top: 0),
                      child: Text(
                        "Lily's Stage Play",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        AnimatedContainer(
          height: _collapsed ? viewHeight - viewHeight * 0.1184 : 300,
          duration: animationTime,
          curve: animationCurve,
          child: AnimatedBuilder(
            animation: _viewportAnimation,
            builder: (BuildContext context, Widget? child) {
              _pageController = PageController(initialPage: _currentPageIndex, viewportFraction: _viewportAnimation.value);
              return PageView.builder(
                controller: _pageController,
                allowImplicitScrolling: false,
                padEnds: false,
                physics: _collapsed ? const NeverScrollableScrollPhysics() : const PageScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    _currentPageIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  var isFirst = index == 0;
                  var isActive = index == _currentPageIndex;
                  return AnimatedContainer(
                    margin: EdgeInsets.fromLTRB(16, _collapsed ? 16 : 32, _collapsed ? 0 : 16, _collapsed ? 0 : 16),
                    decoration: BoxDecoration(
                      color: isActive ? primaryColor : cardInactiveColor,
                      borderRadius: _collapsed
                          ? const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              bottomLeft: Radius.circular(16),
                            )
                          : BorderRadius.circular(16),
                    ),
                    duration: animationTime,
                    curve: animationCurve,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        splashColor: isActive ? secondaryColor.withAlpha(25) : Colors.transparent,
                        onTap: () {
                          if (isActive) {
                            startOpenAnimation();
                          } else {
                            _pageController.nextPage(duration: animationTime, curve: animationCurve);
                          }
                        },
                        child: Column(
                          children: [
                            Expanded(
                              child: AnimatedCrossFade(
                                firstChild: SizedBox(
                                  height: 300,
                                  child: Column(
                                    children: [
                                      SizedBox(height: index == 0 ? 8 : 16),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.access_time,
                                              color: isActive ? null : Theme.of(context).textTheme.bodyText1?.color?.withAlpha(125),
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              "9:45 AM",
                                              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                    color: isActive ? null : Theme.of(context).textTheme.bodyText1?.color?.withAlpha(125),
                                                  ),
                                            ),
                                            const Spacer(),
                                            Visibility(
                                              visible: isFirst,
                                              child: ElevatedButton(
                                                onPressed: () {},
                                                child: Text(
                                                  "LIVE",
                                                  style: Theme.of(context).textTheme.caption?.copyWith(color: primaryColor, fontWeight: FontWeight.bold),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  primary: secondaryColor,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(4),
                                                  ),
                                                  minimumSize: const Size(60, 32),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: index == 0 ? 4 : 26,
                                      ),
                                      Text(
                                        "Robots vs Restlers",
                                        style: Theme.of(context).textTheme.subtitle2?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: isActive ? null : Theme.of(context).textTheme.bodyText1?.color?.withAlpha(125),
                                            ),
                                      ),
                                      const Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: Row(
                                          children: [
                                            Icon(
                                              index == 0 ? Icons.location_on : Icons.location_on_outlined,
                                              color: isActive ? null : Theme.of(context).textTheme.bodyText1?.color?.withAlpha(125),
                                            ),
                                            Text(
                                              "Viena, Italy",
                                              style: Theme.of(context).textTheme.subtitle2?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: isActive ? null : Theme.of(context).textTheme.bodyText1?.color?.withAlpha(125),
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                    ],
                                  ),
                                ),
                                secondChild: SizedBox(
                                  height: viewHeight - 152,
                                  child: Stack(
                                    children: [
                                      AnimatedPositioned(
                                        duration: animationTime,
                                        curve: animationCurve,
                                        top: _collapsed ? 10 : 200,
                                        child: AnimatedOpacity(
                                          duration: animationTime,
                                          opacity: _collapsed ? 1 : 0,
                                          curve: animationCurve,
                                          child: Container(
                                            padding: const EdgeInsets.all(32),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: const [
                                                    Icon(Icons.info_outline),
                                                    SizedBox(width: 8),
                                                    Text("Event description", style: TextStyle(fontWeight: FontWeight.w800)),
                                                  ],
                                                ),
                                                const SizedBox(height: 16),
                                                Container(
                                                  width: MediaQuery.of(context).size.width - 64,
                                                  child: const Text(
                                                    "Pete Paquette starts in \"The Elvis Concert\" an \nunforgetable live concert experience showcasing the musicial career of Elvis Presley: the 1950s. Elvis in the Leather and the explosive Vegas years an unforgetable live concert experience showcasing the musicial career of Elvis Presley: the 1950s. Elvis in the Leather and the explosive Vegas years.",
                                                    style: TextStyle(height: 1.5, fontWeight: FontWeight.w600),
                                                  ),
                                                ),
                                                const SizedBox(height: 16),
                                                Row(
                                                  children: const [
                                                    Icon(Icons.article_outlined),
                                                    SizedBox(width: 8),
                                                    Text("Event details", style: TextStyle(fontWeight: FontWeight.w800)),
                                                  ],
                                                ),
                                                const SizedBox(height: 16),
                                                Container(
                                                  height: 72,
                                                  width: MediaQuery.of(context).size.width - 80,
                                                  decoration: BoxDecoration(
                                                    color: cardInactiveColor,
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  child: Row(
                                                    children: const [
                                                      SizedBox(width: 16),
                                                      Text(
                                                        "11th\nMAY",
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(fontWeight: FontWeight.bold, height: 1.5),
                                                      ),
                                                      SizedBox(width: 24),
                                                      Text(
                                                        "9:45 AM",
                                                        style: TextStyle(fontWeight: FontWeight.bold),
                                                      ),
                                                      SizedBox(width: 8),
                                                      Expanded(
                                                        child: Divider(
                                                          thickness: 3,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      SizedBox(width: 8),
                                                      Text(
                                                        "11:00 AM",
                                                        style: TextStyle(fontWeight: FontWeight.bold),
                                                      ),
                                                      SizedBox(width: 16),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 16),
                                                AnimatedOpacity(
                                                  duration: const Duration(milliseconds: 250),
                                                  curve: animationCurve,
                                                  opacity: _capacityAnimationStarted ? 1 : 0.5,
                                                  child: Stack(
                                                    alignment: Alignment.centerLeft,
                                                    children: [
                                                      Container(
                                                        height: 50,
                                                        width: MediaQuery.of(context).size.width - 80,
                                                        padding: const EdgeInsets.only(right: 16),
                                                        decoration: BoxDecoration(
                                                          color: cardInactiveColor,
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                        child: Align(
                                                          alignment: Alignment.centerRight,
                                                          child: AnimatedOpacity(
                                                            duration: const Duration(milliseconds: 250),
                                                            curve: animationCurve,
                                                            opacity: _capacityAnimationStarted ? 1 : 0.5,
                                                            child: const Text(
                                                              "100",
                                                              style: TextStyle(color: secondaryColor, fontWeight: FontWeight.bold),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      AnimatedContainer(
                                                        curve: animationCurve,
                                                        height: 54,
                                                        width: _capacityScale,
                                                        decoration: BoxDecoration(
                                                          color: _capacityColor,
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                        duration: const Duration(milliseconds: 250),
                                                        child: Stack(
                                                          children: [
                                                            Positioned(
                                                              left: 16,
                                                              top: 20,
                                                              child: AnimatedOpacity(
                                                                duration: const Duration(milliseconds: 250),
                                                                opacity: _capacityAnimationStarted ? 1 : 0.5,
                                                                curve: animationCurve,
                                                                child: const Text(
                                                                  "CAPACITY",
                                                                  style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
                                                                ),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              right: 16,
                                                              top: 20,
                                                              child: AnimatedOpacity(
                                                                duration: const Duration(milliseconds: 250),
                                                                curve: animationCurve,
                                                                opacity: _capacityAnimationStarted ? 1 : 0.5,
                                                                child: const Text(
                                                                  "80",
                                                                  style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 16),
                                                Row(
                                                  children: const [
                                                    Icon(Icons.location_on_outlined),
                                                    SizedBox(width: 8),
                                                    Text("Event location", style: TextStyle(fontWeight: FontWeight.w800)),
                                                  ],
                                                ),
                                                const SizedBox(height: 16),
                                                ClipRRect(
                                                  borderRadius: BorderRadius.circular(10),
                                                  child: Image.asset(
                                                    "assets/images/challenge_1/map.png",
                                                    width: MediaQuery.of(context).size.width - 80,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                crossFadeState: _collapsed ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                                duration: animationTime,
                                sizeCurve: animationCurve,
                                firstCurve: animationCurve,
                                secondCurve: animationCurve,
                                layoutBuilder: defaultLayoutBuilder,
                              ),
                            ),
                            AnimatedOpacity(
                              duration: animationTime,
                              opacity: isActive ? 1 : 0,
                              curve: animationCurve,
                              child: AnimatedContainer(
                                height: isActive
                                    ? _collapsed
                                        ? 80
                                        : 50
                                    : 0,
                                decoration: BoxDecoration(
                                  color: secondaryColor,
                                  borderRadius: _collapsed
                                      ? const BorderRadius.only(
                                          topLeft: Radius.circular(32),
                                          // bottomLeft: Radius.circular(16),
                                        )
                                      : const BorderRadius.only(
                                          bottomLeft: Radius.circular(16),
                                          bottomRight: Radius.circular(16),
                                        ),
                                ),
                                curve: animationCurve,
                                duration: animationTime,
                                child: Row(
                                  children: [
                                    AnimatedPadding(padding: EdgeInsets.only(left: _collapsed ? 32 : 16), duration: animationTime),
                                    ElevatedButton.icon(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.favorite_border,
                                        color: secondaryColor,
                                      ),
                                      label: const Text(
                                        "60",
                                        style: TextStyle(color: secondaryColor),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary: primaryColor,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                      ),
                                    ),
                                    Expanded(
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          AnimatedCrossFade(
                                            firstChild: const Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "Interested",
                                                style: TextStyle(color: primaryColor),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            secondChild: const Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "Interested in Attending",
                                                style: TextStyle(color: primaryColor),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            crossFadeState: _collapsed ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                                            duration: animationTime,
                                            sizeCurve: animationCurve,
                                            firstCurve: animationCurve,
                                            secondCurve: animationCurve,
                                            alignment: Alignment.center,
                                            layoutBuilder: textLayoutBuilder,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: animationTime,
                top: _collapsed ? 500 : 0,
                curve: animationCurve,
                child: Container(
                  height: 900,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(top: 20, left: 16),
                  decoration: BoxDecoration(
                    color: cardInactiveColor.withAlpha(125),
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(32)),
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(99),
                          ),
                          child: IconButton(
                            color: primaryColor,
                            onPressed: () {},
                            icon: const Icon(Icons.lightbulb_outline),
                          ),
                        ),
                        const SizedBox(width: 24),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Interested events",
                              style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Events that you have shown interest in",
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: animationTime,
                top: _collapsed ? 500 : 88,
                curve: animationCurve,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  height: 900,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: cardInactiveColor,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(32)),
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 16, top: 16, right: 20),
                          child: Text("2", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        ),
                        const SizedBox(width: 24),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Interested events",
                              style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Events that you have shown interest in",
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: animationTime,
                top: _collapsed ? 500 : 166,
                curve: animationCurve,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  height: 900,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(32)),
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(99),
                          ),
                          child: IconButton(
                            color: primaryColor,
                            onPressed: () {},
                            icon: const Text(
                              "1",
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 24),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Interested events",
                              style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Events that you have shown interest in",
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  void startOpenAnimation() {
    setState(() {
      _collapsed = !_collapsed;
      if (!_collapsed) {
        _controller.reverse();
      } else {
        _controller
          ..stop()
          ..reset()
          ..forward();
      }
    });
  }

  Widget defaultLayoutBuilder(Widget topChild, Key topChildKey, Widget bottomChild, Key bottomChildKey) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: <Widget>[
        Positioned(
          key: bottomChildKey,
          left: 0.0,
          top: 0.0,
          right: 0.0,
          child: bottomChild,
        ),
        Positioned(
          key: topChildKey,
          child: topChild,
        ),
      ],
    );
  }

  Widget textLayoutBuilder(Widget topChild, Key topChildKey, Widget bottomChild, Key bottomChildKey) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: <Widget>[
        Positioned.fill(
          key: bottomChildKey,
          left: 0.0,
          top: 0.0,
          right: 0.0,
          child: bottomChild,
        ),
        Positioned.fill(
          key: topChildKey,
          child: topChild,
        ),
      ],
    );
  }
}
