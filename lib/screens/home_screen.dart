import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/saving.dart';
import 'add_edit_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Saving> savings = [];
  int totalSaldo = 0;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final data = await DatabaseHelper.instance.getSavings();
    final total = await DatabaseHelper.instance.getTotalSaldo();

    setState(() {
      savings = data;
      totalSaldo = total;
    });
  }

  void deleteItem(int id) async {
    await DatabaseHelper.instance.deleteSaving(id);
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Aplikasi Menabung"),
        backgroundColor: Colors.teal,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddEditScreen()),
          );
          loadData();
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            color: Colors.teal.shade100,
            child: Text(
              "Total Saldo: Rp $totalSaldo",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: savings.length,
              itemBuilder: (context, index) {
                final item = savings[index];

                return Card(
                  child: ListTile(
                    title: Text(item.bulan),
                    subtitle: Text("Jumlah: Rp ${item.jumlah}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AddEditScreen(saving: item),
                              ),
                            );
                            loadData();
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => deleteItem(item.id!),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
