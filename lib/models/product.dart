class Product {
  final int id;
  final String name;
  final String category;
  final double price;
  final double? oldPrice;
  final String imageUrl;
  final bool isFavorite;
  final bool discount;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    this.oldPrice,
    required this.imageUrl,
    required this.isFavorite,
    required this.discount,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      price: double.parse(json['price'].toString()),
      oldPrice: json['old_price'] != null
          ? double.tryParse(json['old_price'].toString())
          : null,
      imageUrl: json['image_url'] ?? '',
      isFavorite: json['is_favorite'] ?? false,
      discount: json['discount'] ?? false,
      description: json['description'] ?? '',
    );
  }
}
