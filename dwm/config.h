/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 3;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int swallowfloating    = 1;        /* 1 means swallow floating windows by default */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 0;        /* 0 means bottom bar */
static const char *fonts[]          = { "mono:size=8", "Ionicons:size=8" };
// static const char *fonts[]          = { "Mononoki Nerd Font:size=8", "Symbola:size=8" };
static const char dmenufont[]       = "mono:size=10";
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#005577";
static const char *colors[][3]      = {
    /*               fg         bg         border   */
    [SchemeNorm] = { col_gray3, col_gray1, col_gray2 }, // status color
    // [SchemeSel]  = { col_gray4, col_cyan,  col_cyan  }, // title color
    // [SchemeNorm] = { "#18B218", "#000000", col_gray2 },
    [SchemeSel]  = { col_gray4, col_cyan,  "#00A5FF"}, // neon blue
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
    /* xprop(1):
     *  WM_CLASS(STRING) = instance, class
     *  WM_NAME(STRING) = title
     */
    /* class                    instance    title           tags mask   isfloating  isterminal  noswallow   monitor */
        { "qutebrowser",        NULL,       NULL,           1 << 1,     0,          0,          1,          -1 },
        { "TelegramDesktop",    NULL,       NULL,           1 << 7,     0,          0,          1,          -1 },
        { "battle.net.exe",     NULL,       NULL,           1 << 5,     0,          0,          1,          -1 },
        { "explorer.exe",       NULL,       NULL,           1 << 5,     0,          0,          1,          -1 },
        { "GoldenDict",         NULL,       NULL,           1 << 2,     0,          0,          1,          -1 },
        { "Zathura",            NULL,       NULL,           1 << 8,     0,          0,          1,          -1 },
        { "Evince",             NULL,       NULL,           1 << 8,     0,          0,          1,          -1 },
        { "FBReader",           NULL,       NULL,           1 << 8,     0,          0,          1,          -1 },
        { "firefox",            NULL,       NULL,           1 << 2,     0,          0,          1,          -1 },
        { "chromium",           NULL,       NULL,           1 << 1,     0,          0,          1,          -1 },
        { "St",                 NULL,       NULL,           0,          0,          1,          1,          -1 },
        { "Alacritty",          NULL,       NULL,           0,          0,          1,          1,          -1 },
        { "URxvt",              NULL,       NULL,           0,          0,          1,          1,          -1 },
        { "Gimp",               NULL,       NULL,           0,          0,          0,          0,          -1 },
        // { "Sxiv",            NULL,       NULL,           0,          1,          0,         -1,          -1 },
        { "mpv",                NULL,       NULL,           1 << 7,     0,          0,          0,          -1 },
        { NULL,                 NULL,       "ncmpcpp",      1 << 7,     0,          0,          1,          -1 },
        { NULL,                 NULL,       "trans",        0,          1,          1,          1,          -1 },                   // xterm
        { NULL,                 NULL,       "trans",        0,          1,          1,          1,          -1 },                    // urxvt
        { NULL,                 NULL,       "Event Tester", 0,          1,          0,          1,          -1 }, /*xev*/
        { "Qemu-system-x86_64", NULL,       NULL,           1 << 6,     0,          0,          0,          -1 },


};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static int attachbelow = 0;    /* 1 means attach after the currently active window */


