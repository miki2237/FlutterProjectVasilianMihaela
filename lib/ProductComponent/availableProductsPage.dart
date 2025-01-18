import 'package:flutterproiecttest1/ProductComponent/productDetailPage.dart';
import 'package:flutterproiecttest1/ProductComponent/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutterproiecttest1/APICalls/data.dart';

class AvailableProducts extends StatefulWidget {
  @override
  _AvailableProductsState createState() => _AvailableProductsState();
}

class _AvailableProductsState extends State<AvailableProducts> {
  List<Filter> filters = getFilterList();
  late Filter selectedFilter;

  List<Products> products = [];
  List<Products> productsForCategoryFiltering = [];
  List<MakeupProductsDetails> makeupProductDetails = [];
  List<PerfumeProductsDetails> perfumeProductDetails = [];

  void fetchData() async {
    List<Products> productList = await getProductsList();
    setState(() {
      productsForCategoryFiltering = productList;
      products = productList;
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

  void sortProducts() {
    setState(() {
      if (selectedFilter == filters[0]) {
        fetchData();
      } else if (selectedFilter == filters[1]) {
        products.sort((a, b) => a.brand.compareTo(b.brand));
      } else if (selectedFilter == filters[2]) {
        products.sort((a, b) => a.pret.compareTo(b.pret));
      } else if (selectedFilter == filters[3]) {
        products.sort((a, b) =>
            int.parse(a.cantitateStoc).compareTo(int.parse(b.cantitateStoc)));
      } else if (selectedFilter == filters[4]) {
        products.sort((a, b) =>
            int.parse(b.cantitateStoc).compareTo(int.parse(a.cantitateStoc)));
      } else if (selectedFilter == filters[5]) {
        products = productsForCategoryFiltering;
        products =
            products.where((product) => product.categorie == "Makeup").toList();
      } else if (selectedFilter == filters[6]) {
        products = productsForCategoryFiltering;
        products =
            products.where((product) => product.categorie == "Parfum").toList();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchMakeupProductDetails();
    fetchPerfumeProductDetails();
    setState(() {
      selectedFilter = filters[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
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
              const SizedBox(
                height: 16,
              ),
              Text(
                "Available Products (${products.length})",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 33,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: GridView.count(
                  physics: const BouncingScrollPhysics(),
                  childAspectRatio: 1 / 2.10,
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  children: products
                      .asMap()
                      .map((index, item) {
                        return MapEntry(
                          index,
                          GestureDetector(
                            onTap: () {
                              // Determine which list to assign to productDetails based on the category
                              final List<dynamic> productDetails;

                              if (item.categorie == "Makeup") {
                                // Find the matching product from makeupProductDetails and send it in a list or an empty list if not found
                                productDetails = makeupProductDetails
                                    .where((product) => product.id == item.id)
                                    .toList();
                              } else if (item.categorie == "Parfum") {
                                // Find the matching product from perfumeProductDetails and send it in a list or an empty list if not found
                                productDetails = perfumeProductDetails
                                    .where((product) => product.id == item.id)
                                    .toList();
                              } else {
                                productDetails =
                                    []; // Default to an empty list for unsupported categories
                              }

                              // Debugging: Check the selected list based on category
                              print('Selected productDetails: $productDetails');

                              // Navigate to ProductDetailPage with the selected productDetails and the index
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailPage(
                                    productDetails: productDetails,
                                    index:
                                        index, // Send the index to the ProductDetailPage
                                  ),
                                ),
                              );
                            },
                            child: buildProduct(item,
                                index), // Use the index here to show the product
                          ),
                        );
                      })
                      .values
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 90,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              buildFilterIcon(),
              Row(
                children: buildFilters(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFilterIcon() {
    return Container(
      width: 50,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.pink.shade200,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.filter_list,
          color: Colors.black,
          size: 24,
        ),
      ),
    );
  }

  List<Widget> buildFilters() {
    List<Widget> list = [];
    for (var i = 0; i < filters.length; i++) {
      list.add(buildFilter(filters[i]));
    }
    return list;
  }

  Widget buildFilter(Filter filter) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = filter;
          sortProducts();
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Text(
          filter.name,
          style: TextStyle(
            color: selectedFilter == filter
                ? Colors.pink.shade500
                : Colors.grey[600],
            fontSize: 16,
            fontWeight:
                selectedFilter == filter ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
