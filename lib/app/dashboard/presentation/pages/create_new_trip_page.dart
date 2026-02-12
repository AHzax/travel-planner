import 'package:clean_architecture_app/app/dashboard/presentation/pages/trip_created.dart';
import 'package:flutter/material.dart';
import '../state/trip_store.dart';

class CreateNewTripScreen extends StatefulWidget {
  const CreateNewTripScreen({super.key});

  static const routeName = '/createTripPage';

  @override
  State<CreateNewTripScreen> createState() => _CreateNewTripScreenState();
}

class _CreateNewTripScreenState extends State<CreateNewTripScreen> {
  String selectedBudget = 'Medium';
  final Set<String> selectedInterests = {};
  final TextEditingController labelController = TextEditingController();
  final TextEditingController hintController = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;

  @override
  void dispose() {
    labelController.dispose();
    hintController.dispose();
    super.dispose();
  }

  void _submit() {
    final name = labelController.text.trim();
    final destination = hintController.text.trim();

    if (name.isEmpty ||
        destination.isEmpty ||
        startDate == null ||
        endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Please fill in the trip name, destination, and dates.'),
        ),
      );
      return;
    }

    final trip = Trip(
      title: name,
      location: destination,
      startDate: startDate!,
      endDate: endDate!,
      budget: selectedBudget,
      interests: selectedInterests.toList()..sort(),
    );

    TripScope.of(context).addTrip(trip);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => TripCreatedSuccessScreen(trip: trip),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final maxWidth =
        MediaQuery.of(context).size.width > 600 ? 520.0 : double.infinity;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            const _Header(),
            Expanded(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxWidth),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _Label('Trip Name *'),
                        _Input(
                          hint: 'e.g., Summer in Paris',
                          controller: labelController,
                        ),
                        const SizedBox(height: 20),
                        const _Label('Destination *', icon: Icons.location_on),
                        _Input(
                          hint: 'e.g., Paris, France',
                          controller: hintController,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: _DateInput(
                                label: 'Start Date *',
                                value: startDate,
                                onTap: () async {
                                  final picked = await showDatePicker(
                                    context: context,
                                    initialDate: startDate ?? DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2030),
                                  );
                                  if (picked != null) {
                                    setState(() {
                                      startDate = picked;
                                      if (endDate != null &&
                                          endDate!.isBefore(picked)) {
                                        endDate = null;
                                      }
                                    });
                                  }
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _DateInput(
                                label: 'End Date *',
                                value: endDate,
                                onTap: startDate == null
                                    ? null
                                    : () async {
                                        final picked = await showDatePicker(
                                          context: context,
                                          initialDate: endDate ?? startDate!,
                                          firstDate: startDate!,
                                          lastDate: DateTime(2030),
                                        );
                                        if (picked != null) {
                                          setState(() => endDate = picked);
                                        }
                                      },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        const _Label('Budget', icon: Icons.attach_money),
                        const SizedBox(height: 12),
                        Row(
                          children: ['Low', 'Medium', 'High']
                              .map(
                                (e) => Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: _BudgetButton(
                                      label: e,
                                      selected: selectedBudget == e,
                                      onTap: () =>
                                          setState(() => selectedBudget = e),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 24),
                        const _Label('Interests', icon: Icons.favorite_border),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            'Culture',
                            'Food',
                            'Adventure',
                            'Shopping',
                            'Nature',
                            'Beach',
                          ]
                              .map(
                                (interest) => _InterestChip(
                                  label: interest,
                                  selected:
                                      selectedInterests.contains(interest),
                                  onTap: () {
                                    setState(() {
                                      if (!selectedInterests.add(interest)) {
                                        selectedInterests.remove(interest);
                                      }
                                    });
                                  },
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 120),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            InkWell(onTap: _submit, child: const _BottomCTA()),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1E6FFB), Color(0xFF13B1A7)],
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 8),
          const Text(
            'Create New Trip',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _Label extends StatelessWidget {
  final String text;
  final IconData? icon;

  const _Label(this.text, {this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null) ...[
          Icon(icon, size: 18, color: Colors.teal),
          const SizedBox(width: 6),
        ],
        Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class _Input extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  const _Input({required this.hint, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _DateInput extends StatelessWidget {
  final String label;
  final DateTime? value;
  final VoidCallback? onTap;

  const _DateInput({
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.calendar_today, size: 16, color: Colors.blue),
            const SizedBox(width: 6),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color:
                    onTap == null ? Colors.grey.shade200 : Colors.grey.shade300,
              ),
            ),
            child: Text(
              value == null
                  ? 'Select date'
                  : '${value!.day}/${value!.month}/${value!.year}',
              style: TextStyle(
                color: value == null ? Colors.grey : Colors.black87,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _BudgetButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _BudgetButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: selected ? Colors.teal.withValues(alpha: 0.12) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? Colors.teal : Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.teal : Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _InterestChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _InterestChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? Colors.blue.withValues(alpha: 0.12) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? Colors.blue : Colors.grey.shade300,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.blue : Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _BottomCTA extends StatelessWidget {
  const _BottomCTA();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        height: 52,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [Color(0xFF1E6FFB), Color(0xFF13B1A7)],
          ),
        ),
        alignment: Alignment.center,
        child: const Text(
          'Create My Trip',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
