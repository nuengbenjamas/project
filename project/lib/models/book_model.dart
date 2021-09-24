import 'dart:convert';

class BookModel {
  final String name;
  final String cover;
  final String pdf;
  final String author;
  final String pagenumber;
  BookModel({
    required this.name,
    required this.cover,
    required this.pdf,
    required this.author,
    required this.pagenumber,
  });

  BookModel copyWith({
    String? name,
    String? cover,
    String? pdf,
    String? author,
    String? pagenumber,
  }) {
    return BookModel(
      name: name ?? this.name,
      cover: cover ?? this.cover,
      pdf: pdf ?? this.pdf,
      author: author ?? this.author,
      pagenumber: pagenumber ?? this.pagenumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'cover': cover,
      'pdf': pdf,
      'author': author,
      'pagenumber': pagenumber,
    };
  }

  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      name: map['name'],
      cover: map['cover'],
      pdf: map['pdf'],
      author: map['author'],
      pagenumber: map['pagenumber'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BookModel.fromJson(String source) => BookModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BookModel(name: $name, cover: $cover, pdf: $pdf, author: $author, pagenumber: $pagenumber)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is BookModel &&
      other.name == name &&
      other.cover == cover &&
      other.pdf == pdf &&
      other.author == author &&
      other.pagenumber == pagenumber;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      cover.hashCode ^
      pdf.hashCode ^
      author.hashCode ^
      pagenumber.hashCode;
  }
}
