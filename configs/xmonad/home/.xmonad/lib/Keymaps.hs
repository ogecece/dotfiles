module Keymaps (
  myKeys
, myMouseBindings
) where


import Data.Map (fromList)

import qualified XMonad as XM
import XMonad ( focus
              , kill
              , layoutHook
              , modMask
              , mouseMoveWindow
              , mouseResizeWindow
              , sendMessage
              , spawn
              , setLayout
              , windows
              , withFocused
              , workspaces
              )

import XMonad.Actions.CycleWS ( nextScreen
                              , prevScreen
                              , shiftNextScreen
                              , shiftPrevScreen
                              , swapNextScreen
                              , swapPrevScreen
                              , toggleWS
                              )
import qualified XMonad.Hooks.ManageDocks as MD
import qualified XMonad.Layout.MultiToggle as MT
import qualified XMonad.Layout.MultiToggle.Instances as MT
import qualified XMonad.Prompt.Window as PW
import XMonad.Prompt.Window ( allWindows
                            , windowMultiPrompt
                            , windowPrompt
                            , wsWindows
                            )
import XMonad.StackSet ( focusDown
                       , focusMaster
                       , focusUp
                       , greedyView
                       , shift
                       , shiftMaster
                       , sink
                       , swapDown
                       , swapMaster
                       , swapUp
                       )

import Settings ( back
                , focused
                , fore
                , myPromptConfig
                , myTerminal
                )

myMouseBindings (XM.XConfig {modMask = modMask}) = fromList $
    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modMask, 1), (\w -> focus w >> mouseMoveWindow w >> windows shiftMaster))
    -- mod-button2, Raise the window to the top of the stack
    , ((modMask, 2), (\w -> focus w >> windows shiftMaster))
    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modMask, 3), (\w -> focus w >> mouseResizeWindow w >> windows shiftMaster))
    ]

myKeys conf =
    -- GENERAL
    -- super keys
    [ ("M-t", spawn $ "tdrop -tma -w 60% -x 20% -h 40% -y 59% -s dropdown " ++ myTerminal ++ " --title tdrop")
    , ("M-e", spawn $ "thunar")
    , ("M-d", spawn $ "rofi -no-config -no-lazy-grab -show drun -modi drun -theme ~/.config/rofi/launcher2.rasi")
    , ("M-v", spawn $ "alacritty -e nvim")
    , ("M-<Escape>", spawn $ "xfce4-taskmanager")
    , ("M-<Return>", spawn $ myTerminal)
    -- super + shift keys
    , ("M-S-t", spawn $ myTerminal)
    , ("M-S-e", spawn $ "nemo")
    , ("M-S-d", spawn $ "dmenu_run -i -nb '" ++ back ++ "' -nf '" ++ fore ++ "' -sb '" ++ back ++ "' -sf '" ++ focused ++ "' -fn 'SauceCodePro:semibold:pixelsize=25'")
    , ("M-S-<Escape>", spawn $ "arcolinux-logout")
    , ("M-S-q", kill)
    , ("M-C-q", spawn $ "xkill")
    -- super + alt keys
    , ("M-M1-r", spawn $ "xmonad --recompile && xmonad --restart")

    -- MULTIMEDIA
    -- volume controls
    , ("<XF86AudioMute>", spawn $ "amixer -q set Master toggle")
    , ("<XF86AudioLowerVolume>", spawn $ "amixer -q set Master 5%-")
    , ("<XF86AudioRaiseVolume>", spawn $ "amixer -q set Master 5%+")
    -- media player controls
    , ("<XF86AudioPlay>", spawn $ "playerctl play-pause -i chromium")
    , ("<XF86AudioNext>", spawn $ "playerctl next -i chromium")
    , ("<XF86AudioPrev>", spawn $ "playerctl previous -i chromium")
    , ("<XF86AudioStop>", spawn $ "playerctl stop -i chromium")

    -- SCREEN
    -- screenshots
    , ("<Print>", spawn $ "flameshot gui")
    , ("S-<Print>", spawn $ "xfce4-screenshooter")
    -- screen brightness
    , ("<XF86MonBrightnessUp>", spawn $ "busctl --user call org.clight.clight /org/clight/clight org.clight.clight IncBl d 0.02")
    , ("<XF86MonBrightnessDown>", spawn $ "busctl --user call org.clight.clight /org/clight/clight org.clight.clight DecBl d 0.02")
    -- XMONAD LAYOUT

    -- toggle full screen
    , ("M-f", sendMessage (MT.Toggle MT.FULL) >> sendMessage MD.ToggleStruts)
    -- cycle through the available layout algorithms.
    , ("M-<Space>", sendMessage XM.NextLayout)
    -- reset the layouts on the current workspace to default.
    , ("M-M1-<Space>", setLayout $ layoutHook conf)
    -- focus previous screen
    , ("M-p", prevScreen)
    -- focus next screen
    , ("M-n", nextScreen)
    -- move window to previous screen
    , ("M-S-p", shiftPrevScreen)
    -- move window to next screen
    , ("M-S-n", shiftNextScreen)
    -- swap current screen with previous screen
    , ("M-C-p", swapPrevScreen)
    -- swap current screen with next screen
    , ("M-C-n", swapNextScreen)
    -- move focus to the next window.
    , ("M-j", windows focusDown)
    -- move focus to the previous window.
    , ("M-k", windows focusUp)
    -- increment the number of xm.windows in the master area.
    , ("M-l", sendMessage (XM.IncMasterN 1))
    -- decrement the number of xm.windows in the master area.
    , ("M-h", sendMessage (XM.IncMasterN (-1)))
    -- move focus to the master window.
    , ("M-m", windows focusMaster)
    -- swap the focused window with the next window.
    , ("M-S-j", windows swapDown)
    -- swap the focused window with the previous window.
    , ("M-S-k", windows swapUp)
    -- swap the focused window with the master window.
    , ("M-S-m", windows swapMaster)
    -- shrink the master area.
    , ("M-S-h", sendMessage XM.Shrink)
    -- expand the master area.
    , ("M-S-l", sendMessage XM.Expand)
    -- push window back into tiling.
    , ("M-M1-t", withFocused $ windows . sink)
    -- go to last displayed workspace
    , ("M-w", toggleWS)
    -- go to selected application in a grid
    , ("M-g", windowMultiPrompt myPromptConfig [(PW.Goto, allWindows), (PW.Goto, wsWindows)])
    -- select application in a grid and bring it to current workspace
    , ("M-b", windowPrompt myPromptConfig PW.Bring allWindows)
    ]
    ++
    -- mod-[1..],       Switch to workspace N
    -- mod-shift-[1..], Move client to workspace N
    -- mod-ctrl-[1..], Move client to workspace N and focus
    [ (m ++ "M-" ++ [k], windows $ f i)
        | (i, k) <- zip (workspaces conf) "1234567890"
        , (f, m) <- [ (greedyView, "")
                    , (shift, "S-")
                    , (\i -> greedyView i . shift i, "C-")
                    ]
    ]
