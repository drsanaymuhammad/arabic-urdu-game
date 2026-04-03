// lib/screens/result_screen.dart
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../data/words_data.dart';
import 'game_screen.dart';
import 'home_screen.dart';

class ResultScreen extends StatelessWidget {
  final int levelIndex;
  final int score;
  final int total;

  const ResultScreen({
    super.key,
    required this.levelIndex,
    required this.score,
    required this.total,
  });

  String get _stars {
    final pct = score / total;
    if (pct >= 0.875) return '⭐⭐⭐';
    if (pct >= 0.625) return '⭐⭐';
    if (pct >= 0.375) return '⭐';
    return '🔄';
  }

  String get _message {
    final pct = score / total;
    if (pct == 1.0) return 'شاندار! مکمل اسکور!';
    if (pct >= 0.75) return 'بہت اچھے!';
    if (pct >= 0.5) return 'اچھی کوشش!';
    return 'مزید مشق کریں!';
  }

  String get _shareText {
    final level = levelsData[levelIndex];
    final pct = ((score / total) * 100).round();
    return '''
📖 قرآنی الفاظ گیم — میرا نتیجہ!

${_stars}
لیول ${levelIndex + 1}: ${level.surahName}
اسکور: $score / $total ($pct%)
$_message

🕋 کیا آپ بھی یہ گیم کھیلنا چاہتے ہیں؟
قرآنی الفاظ سیکھیں — آسان اور دلچسپ طریقے سے!

#QuranWords #IslamicApp #ArabicLearning #قرآنی_الفاظ
''';
  }

  void _shareScore(BuildContext context) {
    Share.share(
      _shareText,
      subject: 'قرآنی الفاظ گیم — میرا اسکور',
    );
  }

  void _shareToWhatsApp(BuildContext context) {
    Share.share(
      _shareText,
      subject: 'قرآنی الفاظ گیم',
    );
  }

  Color get _scoreColor {
    final pct = score / total;
    if (pct >= 0.875) return const Color(0xFF3B6D11);
    if (pct >= 0.5) return const Color(0xFF4A3B8C);
    return const Color(0xFFA32D2D);
  }

  @override
  Widget build(BuildContext context) {
    final level = levelsData[levelIndex];
    final pct = ((score / total) * 100).round();
    final hasNext = levelIndex < levelsData.length - 1;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F0FF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Trophy / emoji
              Text(
                score == total ? '🏆' : score >= total * 0.75 ? '🌟' : score >= total * 0.5 ? '👍' : '📚',
                style: const TextStyle(fontSize: 64),
              ),
              const SizedBox(height: 16),
              Text(
                _message,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A3B8C),
                  fontFamily: 'NooriFont',
                ),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              Text(
                'Level ${levelIndex + 1} مکمل',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600, fontFamily: 'NooriFont'),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 6),
              Text(
                level.surahName,
                style: const TextStyle(fontSize: 13, color: Color(0xFF4A3B8C), fontFamily: 'NooriFont'),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              // Score card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.07), blurRadius: 10, offset: const Offset(0, 3)),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      _stars,
                      style: const TextStyle(fontSize: 40, letterSpacing: 6),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _statBox('اسکور', '$score/$total', _scoreColor),
                        _statBox('فیصد', '$pct%', _scoreColor),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Share section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  children: [
                    const Text(
                      'اپنا اسکور شیئر کریں!',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4A3B8C),
                        fontFamily: 'NooriFont',
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: _shareButton(
                            context,
                            label: 'WhatsApp',
                            icon: Icons.chat,
                            color: const Color(0xFF25D366),
                            onTap: () => _shareToWhatsApp(context),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _shareButton(
                            context,
                            label: 'Instagram',
                            icon: Icons.camera_alt,
                            color: const Color(0xFFE1306C),
                            onTap: () => _shareScore(context),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _shareButton(
                            context,
                            label: 'دیگر',
                            icon: Icons.share,
                            color: const Color(0xFF4A3B8C),
                            onTap: () => _shareScore(context),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Action buttons
              if (score < total)
                _actionButton(
                  context,
                  label: 'دوبارہ کوشش کریں',
                  icon: Icons.refresh,
                  isPrimary: true,
                  onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => GameScreen(levelIndex: levelIndex)),
                  ),
                ),
              if (score < total) const SizedBox(height: 10),
              if (hasNext)
                _actionButton(
                  context,
                  label: 'اگلا لیول ←',
                  icon: Icons.arrow_forward,
                  isPrimary: score == total,
                  onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => GameScreen(levelIndex: levelIndex + 1)),
                  ),
                ),
              const SizedBox(height: 10),
              _actionButton(
                context,
                label: '← تمام لیولز',
                icon: Icons.home_outlined,
                isPrimary: false,
                onTap: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                  (route) => false,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statBox(String label, String value, Color color) {
    return Column(
      children: [
        Text(value,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: color, fontFamily: 'NooriFont')),
        const SizedBox(height: 4),
        Text(label,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade600, fontFamily: 'NooriFont'),
            textDirection: TextDirection.rtl),
      ],
    );
  }

  Widget _shareButton(BuildContext context,
      {required String label, required IconData icon, required Color color, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _actionButton(BuildContext context,
      {required String label, required IconData icon, required bool isPrimary, required VoidCallback onTap}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 18),
        label: Text(label,
            style: const TextStyle(fontSize: 16, fontFamily: 'NooriFont', fontWeight: FontWeight.bold),
            textDirection: TextDirection.rtl),
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? const Color(0xFF4A3B8C) : Colors.white,
          foregroundColor: isPrimary ? Colors.white : const Color(0xFF4A3B8C),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: isPrimary ? BorderSide.none : const BorderSide(color: Color(0xFF4A3B8C)),
          ),
          elevation: isPrimary ? 2 : 0,
        ),
      ),
    );
  }
}
