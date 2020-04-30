class Video{
  final String id;
  final String title;
  final String thumbnailUrl;
  final String channelTitle;

  Video({
    this.id,
    this.title,
    this.thumbnailUrl,
    this.channelTitle,
});


  //Factory constructors allow us to return an instance of the class unlike regular constructors
  factory Video.fromMap(Map<String,dynamic>snippet){
    return Video(
      id:snippet['resourceId']['videoid'],
      title:snippet['title'],
      thumbnailUrl:snippet['thunmbnails']['high']['url'],
      channelTitle: snippet['channelTitle'],

    );
  }

}