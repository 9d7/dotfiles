from kittens.tui.loop import debug
def main(args):
    pass


def handle_result(args, result, target_window_id, boss):
    window = boss.active_window
    boss.active_tab.neighboring_window(args[1])
    if boss.active_window == window:
        directions = {
            "top": "north",
            "bottom": "south",
            "left": "west",
            "right": "east"}
        import os
        os.system(f"bspc node --focus {directions[args[1]]}")

handle_result.no_ui = True
