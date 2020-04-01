import UIKit
/* Comment Kdoc
@author Gabriele Zagarella
@project Supermarket

Creare un’applicazione che permetta di acquistare da un negoziante una
serie di prodotti in base ad una determinata categoria:
Prodotti alimentari, Indumenti, utensileria etc etc
I prodotti sono gestiti da un Negoziante il quale ha delle funzionalità :
- mostrare tutte le categorie di prodotti in vendita
- mostrare tutti i prodotti in vendita per categoria
- mostrare tutti i prodotti in vendita
- vendere un prodotto; (Rimuovere)
- inserire un nuovo prodotto nella lista in base alla categoria.
Un utente deve poter :
- richiedere la lista di tutti i prodotti in vendita del negoziante
- richiedere la lista di tutte le categorie in vendita del negoziante
- richiedere la lista dei prodotti in vendita del negoziante per categoria
- comprare un prodotto inserendolo in una lista di prodotti
Nota :
Una volta acquistato un elemento, questo viene aggiunto nella lista dei
prodotti dell’utente e rimosso dalla lista dei prodotti in vendita del negoziante
Suggerimento: Organizza gli elementi all’interno di un dizionario di array
dove la chiave rappresenta la categoria ed il valore è un array di stringhe che
identificano gli elementi da acquistare.*/

class Shop {
    
    private var name: String;
    private var place: String;
    var products: [String: [String]] = [
         "Desserts": ["chips", "ice-cream", "cake", "cookie", "pancakes", "chocolate"],
         "Garments": ["trousers", "tie", "t-shirt", "skirt", "bathrobe", "shoes"],
         "tools": ["coffeepot", "scissors", "forks", "pincer", "knive", "screwdriver"]
    ];
    var soldProducts: [String] = ["hammer", "slippers"];
    
    var newName: String {
        get {
            return self.name
        }
        set (name){
            self.name = name
        }
    }
    
    var newPlace: String {
        get {
            return self.place
        }
        set (place) {
            self.place = place
        }
    }
    
    var newProducts: [String: [String]] {
        get {
            return self.products
        }
        set (products) {
            self.products = products
        }
    }
    
    var newSoldProducts: [String] {
        get {
            return self.soldProducts
        }
        set (soldProducts) {
            self.soldProducts = soldProducts
        }
    }
    
    init(name: String, place :String) {
        self.name = name;
        self.place = place;
    }
    
    func toString() -> String {
        return "Shop \(self.newName), located in \(newPlace)";
    }
    
    func getCategoriesOfProductForSale() {
        print("Categories Of Product For Sale:");
        for (category, _) in newProducts {
            print("\(category)");
            }
    }
    
    func getAllProductForSale() {
        print("All Product For Sale:");
        for category in newProducts {
            for product in category.value {
                print("\(product)");
            }
        }
    }
    
    func getAllProductsForCategory() {
        print("Categories and Product For Sale:");
        for (category, product) in newProducts {
            print("\(category), \(product)");
        }
    }
    
    func getProductsForCategory(categoryPass: String) {
           for  (category, product) in newProducts {
                   if category != categoryPass{
                    print("Category not found");
                   }else {
                       print("Category is \(category), products are:");
                       for products in product {
                        print(products);
                       }
                   }
               return
           }
       }
    
    func sellProduct(categoryPass: String, product: String) {
        for  (category, products) in newProducts {
                if category != categoryPass{
                    print("Category not found");
                }else {
                    for (index, item) in products.enumerated() {
                        if item != product{
                            print("Product not found");
                        }else {
                            newProducts[category]?.remove(at: index);
                            print("Product \(item) selled");
                            soldProducts.append(item);
                        }
                        return
                    }
                }
            return
        }
    }
    
    func insertProductIntoCategory(categoryPass: String, product: String) {
        for  (category, _) in newProducts {
                if category != categoryPass{
                    print("Category not found");
                }else {
                    newProducts[category]?.append(product);
                    print("Product \(product) successfully inserted");
                }
            return
        }
    }
    
    func insertCategoryAndProduct(categoryPass: String, product: [String]) {
        self.newProducts.updateValue(product, forKey: categoryPass);
        print("Added new category and products \n\(categoryPass), \(product)");
    }
}

class Customer {
    private var user: String;
    private var id: Int;

    var shopping: [String] = [];

    var newUser: String {
        get {
            return self.user
        }
        set (user){
            self.user = user
        }
    }

    var newId: Int {
        get {
            return self.id
        }
        set (id) {
            self.id = id
        }
    }
    
    init(user: String, id: Int) {
        self.user = user;
        self.id = id;
    }

    func geProductListOfTheShop(shop: Shop) {
        shop.getAllProductForSale();
    }
    
    func getListCategoryOfTheShop(shop: Shop) {
        shop.getCategoriesOfProductForSale();
    }
    
    func  getListProductForCategoryOfTheShop(shop: Shop) {
        shop.getAllProductsForCategory();
    }
    
    func buyProduct(shop: Shop, category: String, product: String) -> Bool{
        shop.sellProduct(categoryPass: category, product: product);
        return true;
    }
    
    func buy(shop: Shop, category: String, product: String) {
        if (buyProduct(shop: shop, category: category, product: product)) == true {
            var selled = shop.newSoldProducts;
            for (index, item) in selled.enumerated() {
                if item == product {
                    selled.remove(at: index);
                    self.shopping.append(item);
                }
            }
        }
    }
}

"*...Created shop object...*"
var shop = Shop(name: "A&O", place: "Biancavilla");
"*...Created customer object...*"
var customer = Customer(user: "Gabriele", id: 1);

print("Customer")
"*...Show all products...*"
customer.geProductListOfTheShop(shop: shop);
print()
"*...Show category of products...*"
customer.getListCategoryOfTheShop(shop: shop);
print()
"*...Show all products for category...*"
customer.getListProductForCategoryOfTheShop(shop: shop);
print()
"*...Buy products...*"
customer.buy(shop: shop, category: "Desserts", product: "chips");
print()
"*...Show prodocts boughth...*"
print(customer.shopping);
print()
print()
"*...Show shop...*"
print(shop.toString());
print()
"*...Show category of products...*"
shop.getCategoriesOfProductForSale();
print()
"*...Show all products...*"
shop.getAllProductForSale();
print()
"*...Show all products for category...*"
shop.getAllProductsForCategory();
print()
"*...Show products for category...*"
shop.getProductsForCategory(categoryPass: "Desserts");
print()
"*...Sell prodoct...*"
shop.sellProduct(categoryPass: "Desserts", product: "ice-cream");
print()
"*...Show prodocts selled...*"
print(shop.newSoldProducts);
print()
"*...Insert products into category...*"
shop.insertProductIntoCategory(categoryPass: "Desserts", product: "pastries");
print()
"*...Insert category and products...*"
shop.insertCategoryAndProduct(categoryPass: "Fruit", product: ["apple", "banana"]);
