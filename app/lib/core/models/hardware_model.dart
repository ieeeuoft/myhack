import 'package:cloud_firestore/cloud_firestore.dart';

 class Image {
  final String _name;
  final int _width;
  final int _height;
  final String _path;

  // Constructor
  Image(this._name, this._width, this._height, this._path);

  // Getter methods
  String get name => _name;
  int get width => _width;
  int get height => _height;
  String get path => _path;
 }

class HardwareModel {
  final String id; 
  final String category;
  final String name;
  final int modelNumber;
  final String manufacturer;
  final String datasheet;
  final String notes;
  final List<Image> images;
  final Timestamp updatedTimestamp;
  final String websiteURL;


  HardwareModel({ required this.id, required this.category, required this.name, 
      required this.modelNumber, required this.manufacturer, 
      required this.datasheet, required this.notes, required this.images, 
      required this.updatedTimestamp, required this.websiteURL
  });

  factory HardwareModel.fromDocument(Map<String, dynamic> doc, String id) {
    return HardwareModel(
      id: id, 
      category: doc['category'], 
      name: doc['name'], 
      modelNumber: doc['modelNumber'], 
      manufacturer: doc['manufacturer'], 
      datasheet: doc['datasheet'], 
      notes: doc['notes'], 
      images: doc['images'], 
      updatedTimestamp: doc['updatedTimestamp'], 
      websiteURL: doc['websiteURL']
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': id, 
      'category': category, 
      'name': name, 
      'modelNumber': modelNumber, 
      'manufacturer': manufacturer, 
      'datasheet': datasheet, 
      'notes': notes, 
      'images': images, 
      'updatedTimestamp': updatedTimestamp, 
      'websiteURL': websiteURL,
    };
  }
}