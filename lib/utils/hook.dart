

String calculateTimeAgo(DateTime createdAt) {
  final now = DateTime.now();
  final difference = now.difference(createdAt);

  if (difference.inDays > 365) {
    final years = (difference.inDays / 365).floor();
    return '$years ${years > 1 ? 'years' : 'year'} ago';
  } else if (difference.inDays >= 30) {
    final months = (difference.inDays / 30).floor();
    return '$months ${months > 1 ? 'months' : 'month'} ago';
  } else if (difference.inDays > 0) {
    return '${difference.inDays} ${difference.inDays > 1 ? 'days' : 'day'} ago';
  } else if (difference.inHours > 0) {
    return '${difference.inHours} ${difference.inHours > 1 ? 'hours' : 'hour'} ago';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes} ${difference.inMinutes > 1 ? 'minutes' : 'minute'} ago';
  } else {
    return 'Just now';
  }
}