#include "grid.c"
static const Layout layouts[] = {
    /* symbol     arrange function */
    { "[]=",      tile },    /* first entry is default */
    { "><>",      NULL },    /* no layout function means floating behavior */
    { "HHH",      grid},    
    { "|M|",      centeredmaster },
    { ">M>",      centeredfloatingmaster },
    // { "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod1Mask
#define TAGKEYS(KEY,TAG) \
    { MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
    { MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
    { MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
    { MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *termcmd[]  = { "st", NULL};

#include <X11/XF86keysym.h>
#include "movestack.c"
static Key keys[] = {
    /* modifier             key             function            argument */
    { MODKEY,               XK_d,           spawn,              {.v = dmenucmd } },
    { MODKEY|ControlMask,   XK_y,           spawn,              SHCMD("clip.sh copy") },
    { MODKEY|ControlMask,   XK_p,           spawn,              SHCMD("clip.sh paste") },
    { MODKEY|ControlMask,   XK_l,           spawn,              SHCMD("clip.sh clear") },
    { MODKEY,               XK_Return,      spawn,              {.v = termcmd } },
    { MODKEY|ShiftMask,     XK_Return,      spawn,              SHCMD("st -e tmux") },
    { MODKEY,               XK_b,           togglebar,          {0} },
    { MODKEY,               XK_j,           focusstack,         {.i = +1 } },
    { MODKEY,               XK_k,           focusstack,         {.i = -1 } },
    { MODKEY,               XK_i,           incnmaster,         {.i = +1 } },
    { MODKEY|ShiftMask,     XK_i,           incnmaster,         {.i = -1 } },
    { MODKEY,               XK_h,           setmfact,           {.f = -0.05} },
    { MODKEY,               XK_l,           setmfact,           {.f = +0.05} },
    { MODKEY|ShiftMask,     XK_j,           movestack,          {.i = +1 } },
    { MODKEY|ShiftMask,     XK_k,           movestack,          {.i = -1 } },
    { MODKEY,               XK_space,       zoom,               {0} },
    { MODKEY,               XK_Tab,         view,               {0} },
    { MODKEY|ShiftMask,     XK_Tab,         toggleAttachBelow,  {0} },
    { MODKEY,               XK_q,           killclient,         {0} },
    { MODKEY,               XK_t,           setlayout,          {.v = &layouts[0]} },
    { MODKEY|ShiftMask,     XK_t,           setlayout,          {.v = &layouts[1]} },
    { MODKEY,               XK_u,           setlayout,          {.v = &layouts[2]} },
    { MODKEY,               XK_y,           setlayout,          {.v = &layouts[3]} },
    { MODKEY|ShiftMask,     XK_y,           setlayout,          {.v = &layouts[4]} },
 // { MODKEY,               XK_space,       setlayout,          {0} },
    { MODKEY|ShiftMask,     XK_space,       togglefloating,     {0} },
    { MODKEY,               XK_f,           togglefullscr,      {0} },
    { MODKEY,               XK_0,           view,               {.ui = ~0 } },
    { MODKEY|ShiftMask,     XK_0,           tag,                {.ui = ~0 } },
    // { MODKEY,            XK_comma,       focusmon,           {.i = -1 } },
    // { MODKEY,            XK_period,      focusmon,           {.i = +1 } },
    // { MODKEY|ShiftMask,  XK_comma,       tagmon,             {.i = -1 } },
    // { MODKEY|ShiftMask,  XK_period,      tagmon,             {.i = +1 } },
    TAGKEYS(                XK_1,                               0)
    TAGKEYS(                XK_2,                               1)
    TAGKEYS(                XK_3,                               2)
    TAGKEYS(                XK_4,                               3)
    TAGKEYS(                XK_5,                               4)
    TAGKEYS(                XK_6,                               5)
    TAGKEYS(                XK_7,                               6)
    TAGKEYS(                XK_8,                               7)
    TAGKEYS(                XK_9,                               8)
    { MODKEY|ShiftMask,     XK_e,           quit,               {0} },
    { MODKEY|ShiftMask,     XK_r,           quit,               {1} }, 
    { MODKEY,               XK_minus,       scratchpad_show,    {0} },
    { MODKEY|ShiftMask,     XK_minus,       scratchpad_hide,    {0} },
    { MODKEY,               XK_equal,       scratchpad_remove,  {0} },


/* Custom keybinding */
    { MODKEY,               XK_p,                       spawn,  SHCMD("mpc toggle") },
    { MODKEY,               XK_bracketleft,             spawn,  SHCMD("mpc prev") },
    { MODKEY,               XK_bracketright,            spawn,  SHCMD("mpc next") },
    // { MODKEY|ShiftMask,      XK_bracketleft,             spawn,  SHCMD("mpc seek -10 ") },
    // { MODKEY|ShiftMask,      XK_bracketright,            spawn,  SHCMD("mpc seek +10") },
    { MODKEY|ShiftMask,     XK_p,                       spawn,  SHCMD("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause") }, // required xbindkeys
    { MODKEY|ShiftMask,     XK_bracketleft,             spawn,  SHCMD("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous") },
    { MODKEY|ShiftMask,     XK_bracketright,            spawn,  SHCMD("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next") },
    { MODKEY,               XK_n,                       spawn,  SHCMD("xterm -e ncmpcpp") },
    { MODKEY,               XK_m,                       spawn,  SHCMD("st -e lf /mnt/sdb2/videos/tv_series") },
    // { MODKEY,            XK_comma,                   spawn,  SHCMD("mpc prev") },
    // { MODKEY|ShiftMask,  XK_comma,                   spawn,  SHCMD("mpc seek 0%") },
    // { MODKEY,            XK_period,                  spawn,  SHCMD("mpc next") },
    // { MODKEY|ShiftMask,  XK_period,                  spawn,  SHCMD("mpc repeat") },
    // { 0,                 XF86XK_ScreenSaver,         spawn,  SHCMD("i3lock -k") },
    { MODKEY,               XK_F2,                      spawn,  SHCMD("i3lock -k") },
    { 0,                    XF86XK_AudioMicMute,        spawn,  SHCMD("pactl set-source-mute 1 toggle") },
    { 0,                    XF86XK_AudioMute,           spawn,  SHCMD("pactl set-sink-mute 0 toggle") },
    { 0,                    XF86XK_AudioRaiseVolume,    spawn,  SHCMD("pactl set-sink-volume 0 +5%") },
    { 0,                    XF86XK_AudioLowerVolume,    spawn,  SHCMD("pactl set-sink-volume 0 -5%") },
    // { MODKEY,                XK_F10,         spawn,  SHCMD("amixer -D pulse -q set Master toggle" ) },
    // { MODKEY,                XK_F11,    spawn,   SHCMD("amixer -D pulse -q set Master 5%+    ") },
    // { MODKEY,                XK_F9,    spawn,    SHCMD("amixer -D pulse -q set Master 5%-    ") },
    // { MODKEY,                XK_F12,        spawn,  SHCMD("pactl set-source-mute 1 toggle") },
    { MODKEY,               XK_F8,                      spawn,  SHCMD("touchpad_toggle.sh") },
    { 0,                    XK_Print,                   spawn,  SHCMD("scrot ~/Pictures/ScreenShots/%b%d:%H%M%S.png") },
    { MODKEY,               XK_Print,                   spawn,  SHCMD("scrot -s ~/Pictures/ScreenShots/%b%d:%H%M%S.png") },
    { MODKEY,               XK_Delete,                  spawn,  SHCMD("turnoff_screen.sh") },
    { MODKEY,               XK_r,                       spawn,  SHCMD("st -e lf") },
    { MODKEY,               XK_g,                       spawn,  SHCMD("goldendict") },
    // { MODKEY,                XK_z,                       spawn,  SHCMD("FBReader") },
    { Mod4Mask,             XK_i,                       spawn,  SHCMD("ibus-daemon -drx") },
    { Mod4Mask|ShiftMask,   XK_i,                       spawn,  SHCMD("ibus exit") },
    { MODKEY,               XK_w,                       spawn,  SHCMD("$BROWSER") },
    { MODKEY,               XK_period,                  spawn,  SHCMD("xterm_trans.sh") },
    { MODKEY,               XK_z,                   spawn,  SHCMD("xterm_trans.sh") },
    { MODKEY|ShiftMask,     XK_period,                  spawn,  SHCMD("xterm -e trans :vi -b --shell") },
    { MODKEY,               XK_comma,                   spawn,  SHCMD("xterm_trans1.sh") },
    { MODKEY|ShiftMask,     XK_comma,                   spawn,  SHCMD("xterm -e trans :vi --shell") },
    { MODKEY,               XK_F1,                      spawn,  SHCMD("keylog.sh") },
    { MODKEY|ShiftMask,     XK_F1,                      spawn,  SHCMD("sudo killall python3") },
    { MODKEY|ControlMask,   XK_f,						spawn,  SHCMD("thePower.sh") },
    { MODKEY|ControlMask,   XK_d,						spawn,  SHCMD("allUp.sh") },

};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
    /* click                event mask      button          function                        argument */
    { ClkLtSymbol,          0,              Button1,        setlayout,                      {0} },
    { ClkLtSymbol,          0,              Button3,        setlayout,                      {.v = &layouts[2]} },
    { ClkWinTitle,          0,              Button2,        zoom,                           {0} },
    { ClkStatusText,        0,              Button2,        spawn,                          {.v = termcmd } },
    { ClkClientWin,         MODKEY,         Button1,        movemouse,                      {0} },
    { ClkClientWin,         MODKEY,         Button2,        togglefloating,                 {0} },
    { ClkClientWin,         MODKEY,         Button3,        resizemouse,                    {0} },
    { ClkTagBar,            0,              Button1,        view,                           {0} },
    { ClkTagBar,            0,              Button3,        toggleview,                     {0} },
    { ClkTagBar,            MODKEY,         Button1,        tag,                            {0} },
    { ClkTagBar,            MODKEY,         Button3,        toggletag,                      {0} },
};
