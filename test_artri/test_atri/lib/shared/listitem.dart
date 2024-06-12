class NewsItem{
  String imgUrl;
  String newsTitle;
  String author;
  String date;
  String type;
  String content;
  NewsItem(this.imgUrl, this.newsTitle, this.author, this.date, this.type, this.content);

  NewsItem.fromJson(Map<String, dynamic> json)
  : imgUrl = json['imgUrl'] as String,
  newsTitle = json['newsTitle'] as String,
  author = json['author'] as String,
  date = json['date'] as String,
  type = json['type'] as String,
  content = json['content'] as String;

  Map<String, dynamic> ToJson() => {
    'imgUrl' : imgUrl,
    'newsTitle' : newsTitle,
    'author' : author,
    'date' : date,
    'type' : type,
    'content' : content
  };
}