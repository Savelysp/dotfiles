from os import path
from subprocess import Popen
from libqtile import bar, layout, qtile, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy


home = path.expanduser('~')
mod = "mod4"
terminal = "alacritty"
emacs = "emacsclient -c -a 'emacs'"
emacs_start = "emacs --daemon"
browser = "firefox"
rofi = "rofi -show drun"
telegram = "telegram-desktop"
wallpaper_tool = "feh --randomize --no-fehbg --bg-scale " + home + "/images"
screenshot_tool = "flameshot gui"
color_pick = home + "/bin/xcolor-pick"

vol_mute = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
vol_up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+"
vol_down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"
br_up = "brightnessctl set +5%"
br_down = "brightnessctl set 5%-"


keys = [
    Key([mod], "h",     lazy.layout.left(),  desc="Move focus to left"),
    Key([mod], "l",     lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j",     lazy.layout.down(),  desc="Move focus down"),
    Key([mod], "k",     lazy.layout.up(),    desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(),  desc="Move window focus to other window"),

    Key([mod, "shift"], "h", lazy.layout.shuffle_left(),  desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(),  desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(),    desc="Move window up"),

    Key([mod, "control"], "h", lazy.layout.grow_left(),  desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(),  desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(),    desc="Grow window up"),
    Key([mod],            "n", lazy.layout.normalize(),  desc="Reset all window sizes"),

    Key([], "XF86AudioMute",         lazy.spawn(vol_mute), desc="Mute volume"),
    Key([], "XF86AudioRaiseVolume",  lazy.spawn(vol_up),   desc="Raise volume"),
    Key([], "XF86AudioLowerVolume",  lazy.spawn(vol_down), desc="Lower volume"),
    Key([], "XF86MonBrightnessUp",   lazy.spawn(br_up),    desc="Up brightness"),
    Key([], "XF86MonBrightnessDown", lazy.spawn(br_down),  desc="down brightness"),

    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),

    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "Tab", lazy.next_layout(),      desc="Toggle between layouts"),
    Key([mod], "c", lazy.window.kill(),        desc="Kill focused window"),
    Key([mod], "d", lazy.spawn(rofi),          desc="Launch rofi"),

    Key([mod, "shift"], "e", lazy.spawn(emacs),           desc="Launch emacs"),
    Key([mod, "shift"], "t", lazy.spawn(telegram),        desc="Launch telegram"),
    Key([mod, "shift"], "f", lazy.spawn(browser),         desc="Launch browser"),
    Key([mod, "shift"], "w", lazy.spawn(wallpaper_tool),  desc="change wallpaper"),
    Key([mod, "shift"], "x", lazy.spawn(color_pick),      desc="pick color"),

    Key([], "Print", lazy.spawn(screenshot_tool), desc="Take screenshot"),


    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),

    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
]


for vt in range(1, 9):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )


groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend(
        [
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc=f"Switch to group {i.name}",
            ),
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=False),
                desc=f"Move focused window to group {i.name}",
            ),
        ]
    )

@hook.subscribe.startup_once
def autostart():
    apps = [
        ['picom'],
        ['emacs', '--daemon'],
        ['dunst'],
        ['feh', '--randomize', '--no-fehbg', '--bg-scale', f'{home}/images']
    ]
    for app in apps:
        Popen(app)

layouts = [
    layout.Columns(
        margin=8,
        border_width=2,
        border_focus="#ff0000",
        border_normal="#444444",
    ),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="JetBrains Mono Bold",
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()


screens = [
    Screen(
        top=bar.Bar(
            [
                widget.TextBox(
                    text="",
                    fontsize=20,
                    padding=10,
                    background="#D19A66",
                    foreground="#FFFFFF",
                ),
                widget.GroupBox(
                    padding=2,
                    highlight_method='line'
                ),
                widget.CurrentLayout(fmt="[]"),
                widget.Prompt(),
                widget.WindowName(),

                widget.Spacer(),
                widget.ThermalSensor(
                    format="  {temp:.0f}{unit}",
                    foreground="#9DE7EB"
                ),
                widget.Memory(
                    measure_mem='G',
                    format="  {MemUsed:.1f}G/{MemTotal:.1f}G",
                    foreground="#D19A66"
                ),
                widget.CPU(
                    format="  {load_percent}%",
                    foreground="#9B9AF0"
                ),
                widget.Spacer(),

                widget.Battery(
                    format="{char} {percent:2.0%}",
                    charge_char="󰂄",
                    discharge_char="󱊣",
                ),
                widget.PulseVolume(
                    fmt="{}",
                    emoji=True,
                    padding=1
                ),
                widget.PulseVolume(padding=1),
                # widget.Backlight(),
                widget.Net(format="{essid}"),
                widget.Clock(format="%m:%d  ", padding=0),
                widget.Clock(format="%H:%M  ", padding=1),
                widget.Systray(),
                widget.TextBox("  ", foreground="#ff0000", fontsize=14),
            ],
            26,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
            background="#2e3440",
        ),
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        # x11_drag_polling_rate = 60,
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

auto_minimize = True

wl_input_rules = None

wl_xcursor_theme = None
wl_xcursor_size = 24

wmname = "Qtile"
