import 'dart:convert';
import 'package:ecom_flutter/models/product.dart';
import 'package:ecom_flutter/utils/app_textstyles.dart';
import 'package:ecom_flutter/view/cart_screen.dart';
import 'package:ecom_flutter/view/size_selector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

// Import your CartController here
import '../controllers/cart_controller.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late Product _product;
  bool _updating = false;

  final CartController cartController = Get.put(CartController());

  @override
  void initState() {
    super.initState();
    _product = widget.product;
  }

  Future<void> _toggleFavorite() async {
    setState(() => _updating = true);

    final updated = _product.copyWith(isFavorite: !_product.isFavorite);

    try {
      final url = Uri.parse(
        'http://192.168.146.1:8000/api/products/${_product.id}',
      );
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'is_favorite': updated.isFavorite}),
      );

      if (response.statusCode == 200) {
        setState(() {
          _product = updated;
        });
      } else {
        debugPrint('Failed to update favorite: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error updating product: $e');
    } finally {
      setState(() => _updating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
          color: isDark ? Colors.white : Colors.black,
        ),
        title: Text(
          'Details',
          style: AppTextstyle.withColor(
            AppTextstyle.h3,
            isDark ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () =>
                _shareProduct(context, _product.name, _product.description),
            icon: Icon(
              Icons.share,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    _product.imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const Center(child: Icon(Icons.broken_image, size: 60)),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    onPressed: _updating ? null : _toggleFavorite,
                    icon: Icon(
                      _product.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: _product.isFavorite
                          ? Theme.of(context).primaryColor
                          : (isDark ? Colors.white : Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(screenSize.width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title and Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          _product.name,
                          style: AppTextstyle.withColor(
                            AppTextstyle.h2,
                            Theme.of(context).textTheme.headlineMedium!.color!,
                          ),
                        ),
                      ),
                      Text(
                        '\$${_product.price.toStringAsFixed(2)}',
                        style: AppTextstyle.withColor(
                          AppTextstyle.h2,
                          Theme.of(context).textTheme.headlineMedium!.color!,
                        ),
                      ),
                    ],
                  ),

                  /// Category
                  Text(
                    _product.category,
                    style: AppTextstyle.withColor(
                      AppTextstyle.bodyMediem,
                      isDark ? Colors.grey[400]! : Colors.grey[600]!,
                    ),
                  ),

                  SizedBox(height: screenSize.height * 0.02),

                  /// Select Size
                  Text(
                    'Select Size',
                    style: AppTextstyle.withColor(
                      AppTextstyle.labelMedium,
                      Theme.of(context).textTheme.bodyLarge!.color!,
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.01),
                  const SizeSelector(),

                  SizedBox(height: screenSize.height * 0.02),

                  /// Description
                  Text(
                    'Description',
                    style: AppTextstyle.withColor(
                      AppTextstyle.labelMedium,
                      Theme.of(context).textTheme.bodyLarge!.color!,
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.01),
                  Text(
                    _product.description,
                    style: AppTextstyle.withColor(
                      AppTextstyle.bodySmall,
                      isDark ? Colors.grey[400]! : Colors.grey[600]!,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(screenSize.width * 0.04),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    cartController.addToCart(_product);
                    Get.to(() => const CartScreen());
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      vertical: screenSize.height * 0.02,
                    ),
                    side: BorderSide(
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  child: Text(
                    'Add To Cart',
                    style: AppTextstyle.withColor(
                      AppTextstyle.buttonMedium,
                      Theme.of(context).textTheme.bodyLarge!.color!,
                    ),
                  ),
                ),
              ),
              SizedBox(width: screenSize.width * 0.04),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Implement buy now action or checkout flow here
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      vertical: screenSize.height * 0.02,
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  child: Text(
                    'Buy Now',
                    style: AppTextstyle.withColor(
                      AppTextstyle.buttonMedium,
                      Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _shareProduct(
    BuildContext context,
    String productName,
    String description,
  ) async {
    const String shopLink = 'https://tepreaksmey.site';
    final String shareMessage = '$description\n\nShop now $shopLink';

    // Uncomment if using the share_plus package
    // Share.share(shareMessage, subject: productName);
  }
}

// Extension to simulate immutability
extension ProductCopy on Product {
  Product copyWith({bool? isFavorite}) {
    return Product(
      id: id,
      name: name,
      category: category,
      price: price,
      oldPrice: oldPrice,
      imageUrl: imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
      discount: discount ?? this.discount,
      description: description,
    );
  }
}
