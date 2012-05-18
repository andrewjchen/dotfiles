import XMonad hiding (Tall) 
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks

import XMonad.Actions.FloatKeys
import XMonad.Layout.HintedTile
import XMonad.Layout.LayoutHints (layoutHints)
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
import XMonad.Layout.NoBorders
import XMonad.Layout
import XMonad.Layout.WindowArranger


import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Util.Run(spawnPipe)

 
import System.Exit
import System.IO
import Data.Monoid
 
import qualified XMonad.StackSet as W
import qualified Data.Map        as M
 
myBorderWidth   = 1
main = do
    xmproc <- spawnPipe "/usr/bin/xmobar /home/ajc/.xmobarrc"
    xmonad $ defaultConfig {
        terminal           = "urxvt"
        , modMask            = mod4Mask
        , workspaces         = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
        , normalBorderColor  = "#000000"
        , focusedBorderColor = "#00FF00"
        --, focusedBorderColor = "#0066FF"
        , manageHook         = myManageHook --composeAll [],
        --, manageHook         = composeAll []  --myManageHook,--composeAll [],
        , borderWidth        = myBorderWidth
        , keys               = myKeys
        --, layoutHook         = avoidStruts $ windowArrange myLayout 
        , layoutHook         = avoidStruts $  windowArrange myLayout 
        , logHook            = dynamicLogWithPP $ xmobarPP { 
                                 ppOutput = hPutStrLn xmproc,
                                 ppTitle = xmobarColor "green" "" . shorten 50,
                                 ppHiddenNoWindows = xmobarColor "gray" "",
                                 ppHidden = xmobarColor "white" ""
                             }
    }
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
 
    [ ((modMask              , xK_Return   ), spawn $ XMonad.terminal conf)
    , ((modMask .|. shiftMask, xK_c        ), kill)
    , ((modMask              , xK_space    ), sendMessage NextLayout)
    , ((modMask .|. shiftMask, xK_space    ), setLayout $ XMonad.layoutHook conf)
    , ((modMask              , xK_n        ), refresh)
    --, ((modMask,               xK_p     ), spawn "exe=`dmenu_path | dmenu -b ` && eval \"exec $exe\"")
    -- we want to use our own dmenu
    , ((modMask,               xK_p     ), spawn "exe=`dmenu_run -b -nb '#000000' -sb '#0066FF' -sf '#ffffff' -nf '#ffffff' ` && eval \"exec $exe\"")
    , ((modMask              , xK_Tab      ), windows W.focusDown)
    , ((modMask              , xK_j        ), windows W.focusDown)
    , ((modMask              , xK_k        ), windows W.focusUp)
    , ((modMask              , xK_m        ), windows W.focusMaster)
    , ((modMask .|. shiftMask, xK_Return   ), windows W.swapMaster)
    , ((modMask .|. shiftMask, xK_j        ), windows W.swapDown)
    , ((modMask .|. shiftMask, xK_k        ), windows W.swapUp)
    , ((modMask              , xK_h        ), sendMessage Shrink)
    , ((modMask              , xK_l        ), sendMessage Expand)
    , ((modMask              , xK_t        ), withFocused $ windows . W.sink)
    , ((modMask              , xK_comma    ), sendMessage (IncMasterN 1))
    , ((modMask              , xK_period   ), sendMessage (IncMasterN (-1)))
    , ((modMask .|. shiftMask, xK_q        ), io (exitWith ExitSuccess))
    , ((modMask              , xK_q        ), spawn "xmonad --recompile; xmonad --restart")
    , ((modMask              , xK_F2       ), shellPrompt defaultXPConfig)
    , ((0                    , 0x1008ff30  ), shellPrompt defaultXPConfig)
    , ((0                    , 0x1008ff13  ), spawn "amixer -q set PCM 1dB+")
    , ((0                    , 0x1008ff11  ), spawn "amixer -q set PCM 1dB-")
    --, ((0                    , 0x1008ff12  ), spawn "amixer -q set Master toggle")
    , ((0                    , 0x1008ff16  ), spawn "cmus-remote --prev")
    , ((0                    , 0x1008ff17  ), spawn "cmus-remote --next")
    , ((0                    , 0x1008ff14  ), spawn "cmus-remote --pause")
    , ((0                    , 0x1008ff5b  ), spawn "urxvt -e screen -rd cmus")
    , ((modMask              , xK_Print    ), spawn "scrot -e 'mv $f ~/Screenshots'")
    --resize float
    --, ((modMask            , xK_f         ), withFocused (keysResizeWindow (-10,-10) (1,1)))
    --, ((modMask                , xK_g         ), withFocused (keysResizeWindow (10,10) (1,1)))
    --, ((modMask                , xK_w         ), withFocused (keysMoveWindow (0, -10)))
    --, ((modMask                , xK_a         ), withFocused (keysMoveWindow (-10 ,0)))
    --, ((modMask                , xK_s         ), withFocused (keysMoveWindow (0,10)))
    --, ((modMask                , xK_d         ), withFocused (keysMoveWindow (10,0)))
  --, ((modMask .|. shiftMask, xK_d     ), withFocused (keysAbsResizeWindow (-10,-10) (1024,752)))
  --, ((modMask .|. shiftMask, xK_s     ), withFocused (keysAbsResizeWindow (10,10) (1024,752)))


    --ResizeableTile layout bindings
    , ((modMask             , xK_x          ), sendMessage MirrorShrink)
    , ((modMask             , xK_z          ), sendMessage MirrorExpand)
    , ((modMask  .|. controlMask              , xK_s    ), sendMessage  Arrange         )
    , ((modMask  .|. controlMask .|. shiftMask, xK_s    ), sendMessage  DeArrange       )
    , ((modMask  .|. controlMask              , xK_Left ), sendMessage (MoveLeft      1))
    , ((modMask  .|. controlMask              , xK_Right), sendMessage (MoveRight     1))
    , ((modMask  .|. controlMask              , xK_Down ), sendMessage (MoveDown      1))
    , ((modMask  .|. controlMask              , xK_Up   ), sendMessage (MoveUp        1))
    , ((modMask                  .|. shiftMask, xK_Left ), sendMessage (IncreaseLeft  1))
    , ((modMask                  .|. shiftMask, xK_Right), sendMessage (IncreaseRight 1))
    , ((modMask                  .|. shiftMask, xK_Down ), sendMessage (IncreaseDown  1))
    , ((modMask                  .|. shiftMask, xK_Up   ), sendMessage (IncreaseUp    1))
    , ((modMask  .|. controlMask .|. shiftMask, xK_Left ), sendMessage (DecreaseLeft  1))
    , ((modMask  .|. controlMask .|. shiftMask, xK_Right), sendMessage (DecreaseRight 1))
    , ((modMask  .|. controlMask .|. shiftMask, xK_Down ), sendMessage (DecreaseDown  1))
    , ((modMask  .|. controlMask .|. shiftMask, xK_Up   ), sendMessage (DecreaseUp    1))

    , ((modMask                         , xK_Delete         ), spawn "xinput set-prop 12 \"Device Enabled\" 0")
    , ((modMask                         , xK_Insert         ), spawn "xinput set-prop 12 \"Device Enabled\" 1")
    --screenoff
    , ((modMask                         , xK_Escape         ), spawn "sleep 1 && xset dpms force off")
    --fan control
    --sounds!
    , ((modMask                         , xK_F1         ), spawn "/home/ajc/ros_workspace/gunncs_navigation/windowSession.sh")
    , ((modMask                         , xK_F2         ), spawn "mplayer /home/ajc/Media/sounds/found.mp3")
    , ((modMask                         , xK_F3         ), spawn "mplayer /home/ajc/Media/sounds/portalgun_shoot_red1.wav")
    , ((modMask                         , xK_F4         ), spawn "mplayer /home/ajc/Media/sounds/wpn_portal_gun_fire_red_01.wav")
    --, ((modMask                         , xK_F5       ), spawn "mplayer /home/ajc/Media/Music/sounds/rocketlaunch.wav")
    , ((modMask                         , xK_F5         ), spawn "mplayer /home/ajc/Media/Music/sounds/thetruth.mp3")
    , ((modMask                         , xK_F7         ), spawn "mplayer /home/ajc/Media/Music/sounds/elevatorstuck.mp3")
    , ((modMask                         , xK_F8         ), spawn "mplayer /home/ajc/Media/Music/sounds/wakeup.mp3")
    , ((modMask                         , xK_F9         ), spawn "mplayer /home/ajc/Media/sounds/slinky.flv")
    , ((modMask                         , xK_F10        ), spawn "mplayer /home/ajc/Media/sounds/petman.flv")
    , ((modMask                         , xK_F11        ), spawn "/home/ajc/bash/wallpapers/nextWall.sh")
    --stop sounds
    , ((modMask                         , xK_F12        ), spawn "killall mplayer")

    ]
    ++
 
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
 
    ++
 
    [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..] --xK_y used to be --xK_w
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


--myLayout = smartBorders $ (tiled ||| Mirror tiled ||| Full ||| simpleTabbed)
myLayout = smartBorders $ (tiled ||| Mirror tiled ||| Full ||| simpleTabbed)
  where
    tiled = ResizableTall nmaster delta ratio []
    nmaster = 1--number of master windows
    delta = 3/100 --change of resizing actions
    ratio = 1/2 --width of master

myManageHook :: ManageHook
myManageHook = composeAll . concat $
    [ [ className   =? c                 --> doFloat | c <- myFloats]
    , [ title       =? t                 --> doFloat | t <- myOtherFloats]
    , [ resource    =? r                 --> doIgnore | r <- myIgnores]
    ]
    where
        myIgnores       = ["panel"]
        myFloats        = ["feh", "GIMP", "gimp", "gimp-2.4", "Galculator", "VirtualBox", "VBoxSDL", "mplayer", "original-left", "original-right", "disparity", "grayscale", "original"]
        myOtherFloats   = ["alsamixer", "Bon Echo Preferences", "Mail/News Preferences", "Bon Echo - Restore Previous Session"] 


