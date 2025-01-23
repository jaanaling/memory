// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';
import 'dart:ui';

class ColorData {
  final String name;
  final Color color;

  const ColorData({
    required this.name,
    required this.color,
  });

  @override
  bool operator ==(covariant ColorData other) {
    if (identical(this, other)) return true;

    return other.name == name && other.color == color;
  }

  @override
  int get hashCode => name.hashCode ^ color.hashCode;
}

final List<ColorData> kAvailableColors = [
  const ColorData(name: 'Red', color: Color(0xFFFF0000)),
  const ColorData(name: 'Green', color: Color(0xFF008000)),
  const ColorData(name: 'Blue', color: Color(0xFF0000FF)),
  const ColorData(name: 'Yellow', color: Color(0xFFFFFF00)),
  const ColorData(name: 'Black', color: Color(0xFF000000)),
  const ColorData(name: 'Purple', color: Color(0xFF800080)),
  const ColorData(name: 'Orange', color: Color(0xFFFFA500)),
  const ColorData(name: 'Pink', color: Color(0xFFFB95AB)),
  const ColorData(name: 'Brown', color: Color(0xFFA52A2A)),
  const ColorData(name: 'Lime', color: Color(0xFF00FF00)),
  const ColorData(name: 'Cyan', color: Color(0xFF00FFFF)),
  const ColorData(name: 'Magenta', color: Color(0xFFFF00FF)),
  const ColorData(name: 'Teal', color: Color(0xFF008080)),
  const ColorData(name: 'Indigo', color: Color(0xFF4B0082)),
  const ColorData(name: 'Violet', color: Color(0xFF8F00FF)),
  const ColorData(name: 'Gold', color: Color(0xFFFFD700)),
  const ColorData(name: 'Maroon', color: Color(0xFF800000)),
  const ColorData(name: 'Navy', color: Color(0xFF000080)),
  const ColorData(name: 'Olive', color: Color(0xFF808000)),
  const ColorData(name: 'Coral', color: Color(0xFFFF7F50)),
  const ColorData(name: 'Turquoise', color: Color(0xFF40E0D0)),
  const ColorData(name: 'Chocolate', color: Color(0xFFD2691E)),
  const ColorData(name: 'Crimson', color: Color(0xFFDC143C)),
  const ColorData(name: 'Khaki', color: Color(0xFFFBF073)),
  const ColorData(name: 'Salmon', color: Color(0xFFFA8072)),
  const ColorData(name: 'Orchid', color: Color(0xFFDA70D6)),
  const ColorData(name: 'Mint', color: Color(0xFF98FF98)),
  const ColorData(name: 'Tomato', color: Color(0xFFFF6347)),
  const ColorData(name: 'HotPink', color: Color(0xFFFF69B4)),
  const ColorData(name: 'SeaGreen', color: Color(0xFF2E8B57)),
  const ColorData(name: 'SlateBlue', color: Color(0xFF6A5ACD)),
  const ColorData(name: 'LightCoral', color: Color(0xFFF08080)),
  const ColorData(name: 'LightGreen', color: Color(0xff90EE90)),
  const ColorData(name: 'LightSalmon', color: Color(0xFFF8946D)),
  const ColorData(name: 'LightSeaGreen', color: Color(0xFF00FFF3)),
  const ColorData(name: 'LimeGreen', color: Color(0xFF32CD32)),
  const ColorData(name: 'Aquamarine', color: Color(0xFF00FFA9)),
];

enum DifficultyLevel {
  easy,
  medium,
  hard,
  extreme,
}

String getTaskDescription() {
  final descriptions = [
    "Select the circles' FILL color",
    "Select the circles' TEXT color",
    "Select the circles' TEXT name",
    'Select the color that was ANNOUNCED by voice',
  ];
  final rand = Random();
  return descriptions[rand.nextInt(descriptions.length)];
}

int getNumberOfCircles(DifficultyLevel level) {
  switch (level) {
    case DifficultyLevel.easy:
      return 1;
    case DifficultyLevel.medium:
      return 2;
    case DifficultyLevel.hard:
      return 3;
    case DifficultyLevel.extreme:
      return 5;
  }
}

int getMemorizationTime(DifficultyLevel level) {
  switch (level) {
    case DifficultyLevel.easy:
      return 5;
    case DifficultyLevel.medium:
      return 8;
    case DifficultyLevel.hard:
      return 9;
    case DifficultyLevel.extreme:
      return 10;
  }
}

class CircleData {
  final ColorData fillColor;
  final ColorData textColor;
  final ColorData textName;
  final ColorData anounsmentColor;

  CircleData({
    required this.fillColor,
    required this.textColor,
    required this.textName,
    required this.anounsmentColor,
  });
}


  final List<String> shortTips = [
    "Use mnemonic devices",
    "Practice active recall",
    "Teach others what you learn",
    "Get enough sleep",
    "Use visualization techniques",
    "Break information into chunks",
    "Review material regularly"
  ];

    final List<String> detailedTips = [
    "Tip #1: Use spaced repetition to reinforce your memory over time.",
    "Tip #2: Create vivid mental images to associate with what you are learning.",
    "Tip #3: Practice active recall by testing yourself on the material.",
    "Tip #4: Write notes by hand to help encode information better.",
    "Tip #5: Teach what you’ve learned to others to solidify your understanding.",
    "Tip #6: Break information into smaller, manageable chunks.",
    "Tip #7: Use mnemonic devices to remember complex concepts.",
    "Tip #8: Get adequate sleep to consolidate your memories.",
    "Tip #9: Stay hydrated, as dehydration can affect memory and focus.",
    "Tip #10: Use acronyms or abbreviations to recall lists or sequences.",
    "Tip #11: Study in short sessions with regular breaks to avoid fatigue.",
    "Tip #12: Relate new information to things you already know.",
    "Tip #13: Practice mindfulness to improve focus and attention.",
    "Tip #14: Exercise regularly, as physical activity boosts brain health.",
    "Tip #15: Create a dedicated study environment free of distractions.",
    "Tip #16: Listen to music without lyrics if it helps you focus.",
    "Tip #17: Review material before going to sleep to aid memory consolidation.",
    "Tip #18: Use flashcards to practice and test your recall.",
    "Tip #19: Use storytelling to make information more memorable.",
    "Tip #20: Visualize concepts using diagrams or mind maps.",
    "Tip #21: Take regular walks to clear your mind and boost creativity.",
    "Tip #22: Avoid multitasking; focus on one task at a time.",
    "Tip #23: Practice meditation to enhance your cognitive abilities.",
    "Tip #24: Repeat information out loud to reinforce memory.",
    "Tip #25: Use apps or tools designed for memory improvement.",
    "Tip #26: Avoid cramming; spread your study sessions over time.",
    "Tip #27: Highlight key points and review them frequently.",
    "Tip #28: Reward yourself after completing a study session.",
    "Tip #29: Keep a positive attitude, as stress can hinder memory.",
    "Tip #30: Eat brain-boosting foods like nuts, berries, and fish."
  ];