class MassageModel {
  final String? massage;
  final String? id;

  MassageModel(this.massage, this.id);

  factory MassageModel.fromJson(json) {
    return MassageModel(json['massage'] , json['id']);
  }
}
