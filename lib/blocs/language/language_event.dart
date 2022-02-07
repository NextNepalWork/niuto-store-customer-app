part of 'language_bloc.dart';

abstract class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

class LanguageLoadStarted extends LanguageEvent {}

class LanguageLoadServer extends LanguageEvent {
  final LanguageData language;

  LanguageLoadServer(this.language) : assert(language != null);

  @override
  List<Object> get props => [this.language];
}

class LanguageSelected extends LanguageEvent {
  final LanguageData language;

  LanguageSelected(this.language) : assert(language != null);

  @override
  List<Object> get props => [this.language];
}
