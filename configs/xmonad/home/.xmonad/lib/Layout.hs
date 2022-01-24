{-# LANGUAGE MultiParamTypeClasses, FlexibleInstances #-}

module Layout (myLayoutHook) where


import qualified XMonad as XM
import XMonad ((|||))

import XMonad.Hooks.ManageDocks (avoidStruts)
import qualified XMonad.Layout.Decoration as LD
import XMonad.Layout.Decoration ( activeBorderColor
                                , activeColor
                                , activeTextColor
                                , decoHeight
                                , fontName
                                , fi
                                , inactiveBorderColor
                                , inactiveColor
                                , inactiveTextColor
                                , shrinkText
                                , urgentBorderColor
                                , urgentColor
                                , urgentTextColor
                                )
import XMonad.Layout.IfMaxAlt as IM
import qualified XMonad.Layout.MultiToggle as MT
import XMonad.Layout.MultiToggle ( mkToggle
                                 , (??)
                                 )
import qualified XMonad.Layout.MultiToggle.Instances as MT
import qualified XMonad.Layout.Renamed as LR
import XMonad.Layout.Renamed (renamed)
import qualified XMonad.Layout.Spacing as SP
import XMonad.Layout.Spacing (spacingRaw)
import qualified XMonad.Layout.ThreeColumns as TC
import XMonad.Layout.Gaps (gaps)
import XMonad.Layout.Tabbed (tabbedBottom)
import XMonad.StackSet (integrate)
import qualified XMonad.Util.Types as T

import Settings ( back
                , focused
                , fore
                , myMonoFont
                , normal
                )


myTabbedConfig = LD.def {
  activeColor = focused
, inactiveColor = normal
, urgentColor = fore
, activeBorderColor = focused
, inactiveBorderColor = normal
, urgentBorderColor = fore
, activeTextColor = back
, inactiveTextColor = fore
, urgentTextColor = back
, fontName = myMonoFont
}

sideBorderConfig = LD.def {
  activeColor = focused
, inactiveColor = normal
, urgentColor = fore
, activeBorderColor = focused
, inactiveBorderColor = normal
, urgentBorderColor = fore
, activeTextColor = focused
, inactiveTextColor = normal
, urgentTextColor = fore
, fontName = myMonoFont
, decoHeight = 5
}

data SideDecoration a = SideDecoration T.Direction2D deriving (Show, Read)

instance Eq a => LD.DecorationStyle SideDecoration a where
    shrink b (XM.Rectangle _ _ decoWidth decoHeight) (XM.Rectangle x y w h)
        | SideDecoration T.U <- b = XM.Rectangle x (y + fi decoHeight) w (h - decoHeight)
        | SideDecoration T.R <- b = XM.Rectangle x y (w - decoWidth) h
        | SideDecoration T.D <- b = XM.Rectangle x y w (h - decoHeight)
        | SideDecoration T.L <- b = XM.Rectangle (x + fi decoWidth) y (w - decoWidth) h

    pureDecoration b decoWidth decoHeight _ st _ (win, XM.Rectangle x y w h)
        | win `elem` integrate st && decoWidth < w && decoHeight < h = Just $
            case b of
                SideDecoration T.U -> XM.Rectangle (x + fi decoWidth) y (w - (2 * decoWidth)) decoHeight
                SideDecoration T.R -> XM.Rectangle (x + fi (w - decoHeight)) (y + fi (decoWidth `div` 2)) decoHeight (h - decoWidth)
                SideDecoration T.D -> XM.Rectangle (x + fi decoWidth) (y + fi (h - decoHeight)) (w - (2 * decoWidth)) decoHeight
                SideDecoration T.L -> XM.Rectangle x (y + fi (decoWidth `div` 2)) decoHeight (h - decoWidth)
        | otherwise = Nothing

bottomBorder :: (Eq a, LD.Shrinker s) => s -> LD.Theme -> l a -> LD.ModifiedLayout (LD.Decoration SideDecoration s) l a
bottomBorder s c = LD.decoration s c $ SideDecoration T.D

leftBorder :: (Eq a, LD.Shrinker s) => s -> LD.Theme -> l a -> LD.ModifiedLayout (LD.Decoration SideDecoration s) l a
leftBorder s c = LD.decoration s c $ SideDecoration T.L

myLayoutHook = avoidStruts $ mkToggle (MT.FULL ?? MT.EOT) $ oneWindowFull $
    tabbedWindowGaps (screenGapsTabbed (tabbedBottom shrinkText myTabbedConfig))
    ||| bottomBorder shrinkText sideBorderConfig (tiledWindowGaps tiledTall)
    ||| leftBorder shrinkText sideBorderConfig (tiledWindowGaps tiledWide)
    ||| bottomBorder shrinkText sideBorderConfig (tiledWindowGaps tiledMainMid)
    where
        oneWindowFull = IM.IfMaxAlt 1 (screenGapsFull XM.Full)
        screenGapsTabbed = gaps [(T.U,3), (T.D,0), (T.R,8), (T.L,8)]
        screenGapsFull = gaps [(T.U,3), (T.D,8), (T.R,8), (T.L,8)]
        tabbedWindowGaps = spacingRaw False (SP.Border 0 0 0 0) False (SP.Border 0 8 0 0) True
        tiledWindowGaps = spacingRaw False (SP.Border 0 5 5 5) True (SP.Border 3 3 3 3) True
        tiledTall = XM.Tall nmaster delta ratio
        tiledWide = XM.Mirror tiledTall
        tiledMainMid = TC.ThreeColMid nmaster delta ratio
        nmaster = 1
        delta = 3/100
        ratio = 1/2

