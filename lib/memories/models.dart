class OnlineModel {
  final String dataSource;
  final String tag;
  final String showTime;
  final bool isImage;
  final int index;

  OnlineModel(this.dataSource, this.tag, this.showTime, this.isImage,this.index);

  OnlineModel.fromJson(Map<String, dynamic> json)
      : dataSource = json['dataSource'],
        tag = json['tag'],
        showTime = json['showTime'],
        isImage = json['isImage'],
        index = json['index'];

  Map<String, dynamic> toJson() => {
        'dataSource': dataSource,
        'tag': tag,
        'showTime': showTime,
        'isImage': isImage,
        'index' :index
      };
}

class LocalModel {
  final String dataSource;
  final bool isImage;

  LocalModel(this.dataSource, this.isImage);

  LocalModel.fromJson(Map<String, dynamic> json)
      : dataSource = json['dataSource'],
        isImage = json['isImage'];

  Map<String, dynamic> toJson() => {
        'dataSource': dataSource,
        'isImage': isImage,
      };
}