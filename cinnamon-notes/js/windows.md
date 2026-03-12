# Window Actor Notes

### Get all windows:
- `let actors = global.get_window_actors()`

### Get actor data:
- `let title = actor.get_meta_window().get_title()`
- `let wm_class = actor.get_meta_window().get_wm_class()`
    - N/A
- `let type = actor.get_meta_window().get_window_type()`
    - Returns an integer representing the window type.

### Determine actor status:
- `actor.is_finalized()`
    - Returns true or false regarding if the actor(window) has been destroyed.
