import 'package:flutter/material.dart';
import '../../domain/entities/slot_entity.dart';
import '../../domain/usecases/add_slot.dart';
import '../../domain/usecases/get_slots.dart';
import '../../domain/usecases/delete_slot.dart';

class SlotProvider extends ChangeNotifier {
  final AddSlot addSlotUseCase;
  final GetSlots getSlotsUseCase;
  final DeleteSlot deleteSlotUseCase;

  List<SlotEntity> slots = [];

  SlotProvider({
    required this.addSlotUseCase,
    required this.getSlotsUseCase,
    required this.deleteSlotUseCase,
  });

  void fetchSlots() {
    getSlotsUseCase().listen((data) {
      slots = data;
      notifyListeners();
    });
  }


  Future<void> addSlot(SlotEntity slot) async {
    await addSlotUseCase(slot);
  }

  Future<void> deleteSlot(String id) async {
    await deleteSlotUseCase(id);
    notifyListeners();
  }
}
