class EventDetail {
  late String id;
  late String description;
  late String date;
  late String startTime;
  late String endTime;
  late String speaker;
  late String isFavorite;

  EventDetail(this.id, this.description, this.date, this.startTime,
      this.endTime, this.speaker, this.isFavorite);

  EventDetail.fromMap(dynamic obj) {
    description = obj['description'];
    date = obj['date'];
    startTime = obj['start_time'];
    endTime = obj['end_time'];
    speaker = obj['speaker'];
    isFavorite = obj['is_favorite'].toString();
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
      map['description'] = description;
      map['date'] = date;
      map['start_time'] = startTime;
      map['end_time'] = endTime;
      map['speaker'] = speaker;
      map['is_favorite'] = isFavorite;
    }
    return map;
  }
}
