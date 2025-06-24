import 'package:ecom_flutter/models/product.dart';
import 'package:ecom_flutter/services/product_service.dart';
import 'package:ecom_flutter/view/product_detail_screen.dart';
import 'package:ecom_flutter/view/widgets/product_card_all.dart';
import 'package:ecom_flutter/view/widgets/category_chips.dart';
import 'package:flutter/material.dart';

class ProductGridAll extends StatefulWidget {
  const ProductGridAll({super.key});

  @override
  State<ProductGridAll> createState() => _ProductGridAllState();
}

class _ProductGridAllState extends State<ProductGridAll> {
  late Future<List<Product>> _futureProducts;
  String selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    _futureProducts = ProductService.fetchProducts();
  }

  void _onCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategoryChips(onCategorySelected: _onCategorySelected),
        const SizedBox(height: 8),
        Expanded(
          child: FutureBuilder<List<Product>>(
            future: _futureProducts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              List<Product> products = snapshot.data ?? [];
              if (selectedCategory != 'All') {
                products = products
                    .where(
                      (p) =>
                          p.category.toLowerCase() ==
                          selectedCategory.toLowerCase(),
                    )
                    .toList();
              }

              if (products.isEmpty) {
                return const Center(child: Text('No products available.'));
              }

              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailScreen(product: product),
                      ),
                    ),
                    child: ProductCardAll(product: product),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
