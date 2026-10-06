import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/primary_button.dart';

class AddSlotSheet extends StatefulWidget {
  final void Function(String startTime, String endTime) onAdd;

  const AddSlotSheet({super.key, required this.onAdd});

  @override
  State<AddSlotSheet> createState() => _AddSlotSheetState();
}

class _AddSlotSheetState extends State<AddSlotSheet> {
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  String? _validationError;

  Future<void> _pickTime(bool isStart) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: isStart ? 9 : 12, minute: 0),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: AppColors.primary,
                ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
        _validationError = null;
      });
    }
  }

  void _submit() {
    if (_startTime == null || _endTime == null) {
      setState(() => _validationError = 'Please select both start and end time');
      return;
    }

    final startMinutes = _startTime!.hour * 60 + _startTime!.minute;
    final endMinutes = _endTime!.hour * 60 + _endTime!.minute;

    if (endMinutes <= startMinutes) {
      setState(() => _validationError = 'End time must be after start time');
      return;
    }

    widget.onAdd(_startTime!.format(context), _endTime!.format(context));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text('Add Time Slot', style: AppTextStyles.h2),
          const SizedBox(height: 4),
          const Text(
            'Set the available hours for this day',
            style: AppTextStyles.body,
          ),
          const SizedBox(height: 22),
          Row(
            children: [
              Expanded(
                child: _TimeField(
                  label: 'Start time',
                  value: _startTime?.format(context),
                  onTap: () => _pickTime(true),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _TimeField(
                  label: 'End time',
                  value: _endTime?.format(context),
                  onTap: () => _pickTime(false),
                ),
              ),
            ],
          ),
          if (_validationError != null) ...[
            const SizedBox(height: 10),
            Text(
              _validationError!,
              style: const TextStyle(color: Colors.redAccent, fontSize: 12),
            ),
          ],
          const SizedBox(height: 24),
          PrimaryButton(
            label: 'Add Slot',
            trailingIcon: Icons.add_rounded,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}

class _TimeField extends StatelessWidget {
  final String label;
  final String? value;
  final VoidCallback onTap;

  const _TimeField({required this.label, required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.bodyBold),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Icon(Icons.access_time_rounded,
                    size: 18, color: AppColors.textMuted),
                const SizedBox(width: 8),
                Text(
                  value ?? 'Select',
                  style: AppTextStyles.body.copyWith(
                    color: value == null
                        ? AppColors.textMuted
                        : AppColors.textPrimary,
                    fontWeight:
                        value == null ? FontWeight.normal : FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}