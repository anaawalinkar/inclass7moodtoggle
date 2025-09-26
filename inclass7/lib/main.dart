import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MoodModel(),
      child: const MyApp(),
    ),
  );
}

class MoodModel with ChangeNotifier {
  String _currentMood = 'Happy';
  String _currentMoodImage = 'assets/happy.jpeg';

  String get currentMood => _currentMood;
  String get currentMoodImage => _currentMoodImage;

  void setHappy() {
    _currentMood = 'Happy';
    _currentMoodImage = 'assets/happy.jpeg';
    notifyListeners();
  }

  void setSad() {
    _currentMood = 'Sad';
    _currentMoodImage = 'assets/sad.jpeg';
    notifyListeners();
  }

  void setExcited() {
    _currentMood = 'Excited';
    _currentMoodImage = 'assets/excited.jpeg';
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Toggle Challenge',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Toggle Challenge'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade100, Colors.purple.shade100],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'How are you feeling today?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 40),
              const MoodDisplay(),
              const SizedBox(height: 40),
              const MoodButtons(),
              const SizedBox(height: 20),
              Consumer<MoodModel>(
                builder: (context, moodModel, child) {
                  return Text(
                    'Current Mood: ${moodModel.currentMood}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.deepPurple,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MoodDisplay extends StatelessWidget {
  const MoodDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (context, moodModel, child) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Image.asset(
                moodModel.currentMoodImage,
                width: 120,
                height: 120,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback if image fails to load
                  return Container(
                    width: 120,
                    height: 120,
                    color: Colors.grey.shade200,
                    child: Icon(
                      Icons.sentiment_dissatisfied,
                      size: 60,
                      color: Colors.grey.shade400,
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              Text(
                _getMoodEmoji(moodModel.currentMood),
                style: const TextStyle(fontSize: 40),
              ),
            ],
          ),
        );
      },
    );
  }

  String _getMoodEmoji(String mood) {
    switch (mood) {
      case 'Happy':
        return '😊';
      case 'Sad':
        return '😢';
      case 'Excited':
        return '🎉';
      default:
        return '😊';
    }
  }
}

class MoodButtons extends StatelessWidget {
  const MoodButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildMoodButton(
          context: context,
          mood: 'Happy',
          imagePath: 'assets/happy.jpeg',
          color: Colors.green,
          onPressed: () {
            Provider.of<MoodModel>(context, listen: false).setHappy();
          },
        ),
        _buildMoodButton(
          context: context,
          mood: 'Sad',
          imagePath: 'assets/sad.jpeg',
          color: Colors.blue,
          onPressed: () {
            Provider.of<MoodModel>(context, listen: false).setSad();
          },
        ),
        _buildMoodButton(
          context: context,
          mood: 'Excited',
          imagePath: 'assets/excited.jpeg',
          color: Colors.orange,
          onPressed: () {
            Provider.of<MoodModel>(context, listen: false).setExcited();
          },
        ),
      ],
    );
  }

  Widget _buildMoodButton({
    required BuildContext context,
    required String mood,
    required String imagePath,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: color.withOpacity(0.8),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(15),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                imagePath,
                width: 40,
                height: 40,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Text(
                      _getMoodEmoji(mood),
                      style: const TextStyle(fontSize: 24),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          mood,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: color,
          ),
        ),
      ],
    );
  }

  String _getMoodEmoji(String mood) {
    switch (mood) {
      case 'Happy':
        return '😊';
      case 'Sad':
        return '😢';
      case 'Excited':
        return '🎉';
      default:
        return '😊';
    }
  }
}