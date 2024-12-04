import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_search_app_personalproject/data/model/detailpage/detail_view_model.dart';

class OptionBar extends ConsumerStatefulWidget {
  const OptionBar(this.location, {super.key});

  final location;

  @override
  ConsumerState<OptionBar> createState() => _OptionBarState();
}

class _OptionBarState extends ConsumerState<OptionBar> {
  final TextEditingController controllerChatRoomName = TextEditingController();
  final TextEditingController controllerNickName = TextEditingController();
  final TextEditingController controllerPassWord = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? validatorChatRoomName(String? value) {
    if (value == null || value.isEmpty) {
      return '반드시 입력되어야 합니다.';
    }
    if (value.length != value.replaceAll(' ', '').length) {
      return '띄어쓰기를 넣으면 안됩니다.(언더바 권장)';
    }
    return null;
  }

  String? validatorNickName(String? value) {
    if (value == null || value.isEmpty) {
      return '반드시 입력되어야 합니다.';
    }
    if (value.length != value.replaceAll(' ', '').length) {
      return '띄어쓰기를 넣으면 안됩니다.';
    }
    if (int.tryParse(value[0]) != null) {
      return 'Nickname은 숫자로 시작되어선 안됩니다.';
    }
    if (value.length <= 2) {
      return 'Nickname은 반드시 3글자 이상이어야 합니다.';
    }
    return null;
  }

  String? validatorPassWord(String? value) {
    if (value == null || value.isEmpty) {
      return '반드시 입력되어야 합니다.';
    }
    if (value.length != value.replaceAll(' ', '').length) {
      return '띄어쓰기를 넣으면 안됩니다.';
    }
    if (int.tryParse(value) == null) {
      return 'Nickname은 숫자로만 입력되어야 합니다.';
    }
    if (value.length >= 5) {
      return 'Nickname은 반드시 4글자 이하여야 합니다.';
    }
    return null;
  }

  @override
  void dispose() {
    controllerChatRoomName.dispose();
    controllerNickName.dispose();
    controllerPassWord.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          chatOption(),
          Spacer(),
          addChat(context),
        ],
      ),
    );
  }

  Widget chatOption() {
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          Text(
            '채팅',
            style:
                TextStyle(fontSize: 24, fontWeight: FontWeight.bold, height: 2),
          ),
          Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }

  Widget addChat(BuildContext context) {
    return IconButton(
        onPressed: () => showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) => plusChatRoomDialog(context),
            ),
        icon: Icon(
          Icons.add_box_outlined,
          color: Colors.grey,
          size: 32,
        ));
  }

  Widget plusChatRoomDialog(BuildContext context) {
    final detailState = ref.watch(detailViewModelProvier);

    return StatefulBuilder(builder: (BuildContext context, setState) {
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: AlertDialog(
          title: Text('채팅방 만들기'),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 이미지
                  GestureDetector(
                    onTap: () async {
                      final imagePicker = ImagePicker();

                      var image = await imagePicker.pickImage(
                          source: ImageSource.gallery);
                      if (image != null) {
                        print('이미지 선택');

                        // AlertDialog에서 ref.read 방식으로는 Dialog 새로고침이 안되서
                        // setState 사용..
                        setState(() {
                          detailState.selectedImagePath = image.path;
                        });
                      } else {
                        print('이미지 선택 안함');
                      }
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            fit: BoxFit.cover,
                            image: detailState.selectedImagePath == null
                                ? AssetImage('assets/images/default_img.jpg')
                                : FileImage(
                                    File(detailState.selectedImagePath!)),
                          )),
                          child: Center(
                            child: Icon(
                              Icons.image,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // 채팅방 name 입력
                  SizedBox(
                    width: double.maxFinite,
                    child: TextFormField(
                      controller: controllerChatRoomName,
                      validator: validatorChatRoomName,
                      decoration: InputDecoration(
                        hintText: '새로운 채팅방 이름을 입력해주세요',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Creater_Nickname
                  SizedBox(
                    width: double.maxFinite,
                    child: TextFormField(
                      controller: controllerNickName,
                      validator: validatorNickName,
                      decoration: InputDecoration(
                        hintText: '개설자의 닉네임을 입력해주세요',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // password
                  SizedBox(
                    width: double.maxFinite,
                    child: TextFormField(
                      controller: controllerPassWord,
                      validator: validatorPassWord,
                      maxLength: 4,
                      decoration: InputDecoration(
                        hintText: '비밀번호를 입력해주세요',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  ref.read(detailViewModelProvier.notifier).initSelectedImage();
                  controllerChatRoomName.text = '';
                  controllerNickName.text = '';
                  controllerPassWord.text = '';
                  Navigator.pop(context);
                },
                child: Text('취소')),
            TextButton(
                onPressed: () {
                  final bool isValid =
                      formKey.currentState?.validate() ?? false;
                  if (!isValid) {
                    return;
                  } else {
                    print(controllerPassWord.text);
                    // 채팅창 만들기
                    ref.read(detailViewModelProvier.notifier).insertNewChatRoom(
                        widget.location.title,
                        controllerChatRoomName.text,
                        controllerNickName.text,
                        controllerPassWord.text,
                        detailState.selectedImagePath);

                    // 초기화
                    ref
                        .read(detailViewModelProvier.notifier)
                        .initSelectedImage();
                    controllerChatRoomName.text = '';
                    controllerNickName.text = '';
                    controllerPassWord.text = '';

                    Navigator.pop(context);
                  }
                },
                child: Text('만들기')),
          ],
        ),
      );
    });
  }
}
