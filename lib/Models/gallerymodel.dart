class GalleryModel{
  final int albumid;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  GalleryModel({this.albumid,this.id,this.title,this.url,this.thumbnailUrl});

  factory GalleryModel.fromJson(Map<String,dynamic> json){
    return GalleryModel(
      albumid: json['albumId'],
      id:json['id'],
      title:json['title'],
      url:json['url'],
      thumbnailUrl:json['thumbnailUrl']
    );
  }

}