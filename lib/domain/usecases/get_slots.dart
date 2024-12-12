import '../entities/slot_entity.dart';
import '../repositories/slot_repository.dart';

class GetSlots {
  final SlotRepository repository;

  GetSlots(this.repository);

  Stream<List<SlotEntity>> call() {
    return repository.getSlots();
  }
}
