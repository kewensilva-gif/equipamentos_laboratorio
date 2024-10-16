class Equipament {
  final int id;
  final String name;
  final String description;
  final String image;
  final String? manufacturerNumber;
  final String? assetNumber;
  final String? brand;
  final String? model;

  // Construtor com atributos obrigatórios e opcionais
  Equipament({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    this.manufacturerNumber,
    this.assetNumber,
    this.brand,
    this.model,
  });

  // Método para criar uma instância de Equipament a partir de um JSON
  factory Equipament.fromJson(Map<String, dynamic> json) {
    return Equipament(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      manufacturerNumber: json['manufacturerNumber'],
      assetNumber: json['assetNumber'],
      brand: json['brand'],
      model: json['model'],
    );
  }

  // Método para converter uma instância de Equipament em JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'manufacturerNumber': manufacturerNumber,
      'assetNumber': assetNumber,
      'brand': brand,
      'model': model,
    };
  }
}
