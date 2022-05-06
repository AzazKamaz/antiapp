class NotesModel {
  final String uuid;
  final String data;

  NotesModel(this.uuid, this.data);

  factory NotesModel.fromJson(Map<String, dynamic> json) => NotesModel(
        json['uuid'],
        json['data'],
      );

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'data': data,
      };
}
