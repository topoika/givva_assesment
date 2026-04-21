// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:givva_assesment/src/models/fundraiser.dart';

class EventItemWidget extends StatelessWidget {
  final Fundraiser fundraiser;
  const EventItemWidget({super.key, required this.fundraiser});

  @override
  Widget build(BuildContext context) {
    final statusMeta = _statusMeta(fundraiser);
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black26, width: 1.2),
          color: Color.fromARGB(255, 164, 182, 95),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(7),
        child: Row(
          spacing: 10,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                fundraiser.images ?? "",
                height: 65,
                width: 65,
                fit: BoxFit.cover,
              ),
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    fundraiser.name ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 15),
                  StatusChip(
                    label: statusMeta.label,
                    backgroundColor: statusMeta.backgroundColor,
                    textColor: statusMeta.textColor,
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_outlined),
          ],
        ),
      ),
    );
  }
}

({String label, Color backgroundColor, Color textColor}) _statusMeta(
  Fundraiser fundraiser,
) {
  if (fundraiser.archivedAt != null) {
    return (
      label: 'Archived',
      backgroundColor: Colors.purple.shade100,
      textColor: Colors.purple.shade800,
    );
  }

  if (fundraiser.closedAt != null) {
    return (
      label: 'Closed',
      backgroundColor: Colors.orange.shade100,
      textColor: Colors.orange.shade800,
    );
  }

  return (
    label: 'Active',
    backgroundColor: Colors.green.shade100,
    textColor: Colors.green.shade800,
  );
}

class StatusChip extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;
  const StatusChip({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
