import 'package:flutter/material.dart';

class StarRatingInput extends StatelessWidget {
  final int rating;
  final ValueChanged<int> onChanged;

  const StarRatingInput({
    super.key,
    required this.rating,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        final starValue = index + 1;
        final filled = starValue <= rating;
        return Semantics(
          button: true,
          selected: filled,
          label: '$starValue de 5 estrelas',
          child: IconButton(
            key: Key('review_star_$starValue'),
            iconSize: 36,
            icon: Icon(
              filled ? Icons.star_rounded : Icons.star_border_rounded,
              color: Colors.amber,
            ),
            onPressed: () => onChanged(starValue),
          ),
        );
      }),
    );
  }
}
