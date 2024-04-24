import 'package:app_sample/SampleItem.dart';
import 'package:app_sample/SampleItemUpdate.dart';
import 'package:app_sample/SampleItemViewModel.dart';
import 'package:flutter/material.dart';

class SampleItemDetailsView extends StatefulWidget {
  final SampleItem item;

  const SampleItemDetailsView({Key? key, required this.item}) : super(key: key);

  @override
  _SampleItemDetailsViewState createState() => _SampleItemDetailsViewState();
}

class _SampleItemDetailsViewState extends State<SampleItemDetailsView> {
  final viewModel = SampleItemViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet<String?>(
                context: context,
                builder: (context) => SampleItemUpdate(
                  initialName: widget.item.name.value,
                ),
              ).then((value) {
                if (value != null) {
                  viewModel.updateItem(widget.item.id, value);
                }
              });
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Xác nhận xóa"),
                    content: const Text("Bạn có chắc muốn xóa mục này"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Hủy"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          viewModel.removeItem(widget.item.id);
                          Navigator.of(context).pop(true);
                        },
                        child: const Text("Xóa"),
                      ),
                    ],
                  );
                },
              ).then((value) => (confirmed) {
                    if (confirmed) {
                      Navigator.of(context).pop(true);
                    }
                  });
            },
          ),
        ],
      ),
      body: ValueListenableBuilder<String>(
        valueListenable: widget.item.name,
        builder: (_, name, __) {
          return Center(child: Text(name));
        },
      ),
    );
  }
}
