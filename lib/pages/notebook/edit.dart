import 'package:concentrationscreen/classes/note.dart';
import 'package:concentrationscreen/providers/appstate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Edit extends StatefulWidget {
  final Note? editNote;
  const Edit({super.key, this.editNote});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.editNote != null) {
      title.text = widget.editNote!.title;
      body.text = widget.editNote!.body;
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppState appState = context.watch<AppState>();
    return Scaffold(
      appBar: AppBar(
          title: Text(
        widget.editNote == null
            ? 'Write an Entry'
            : 'Edit ${widget.editNote!.title}',
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          appState.editEntry(
            Note(
              id: widget.editNote?.id,
              title: title.text,
              body: body.text,
              createdAt: widget.editNote?.createdAt ??
                  DateTime.now().millisecondsSinceEpoch,
              updatedAt: DateTime.now().millisecondsSinceEpoch,
            ),
          );
          Navigator.pop(context);
        },
        child: Icon(widget.editNote == null ? Icons.check : Icons.save),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
              controller: title,
              decoration: const InputDecoration(
                hintText: 'Title',
                border: InputBorder.none,
              ),
              onChanged: (v) {
                setState(() {});
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: body,
                decoration: const InputDecoration(
                  hintText: 'Description',
                  border: InputBorder.none,
                ),
                onChanged: (v) {
                  setState(() {});
                },
                maxLines: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
