part of 'joke_single_bloc.dart';

@immutable
class JokeSingleState {
  final String? content;
  final bool isLast;
 final  List<String>? randomizedContent;
  final int currentIndex;

  const JokeSingleState({
    this.content,
    this.isLast = false,
    this.currentIndex = 0,
    this.randomizedContent,
  });

  JokeSingleState copyWith({
    String? content,
    bool? isLast,
      List<String>? randomizedContent,
     int? currentIndex,
  }) {
    return JokeSingleState(
      content: content ?? this.content,
      isLast: isLast ?? this.isLast,
      currentIndex: currentIndex ?? this.currentIndex,
      randomizedContent: randomizedContent ?? this.randomizedContent,
    );
  }
}
