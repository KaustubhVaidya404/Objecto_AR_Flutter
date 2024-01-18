import 'package:ar_flutter/utilities/use_colors.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:ar_flutter_plugin/widgets/ar_view.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:flutter/material.dart';

class ARObjectScreen extends StatefulWidget {
  final String object;
  const ARObjectScreen({super.key, required this.object});

  @override
  State<ARObjectScreen> createState() => _ARObjectScreenState();
}

class _ARObjectScreenState extends State<ARObjectScreen> {
  late ARSessionManager arSessionManager;
  late ARObjectManager arObjectManager;
  ARNode? arNode;
  bool isAdd = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: transparentcolor,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: floatingActionButtonPress,
        backgroundColor: greycolor,
        child: Icon(isAdd ? Icons.remove : Icons.add),
      ),
      body: ARView(onARViewCreated: onARCreate),
    );
  }

  void onARCreate(
      ARSessionManager arSessionManager,
      ARObjectManager arObjectManager,
      ARAnchorManager arAnchorManager,
      ARLocationManager arLocationManager) {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;

    this.arSessionManager.onInitialize(
          showFeaturePoints: false,
          showWorldOrigin: true,
          showPlanes: true,
          handleTaps: false,
        );
    this.arObjectManager.onInitialize();
  }

  Future floatingActionButtonPress() async {
    if (arNode != null) {
      arObjectManager.removeNode(arNode!);
      arNode = null;
    } else {
      var newNode = ARNode(
          type: NodeType.localGLTF2,
          uri: widget.object,
          scale: Vector3(0.2, 0.2, 0.2),
          position: Vector3(0.0, 0.0, 0.0),
          rotation: Vector4(1.0, 0.0, 0.0, 0.0));
      bool? didAddLocalNode = await arObjectManager.addNode(newNode);
      arNode = (didAddLocalNode!) ? newNode : null;
    }
  }

  @override
  void dispose() {
    arSessionManager.dispose();
    super.dispose();
  }
}
