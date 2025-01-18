import 'package:flutter/material.dart';
import 'package:flutterproiecttest1/APICalls/data.dart';

Widget buildDealer(Dealer dealer, int index) {
  return Container(
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(
        Radius.circular(15),
      ),
    ),
    padding: const EdgeInsets.all(16),
    margin: EdgeInsets.only(right: 16, left: index == 0 ? 16 : 0),
    width: 190,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(dealer.image),
              fit: BoxFit.cover,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          height: 150,
          width: 170,
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          dealer.name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            height: 1,
          ),
        ),
        Text(
          "${dealer.offers} ${dealer.offers == "1" ? 'offer' : 'offers'}",
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    ),
  );
}
