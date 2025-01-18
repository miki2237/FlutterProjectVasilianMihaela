import 'package:flutter/material.dart';
import 'package:flutterproiecttest1/AppConstants/AndroidEmulatorApiEndpoints.dart';
import 'package:flutterproiecttest1/MyNotinoProfileComponents/userProfilePage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NavigationItem {
  IconData iconData;
  VoidCallback? onTap;
  NavigationItem(this.iconData, {this.onTap});
}

List<NavigationItem> getNavigationItemList(BuildContext context) {
  return <NavigationItem>[
    NavigationItem(Icons.home),
    NavigationItem(Icons.person, onTap: () => _navigateToUserProfile(context)),
  ];
}

void _navigateToUserProfile(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => MyProfilePage()));
}

class Products {
  String id;
  String brand;
  String denumireProdus;
  String cantitateStoc;
  String pret;
  List<String> img;
  String categorie;

  Products(this.id, this.brand, this.denumireProdus, this.cantitateStoc,
      this.pret, this.img, this.categorie);

  factory Products.mapProductsDataFromJson(Map<String, dynamic> json) {
    return Products(
      json['id'] as String,
      json['brand'] as String,
      json['denumireProdus'] as String,
      json['cantitateStoc'] != null
          ? json['cantitateStoc'].toString()
          : 'Stoc indisponibil',
      json['pret'] as String,
      List<String>.from(json['img'] as List),
      json['categorie'] as String,
    );
  }
}

Future<List<Products>> getProductsList() async {
  try {
    // Send the requests to the Products.API by calling the 2 endpoints
    final responses = await Future.wait([
      http.get(Uri.parse(getAllMakeupProductsAndroidEmulatorApiEndpoint)),
      http.get(Uri.parse(getAllPerfumeProductsAndroidEmulatorApiEndpoint)),
    ]);

    // Combine results from both responses
    final allProducts = <Products>[];

    for (final response in responses) {
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        allProducts.addAll(
          jsonResponse
              .map((data) => Products.mapProductsDataFromJson(data))
              .toList(),
        );
      } else {
        throw Exception(
          'Failed to load data from one of the APIs with status code: ${response.statusCode}',
        );
      }
    }

    return allProducts;
  } catch (e) {
    throw Exception('Failed to load data: $e');
  }
}

class MakeupProductsDetails {
  String id;
  String brand;
  String tipProdus;
  String denumireProdus;
  String categorie;
  String acoperire;
  String finish;
  String nuanta;
  String tip;
  String cantitate;
  String descriere;
  String ingrediente;
  String cantitateStoc;
  String peStoc;
  String pret;
  List<String> img;

  MakeupProductsDetails(
      this.id,
      this.brand,
      this.tipProdus,
      this.denumireProdus,
      this.categorie,
      this.acoperire,
      this.finish,
      this.nuanta,
      this.tip,
      this.cantitate,
      this.descriere,
      this.ingrediente,
      this.cantitateStoc,
      this.peStoc,
      this.pret,
      this.img);

  factory MakeupProductsDetails.mapMakeupProductDetailsFromJson(
      Map<String, dynamic> json) {
    return MakeupProductsDetails(
      json['id'] as String,
      json['brand'] as String,
      json['tipProdus'] as String,
      json['denumireProdus'] as String,
      json['categorie'] as String,
      json['acoperire'] as String,
      json['finish'] as String,
      json['nuanta'] as String,
      json['tip'] as String,
      json['cantitate'] as String,
      json['descriere'] as String,
      json['ingrediente'] as String,
      json['cantitateStoc'].toString(),
      json['peStoc'].toString(),
      json['pret'] as String,
      List<String>.from(json['img'] as List),
    );
  }
}

Future<List<MakeupProductsDetails>> getMakeupProductDetails() async {
  final makeupDetailsResponse = await http
      .get(Uri.parse(getMakeupProductDetailsAndroidEmulatorApiEndpoint));

  if (makeupDetailsResponse.statusCode == 200) {
    final List<dynamic> jsonResponse = jsonDecode(makeupDetailsResponse.body);
    return jsonResponse
        .map((data) =>
            MakeupProductsDetails.mapMakeupProductDetailsFromJson(data))
        .toList();
  } else {
    throw Exception('Failed to load data from the API');
  }
}

class PerfumeProductsDetails {
  String id;
  String brand;
  String gen;
  String tipParfum;
  String grupOlfactiv;
  String cantitate;
  String cantitateStoc;
  String peStoc;
  String categorie;
  String pret;
  List<String> img;
  String denumireProdus;

