import 'dart:convert';

///
/// 标签数据实体
///
class TagBean {
  String title;
  String cover;
  String url;

  TagBean({
    this.title,
    this.cover,
    this.url,
  });

  factory TagBean.fromJson(Map<String, dynamic> json) {
    return TagBean(
      title: json['title'],
      cover: json['cover'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'cover': cover, 'url': url};
  }

  @override
  String toString() {
    return json.encode(this.toJson());
  }
}
