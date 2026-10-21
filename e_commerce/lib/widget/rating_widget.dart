import 'package:flutter/material.dart';

class Rating extends StatefulWidget {
  final double rating;
  const Rating({super.key, required this.rating});

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.rating.toStringAsFixed(1),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
        SizedBox(width: 5),
        Icon(
          widget.rating >= 1 ? Icons.star : Icons.star_outline,
          color: Colors.orange,
          size: 16,
        ),
        Icon(
          widget.rating >= 2 ? Icons.star : Icons.star_outline,
          color: Colors.orange,
          size: 16,
        ),
        Icon(
          widget.rating >= 3 ? Icons.star : Icons.star_outline,
          color: Colors.orange,
          size: 16,
        ),
        Icon(
          widget.rating >= 4 ? Icons.star : Icons.star_outline,
          color: Colors.orange,
          size: 16,
        ),
        Icon(
          widget.rating >= 5 ? Icons.star : Icons.star_outline,
          color: Colors.orange,
          size: 16,
        ),
      ],
    );
  }
}
