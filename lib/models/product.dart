class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final String image;
  final int quantity;


  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.quantity
  });

  Product copyWith({
    int? id,
    String? title,
    String? description,
    double? price,
    String? image,
    int? quantity,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        price: (json['price'] as num).toDouble(),
        image: json['image'],
        quantity: json['quantity'] ?? 1
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'price': price,
        'image': image,
        'quantity' : quantity
      };

  factory Product.fromMap(Map<String, dynamic> map) => Product(
        id: map['id'] ?? 0,
        title: map['title'] ?? 'No Title',
        description: map['description'] ?? 'No Description',
        price: (map['price'] as num).toDouble() ?? 0.0,
        image: map['image'] ?? '',
        quantity: map['quantity'] ?? 1
      );
}
