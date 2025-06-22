class Product {
  final String name;
  final String category;
  final double price;
  final double? oldPrice;
  final String imageUrl;
  final bool isFavorite;
  final String description;
  const Product({
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.name,
    required this.price,
    this.oldPrice,
    this.isFavorite = false,
  });
}

final List<Product> products = [
  const Product(
    category: 'Footwear',
    description: 'This is 1',
    imageUrl: 'assets/images/shoe.jpg',
    isFavorite: true,
    name: 'shoes1',
    price: 69.00,
    oldPrice: 189.00,
  ),
  const Product(
    category: 'laptop',
    description: 'This is 2',
    imageUrl: 'assets/images/laptop.jpg',
    isFavorite: true,
    name: 'shoes2',
    price: 69.00,
    oldPrice: 189.00,
  ),
  const Product(
    category: 'jonhdan',
    description: 'This is 3',
    imageUrl: 'assets/images/shoe2.jpg',
    name: 'shoes3',
    price: 69.00,
    oldPrice: 189.00,
  ),
  const Product(
    category: 'puma',
    description: 'This is 1',
    imageUrl: 'assets/images/shoe.jpg',
    name: 'shoes4',
    price: 69.00,
    oldPrice: 189.00,
  ),
];
