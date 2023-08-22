class Member {
  final String id;
  final String name;
  final String team;
  final String pinyin;
  final String abbr;
  final String tid;
  final String pid;
  final String pname;
  final String nickname;
  final String company;
  final String join_day;
  final String height;
  final String birth_day;
  final String star_sign_12;
  final String star_sign_48;
  final String birth_place;
  final String speciality;
  final String hobby;

  Member({
    required this.id,
    required this.name,
    required this.team,
    required this.pinyin,
    required this.abbr,
    required this.tid,
    required this.pid,
    required this.pname,
    required this.nickname,
    required this.company,
    required this.join_day,
    required this.height,
    required this.birth_day,
    required this.star_sign_12,
    required this.star_sign_48,
    required this.birth_place,
    required this.speciality,
    required this.hobby,
  });

  String get avatarUrl {
    return 'https://www.snh48.com/images/member/zp_$id.jpg';
  }

  @override
  String toString() => '$id: $name';
}
