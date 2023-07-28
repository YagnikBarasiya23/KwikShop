import 'package:kwikshop/features/categories/domain/entities.dart';

import '../../domain/entities/products.dart';
import '../../domain/repository/products_repository.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  @override
  List<Product> loadAllProducts(Categories categories) {
    const List<Product> products = [
      Product(
        productAmount: "500g",
        productImage: "https://pngimg.com/uploads/apple/apple_PNG12439.png",
        productName: "Apple",
        productPrice: 50,
        productCategory: Categories.fruits,
      ),
      Product(
        productAmount: "500g",
        productImage: "https://pngimg.com/uploads/banana/banana_PNG824.png",
        productName: "Banana",
        productPrice: 40,
        productCategory: Categories.fruits,
      ),
      Product(
        productAmount: "500g",
        productImage:
            "https://pngimg.com/uploads/cucumber/cucumber_PNG12602.png",
        productName: "Cucumber",
        productPrice: 55,
        productCategory: Categories.vegetables,
      ),
      Product(
        productAmount: "500g",
        productImage: "https://pngimg.com/uploads/tomato/tomato_PNG12530.png",
        productName: "Tomato",
        productPrice: 45,
        productCategory: Categories.vegetables,
      ),
      Product(
        productAmount: "250g",
        productImage: "https://pngimg.com/uploads/biscuit/biscuit_PNG16.png",
        productName: "Biscuit",
        productPrice: 56,
        productCategory: Categories.snacks,
      ),
      Product(
        productAmount: "250g",
        productImage: "https://pngimg.com/uploads/bread/bread_PNG2286.png",
        productName: "Bread",
        productPrice: 40,
        productCategory: Categories.snacks,
      ),
      Product(
        productAmount: "250g",
        productImage: "https://pngimg.com/uploads/cake/cake_PNG13080.png",
        productName: "Cake",
        productPrice: 60,
        productCategory: Categories.dairy,
      ),
      Product(
        productAmount: "250g",
        productImage: "https://pngimg.com/uploads/cheese/cheese_PNG11.png",
        productName: "Cheese",
        productPrice: 120,
        productCategory: Categories.dairy,
      ),
      Product(
        productAmount: "1",
        productImage: "https://pngimg.com/uploads/mop/mop_PNG5.png",
        productName: "Floor Cleaner",
        productPrice: 250,
        productCategory: Categories.cleaners,
      ),
      Product(
        productAmount: "250g",
        productImage:
            "https://pngimg.com/uploads/ice_cream/ice_cream_PNG5103.png",
        productName: "Ice cream",
        productPrice: 40,
        productCategory: Categories.frozenFoods,
      ),
      Product(
        productAmount: "250g",
        productImage:
            "https://pngimg.com/uploads/chocolate/chocolate_PNG97173.png",
        productName: "Chocolates",
        productPrice: 400,
        productCategory: Categories.frozenFoods,
      ),
      Product(
        productAmount: "250g",
        productImage:
            "https://www.pngarts.com/files/7/Hand-Sanitizer-Bottle-PNG-Download-Image.png",
        productName: "Sanitizer",
        productPrice: 100,
        productCategory: Categories.personalCare,
      ),
      Product(
        productAmount: "1 pack",
        productImage: "https://pngimg.com/uploads/soap/soap_PNG3.png",
        productName: "Soap",
        productPrice: 40,
        productCategory: Categories.personalCare,
      ),
      Product(
        productAmount: "250ml",
        productImage: "https://pngimg.com/uploads/sprite/sprite_PNG8919.png",
        productName: "Cold drinks",
        productPrice: 40,
        productCategory: Categories.beverages,
      ),
      Product(
        productAmount: "250ml",
        productImage: "https://pngimg.com/uploads/sprite/sprite_PNG8919.png",
        productName: "Energy drinks",
        productPrice: 40,
        productCategory: Categories.beverages,
      ),
      Product(
        productAmount: "250ml",
        productImage: "https://pngimg.com/uploads/milk/milk_PNG12704.png",
        productName: "Milk",
        productPrice: 40,
        productCategory: Categories.dairy,
      ),
      Product(
        productAmount: "500g",
        productImage: "https://pngimg.com/uploads/ketchup/ketchup_PNG48.png",
        productName: "Ketchup",
        productPrice: 225,
        productCategory: Categories.cannedGoods,
      ),
      Product(
        productAmount: "500g",
        productImage:
            "https://pngimg.com/uploads/mayonnaise/mayonnaise_PNG3.png",
        productName: "Mayonnaise",
        productPrice: 400,
        productCategory: Categories.cannedGoods,
      ),
      Product(
        productAmount: "250g",
        productImage: "https://pngimg.com/uploads/flour/flour_PNG3.png",
        productName: "Wheat Flour",
        productPrice: 40,
        productCategory: Categories.foodGrains,
      ),
      Product(
        productAmount: "250g",
        productImage: "https://pngimg.com/uploads/peanut/peanut_PNG5.png",
        productName: "Peanuts",
        productPrice: 40,
        productCategory: Categories.foodGrains,
      ),
      Product(
        productAmount: "250g",
        productImage: "https://pngimg.com/uploads/meat/meat_PNG3907.png",
        productName: "Meat",
        productPrice: 40,
        productCategory: Categories.meats,
      ),
    ];
    if (categories == Categories.all) {
      return products;
    } else {
      return products
          .where((product) => product.productCategory == categories)
          .toList();
    }
  }
}
