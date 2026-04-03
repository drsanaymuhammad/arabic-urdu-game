// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/words_data.dart';
import 'game_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> completedLevels = [];
  Map<int, int> levelScores = {};

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final completed = prefs.getStringList('completed_levels') ?? [];
    final Map<int, int> scores = {};
    for (int i = 0; i < levelsData.length; i++) {
      final sc = prefs.getInt('level_score_$i');
      if (sc != null) scores[i] = sc;
    }
    setState(() {
      completedLevels = completed.map(int.parse).toList();
      levelScores = scores;
    });
  }

  int get totalScore => levelScores.values.fold(0, (a, b) => a + b);
  int get totalWords => levelsData.length * 8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0FF),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildStatsRow(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.6,
                  ),
                  itemCount: levelsData.length,
                  itemBuilder: (ctx, i) => _buildLevelCard(i),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF4A3B8C), Color(0xFF7B68CC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          const Text(
            '﷽',
            style: TextStyle(fontSize: 28, color: Colors.white, fontFamily: 'NooriFont'),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 8),
          const Text(
            'قرآنی الفاظ گیم',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'NooriFont',
            ),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 4),
          Text(
            'Arabic Vocabulary Quiz',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.85),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _statItem('کل اسکور', '$totalScore/$totalWords'),
          Container(width: 1, height: 36, color: Colors.grey.shade200),
          _statItem('مکمل', '${completedLevels.length}/${levelsData.length}'),
          Container(width: 1, height: 36, color: Colors.grey.shade200),
          _statItem('باقی', '${levelsData.length - completedLevels.length} لیول'),
        ],
      ),
    );
  }

  Widget _statItem(String label, String value) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF4A3B8C), fontFamily: 'NooriFont')),
        const SizedBox(height: 2),
        Text(label,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600, fontFamily: 'NooriFont'),
            textDirection: TextDirection.rtl),
      ],
    );
  }

  Widget _buildLevelCard(int index) {
    final bool isCompleted = completedLevels.contains(index);
    final bool isLocked = index > 0 && !completedLevels.contains(index - 1);
    final int? score = levelScores[index];
    final level = levelsData[index];

    Color cardColor = Colors.white;
    Color borderColor = Colors.grey.shade200;
    Color numberColor = const Color(0xFF4A3B8C);

    if (isCompleted) {
      cardColor = const Color(0xFFEAF3DE);
      borderColor = const Color(0xFF639922);
      numberColor = const Color(0xFF3B6D11);
    } else if (isLocked) {
      cardColor = Colors.grey.shade100;
    }

    return GestureDetector(
      onTap: isLocked
          ? null
          : () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => GameScreen(levelIndex: index),
                ),
              );
              _loadProgress();
            },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, width: 1.5),
          boxShadow: isLocked
              ? []
              : [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 6, offset: const Offset(0, 2))],
        ),
        child: Stack(
          children: [
            if (isLocked)
              const Center(child: Icon(Icons.lock_outline, color: Colors.grey, size: 28))
            else
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (isCompleted)
                          const Icon(Icons.check_circle, color: Color(0xFF639922), size: 18)
                        else
                          const SizedBox(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: numberColor.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Level ${index + 1}',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold, color: numberColor),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      level.surahName.split('/').first.trim(),
                      style: TextStyle(
                        fontSize: 12,
                        color: isCompleted ? const Color(0xFF3B6D11) : Colors.grey.shade700,
                        fontFamily: 'NooriFont',
                      ),
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (score != null)
                      Text(
                        '$score/8 ★',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold, color: numberColor, fontFamily: 'NooriFont'),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
