String formatDuration(Duration d) {
  if (d.inSeconds < 1) {
    return '00:00';
  }

  var seconds = d.inSeconds;
  final days = seconds ~/ Duration.secondsPerDay;
  seconds -= days * Duration.secondsPerDay;
  final hours = seconds ~/ Duration.secondsPerHour;
  seconds -= hours * Duration.secondsPerHour;
  final minutes = seconds ~/ Duration.secondsPerMinute;
  seconds -= minutes * Duration.secondsPerMinute;

  final List<String> tokens = [];

  if (days != 0) {
    tokens.add('$days');
  }
  if (tokens.isNotEmpty || hours != 0) {
    tokens.add('$hours');
  }
  if (tokens.isNotEmpty || minutes != 0) {
    if (minutes < 10) {
      tokens.add('0$minutes');
    } else {
      tokens.add('$minutes');
    }
  } else if (minutes == 0) {
    tokens.add('00');
  }

  if (seconds < 10) {
    tokens.add('0$seconds');
  } else {
    tokens.add('$seconds');
  }

  return tokens.join(':');
}
