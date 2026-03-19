import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';

class GasStationButton extends StatefulWidget {
  final String audioAsset;
  final VoidCallback? onTap;

  const GasStationButton({super.key, required this.audioAsset, this.onTap});

  @override
  State<GasStationButton> createState() => _GasStationButtonState();
}

class _GasStationButtonState extends State<GasStationButton> {
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.setSource(AssetSource(widget.audioAsset));
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _handleTap() async {
    HapticFeedback.mediumImpact();

    await _audioPlayer.setVolume(1.0);
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(widget.audioAsset));

    if (widget.onTap != null) widget.onTap!();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: _handleTap,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withOpacity(0.1),
          shape: BoxShape.circle,
          border: Border.all(
            color: theme.colorScheme.primary.withOpacity(0.2),
            width: 2,
          ),
        ),
        child: Icon(
          Icons.local_gas_station_rounded,
          size: 80,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }
}
