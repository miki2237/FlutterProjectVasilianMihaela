import 'package:flutter/material.dart';
import 'package:flutterproiecttest1/APICalls/data.dart';

class ProductDetailPage extends StatefulWidget {
  final List<dynamic> productDetails;
  final int index;

  ProductDetailPage(
      {super.key, required this.productDetails, required this.index});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductDetailPage> {
  int _currentImage = 0;
  List<PerfumeProductsDetails> _perfumeProductDetails = [];
  List<MakeupProductsDetails> _makeupProductDetails = [];

  // Method to check and assign the correct type to the respective list
  void _assignProductDetails() {
    if (widget.productDetails.isNotEmpty) {
      if (widget.productDetails[0] is PerfumeProductsDetails) {
        _perfumeProductDetails =
            widget.productDetails.cast<PerfumeProductsDetails>();
        print('Perfume Product Details: ${_perfumeProductDetails}');
      } else if (widget.productDetails[0] is MakeupProductsDetails) {
        _makeupProductDetails =
            widget.productDetails.cast<MakeupProductsDetails>();
        print('Makeup Product Details: ${_makeupProductDetails}');
      }
    } else {
      print('No product details found');
    }
  }

  @override
  void initState() {
    super.initState();
    _assignProductDetails();
  }

  // Method to build page indicator based on img
  List<Widget> buildPageIndicator() {
    List<Widget> list = [];

    // Check type and use the appropriate list for img
    if (_perfumeProductDetails.isNotEmpty) {
      // Access img property of PerfumeProductDetails
      for (var i = 0; i < _perfumeProductDetails[0].img.length; i++) {
        list.add(buildIndicator(i == _currentImage));
      }
    } else if (_makeupProductDetails.isNotEmpty) {
      // Access img property of MakeupProductDetails
      for (var i = 0; i < _makeupProductDetails[0].img.length; i++) {
        list.add(buildIndicator(i == _currentImage));
      }
    }

    return list;
  }

  Widget buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 6),
      height: 8,
      width: isActive ? 20 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.grey[400],
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                    border: Border.all(
                                      color: Colors.grey[300]!,
                                      width: 1,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.keyboard_arrow_left,
                                    color: Colors.black,
                                    size: 28,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          widget.productDetails.isNotEmpty &&
                                  widget.productDetails[0]
                                      is PerfumeProductsDetails
                              ? (widget.productDetails
                                  .cast<PerfumeProductsDetails>()[0]
                                  .denumireProdus)
                              : widget.productDetails.isNotEmpty &&
                                      widget.productDetails[0]
                                          is MakeupProductsDetails
                                  ? (widget.productDetails
                                      .cast<MakeupProductsDetails>()[0]
                                      .denumireProdus)
                                  : '', // Default if no valid product details
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          widget.productDetails.isNotEmpty &&
                                  widget.productDetails[0]
                                      is PerfumeProductsDetails
                              ? (widget.productDetails
                                  .cast<PerfumeProductsDetails>()[0]
                                  .brand)
                              : widget.productDetails.isNotEmpty &&
                                      widget.productDetails[0]
                                          is MakeupProductsDetails
                                  ? (widget.productDetails
                                      .cast<MakeupProductsDetails>()[0]
                                      .brand)
                                  : '', // Default if no valid product details
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Expanded(
                        child: Container(
                          child: PageView(
                            physics: const BouncingScrollPhysics(),
                            onPageChanged: (int page) {
                              setState(() {
                                _currentImage = page;
                              });
                            },
                            children: (widget.productDetails.isNotEmpty &&
                                        widget.productDetails[0]
                                            is PerfumeProductsDetails
                                    ? widget.productDetails
                                        .cast<PerfumeProductsDetails>()[0]
                                        .img
                                    : widget.productDetails.isNotEmpty &&
                                            widget.productDetails[0]
                                                is MakeupProductsDetails
                                        ? widget.productDetails
                                            .cast<MakeupProductsDetails>()[0]
                                            .img
                                        : [])
                                .map((url) {
                              return Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Hero(
                                  tag: widget.productDetails.isNotEmpty &&
                                          widget.productDetails[0]
                                              is PerfumeProductsDetails
                                      ? widget.productDetails
                                          .cast<PerfumeProductsDetails>()[0]
                                          .id
                                      : widget.productDetails.isNotEmpty &&
                                              widget.productDetails[0]
                                                  is MakeupProductsDetails
                                          ? widget.productDetails
                                              .cast<MakeupProductsDetails>()[0]
                                              .id
                                          : '', // Default if no valid product details
                                  child: Image.network(url),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      widget.productDetails.isNotEmpty &&
                              (widget.productDetails[0]
                                          is PerfumeProductsDetails
                                      ? widget.productDetails
                                          .cast<PerfumeProductsDetails>()[0]
                                          .img
                                          .length
                                      : widget.productDetails[0]
                                              is MakeupProductsDetails
                                          ? widget.productDetails
                                              .cast<MakeupProductsDetails>()[0]
                                              .img
                                              .length
                                          : 0) >
                                  1
                          ? Container(
                              margin: const EdgeInsets.symmetric(vertical: 16),
                              height: 30,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: buildPageIndicator(),
                              ),
                            )
                          : Container(),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 16, left: 16, right: 16),
                      child: Text(
                        "DESCRIERE",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                    Container(
                      height: 230,
                      padding: const EdgeInsets.only(
                        top: 48,
                        left: 16,
                      ),
                      margin: const EdgeInsets.only(bottom: 16),
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: [
                          buildProductDescription(
                            "Brand",
                            widget.productDetails.isNotEmpty &&
                                    widget.productDetails[0]
                                        is PerfumeProductsDetails
                                ? widget.productDetails
                                    .cast<PerfumeProductsDetails>()[0]
                                    .brand
                                : widget.productDetails.isNotEmpty &&
                                        widget.productDetails[0]
                                            is MakeupProductsDetails
                                    ? widget.productDetails
                                        .cast<MakeupProductsDetails>()[0]
                                        .brand
                                    : '', // Default if no valid product details
                          ),
                          buildProductDescription(
                            "Denumire produs",
                            widget.productDetails.isNotEmpty &&
                                    widget.productDetails[0]
                                        is PerfumeProductsDetails
                                ? widget.productDetails
                                    .cast<PerfumeProductsDetails>()[0]
                                    .denumireProdus
                                : widget.productDetails.isNotEmpty &&
                                        widget.productDetails[0]
                                            is MakeupProductsDetails
                                    ? widget.productDetails
                                        .cast<MakeupProductsDetails>()[0]
                                        .denumireProdus
                                    : '', // Default if no valid product details
                          ),
                          buildProductDescription(
                            "Cantitate stoc",
                            widget.productDetails.isNotEmpty &&
                                    widget.productDetails[0]
                                        is PerfumeProductsDetails
                                ? widget.productDetails
                                    .cast<PerfumeProductsDetails>()[0]
                                    .cantitateStoc
                                : widget.productDetails.isNotEmpty &&
                                        widget.productDetails[0]
                                            is MakeupProductsDetails
                                    ? widget.productDetails
                                        .cast<MakeupProductsDetails>()[0]
                                        .cantitateStoc
                                    : '', // Default if no valid product details
                          ),
                          buildProductDescription(
                            "Pret",
                            widget.productDetails.isNotEmpty &&
                                    widget.productDetails[0]
                                        is PerfumeProductsDetails
                                ? widget.productDetails
                                    .cast<PerfumeProductsDetails>()[0]
                                    .pret
                                : widget.productDetails.isNotEmpty &&
                                        widget.productDetails[0]
                                            is MakeupProductsDetails
                                    ? widget.productDetails
                                        .cast<MakeupProductsDetails>()[0]
                                        .pret
                                    : '', // Default if no valid product details
                          ),
                          buildProductDescription(
                            "Categorie",
                            widget.productDetails.isNotEmpty &&
                                    widget.productDetails[0]
                                        is PerfumeProductsDetails
                                ? widget.productDetails
                                    .cast<PerfumeProductsDetails>()[0]
                                    .categorie
                                : widget.productDetails.isNotEmpty &&
                                        widget.productDetails[0]
                                            is MakeupProductsDetails
                                    ? widget.productDetails
                                        .cast<MakeupProductsDetails>()[0]
                                        .categorie
                                    : '', // Default if no valid product details
                          ),
                          if (widget.productDetails.isNotEmpty &&
                              widget.productDetails[0] is MakeupProductsDetails)
                            buildProductDescription(
                              "Tip produs",
                              widget.productDetails
                                  .cast<MakeupProductsDetails>()[0]
                                  .tipProdus,
                            ),
                          if (widget.productDetails.isNotEmpty &&
                              widget.productDetails[0] is MakeupProductsDetails)
                            buildProductDescription(
                              "Acoperire",
                              widget.productDetails
                                  .cast<MakeupProductsDetails>()[0]
                                  .acoperire,
                            ),
                          if (widget.productDetails.isNotEmpty &&
                              widget.productDetails[0] is MakeupProductsDetails)
                            buildProductDescription(
                              "Finish",
                              widget.productDetails
                                  .cast<MakeupProductsDetails>()[0]
                                  .finish,
                            ),
                          if (widget.productDetails.isNotEmpty &&
                              widget.productDetails[0] is MakeupProductsDetails)
                            buildProductDescription(
                              "Nuanta",
                              widget.productDetails
                                  .cast<MakeupProductsDetails>()[0]
                                  .nuanta,
                            ),
                          if (widget.productDetails.isNotEmpty &&
                              widget.productDetails[0] is MakeupProductsDetails)
                            buildProductDescription(
                              "Tip textura",
                              widget.productDetails
                                  .cast<MakeupProductsDetails>()[0]
                                  .tip,
                            ),
                          if (widget.productDetails.isNotEmpty &&
                              widget.productDetails[0] is MakeupProductsDetails)
                            buildProductDescription(
                              "Cantitate produs",
                              widget.productDetails
                                  .cast<MakeupProductsDetails>()[0]
                                  .cantitate,
                            ),
                          if (widget.productDetails.isNotEmpty &&
                              widget.productDetails[0] is MakeupProductsDetails)
                            buildProductDescription(
                              "Descriere",
                              widget.productDetails
                                  .cast<MakeupProductsDetails>()[0]
                                  .descriere,
                            ),
                          if (widget.productDetails.isNotEmpty &&
                              widget.productDetails[0] is MakeupProductsDetails)
                            buildProductDescription(
                              "Ingrediente",
                              widget.productDetails
                                  .cast<MakeupProductsDetails>()[0]
                                  .ingrediente,
                            ),
                          if (widget.productDetails.isNotEmpty &&
                              widget.productDetails[0]
                                  is PerfumeProductsDetails)
                            buildProductDescription(
                              "Gen",
                              widget.productDetails
                                  .cast<PerfumeProductsDetails>()[0]
                                  .gen,
                            ),
                          if (widget.productDetails.isNotEmpty &&
                              widget.productDetails[0]
                                  is PerfumeProductsDetails)
                            buildProductDescription(
                              "Tip parfum",
                              widget.productDetails
                                  .cast<PerfumeProductsDetails>()[0]
                                  .tipParfum,
                            ),
                          if (widget.productDetails.isNotEmpty &&
                              widget.productDetails[0]
                                  is PerfumeProductsDetails)
                            buildProductDescription(
                              "Grup olfactiv",
                              widget.productDetails
                                  .cast<PerfumeProductsDetails>()[0]
                                  .grupOlfactiv,
                            ),
                          if (widget.productDetails.isNotEmpty &&
                              widget.productDetails[0]
                                  is PerfumeProductsDetails)
                            buildProductDescription(
                              "Cantitate produs",
                              widget.productDetails
                                  .cast<PerfumeProductsDetails>()[0]
                                  .cantitate,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 90,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Pret",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 1,
                ),
                Row(
                  children: [
                    Text(
                      "${widget.productDetails.isNotEmpty && widget.productDetails[0] is PerfumeProductsDetails ? widget.productDetails.cast<PerfumeProductsDetails>()[0].pret : widget.productDetails.isNotEmpty && widget.productDetails[0] is MakeupProductsDetails ? widget.productDetails.cast<MakeupProductsDetails>()[0].pret : ''} LEI",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      "TVA Inclus",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProductDescription(String title, String data) {
    return Container(
      width: 130,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            data,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
