class ProductModel {
  bool isBasket;
  bool isFavorite;
  String imagePath;
  String title;
  double price;
  String description;
  ProductModel({
    required this.isBasket,
    required this.isFavorite,
    required this.imagePath,
    required this.title,
    required this.price,
    required this.description,
  });
}
