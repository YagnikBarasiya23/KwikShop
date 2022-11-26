class Products {
  final String productName;
  final int productPrice;
  final String image;

  const Products(
      {required this.image,
      required this.productName,
      required this.productPrice});
  static List<Products> getProducts = [];
}
