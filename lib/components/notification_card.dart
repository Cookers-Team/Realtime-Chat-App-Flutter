import 'package:cms_chat_app/models/notification.dart';
import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final NotificationItem notification;
  final Color primaryColor;
  final Color secondaryColor;
  final VoidCallback? onMarkAsRead;
  final VoidCallback onDelete;

  const NotificationCard({
    Key? key,
    required this.notification,
    required this.primaryColor,
    required this.secondaryColor,
    this.onMarkAsRead,
    required this.onDelete,
  }) : super(key: key);

  IconData _getKindIcon() {
    switch (notification.kind) {
      case 1:
        return Icons.info_outline;
      case 2:
        return Icons.check_circle_outline;
      case 3:
        return Icons.error_outline;
      default:
        return Icons.notifications_none;
    }
  }

  Color _getKindColor() {
    switch (notification.kind) {
      case 1:
        return primaryColor;
      case 2:
        return Colors.green;
      case 3:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _getKindColor().withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getKindIcon(),
                      color: _getKindColor(),
                      size: 24,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notification.message,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          notification.createdAt,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              ...[
                Divider(height: 24),
                Row(
                  children: [
                    Spacer(),
                    if (onMarkAsRead != null)
                      TextButton.icon(
                        icon: Icon(Icons.done, size: 20),
                        label: Text('Đánh dấu đã đọc'),
                        style: TextButton.styleFrom(
                          foregroundColor: primaryColor,
                        ),
                        onPressed: onMarkAsRead,
                      ),
                    SizedBox(width: 8),
                    IconButton(
                      icon: Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: onDelete,
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
