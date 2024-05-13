import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class DialogUtils{

  static void showLoadingDialog(BuildContext context,
      String message){
    AwesomeDialog(
        context: context,
        dialogType: DialogType.info,
        animType: AnimType.rightSlide,
        title: 'Loading',
        desc: 'Loading',
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false
    ).show();
  }

  static void hideDialog(BuildContext context){
    Navigator.pop(context);
  }


  static void showSuccess(BuildContext context,
      String message, {
        String? postActionName,
        VoidCallback? posAction,
        String? negActionName,
        VoidCallback? negAction,
        bool dismissible = true
      }){
    List<Widget> actions = [];
    if(postActionName!=null){
      actions.add(TextButton(onPressed: (){
        Navigator.pop(context);
        posAction?.call();
      },
          child: Text(postActionName)));
    }
    if(negActionName!=null){
      actions.add(TextButton(onPressed: (){
        Navigator.pop(context);
        negAction?.call();
      },
          child: Text(negActionName)));
    }
    AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        desc: message,
        dismissOnTouchOutside: true,
        dismissOnBackKeyPress: true,
        btnOk: postActionName!=null ?actions[0] : Container(),
    ).show();
  }

  static void showInfo(BuildContext context,
      String message, {
        String? postActionName,
        VoidCallback? posAction,
        String? negActionName,
        VoidCallback? negAction,
        bool dismissible = true
      }){
    List<Widget> actions = [];
    if(postActionName!=null){
      actions.add(TextButton(onPressed: (){
        Navigator.pop(context);
        posAction?.call();
      },
          child: Text(postActionName)));
    }
    if(negActionName!=null){
      actions.add(TextButton(onPressed: (){
        Navigator.pop(context);
        negAction?.call();
      },
          child: Text(negActionName)));
    }
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.rightSlide,
      desc: message,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      btnOk: postActionName!=null ?actions[0] : Container(),
    ).show();
  }

  static void showWarning(BuildContext context,
      String message, {
        String? postActionName,
        VoidCallback? posAction,
        String? negActionName,
        VoidCallback? negAction,
        bool dismissible = true
      }){
    List<Widget> actions = [];
    if(postActionName!=null){
      actions.add(TextButton(onPressed: (){
        Navigator.pop(context);
        posAction?.call();
      },
          child: Text(postActionName)));
    }
    if(negActionName!=null){
      actions.add(TextButton(onPressed: (){
        Navigator.pop(context);
        negAction?.call();
      },
          child: Text(negActionName)));
    }
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.rightSlide,
      desc: message,
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: true,
      btnOk: postActionName!=null ?actions[0] : Container(),
      btnCancelText: 'Cancel',
      btnCancelOnPress: (){

      }
    ).show();
  }

  static void showFailed(BuildContext context,
      String message, {
        String? postActionName,
        VoidCallback? posAction,
        String? negActionName,
        VoidCallback? negAction,
      }){
    bool dismissible = false;
    List<Widget> actions = [];
    if(postActionName!=null){
      actions.add(TextButton(onPressed: (){
        Navigator.pop(context);
        posAction?.call();
      },
          child: Text(postActionName)));
    }
    if(negActionName!=null){
      actions.add(TextButton(onPressed: (){
        Navigator.pop(context);
        negAction?.call();
      },
          child: Text(negActionName)));
    }
    AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        desc: message,
        dismissOnTouchOutside: dismissible,
        dismissOnBackKeyPress: dismissible,
        btnOkText: postActionName,
        btnOkOnPress: (){
          dismissible = true;
        },
      btnOkColor: Colors.red
    ).show();
  }
}