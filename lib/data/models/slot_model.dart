import '../../domain/entities/slot_entity.dart';

class SlotModel {
  final String id;
  final List<int> slots;
  final bool isWin;

  SlotModel({
    required this.id,
    required this.slots,
    required this.isWin
  });

  factory SlotModel.fromJson(Map<String, dynamic> json) {
    return SlotModel(
      id: json['id'],
      slots: List<int>.from(json['slots']),
      isWin: json['isWin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slots': slots,
      'isWin': isWin,
    };
  }

  SlotEntity toEntity() {
    return SlotEntity(
      id: id,
      slots: slots,
      isWin: isWin,
    );
  }

  static SlotModel fromEntity(SlotEntity entity) {
    return SlotModel(
      id: entity.id,
      slots: entity.slots,
      isWin: entity.isWin,
    );
  }
}

