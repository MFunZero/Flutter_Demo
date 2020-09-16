import 'package:json_annotation/json_annotation.dart';

part 'book.g.dart';
@JsonSerializable()
class Book {
    Book();

    String name;
    Map<String,dynamic> author;
    String publishDate;
    String publisher;
    
    factory Book.fromJson(Map<String,dynamic> json) => _$BookFromJson(json);
    Map<String, dynamic> toJson() => _$BookToJson(this);
}