import 'package:cetis4_master_app/app/presentation/global/widgets/datamex_appbar_widget.dart';
import 'package:cetis4_master_app/app/presentation/screens/notifications/create_notification_form.dart';
import 'package:flutter/material.dart';

class IndexNotificationsScreen extends StatelessWidget {
  const IndexNotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DatamexAppBarWidget(title: 'Notificaciónes'),
      body: Container(
        child: const CreateNotificationForm(),
      ),
    );
  }
}