  PerfumeProductsDetails(
      this.id,
      this.brand,
      this.gen,
      this.tipParfum,
      this.grupOlfactiv,
      this.cantitate,
      this.cantitateStoc,
      this.peStoc,
      this.categorie,
      this.pret,
      this.img,
      this.denumireProdus);

  factory PerfumeProductsDetails.mapPerfumeProductDetailsFromJson(
      Map<String, dynamic> json) {
    return PerfumeProductsDetails(
      json['id'] as String,
      json['brand'] as String,
      json['gen'] as String,
      json['tipParfum'] as String,
      json['grupOlfactiv'] as String,
      json['cantitate'] as String,
      json['cantitateStoc'].toString(),
      json['peStoc'].toString(),
      json['categorie'] as String,
      json['pret'] as String,
      List<String>.from(json['img'] as List),
      json['denumireProdus'] as String,
    );
  }
}

Future<List<PerfumeProductsDetails>> getPerfumeProductDetails() async {
  final perfumeDetailsResponse = await http
      .get(Uri.parse(getPerfumeProductDetailsAndroidEmulatorApiEndpoint));

  if (perfumeDetailsResponse.statusCode == 200) {
    final List<dynamic> jsonResponse = jsonDecode(perfumeDetailsResponse.body);
    return jsonResponse
        .map((data) =>
            PerfumeProductsDetails.mapPerfumeProductDetailsFromJson(data))
        .toList();
  } else {
    throw Exception('Failed to load data from the API');
  }
}

class CustomerData {
  String id;
  String cnp;
  String nume;
  String prenume;
  String email;
  String dataNasterii;
  String parola;
  String joinedSinceDate;
  String tara;
  String oras;
  List<String> favProduse;
  List<String> produseCumparate;

  CustomerData(
      this.id,
      this.cnp,
      this.nume,
      this.prenume,
      this.email,
      this.dataNasterii,
      this.parola,
      this.joinedSinceDate,
      this.tara,
      this.oras,
      this.favProduse,
      this.produseCumparate);

  factory CustomerData.mapCustomerDataFromJson(Map<String, dynamic> json) {
    return CustomerData(
        json['id'] as String,
        json['cnp'] as String,
        json['nume'] as String,
        json['prenume'] as String,
        json['email'] as String,
        json['dataNasterii'] as String,
        json['parola'] as String,
        json['joinedSinceDate'] as String,
        json['tara'] as String,
        json['oras'] as String,
        List<String>.from(json['favProduse'] as List),
        List<String>.from(json['produseCumparate'] as List));
  }
}

Future<CustomerData> getCustomerData(String clientId) async {
  final response = await http
      .get(Uri.parse("$getCustomerDataAndroidEmulatorApiEndpoint/$clientId"));

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonData = json.decode(response.body);
    return CustomerData.mapCustomerDataFromJson(jsonData);
  } else {
    throw Exception('Failed to load data from the API');
  }
}

class Dealer {
  String name;
  String offers;
  String image;
  String website;

  Dealer(this.name, this.offers, this.image, this.website);

  factory Dealer.mapDealerDataFromJson(Map<String, dynamic> json) {
    return Dealer(json["numePartener"], json["numarOferte"],
        json["imagesParteneri"], json["website"]);
  }
}

Future<List<Dealer>> getDealerList() async {
  final dealerResponse =
      await http.get(Uri.parse(getDealersAndroidEmulatorApiEndpoint));

  if (dealerResponse.statusCode == 200) {
    final List<dynamic> jsonResponse = jsonDecode(dealerResponse.body);
    return jsonResponse
        .map((data) => Dealer.mapDealerDataFromJson(data))
        .toList();
  } else {
    throw Exception('Failed to load data from the API');
  }
}

class Filter {
  String name;

  Filter(this.name);
}

List<Filter> getFilterList() {
  return <Filter>[
    Filter("All"), //0
    Filter("Brand"), //1
    Filter("Pret"), //2
    Filter("Cantitate (Crescator)"), //3
    Filter("Cantitate (Descrescator)"), //4
    Filter("Makeup"), //5
    Filter("Perfume"), //6
  ];
}

class Cities {
  List<String> cities;

  Cities(this.cities);

  factory Cities.mapCitiesDataFromJson(Map<String, dynamic> json) {
    return Cities(List<String>.from(json['cities'] as List));
  }
}
