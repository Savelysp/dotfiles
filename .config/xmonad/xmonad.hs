import XMonad
import System.Exit
import System.IO

import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.SpawnOnce
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.Loggers

import XMonad.Layout.NoBorders
-- import XMonad.Layout.Spacing

import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.StatusBar

import qualified XMonad.StackSet as W

------------------------------------------------------------------------
-- Variables

myModMask            = mod4Mask
myTerminal           = "alacritty"
myBrowser            = "firefox"
myEmacs              = "emacsclient -c -a 'emacs'"
myLauncher           = "rofi -show drun"
myColorPick          = "sh ~/dotfiles/bin/xcolor-pick.sh"
myWallpaperTool      = "feh --randomize --no-fehbg --bg-scale ~/images/"
myScreenshotTool     = "flameshot gui"

myWorkspaces         = ["1","2","3","4","5","6","7","8","9"]

myFocusFollowsMouse  = True
myClickJustFocuses   = False

myBorderWidth        = 4
myNormalBorderColor  = "#dddddd"
myFocusedBorderColor = "#cc6493"


-- Color
black   = xmobarColor "#1e1e1e" ""
red     = xmobarColor "#ff5555" ""
green   = xmobarColor "#608b4e" ""
yellow  = xmobarColor "#f1fa8c" ""
blue    = xmobarColor "#cc6493" ""
magenta = xmobarColor "#8f3f71" ""
cyan    = xmobarColor "#9cdcfe" ""
white   = xmobarColor "#ffffff" ""

------------------------------------------------------------------------
-- Startup hook

myStartupHook = do
  spawnOnce "dunst"
  spawnOnce "picom"
  spawnOnce "emacs --daemon"
  spawnOnce "xsetroot -cursor_name left_ptr"
  spawnOnce myWallpaperTool

------------------------------------------------------------------------
-- Layouts:

-- mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

myLayouts = tiled ||| Mirror tiled ||| Full
  where
    tiled   = Tall nmaster delta ratio
    nmaster = 1
    ratio   = 1/2
    delta   = 3/100

myLayoutHook = smartBorders
               -- $ mySpacing 5
               $ avoidStruts
               $ myLayouts

------------------------------------------------------------------------
-- Window rules:

myManageHook = composeAll
    [ className =? "mpv"            --> doFloat
    ]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = mempty

------------------------------------------------------------------------
-- Key bindings

myKeys =
    [ ("M-<Return>",  spawn myTerminal)
    , ("M-c",         kill)
    , ("M-d",         spawn myLauncher)
    , ("M-x",         spawn myColorPick)
    , ("M-w",         spawn myWallpaperTool)

    , ("M-S-f",       spawn myBrowser)
    , ("M-S-e",       spawn myEmacs)
    , ("<Print>",     spawn myScreenshotTool)

    , ("M-<Space>",   sendMessage NextLayout)
    , ("M-n",         refresh)

    , ("M-j",         windows W.focusDown)
    , ("M-k",         windows W.focusUp)
    , ("M-m",         windows W.focusMaster)
    , ("M-S-j",       windows W.swapDown)
    , ("M-S-k",       windows W.swapUp)
    , ("M-h",         sendMessage Shrink)
    , ("M-l",         sendMessage Expand)

    -- , ("M-C-j",       decWindowSpacing 4)
    -- , ("M-C-k",       incWindowSpacing 4)
    -- , ("M-C-h",       decScreenSpacing 4)
    -- , ("M-C-l",       incScreenSpacing 4)

    -- , ("M-t",         withFocused $ windows . W.sink)
    -- , ("M-,",         sendMessage (IncMasterN 1))
    -- , ("M-.",         sendMessage (IncMasterN (-1)))

    , ("<XF86AudioLowerVolume>",  spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-")
    , ("<XF86AudioRaiseVolume>",  spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+")
    , ("<XF86AudioMute>",         spawn "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
    , ("<XF86MonBrightnessDown>", spawn "brightnessctl set 5%-")
    , ("<XF86MonBrightnessUp>",   spawn "brightnessctl set +5%")

    -- , ("M-b", spawn "xdo toggle -n xmobar")
    , ("M-b", spawn "~/dotfiles/bin/toggle-xmobar.sh" >> sendMessage ToggleStruts)

    -- , ("M-b",         sendMessage ToggleStruts)
    , ("M-C-r",       spawn "xmonad --recompile && xmonad --restart")
    , ("M-C-q",       io (exitWith ExitSuccess))
    ]

------------------------------------------------------------------------
-- Status bars and logging

myXmobarPP = def
    { ppSep             = " ┇ "
    , ppTitleSanitize   = xmobarStrip

    , ppCurrent         = xmobarColor "#98be65" "" . wrap "[" "]"
    , ppHidden          = xmobarColor "#F7F7F7" ""
    , ppHiddenNoWindows = xmobarColor "#4E4E4F" ""
    , ppUrgent          = xmobarColor "#ED0000" "" . wrap (yellow "!") (yellow "!")
    -- , ppVisible         = xmobarColor "#c792ea" ""

    , ppLayout          = xmobarColor "#ffcb6b" ""
    , ppOrder           = \[ws, l, _, wins] -> [ws, l, wins]
    , ppExtras          = [logTitles formatFocused formatUnfocused]
    }
  where
    formatFocused   = wrap (white    "[ ") (white    " ]") . blue    . ppWindow
    formatUnfocused = wrap (black "[ ")    (black " ]")    . magenta . ppWindow

ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

myLogHook xmproc = dynamicLogWithPP (myXmobarPP { ppOutput = hPutStrLn xmproc })

------------------------------------------------------------------------

main :: IO ()
main = do
    xmproc <- spawnPipe "xmobar -x 0"
    xmonad $ ewmhFullscreen $ ewmh $ docks def
        { modMask            = myModMask
        , terminal           = myTerminal
        , borderWidth        = myBorderWidth
        , workspaces         = myWorkspaces
        , focusFollowsMouse  = myFocusFollowsMouse
        , clickJustFocuses   = myClickJustFocuses
        , normalBorderColor  = myNormalBorderColor
        , focusedBorderColor = myFocusedBorderColor

        , layoutHook         = myLayoutHook
        , manageHook         = myManageHook
        , handleEventHook    = myEventHook
        , logHook            = myLogHook xmproc
        , startupHook        = myStartupHook
        } `additionalKeysP` myKeys

