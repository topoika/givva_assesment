import 'package:flutter/material.dart';

import '../../models/pagination.dart';

class PaginationWidget extends StatelessWidget {
  final Pagination pagination;
  final ValueChanged<int> onPageChanged;

  const PaginationWidget({
    super.key,
    required this.pagination,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        actionButton(
          "Previous",
          () => onPageChanged(pagination.page - 1),
          enabled: pagination.hasPrevious,
          isNext: false,
        ),

        ..._buildPageNumbers(),
        actionButton(
          "Next",
          () => onPageChanged(pagination.page + 1),
          enabled: pagination.hasNext,
          isNext: true,
        ),
      ],
    );
  }

  Widget actionButton(
    String label,
    VoidCallback onPressed, {
    bool enabled = true,
    bool isNext = true,
  }) {
    Color backgroundColor = enabled ? Colors.white : Colors.white54;
    Color textColor = enabled ? Colors.black : Colors.black54;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(4),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 7,
          children: [
            if (!isNext) Icon(Icons.chevron_left, size: 16, color: textColor),
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
            if (isNext) Icon(Icons.chevron_right, size: 16, color: textColor),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildPageNumbers() {
    List<Widget> widgets = [];
    int total = pagination.totalPages;
    int current = pagination.page;
    int displayCurrent = current + 1;
    if (total <= 5) {
      for (int i = 1; i <= total; i++) {
        widgets.add(_pageButton(i));
      }
    } else {
      widgets.add(_pageButton(1));

      if (displayCurrent > 3) {
        widgets.add(const Text('...', style: TextStyle(color: Colors.white)));
      }
      if (displayCurrent > 2 && displayCurrent < total - 1) {
        widgets.add(_pageButton(displayCurrent));
      } else if (displayCurrent == 1 || displayCurrent == 2) {
        widgets.add(_pageButton(2));
      } else if (displayCurrent == total || displayCurrent == total - 1) {
        widgets.add(_pageButton(total - 1));
      }
      if (displayCurrent < total - 2) {
        widgets.add(const Text('...', style: TextStyle(color: Colors.white)));
      }
      widgets.add(_pageButton(total));
    }
    return widgets;
  }

  Widget _pageButton(int pageNumber) {
    bool isSelected = (pageNumber - 1) == pagination.page;
    return GestureDetector(
      onTap: () => onPageChanged(pageNumber - 1),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(8),
        height: 34,
        width: 34,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? Colors.green[800] : Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          '$pageNumber',
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
