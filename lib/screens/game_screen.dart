// lib/screens/game_screen.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/words_data.dart';
import 'result_screen.dart';

class GameScreen extends StatefulWidget {
  final int levelIndex;
  const GameScreen({super.key, required this.levelIndex});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with SingleTickerProviderStateMixin {
  int wordIndex = 0;
  int score = 0;
  bool answered = false;
  String? chosen;
  List<String>? currentOptions;
  late AnimationController _animController;
  late Animation<double> _fadeAnim;

  LevelData get level => levelsData[widget.levelIndex];
  WordEntry get currentWord => level.words[wordIndex];

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(duration: const Duration(milliseconds: 350), vsync: this);
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeIn);
    _generateOptions();
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _generateOptions() {
    final allMeanings = getAllMeanings();
    final correct = currentWord.urdu;
    final pool = allMeanings.where((m) => m != correct).toList()..shuffle();
    final wrongs = pool.take(3).toList();
    currentOptions = ([correct, ...wrongs])..shuffle();
  }

  void _onOptionTap(String option) {
    if (answered) return;
    setState(() {
      answered = true;
      chosen = option;
      if (option == currentWord.urdu) score++;
    });
  }

  void _nextWord() async {
    if (wordIndex < level.words.length - 1) {
      _animController.reset();
      setState(() {
        wordIndex++;
        answered = false;
        chosen = null;
        _generateOptions();
      });
      _animController.forward();
    } else {
      // Save progress
      final prefs = await SharedPreferences.getInstance();
      final completed = prefs.getStringList('completed_levels') ?? [];
      if (!completed.contains(widget.levelIndex.toString())) {
        completed.add(widget.levelIndex.toString());
        await prefs.setStringList('completed_levels', completed);
      }
      await prefs.setInt('level_score_${widget.levelIndex}', score);

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultScreen(
            levelIndex: widget.levelIndex,
            score: score,
            total: level.words.length,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final progress = (wordIndex + (answered ? 1 : 0)) / level.words.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F0FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A3B8C),
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Level ${widget.levelIndex + 1}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '$score درست',
                style: const TextStyle(
                    fontSize: 15, fontFamily: 'NooriFont', fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress bar
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey.shade200,
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF7B68CC)),
            minHeight: 6,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${wordIndex + 1} / ${level.words.length}',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),
                Text(
                  level.surahName,
                  style: const TextStyle(
                      fontSize: 12, color: Color(0xFF4A3B8C), fontFamily: 'NooriFont'),
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ),
          // Word card
          FadeTransition(
            opacity: _fadeAnim,
            child: _buildWordCard(),
          ),
          const SizedBox(height: 12),
          // Options
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2.4,
                physics: const NeverScrollableScrollPhysics(),
                children: currentOptions!.map((opt) => _buildOptionButton(opt)).toList(),
              ),
            ),
          ),
          // Feedback + Next button
          _buildBottomSection(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildWordCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4A3B8C), Color(0xFF7B68CC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: const Color(0xFF4A3B8C).withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          Text(
            currentWord.arabic,
            style: const TextStyle(
              fontSize: 44,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'NooriFont',
              height: 1.4,
            ),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'اس لفظ کا اردو معنی کیا ہے؟',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontFamily: 'NooriFont',
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionButton(String option) {
    Color bgColor = Colors.white;
    Color borderColor = Colors.grey.shade200;
    Color textColor = Colors.grey.shade800;
    IconData? icon;

    if (answered) {
      if (option == currentWord.urdu) {
        bgColor = const Color(0xFFEAF3DE);
        borderColor = const Color(0xFF639922);
        textColor = const Color(0xFF3B6D11);
        icon = Icons.check_circle;
      } else if (option == chosen) {
        bgColor = const Color(0xFFFCEBEB);
        borderColor = const Color(0xFFE24B4A);
        textColor = const Color(0xFFA32D2D);
        icon = Icons.cancel;
      }
    }

    return GestureDetector(
      onTap: () => _onOptionTap(option),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 1.5),
          boxShadow: answered
              ? []
              : [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          textDirection: TextDirection.rtl,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 16, color: textColor),
              const SizedBox(width: 6),
            ],
            Flexible(
              child: Text(
                option,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                  fontFamily: 'NooriFont',
                ),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSection() {
    if (!answered) return const SizedBox(height: 60);
    final isCorrect = chosen == currentWord.urdu;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: BoxDecoration(
              color: isCorrect ? const Color(0xFFEAF3DE) : const Color(0xFFFCEBEB),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              textDirection: TextDirection.rtl,
              children: [
                Icon(
                  isCorrect ? Icons.check_circle : Icons.info_outline,
                  color: isCorrect ? const Color(0xFF3B6D11) : const Color(0xFFA32D2D),
                  size: 18,
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    isCorrect ? '✓ درست جواب!' : '✗ درست معنی: "${currentWord.urdu}"',
                    style: TextStyle(
                      color: isCorrect ? const Color(0xFF3B6D11) : const Color(0xFFA32D2D),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NooriFont',
                      fontSize: 14,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _nextWord,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A3B8C),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 2,
              ),
              child: Text(
                wordIndex < level.words.length - 1 ? 'اگلا لفظ  ←' : 'نتیجہ دیکھیں  ←',
                style: const TextStyle(fontSize: 16, fontFamily: 'NooriFont', fontWeight: FontWeight.bold),
                textDirection: TextDirection.rtl,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
