class InventoryModel {
  final String id;
  final String hardwareID;
  final int quantity;

  InventoryModel({ required this.id, required this.hardwareID, required this.quantity});

  factory InventoryModel.fromDocument(Map<String, dynamic> doc, String id) {
    return InventoryModel(
      id: id, 
      hardwareID: doc['hardwareID'], 
      quantity: doc['quantity'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': id, 
      'hardwareID': hardwareID, 
      'quantity': quantity, 
    };
  }
}