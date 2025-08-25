class Member {
  final int id;
  final String name;
  final String? avatar;

  const Member({required this.id, required this.name, this.avatar});

  factory Member.fromMap(Map<String, dynamic> m) =>
      Member(id: m['id'] as int, name: m['name'] as String, avatar: m['avatar'] as String?);

  Map<String, dynamic> toMap() => {'id': id, 'name': name, 'avatar': avatar};
}
