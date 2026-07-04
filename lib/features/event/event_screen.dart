import 'package:flutter/material.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  final _eventNameController = TextEditingController();
  final _locationController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _eventNameController.dispose();
    _locationController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveEvent() {
    final eventData = {
      'name': _eventNameController.text.trim(),
      'location': _locationController.text.trim(),
      'date': _dateController.text.trim(),
      'time': _timeController.text.trim(),
      'description': _descriptionController.text.trim(),
    };

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Event saved: ${eventData['name']}'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Details'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create Event',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _eventNameController,
                decoration: const InputDecoration(
                  labelText: 'Event Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _dateController,
                      decoration: const InputDecoration(
                        labelText: 'Date',
                        hintText: 'YYYY-MM-DD',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.datetime,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _timeController,
                      decoration: const InputDecoration(
                        labelText: 'Time',
                        hintText: 'HH:MM',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.datetime,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveEvent,
                  child: const Text('Save Event'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
