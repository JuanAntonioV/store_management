class ProductModel {
  int id;
  String name;
  String? description;
  int price;
  int stock;
  String? image;
  int? status;

  ProductModel({
    this.id = 0,
    required this.name,
    this.description,
    this.price = 0,
    this.stock = 0,
    this.image,
    this.status = 1,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      price: int.parse(json['price']),
      stock: json['stock'],
      status: 1,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['stock'] = this.stock;
    data['image'] = this.image;
    return data;
  }
}
