import '../../domain/entities/slot_entity.dart';
import '../../domain/repositories/slot_repository.dart';
import '../models/slot_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SlotRepositoryImpl implements SlotRepository {
  final DatabaseReference database;

  SlotRepositoryImpl(this.database);

  String? _getCurrentUserId() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return null;
    }
    return user.uid;
  }

  DatabaseReference _getUserSlotsRef() {
    final uid = _getCurrentUserId();
    if (uid == null) {
      throw Exception("Pengguna belum login");
    }
    return database.child('users').child(uid).child('slots');
  }

  @override
  Stream<List<SlotEntity>> getSlots() {
    try {
      final uid = _getCurrentUserId();
      if (uid == null) {
        return Stream.value([]);
      }
      return _getUserSlotsRef().onValue.map((event) {
        final data = event.snapshot.value as Map<dynamic, dynamic>?;
        if (data != null) {
          return data.entries.map((e) {
            final noteJson = Map<String, dynamic>.from(e.value);
            return SlotModel.fromJson(noteJson).toEntity();
          }).toList();
        }
        return [];
      });
    } catch (e) {
      return Stream.error(e);
    }
  }

  @override
  Future<void> addSlot(SlotEntity slot) async {
    try {
      final uid = _getCurrentUserId();
      if (uid == null) {
        throw Exception('Pengguna belum login');
      }
      final model = SlotModel.fromEntity(slot);
      await _getUserSlotsRef().child(model.id).set(model.toJson());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteSlot(String id) async {
    try {
      final uid = _getCurrentUserId();
      if (uid == null) {
        throw Exception('Pengguna belum login');
      }
      await _getUserSlotsRef().child(id).remove();
    } catch (e) {
      rethrow;
    }
  }
}

