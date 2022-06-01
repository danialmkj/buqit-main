

class SearchHistory{
  String content;
  String type;

  SearchHistory({
    required this.content,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'content': this.content,
      'type': this.type,
    };
  }

  static List<SearchHistory> toList(data){
    return (data as List).map((e) => SearchHistory.fromMap(e)).toList();
  }

  factory SearchHistory.fromMap(Map<String, dynamic> map) {
    return SearchHistory(
      content: map['content'] as String,
      type: map['type'] as String,
    );
  }
}