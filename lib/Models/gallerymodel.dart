class GalleryModel{
  final int id;
  final String title;
  final String url;
  final String imageUrl;

  GalleryModel({this.id,this.title,this.url,this.imageUrl});

  factory GalleryModel.fromJson(Map<String,dynamic> json){
    return GalleryModel(
      id:json['id'],
      title:json['title'],
      url:json['url'],
      imageUrl:json['imageUrl']
    );
  }

}