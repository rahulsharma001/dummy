class ProductModel{
  final String productImage;
  final String fullProdImage;
  final String title;
  final int price;
  final String description;

  ProductModel({this.productImage,this.fullProdImage,this.title,this.price,this.description});

  factory ProductModel.fromJson(Map<String,dynamic> json){
    return ProductModel(
      productImage: json['thumbnailUrl'],
      fullProdImage: json['url'],
      description: json['description'],
      title: json['title'],
      price: json['id']
    );
  }
}