import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/slot_entity.dart';
import '../providers/slot_provider.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> slots = [0, 0, 0];
  bool isRolling = false;

  static const imagePaths = [
    'assets/slot_1.png',
    'assets/slot_2.png',
    'assets/slot_3.png',
    'assets/slot_4.png',
    'assets/slot_5.png',
    'assets/slot_6.png',
    'assets/slot_7.png',
    'assets/slot_8.png',
    'assets/slot_9.png',
  ];

  void _rollSlots(SlotProvider provider) async {
    if (isRolling) return;
    setState(() => isRolling = true);

    final random = Random();
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 10; j++) {
        await Future.delayed(const Duration(milliseconds: 100));
        setState(() => slots[i] = random.nextInt(imagePaths.length));
      }
    }

    bool isJackpot = slots[0] == slots[1] && slots[1] == slots[2];

    try {
      final newSlot = SlotEntity(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        slots: slots,
        isWin: isJackpot,
      );
      await provider.addSlot(newSlot);
    } catch (e) {
      debugPrint("Error saving result: $e");
    }

    if (!mounted) return; // Ensure context is still active

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isJackpot ? "Jackpot!" : "Coba Lagi!"),
        content: Text(isJackpot
            ? "Selamat! Anda memenangkan jackpot!"
            : "Better luck next time."),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );

    setState(() => isRolling = false);
  }

  @override
  Widget build(BuildContext context){
    final slotProvider = Provider.of<SlotProvider>(context);
    slotProvider.fetchSlots();

    return Scaffold(
      appBar: AppBar(
        title: Text('Slot Machine'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              await GoogleSignIn().signOut(); // Tambahkan logout Google
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: slots
                  .map((slot) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  imagePaths[slot],
                  width: 96,
                  height: 96,
                  errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error, size: 96),
                ),
              ))
                  .toList(),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 30,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: isRolling
                  ? null
                  : () => _rollSlots(slotProvider),
              child: const Text(
                'Pull',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
                child: slotProvider.slots.isEmpty
                    ? const Center(child: Text('No history yet'))
                    : ListView.builder(
                  itemCount: slotProvider.slots.length,
                  itemBuilder: (context, index) {
                    final slot = slotProvider.slots[index];
                    return ListTile(
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: slot.slots
                            .map((slot) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Image.asset(
                            imagePaths[slot],
                            width: 32,
                            height: 32,
                            errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.error, size: 32),
                          ),
                        ))
                            .toList(),
                      ),
                      title: Text(
                          slot.isWin ? 'Win' : 'Lose',
                          style: TextStyle(
                            color: slot.isWin
                                ? Colors.green
                                : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.end,
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          await slotProvider.deleteSlot(slot.id);
                        },
                      ),
                    );
                  },
                ),
            ),
          ],
        ),
      ),
    );
  }
}