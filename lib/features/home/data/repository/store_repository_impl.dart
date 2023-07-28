import 'package:kwikshop/features/categories/domain/entities.dart';
import '../../domain/entities/store.dart';
import '../../domain/repository/store_repository.dart';

class StoreRepositoryImpl implements StoreRepository {
  @override
  List<Store> loadAllStores(Categories categories) {
    const List<Store> stores = [
      Store(
        id: '#1',
        storeImage:
            'https://e1.pxfuel.com/desktop-wallpaper/603/328/desktop-wallpaper-d-mart.jpg',
        storeAddress: 'Crystal Mall',
        storeName: 'D Mart',
        storeRating: 4.8,
        storeType: 'Supermarket',
        categories: [
          Categories.bakery,
          Categories.beverages,
          Categories.cleaners,
          Categories.frozenFoods,
          Categories.snacks,
          Categories.foodGrains,
          Categories.dairy,
          Categories.cannedGoods,
          Categories.vegetables,
          Categories.fruits,
          Categories.personalCare,
        ],
      ),
      Store(
        id: '#2',
        storeImage:
            'https://lh5.googleusercontent.com/p/AF1QipNEONJtiVnLDBfjkiCc9zycMof4D-4qGlPQ_Zx-=w1080-k-no',
        storeAddress: 'Indira Circle',
        storeName: 'Frozen World',
        storeRating: 4.8,
        storeType: 'Supermarket',
        categories: [
          Categories.bakery,
          Categories.beverages,
          Categories.meats,
          Categories.frozenFoods,
          Categories.snacks,
          Categories.dairy,
        ],
      ),
      Store(
        id: '#3',
        storeImage:
            'https://content.jdmagicbox.com/comp/ahmedabad/r5/079pxx79.xx79.220520212536.p9r5/catalogue/osia-hypermart-vishala-ahmedabad-hypermarkets-ubf1htt76m.jpg',
        storeAddress: 'Ambedkar Chowk',
        storeName: 'Osia Mart',
        storeRating: 4.5,
        storeType: 'Supermarket',
        categories: [
          Categories.bakery,
          Categories.beverages,
          Categories.cleaners,
          Categories.frozenFoods,
          Categories.snacks,
          Categories.foodGrains,
          Categories.dairy,
          Categories.cannedGoods,
          Categories.vegetables,
          Categories.fruits,
          Categories.personalCare,
        ],
      ),
      Store(
        id: '#4',
        storeImage:
            'https://content.jdmagicbox.com/comp/rajkot/t5/0281px281.x281.140913113715.g8t5/catalogue/golden-super-market-university-road-rajkot-supermarkets-home-delivery-ejvb389zfl.jpg?clr=',
        storeAddress: 'Amin Marg',
        storeName: 'Golden SuperMarket',
        storeRating: 4.5,
        storeType: 'Supermarket',
        categories: [
          Categories.bakery,
          Categories.beverages,
          Categories.cleaners,
          Categories.frozenFoods,
          Categories.snacks,
          Categories.foodGrains,
          Categories.dairy,
          Categories.cannedGoods,
          Categories.vegetables,
          Categories.fruits,
          Categories.personalCare,
        ],
      ),
      Store(
        id: '#5',
        storeImage:
            'https://content.jdmagicbox.com/comp/raipur-chhattisgarh/t8/9999px771.x771.160425130118.f9t8/catalogue/vikram-provison-store-pandri-raipur-chhattisgarh-grocery-stores-apdfvyi.jpg',
        storeAddress: 'Indira Circle',
        storeName: 'Vikram Provision Store',
        storeRating: 3.5,
        storeType: 'Store',
        categories: [
          Categories.bakery,
          Categories.beverages,
          Categories.cleaners,
          Categories.frozenFoods,
          Categories.snacks,
          Categories.foodGrains,
          Categories.dairy,
          Categories.cannedGoods,
          Categories.vegetables,
          Categories.fruits,
          Categories.personalCare,
        ],
      ),
      Store(
        id: '#6',
        storeImage:
            'https://content.jdmagicbox.com/comp/bangalore/k6/080pxx80.xx80.170130110436.k7k6/catalogue/krishna-provision-store-kalkere-bangalore-provision-stores-3gfc0bb.jpg',
        storeAddress: 'Race course road',
        storeName: 'Krushna Provision Store',
        storeRating: 1.5,
        storeType: 'Store',
        categories: [
          Categories.bakery,
          Categories.beverages,
          Categories.cleaners,
          Categories.frozenFoods,
          Categories.snacks,
          Categories.foodGrains,
          Categories.dairy,
          Categories.cannedGoods,
          Categories.vegetables,
          Categories.fruits,
          Categories.personalCare,
        ],
      ),
      Store(
        id: '#7',
        storeImage:
            'https://static.wikia.nocookie.net/taarakmehta/images/6/6a/B7392B26-E97E-4E19-A833-26D487AD4560.jpeg/revision/latest?cb=20200624190915',
        storeAddress: 'Gondal Road',
        storeName: 'All in one Store',
        storeRating: 2.0,
        storeType: 'Store',
        categories: [
          Categories.bakery,
          Categories.beverages,
          Categories.cleaners,
          Categories.frozenFoods,
          Categories.snacks,
          Categories.foodGrains,
          Categories.dairy,
          Categories.cannedGoods,
          Categories.vegetables,
          Categories.fruits,
          Categories.personalCare,
        ],
      ),
      Store(
        id: '#8',
        storeImage:
            'https://content.jdmagicbox.com/comp/rewa/c2/9999p7662.7662.161021155321.c3c2/catalogue/yash-kirana-and-general-store-nh-7-satna-road-rewa-general-kirana-provision-stores-ehvgxyy.jpg',
        storeAddress: 'Ashapuradham Chowk',
        storeName: 'Yash General Store',
        storeRating: 4.0,
        storeType: 'Store',
        categories: [
          Categories.bakery,
          Categories.beverages,
          Categories.cleaners,
          Categories.frozenFoods,
          Categories.snacks,
          Categories.foodGrains,
          Categories.dairy,
          Categories.cannedGoods,
          Categories.vegetables,
          Categories.fruits,
          Categories.personalCare,
        ],
      ),
    ];
    if (categories == Categories.all) {
      return stores;
    } else {
      return stores
          .where((store) => store.categories.contains(categories))
          .toList();
    }
  }
}
