module Settings (
  back
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
) where


import qualified XMonad as XM
import XMonad ( mod4Mask
              , xK_greater
              , xK_Tab
              )

import qualified XMonad.Prompt as P
import XMonad.Prompt ( alwaysHighlight
                     , autoComplete
                     , bgColor
                     , bgHLight
                     , borderColor
                     , changeModeKey
                     , completionKey
                     , fgColor
                     , fgHLight
                     , font
                     , height
                     , maxComplRows
                     , position
                     , promptBorderWidth
                     , searchPredicate
                     , showCompletionOnTab
                     , sorter
                     )
import XMonad.Prompt.FuzzyMatch ( fuzzyMatch
                                , fuzzySort
                                )


-- General
myBorderWidth :: XM.Dimension
myBorderWidth = 0
myTerminal = "alacritty"
myModMask = mod4Mask
myMonoFont = "xft:SauceCodePro:size=11"
myMonoFontSemibold = "xft:SauceCodePro:size=11:weight=semibold"
myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]

-- Theming
normal = "#555555"
focused = "#e60053"
fore = "#DEE3E0"
back = "#1e1f29"

-- Prompt
myPromptConfig = P.def {
  font = myMonoFontSemibold
, bgColor = back
, fgColor = fore
, bgHLight = back 
, fgHLight = focused
, borderColor = back
, promptBorderWidth = 1
, completionKey = (0, xK_Tab)
, changeModeKey = xK_greater
, position = P.Top
, height = 32
, maxComplRows = Just 5
, showCompletionOnTab = False
, alwaysHighlight = False
, searchPredicate = fuzzyMatch
, sorter = fuzzySort
, autoComplete = Just 500000
}

