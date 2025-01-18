import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterproiecttest1/AppConstants/constants.dart';
import 'package:flutterproiecttest1/APICalls/data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutterproiecttest1/ProductComponent/product_widget.dart';
import 'package:flutterproiecttest1/DealerComponent/dealers.dart';
import 'package:flutterproiecttest1/ProductComponent/availableProductsPage.dart';
import 'package:flutterproiecttest1/ProductComponent/productDetailPage.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late List<NavigationItem> navigationItems;
  late NavigationItem selectedItem;
  TextEditingController searchController = TextEditingController();
  List<Products> originalProductList = [];

  List<Products> products = [];
  List<Dealer> dealers = [];
  List<MakeupProductsDetails> makeupProductDetails = [];
  List<PerfumeProductsDetails> perfumeProductDetails = [];

  void fetchProductsData() async {
    List<Products> productList = await getProductsList();
    setState(() {
      products = productList;
      originalProductList = productList;
    });
  }

  void fetchMakeupProductDetails() async {
    List<MakeupProductsDetails> makeupProductDetailsList =
        await getMakeupProductDetails();
    setState(() {
      makeupProductDetails = makeupProductDetailsList;
    });
  }

  void fetchPerfumeProductDetails() async {
    List<PerfumeProductsDetails> perfumeProductDetailsList =
        await getPerfumeProductDetails();
    setState(() {
      perfumeProductDetails = perfumeProductDetailsList;
    });
  }

  void fetchDealerData() async {
    List<Dealer> dealerList = await getDealerList();
    setState(() {
      dealers = dealerList;
    });
  }

  List<Products> filterProductsByProductNameOrBrand(String name) {
    return products
        .where((product) =>
            product.denumireProdus.toLowerCase().contains(name.toLowerCase()) ||
            product.brand.toLowerCase().contains(name.toLowerCase()))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    fetchProductsData();
    fetchDealerData();
    fetchMakeupProductDetails();
    fetchPerfumeProductDetails();
    navigationItems = getNavigationItemList(context);
    setState(() {
      selectedItem = navigationItems[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "N O T I N O",
          style: GoogleFonts.mulish(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
          )
        ],
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    if (value.isEmpty) {
                      products = originalProductList;
                    } else {
                      products = filterProductsByProductNameOrBrand(value);
                    }
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: const TextStyle(fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: const EdgeInsets.only(
                    left: 30,
                  ),
                  suffixIcon: const Padding(
                    padding: EdgeInsets.only(right: 24.0, left: 16.0),
                    child: Icon(
                      Icons.search,
                      color: Colors.pink,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "OUR PRODUCTS",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[400],
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "Slide to find",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColorShadow,
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 12,
                                color: kPrimaryColorShadow,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 370,
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: buildDeals(),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AvailableProducts()),
                        );
                      },
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 0, right: 16, left: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.pink.shade200,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          padding: const EdgeInsets.all(24),
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Available Products",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    "Find yourself through us!",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                height: 50,
                                width: 50,
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.pink.shade200,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "PARTNERS",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[400],
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "Slide to find",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColorShadow,
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 12,
                                color: kPrimaryColorShadow,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 300,
                      margin: const EdgeInsets.only(bottom: 16),
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: buildDealers(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: buildNavigationItems(),
        ),
      ),
    );
  }

  List<Widget> buildDeals() {
    List<Widget> list = [];
    List<Products> filteredProducts = searchController.text.isEmpty
        ? products
        : filterProductsByProductNameOrBrand(searchController.text);

    for (var i = 0; i < filteredProducts.length; i++) {
      list.add(
        GestureDetector(
          onTap: () {
            // Determine which list to assign to productDetails based on the category
            final List<dynamic> productDetails;

            if (filteredProducts[i].categorie == "Makeup") {
              // Compare filteredProducts list with makeupProductDetails list to find the match
              productDetails = makeupProductDetails
                  .where(
                    (product) => product.id == filteredProducts[i].id,
                  )
                  .toList();

              // If no matching product is found, an empty list will be returned
            } else if (filteredProducts[i].categorie == "Parfum") {
              // Compare filteredProducts list with perfumeProductDetails list to find the match
              productDetails = perfumeProductDetails
                  .where(
                    (product) => product.id == filteredProducts[i].id,
                  )
                  .toList();

              // If no matching product is found, an empty list will be returned
            } else {
              productDetails =
                  []; // Default to an empty list for unsupported categories
            }

            // Navigate to ProductDetailPage with the selected productDetails
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailPage(
                  productDetails: productDetails,
                  index: i,
                ),
              ),
            );
          },
          child: buildProduct(filteredProducts[i], i),
        ),
      );
    }

    return list;
  }

  List<Widget> buildDealers() {
    List<Widget> list = [];
    for (var i = 0; i < dealers.length; i++) {
      list.add(buildDealer(dealers[i], i));
    }
    return list;
  }

  List<Widget> buildNavigationItems() {
    List<Widget> list = [];
    for (var navigationItem in navigationItems) {
      list.add(buildNavigationItem(navigationItem));
    }
    return list;
  }

  Widget buildNavigationItem(NavigationItem item) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedItem = item;
        });
      },
      child: Container(
        width: 50,
        child: Stack(
          children: <Widget>[
            selectedItem == item
                ? Center(
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.pink.shade200,
                      ),
                    ),
                  )
                : Container(),
            Center(
                child: GestureDetector(
              onTap: item.onTap,
              child: Icon(
                item.iconData,
                color: selectedItem == item ? Colors.black : Colors.grey[400],
                size: 24,
              ),
            ))
          ],
        ),
      ),
    );
  }
}
