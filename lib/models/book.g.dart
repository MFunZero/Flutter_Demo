// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) {
  return Book()
    ..name = json['name'] as String
    ..author = json['author'] as Map<String, dynamic>
    ..publishDate = json['publishDate'] as String
    ..publisher = json['publisher'] as String;
}

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'name': instance.name,
      'author': instance.author,
      'publishDate': instance.publishDate,
      'publisher': instance.publisher
    };
