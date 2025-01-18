import 'package:flutter/material.dart';
import 'package:flutterproiecttest1/APICalls/data.dart';

Widget buildProduct(Products product, int index) {
  return Container(
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(
        Radius.circular(15),
      ),
    ),
    padding: const EdgeInsets.all(16),
    // ignore: unnecessary_null_comparison
    margin: EdgeInsets.only(
        // ignore: unnecessary_null_comparison
        right: index != null ? 16 : 0,
        left: index == 0 ? 16 : 0),
    width: 220,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.pink.shade100,
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                "${product.pret} LEI",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 120,
          child: Center(
            child: Hero(
              tag: product.id,
              child: Image.network(
                product.img[0], // Use the first URL from the list
                fit: BoxFit.fitWidth,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.error,
                    size: 50,
                  ); // Display an error icon if the image fails to load
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child; // Return the fully loaded image
                  }
                  return const CircularProgressIndicator(); // Show a loading indicator while the image is loading
                },
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Text(
          product.denumireProdus,
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          product.brand,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            height: 1,
          ),
        ),
        Text(
          "Categorie: ${product.categorie == "Parfum" ? "Parfum" : product.categorie == "Makeup" ? "Makeup" : "Unknown"}",
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
            height: 2,
          ),
        ),
        Text(
          "Cantitate: ${product.cantitateStoc}",
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
            height: 2,
          ),
        )
      ],
    ),
  );
}
