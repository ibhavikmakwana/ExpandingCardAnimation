import 'package:flutter/material.dart';

//inspired by https://www.uplabs.com/posts/ios-expanding-collection
class ExpandingCard extends StatefulWidget {
  final Widget topChild;
  final Widget secondChild;
  final Widget thirdChild;
  final Curve curve;
  final Duration animationDuration;
  final double borderRadius;

  const ExpandingCard({
    Key key,
    @required this.topChild,
    @required this.secondChild,
    @required this.thirdChild,
    this.curve = Curves.easeInOut,
    this.animationDuration = const Duration(milliseconds: 500),
    this.borderRadius = 4,
  }) : super(key: key);

  @override
  _ExpandingCardState createState() => _ExpandingCardState();
}

class _ExpandingCardState extends State<ExpandingCard> {
  double _containerHeight = 300;
  double _containerWidth = 200;
  double _bottomPosition = 0;
  double _topChildWidth = 200;

  /// state 1: collapsed
  /// state 2: partial expanded
  /// state 3: full screen
  /// state 4: for revers process
  int state = 1;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        overflow: Overflow.visible,
        fit: StackFit.loose,
        alignment: Alignment(0, 0),
        children: <Widget>[
          AnimatedContainer(
            duration: widget.animationDuration,
            curve: widget.curve,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(widget.borderRadius),
                ),
              ),
            ),
            height: _containerHeight,
            width: _containerWidth,
            child: (state == 3)
                ? Container(
                    width: _containerWidth,
                    margin: EdgeInsets.only(top: 300),
                    child: widget.thirdChild,
                  )
                : Visibility(
                    child: widget.secondChild,
                    visible: state == 2 || state == 4,
                  ),
          ),
          AnimatedPositioned(
            duration: widget.animationDuration,
            curve: widget.curve,
            bottom: _bottomPosition,
            child: Align(
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  updateUI(context);
                },
                child: Center(
                  child: AnimatedContainer(
                    duration: widget.animationDuration,
                    width: _topChildWidth,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          blurRadius: 2,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      child: widget.topChild,
                      borderRadius: BorderRadius.all(
                        Radius.circular(widget.borderRadius),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void updateUI(BuildContext context) {
    setState(() {
      if (state == 1) {
        state = 2;
        setConstraints(350, 250, 200, 85);
      } else if (state == 2) {
        state = 3;
        setConstraints(
            MediaQuery.of(context).size.height,
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height - 300);

        return;
      } else if (state == 3) {
        state = 4;
        setConstraints(350, 250, 200, 85);
        return;
      } else if (state == 4) {
        state = 1;
        setConstraints(300, 200, 200, 0);
      }
    });
  }

  void setConstraints(
    double containerHeight,
    double containerWidth,
    double imageWidth,
    double bottomPosition,
  ) {
    _containerHeight = containerHeight;
    _containerWidth = containerWidth;
    _topChildWidth = imageWidth;
    _bottomPosition = bottomPosition;
  }
}
