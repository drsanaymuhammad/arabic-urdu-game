// lib/data/words_data.dart

class WordEntry {
  final String arabic;
  final String urdu;
  const WordEntry(this.arabic, this.urdu);
}

class LevelData {
  final String surahName;
  final List<WordEntry> words;
  const LevelData(this.surahName, this.words);
}

const List<LevelData> levelsData = [
  LevelData('سُوۡرَةُ مَرۡيَم / سُوۡرَةُ طَهٗ', [
    WordEntry('الۡعَظۡم', 'ہڈیاں'),
    WordEntry('غُلَم', 'لڑکا'),
    WordEntry('مُبٰرَکًا', 'بابرکت'),
    WordEntry('اَنۡذِر', 'خبردار کر/ڈرا'),
    WordEntry('اَضَاعُوا', 'انہوں نے ضائع کیا'),
    WordEntry('السَّمٰوٰت', 'آسمان (جمع)'),
    WordEntry('السِّرَّ', 'راز'),
    WordEntry('اِذۡهَب', 'جاؤ'),
  ]),
  LevelData('سُوۡرَةُ طَهٗ / سُوۡرَةُ الۡاَنۡبِيَاء', [
    WordEntry('طَغٰی', 'اس نے سرکشی کی'),
    WordEntry('يَتَذَكَّر', 'وہ نصیحت قبول کرتا ہے'),
    WordEntry('مُعۡرِضُوۡنَ', 'مُنہ موڑنے والے'),
    WordEntry('السِّحۡر', 'جادو'),
    WordEntry('الَّيۡل', 'رات'),
    WordEntry('النَّهَار', 'دن'),
    WordEntry('يَعۡلَم', 'جانتا ہے/جانے گا'),
    WordEntry('النُّجُوم', 'ستارے'),
  ]),
  LevelData('سُوۡرَةُ الۡاَنۡبِيَاء / سُوۡرَةُ الۡحَج', [
    WordEntry('الۡجِبَال', 'پہاڑ'),
    WordEntry('الشَّجَر', 'درخت'),
    WordEntry('اَسۡجُدُوا', 'سجدہ کرو'),
    WordEntry('جَاهِدُوا', 'جہاد کرو'),
    WordEntry('اِلٰهَة', 'معبود'),
    WordEntry('كَنۡز', 'خزانہ'),
    WordEntry('اَسَاطِيۡر', 'کہانیاں'),
    WordEntry('يَرۡجُوۡن', 'وہ امید رکھتے ہیں'),
  ]),
  LevelData('سُوۡرَةُ الۡفُرۡقَان / سُوۡرَةُ الشُّعَرَاء', [
    WordEntry('جُنُوۡد', 'لشکر'),
    WordEntry('لِسَان', 'زبان'),
    WordEntry('نَاقَة', 'اونٹنی'),
    WordEntry('يَخۡتَصِمُوۡن', 'وہ جھگڑتے ہیں'),
    WordEntry('تَعۡبُدُوۡن', 'تم عبادت کرتے ہو'),
    WordEntry('بَيۡضَآء', 'چمکا ہوا/سفید'),
    WordEntry('الطَّيۡر', 'پرندے'),
    WordEntry('زَيَّنَّا', 'ہم نے خوشنما کردیا'),
  ]),
  LevelData('سُوۡرَةُ النَّمۡل / سُوۡرَةُ الۡقَصَص', [
    WordEntry('يُقِيۡمُوۡن', 'وہ قائم کرتے ہیں'),
    WordEntry('جَحَدُوا', 'انہوں نے انکار کیا'),
    WordEntry('طَآئِفَة', 'گروہ'),
    WordEntry('الۡاَرۡض', 'زمین'),
    WordEntry('فُؤَاد', 'دل'),
    WordEntry('نَتۡلُوا', 'ہم پڑھتے ہیں'),
    WordEntry('يُذۡبَح', 'ذبح کرتا ہے'),
    WordEntry('السَّيِّاٰت', 'برائیاں/گناہ'),
  ]),
  LevelData('سُوۡرَةُ الۡعَنۡكَبُوت', [
    WordEntry('الۡبَلٰغ', 'پیغام پہنچانا'),
    WordEntry('اٰمَنَّا', 'ہم ایمان لائے'),
    WordEntry('اشۡكُرُوۡا', 'شکر گزاری کرو'),
    WordEntry('لَنُجۡزِيَنَّ', 'ہم ضرور بدلہ دیں گے'),
    WordEntry('عَاقِبَة', 'انجام'),
    WordEntry('غُلِبَت', 'وہ مغلوب ہوگئی'),
    WordEntry('لَم يَسِيۡرُوا', 'انہوں نے سیر نہیں کی'),
    WordEntry('لِتَسۡكُنُوا', 'تاکہ تم سکون پاؤ'),
  ]),
  LevelData('سُوۡرَةُ الرُّوۡم / سُوۡرَةُ لُقۡمٰن', [
    WordEntry('يَنۡصُر', 'وہ مدد کرتا ہے'),
    WordEntry('الۡحَكِيۡم', 'حکمت والا/دانا'),
    WordEntry('الۡمُفۡلِحُوۡن', 'فلاح پانے والے'),
    WordEntry('اَنۡزَلۡنَا', 'ہم نے نازل کیا'),
    WordEntry('يُوۡقِنُوۡن', 'وہ یقین کرتے ہیں'),
    WordEntry('بَشِّر', 'خوشخبری دو'),
    WordEntry('السَّمۡع', 'کان/سننا/سماعت'),
    WordEntry('سَمِعۡنَا', 'ہم نے سُنا'),
  ]),
  LevelData('سُوۡرَةُ السَّجۡدَة / سُوۡرَةُ سَبَا', [
    WordEntry('اَبۡصَرۡنَا', 'ہم نے دیکھا'),
    WordEntry('يُدَبِّر', 'وہ تدبیر کرتا ہے'),
    WordEntry('ذُوۡقُوا', 'چکھو'),
    WordEntry('الۡحَدِيۡد', 'لوہا'),
    WordEntry('تَمَاثِيۡل', 'تصویریں/مورتیاں'),
    WordEntry('اُفۡتُرِى', 'اس نے گھڑلیا'),
    WordEntry('يَخۡرُج', 'وہ نکلتا ہے'),
    WordEntry('يَعۡرُج', 'وہ چڑھتا ہے'),
  ]),
  LevelData('سُوۡرَةُ فَاطِر / سُوۡرَةُ يٰسٓ', [
    WordEntry('الۡغُرُوۡر', 'دھوکے کا باز'),
    WordEntry('يَمۡكُرُوۡن', 'چالیں چلتے ہیں'),
    WordEntry('يَخۡشٰى', 'ڈرتا ہے'),
    WordEntry('صِرَاط', 'راستہ'),
    WordEntry('مُسۡتَقِيۡم', 'سیدھا'),
    WordEntry('اَغۡشَيۡنَا', 'ہم نے ڈھانپ دیا'),
    WordEntry('يَسۡتَهۡزِءُوۡن', 'وہ مذاق اڑاتے ہیں'),
    WordEntry('مُبِيۡن', 'واضح'),
  ]),
  LevelData('سُوۡرَةُ صٓ / سُوۡرَةُ الۡاَحۡقَاف', [
    WordEntry('شِقَاق', 'مخالفت'),
    WordEntry('كَذَّاب', 'جھوٹا'),
    WordEntry('اَهۡلَكۡنَا', 'ہم نے ہلاک کیا'),
    WordEntry('عَجِّل', 'جلدی کر'),
    WordEntry('غَافِلُوۡن', 'اللہ سے بے خبر'),
    WordEntry('اَعۡدَآء', 'دشمن'),
    WordEntry('شَهِدَ', 'اس نے گواہی دی'),
    WordEntry('اسۡتَكۡبَرۡتُم', 'تم نے تکبر کیا'),
  ]),
];

// All meanings pool for generating wrong answers
List<String> getAllMeanings() {
  return levelsData.expand((l) => l.words.map((w) => w.urdu)).toList();
}
