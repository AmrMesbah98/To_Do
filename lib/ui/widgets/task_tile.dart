import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import 'package:todo/models/task.dart';
import 'package:todo/ui/size_config.dart';
import 'package:todo/ui/theme.dart';

class TaskTile extends StatelessWidget {
  TaskTile(this.task);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: SizeConfig.orientation == Orientation.landscape
          ? const EdgeInsets.all(8.0)
          : const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: _getBGClr(task.color),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title!,
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey[200],
                        size: 18,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '${task.startTime} - ${task.endTime}',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Colors.grey[200],
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    task.note!,
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        color: Colors.grey[200],
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              height: 60,
              width: 0.5,
              color: Colors.grey[200]!.withOpacity(0.5),
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                task.isCompleted == 0 ? 'Todo' : 'Completed',
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _getBGClr(int? color) {
    switch (color) {
      case 0:
        return bluishClr;
      case 1:
        return pinkClr;
      case 2:
        return orangeClr;
      default:
        return pinkClr;
    }
  }
}
