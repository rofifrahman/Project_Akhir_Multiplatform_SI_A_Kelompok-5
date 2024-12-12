import '../entities/slot_entity.dart';

abstract class SlotRepository {
  Future<void> addSlot(SlotEntity slot);
  Future<void> deleteSlot(String id);
  Stream<List<SlotEntity>> getSlots();
}
