const String tableVotes = 'votes';

class VoteFields {
  static final List<String> values = [
    /// Add all fields
    id, contentJoke, funny, notFunny
  ];

  static const String id = '_id';
  static const String contentJoke = 'contentJoke';
  static const String funny = 'funny';
  static const String notFunny = 'notFunny';
}

class Vote {
  final int? id;
  final String? contentJoke;
  final String? funny;
  final String? notFunny;

  const Vote({
    this.id,
    this.contentJoke,
    this.funny,
    this.notFunny,
  });

  Vote copy({
    int? id,
    String? contentJoke,
    String? funny,
    String? notFunny,
  }) =>
      Vote(
        id: id ?? this.id,
        contentJoke: contentJoke ?? this.contentJoke,
        funny: funny ?? this.funny,
        notFunny: notFunny ?? this.notFunny,
      );

  static Vote fromJson(Map<String, Object?> json) => Vote(
        id: json[VoteFields.id] as int?,
        contentJoke: json[VoteFields.contentJoke] as String?,
        funny: json[VoteFields.funny] as String?,
        notFunny: json[VoteFields.notFunny] as String?,
      );

  Map<String, Object?> toJson() => {
        VoteFields.id: id,
        VoteFields.contentJoke: contentJoke,
        VoteFields.funny: funny,
        VoteFields.notFunny: notFunny,
      };
}
