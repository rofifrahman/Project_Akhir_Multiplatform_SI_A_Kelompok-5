import '../entities/slot_entity.dart';
import '../repositories/slot_repository.dart';

class AddSlot {
  final SlotRepository repository;

  AddSlot(this.repository);

  Future<void> call(SlotEntity slot) {
    return repository.addSlot(slot);
  }
}
