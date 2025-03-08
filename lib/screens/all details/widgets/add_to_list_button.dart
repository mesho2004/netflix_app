import 'package:flutter/material.dart';
import 'package:netflix_app/screens/all%20details/api/service.dart';

class AddToListButton extends StatefulWidget {
  final int mediaId;
  final String mediaType;
  final VoidCallback? onListUpdated;

  const AddToListButton({
    super.key,
    required this.mediaId,
    required this.mediaType,
    this.onListUpdated,
  });

  @override
  State<AddToListButton> createState() => _AddToListButtonState();
}

class _AddToListButtonState extends State<AddToListButton> {
  final TMDBService _tmdbService = TMDBService();
  bool _isInList = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkIfInList();
  }

  Future<void> _checkIfInList() async {
    final result = await _tmdbService.isInWatchlist(
      widget.mediaId,
      widget.mediaType,
    );
    if (mounted) {
      setState(() => _isInList = result);
    }
  }

  Future<void> _toggleList() async {
    setState(() => _isLoading = true);
    try {
      if (_isInList) {
        await _tmdbService.removeFromList(widget.mediaId, widget.mediaType);
      } else {
        await _tmdbService.addToList(widget.mediaId, widget.mediaType);
      }
      setState(() => _isInList = !_isInList);
      widget.onListUpdated?.call();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red[700],
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _isLoading ? null : _toggleList,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : Icon(
                  _isInList ? Icons.check_circle : Icons.add_circle_outline,
                  color: Colors.white,
                  size: 24,
                ),
        ),
      ),
    );
  }
}