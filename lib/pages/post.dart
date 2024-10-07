import 'package:flutter/material.dart';
import 'package:flutter_wechat_post/utils/config.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class PostEditPage extends StatefulWidget {
  const PostEditPage({super.key});

  @override
  State<PostEditPage> createState() => _PostEditPageState();
}

class _PostEditPageState extends State<PostEditPage> {
  // 已选中图片列表
  List<AssetEntity> selectedAssets = [];

  // 图片列表
  Widget _bulidPhotoList() {
    return Padding(
      padding: const EdgeInsets.all(spacing),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double width = (constraints.maxWidth - spacing * 2) / 3;
          return Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: [
              // 图片
              for (final asset in selectedAssets) _buidPhotoItem(asset, width),
              // 加入按钮
              if (selectedAssets.length < maxAssets)
                _buildAddBtn(context, width),
            ],
          );
        },
      ),
    );
  }

// 添加按钮
  Widget _buildAddBtn(BuildContext context, double width) {
    return GestureDetector(
      // 选择图片
      onTap: () async {
        final List<AssetEntity>? result = await AssetPicker.pickAssets(context,
            pickerConfig: AssetPickerConfig(
                selectedAssets: selectedAssets, maxAssets: maxAssets));
        setState(() {
          selectedAssets = result ?? [];
        });
      },
      child: Container(
        color: Colors.black12,
        width: width,
        height: width,
        child: const Icon(
          Icons.add,
          size: 48,
          color: Colors.black38,
        ),
      ),
    );
  }

// 图片项
  Container _buidPhotoItem(AssetEntity asset, double width) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(3)),
      child: AssetEntityImage(
        asset,
        width: width,
        height: width,
        fit: BoxFit.cover,
        isOriginal: false,
      ),
    );
  }

  // 主视图
  Widget _mainView() {
    return Column(children: [
      // 图片列表
      _bulidPhotoList()
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('发布'),
      ),
      body: _mainView(),
    );
  }
}
