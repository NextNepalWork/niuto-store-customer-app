import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeTags extends StatelessWidget {
  const HomeTags({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            child: Column(children: [
              SvgPicture.asset("assets/icons/ic_offer.svg", fit: BoxFit.none),
              Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text("10% Off First Order",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 10.0,
                      fontFamily: "MontserratLight",
                    )),
              )
            ]),
          ),
          Flexible(
            child: Column(children: [
              SvgPicture.asset("assets/icons/ic_delivery.svg", fit: BoxFit.none),
              Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text("Free shipping on \$35+",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 10.0,
                      fontFamily: "MontserratLight",
                    )),
              )
            ]),
          ),
          Flexible(
            child: Column(children: [
              SvgPicture.asset("assets/icons/ic_calender.svg", fit: BoxFit.none),
              Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text("30 Daus to Return",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 10.0,
                      fontFamily: "MontserratLight",
                    )),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
