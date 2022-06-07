import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universe/constants/my_colors.dart';
import 'package:universe/tools/translation/localizations.dart';

class AppPostDialog extends StatefulWidget {
  final BuildContext pageContext;
  final String myLanguage;

  const AppPostDialog(
      {Key? key, required this.pageContext, required this.myLanguage})
      : super(key: key);

  @override
  AppPostDialogState createState() => AppPostDialogState();
}

class AppPostDialogState extends State<AppPostDialog> {
  String fileName = "";
  String path = "";
  String fileExtension = "";
  late Map<String, String> paths;
  String extension = "";
  bool loadingPath = false;
  bool hasValidMime = false;
  late FileType _pickingType;
  bool addFiles = false;
  List<Map> listViewMyFiles = [];

  AppPostDialogState();

  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:
          widget.myLanguage == "ar" ? TextDirection.rtl : TextDirection.ltr,
      child: Dialog(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min, // To make the card compact
                children: <Widget>[
                  Container(
                    color: MyColors.inputBackgroundColor.withOpacity(0.2),
                    width: double.infinity,
                    height: 160,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/camera.png',
                          color: MyColors.drawerColor,
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          AppLocalizations.of(widget.pageContext)!.uploadImage,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: MyColors.primaryColor.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      AppLocalizations.of(widget.pageContext)!
                          .writeACommentAboutThePhoto,
                      style: TextStyle(
                          color: MyColors.commentColor,
                          fontWeight: FontWeight.normal,
                          fontSize: 14),
                    ),
                  ),
                  TextFormField(
                    controller: commentController,
                    textCapitalization: TextCapitalization.none,
                    cursorColor: MyColors.accentColor,
                    keyboardType: TextInputType.multiline,
                    maxLength: 120,
                    maxLines: null,
                    style: TextStyle(
                      color: MyColors.primaryColor,
                      fontSize: 14.0,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: TextButton(
                          onPressed: () async {
                            Navigator.of(context).pop();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              AppLocalizations.of(widget.pageContext)!.ignore,
                              style: TextStyle(
                                fontSize: 14.0,
                                color: MyColors.accentColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              MyColors.accentColor,
                            ),
                          ),
                          onPressed: () async {
                            Navigator.of(context).pop();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              AppLocalizations.of(widget.pageContext)!.publish,
                              style: TextStyle(
                                fontSize: 14.0,
                                color: MyColors.whiteColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  uploadFile(String filePath, String fileName, int i) async {}

  void openFileExplorer() async {
    if (_pickingType != FileType.custom || hasValidMime) {
      setState(() => loadingPath = true);
      try {
        paths.clear();
        FilePickerResult? result = await FilePicker.platform.pickFiles();
        if (result != null) {
          PlatformFile file = result.files.first;
          path = file.path!;
          fileExtension = file.extension!;
          listViewMyFiles.add({
            "fileName": file.name,
            "fileExtension": file.extension,
            "filePath": file.path,
            "isUploaded": "0",
          });
          uploadFile(file.path!, file.name, listViewMyFiles.length - 1);
        } else {
          // User canceled the picker
        }

        if (!mounted) return;
        setState(() {
          loadingPath = false;
          fileName = path != null
              ? path.split('/').last
              : paths != null
                  ? paths.keys.toString()
                  : '...';
        });
      } on PlatformException catch (e) {}
    }
  }
}
