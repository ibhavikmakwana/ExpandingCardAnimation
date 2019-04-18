import 'package:flutter/material.dart';
import 'package:flutter_expanding_card/expanding_card.dart';

class ExpandingCardExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(202, 209, 217, 1),
      body: Center(
        child: PageView.builder(
          itemCount: 5,
          itemBuilder: (context, index) => ExpandingCard(
                topChild: Image.network(
                  "https://picsum.photos/200/300/?random",
                  height: 300,
                  fit: BoxFit.cover,
                ),
                secondChild: Container(),
                thirdChild: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => ListTile(
                        title: Text("$index"),
                        onTap: () {
                          print(index.toString());
                        },
                      ),
                ),
                curve: Curves.easeInOut,
                borderRadius: 8,
              ),
        ),
      ),
    );
  }
}
