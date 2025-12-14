import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Assuming you have a Supabase client provider
final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  // Replace with your actual initialization logic
  return Supabase.instance.client;
});

// A provider that listens to a real-time stream from a Supabase table
final dataStreamProvider = StreamProvider.autoDispose<List<Map<String, dynamic>>>((
  ref,
) {
  final supabase = ref.watch(supabaseClientProvider);

  // Supabase stream can sometimes throw exceptions or errors.
  // The StreamProvider will automatically catch these and set the state to AsyncValue.error.
  return supabase
      .from('bannerss')
      .stream(primaryKey: ['id'])
      .order('created_at', ascending: true);
});

class ErrorTestScreen extends ConsumerWidget {
  const ErrorTestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the stream provider, which returns an AsyncValue
    final asyncData = ref.watch(dataStreamProvider);

    return asyncData.when(
      // 1. Loading State: Display a loading indicator
      loading: () => const Center(child: CircularProgressIndicator()),

      // 2. Error State: Display the error message and possibly a retry button
      error: (error, stackTrace) {
        // You can log the error for debugging:
        Log.error('Stream Error: $error\nStack Trace: $stackTrace');

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 48),
              const SizedBox(height: 8),
              Text(
                'Failed to load data: ${error.toString()}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 16),
              // Use .refresh() to restart the stream provider
              ElevatedButton(
                onPressed: () => ref.refresh(dataStreamProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        );
      },

      // 3. Data State: Display the successfully received data
      data: (data) {
        if (data.isEmpty) {
          return const Center(child: Text('No data found.'));
        }
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final item = data[index];
            return ListTile(title: Text(item['title'] as String? ?? 'N/A'));
          },
        );
      },
    );
  }
}
