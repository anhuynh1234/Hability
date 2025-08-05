import 'package:flutter/material.dart';

class AddItemDialog extends StatefulWidget {
  const AddItemDialog({super.key});

  @override
  State<AddItemDialog> createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  int recurringFrequency = 1;
  String recurringUnit = 'day';
  bool isRecurring = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // backgroundColor: const Color(0xFF6C0E11),
      title: const Text('Add Item'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Item Name'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(labelText: 'Extra Description'),
            maxLines: 3,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Checkbox(
                value: isRecurring,
                onChanged: (value) {
                  setState(() {
                    isRecurring = value ?? false;
                  });
                },
              ),
              const Text('Recurring item'),
            ],
          ),
          if (isRecurring) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                // Frequency Dropdown (1–20)
                DropdownButton<int>(
                  value: recurringFrequency,
                  onChanged: (value) {
                    setState(() {
                      recurringFrequency = value!;
                    });
                  },
                  items: List.generate(
                    20,
                    (i) =>
                        DropdownMenuItem(value: i + 1, child: Text('${i + 1}')),
                  ),
                ),
                const SizedBox(width: 12),
                // Unit Dropdown (day/month/year)
                DropdownButton<String>(
                  value: recurringUnit,
                  onChanged: (value) {
                    setState(() {
                      recurringUnit = value!;
                    });
                  },
                  items: ['day', 'month', 'year'].map((unit) {
                    return DropdownMenuItem(value: unit, child: Text(unit));
                  }).toList(),
                ),
              ],
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // TODO: handle saving logic
            Navigator.pop(context);
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
