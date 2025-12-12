import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/saving.dart';

class AddEditScreen extends StatefulWidget {
  final Saving? saving;

  AddEditScreen({this.saving});

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final TextEditingController bulanController = TextEditingController();
  final TextEditingController jumlahController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.saving != null) {
      bulanController.text = widget.saving!.bulan;
      jumlahController.text = widget.saving!.jumlah.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.saving == null ? "Tambah Tabungan" : "Edit Tabungan",
        ),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: bulanController,
              decoration: const InputDecoration(labelText: "Bulan"),
            ),
            TextField(
              controller: jumlahController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Jumlah Tabungan"),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              onPressed: () async {
                if (widget.saving == null) {
                  await DatabaseHelper.instance.createSaving(
                    Saving(
                      bulan: bulanController.text,
                      jumlah: int.parse(jumlahController.text),
                    ),
                  );
                } else {
                  await DatabaseHelper.instance.updateSaving(
                    Saving(
                      id: widget.saving!.id,
                      bulan: bulanController.text,
                      jumlah: int.parse(jumlahController.text),
                    ),
                  );
                }
                Navigator.pop(context);
              },
              child: const Text("Simpan"),
            ),
          ],
        ),
      ),
    );
  }
}
