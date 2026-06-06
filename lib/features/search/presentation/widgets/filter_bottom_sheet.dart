import 'package:flutter/material.dart';

class FilterBottomSheet extends StatefulWidget {
  final String? currentCategory;
  final TimeOfDay? currentTime;
  final Function(String?, TimeOfDay?) onApply;
  final VoidCallback onClear;

  const FilterBottomSheet({
    super.key,
    this.currentCategory,
    this.currentTime,
    required this.onApply,
    required this.onClear,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String? _selectedCategory;
  TimeOfDay? _selectedTime;

  final List<String> _categories = [
    'Cardiologist',
    'Dentist',
    'Dermatologist',
    'Neurologist',
    'Orthopedist',
    'Pediatrician',
    'General Practitioner',
  ];

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.currentCategory;
    _selectedTime = widget.currentTime;
  }

  Future<void> _pickTime() async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (time != null) {
      setState(() {
        _selectedTime = time;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      height: 400,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Filter Doctors',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  widget.onClear();
                  Navigator.pop(context);
                },
                child: const Text(
                  'Clear Filters',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Category',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: _selectedCategory,
            items: _categories.map((category) {
              return DropdownMenuItem(value: category, child: Text(category));
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedCategory = value;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 0,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Availability Time',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: _pickTime,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedTime?.format(context) ?? 'Select Time',
                    style: TextStyle(
                      color: _selectedTime != null ? Colors.black : Colors.grey,
                    ),
                  ),
                  const Icon(Icons.access_time),
                ],
              ),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                widget.onApply(_selectedCategory, _selectedTime);
                Navigator.pop(context);
              },
              child: const Text('Apply Filters'),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
