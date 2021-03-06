class OnlineModel {
  final int id;
  final String title;
  final String remark;
  final String dataSource;
  final String tag;
  final String showTime;
  final bool isImage;
  final int skipNum;

  OnlineModel(this.id, this.title, this.remark, this.dataSource, this.tag,
      this.showTime, this.isImage, this.skipNum);

  OnlineModel.fromJson(Map<String, dynamic> json)
      : id = json['ID'],
        title = json['title'],
        remark = json['remark'],
        dataSource = json['dataSource'],
        tag = json['tag'],
        showTime = json['showTime'],
        isImage = json['isImage'],
        skipNum = json['skipNum'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'remark': remark,
        'dataSource': dataSource,
        'tag': tag,
        'showTime': showTime,
        'isImage': isImage,
        'skipNum': skipNum,
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
