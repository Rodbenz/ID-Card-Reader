import 'package:flutter/material.dart';

class UsbDeviceCard extends StatelessWidget {
  final dynamic device;
  const UsbDeviceCard({
    super.key,
    this.device,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: device.isAttached ? 1.0 : 0.5,
      child: Card(
        child: ListTile(
          leading: const Icon(
            Icons.usb,
            size: 32,
          ),
          title: Text('${device!.manufacturerName} ${device!.productName}'),
          subtitle: Text(device!.identifier ?? ''),
          trailing: Container(
            padding: const EdgeInsets.all(8),
            color: device!.hasPermission ? Colors.green : Colors.grey,
            child: Text(
                device!.hasPermission
                    ? 'Listening'
                    : (device!.isAttached ? 'Connected' : 'Disconnected'),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                )),
          ),
        ),
      ),
    );
  }
}