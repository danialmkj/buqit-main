class DrawerItemModel{
  String id;
  String title;
  String? subtitle;
  String icon;
  bool enabled;

  DrawerItemModel({
    required this.id,
    required this.title,
    this.subtitle,
    required this.icon,
    required this.enabled,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.title,
      'subtitle': this.subtitle,
      'icon': this.icon,
      'enabled': this.enabled,
    };
  }

  factory DrawerItemModel.fromMap(Map<String, dynamic> map) {
    return DrawerItemModel(
      id: map['id'] as String,
      title: map['title'] as String,
      subtitle: map['subtitle'] as String?,
      icon: map['icon'] as String,
      enabled: map['enabled'] as bool,
    );
  }

  static List<DrawerItemModel> toList(map) {
    return (map as List).map((e) => DrawerItemModel.fromMap(e) ).toList();
  }
}