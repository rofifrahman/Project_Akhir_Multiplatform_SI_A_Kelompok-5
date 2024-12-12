import '../repositories/slot_repository.dart';

class DeleteSlot {
  final SlotRepository repository;

  DeleteSlot(this.repository);

  Future<void> call(String id) {
    return repository.deleteSlot(id);
  }
}
