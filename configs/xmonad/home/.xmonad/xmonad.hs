import qualified Codec.Binary.UTF8.String as UTF8
import Data.Ratio ((%))
import qualified DBus as D
import qualified DBus.Client as D

import qualified XMonad as XM
import XMonad ( (<+>)
              , (-->)
              , (=?)
              , borderWidth
              , className
              , composeAll
              , doFloat
              , doIgnore
              , handleEventHook 
              , keys
              , layoutHook
              , logHook
              , manageHook
              , modMask
              , mouseBindings
              , resource 
              , spawn
              , startupHook
              , terminal
              , title
              , workspaces
              , xmonad
              )

import XMonad.Actions.UpdatePointer (updatePointer)
import XMonad.Config.Desktop (desktopConfig)
import qualified XMonad.Hooks.DynamicLog as DL
import XMonad.Hooks.DynamicLog ( PP
                               , dynamicLogWithPP
                               , ppCurrent
                               , ppHidden
                               , ppHiddenNoWindows
                               , ppLayout
                               , ppOutput
                               , ppSep
                               , ppTitle
                               , ppUrgent
                               , ppVisible
                               , ppWsSep
                               , wrap
                               )
import qualified XMonad.Hooks.EwmhDesktops as EWMH
import XMonad.Hooks.ManageHelpers ( doCenterFloat
                                  , doFullFloat
                                  , isDialog
                                  )
import XMonad.Hooks.SetWMName (setWMName)
import XMonad.StackSet (integrate)
import XMonad.Util.EZConfig ( additionalKeysP
                            , checkKeymap
                            , mkKeymap
                            )


import Keymaps ( myKeys
               , myMouseBindings
               )
import Layout (myLayoutHook)
import Settings ( back
                , focused
                , fore
                , myBorderWidth
                , myModMask
                , myMonoFont
                , myMonoFontSemibold
                , myPromptConfig
                , myTerminal
                , myWorkspaces
                , normal
                )


myConfig dbus = desktopConfig {
  borderWidth = myBorderWidth
, workspaces = myWorkspaces
, terminal = myTerminal
  -- key bindings
, keys = \conf -> mkKeymap conf (myKeys conf)
, modMask = myModMask
, mouseBindings = myMouseBindings
  -- hooks, layouts
, layoutHook = myLayoutHook
, manageHook = myManageHook
, handleEventHook = myHandleEventHook
, logHook = myLogHook dbus
, startupHook = myStartupHook
}

main :: IO ()
main = do
    dbus <- D.connectSession
    -- Request access to the DBus name
    D.requestName dbus (D.busName_ "org.xmonad.Log")
        [D.nameAllowReplacement, D.nameReplaceExisting, D.nameDoNotQueue]

    xmonad $ (myConfig dbus)

myManageHook = composeAll . concat $
    [ [isDialog --> doCenterFloat]
    , [className =? c --> doCenterFloat | c <- myCFloats]
    , [title =? t --> doFloat | t <- myTFloats]
    , [resource =? r --> doFloat | r <- myRFloats]
    , [resource =? i --> doIgnore | i <- myRIgnores]
    , [title =? "Archlinux Logout" --> doFullFloat]
    ]
    where
        myCFloats = ["Arcolinux-calamares-tool.py", "Arcolinux-tweak-tool.py", "Arcolinux-welcome-app.py", "Galculator", "feh", "mpv", "Xfce4-terminal"]
        myTFloats = ["Downloads", "Save As...", "tdrop"]
        myRFloats = []
        myRIgnores = ["desktop_window"]

myHandleEventHook = handleEventHook desktopConfig <+> EWMH.fullscreenEventHook

dbusOutput :: D.Client -> String -> IO ()
dbusOutput dbus str = do
    let signal = (D.signal objectPath interfaceName memberName) {
            D.signalBody = [D.toVariant $ UTF8.decodeString str]
        }
    D.emit dbus signal
    where
        objectPath = D.objectPath_ "/org/xmonad/Log"
        interfaceName = D.interfaceName_ "org.xmonad.Log"
        memberName = D.memberName_ "Update"

myLogHook dbus = do 
  updatePointer (0.5, 0.5) (0, 0)
  dynamicLogWithPP (
      DL.def { ppOutput = dbusOutput dbus
             , ppCurrent = wrap ("%{B" ++ focused ++ "}%{F" ++ back ++ "} ") " %{F-}%{B-}"
             , ppVisible = wrap ("%{B" ++ fore ++ "}%{F" ++ back ++ "} ") " %{F-}%{B-}"
             , ppUrgent = wrap ("%{F" ++ focused ++ "} ") " %{F-}"
             , ppHidden = wrap ("%{F" ++ fore ++ "} ") " %{F-}"
             , ppHiddenNoWindows = wrap ("%{F" ++ normal ++ "} ") " %{F-}"
             , ppWsSep = " "
             , ppSep = ""
             , ppTitle = \text -> ""
             , ppLayout = \text -> ""
             }
      )

myStartupHook = do
    -- TODO[gcc]: make checkKeymap work (I'm not understanding what conf has to be passed as argument and how to do it)
    -- return ()
    -- checkKeymap conf (myKeys conf)
    spawn "$HOME/.scripts/autostart.sh"
    setWMName "LG3D"


