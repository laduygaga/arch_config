/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const unsigned int gappih    = 0;       /* horiz inner gap between windows */
static const unsigned int gappiv    = 0;       /* vert inner gap between windows */
static const unsigned int gappoh    = 0;       /* horiz outer gap between windows and screen edge */
static const unsigned int gappov    = 0;       /* vert outer gap between windows and screen edge */
static const int smartgaps          = 0;        /* 1 means no outer gap when there is only one window */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 0;        /* 0 means bottom bar */
static const char *fonts[]          = { "Ionicons:size=8", "FontAwesome:size=8"};
static char dmenufont[]             = "monospace:size=10";
static char normbgcolor[]           = "#222222";
static char normbordercolor[]       = "#000000";
// static char normbordercolor[]       = "#444444";
static char normfgcolor[]           = "#bbbbbb";
static char selfgcolor[]            = "#eeeeee";
static char selbordercolor[]        = "#005577";
static char selbgcolor[]            = "#005577";
static char *colors[][3] = {
    /*               fg           bg           border   */
    [SchemeNorm] = { normfgcolor, normbgcolor, normbordercolor },
    [SchemeSel]  = { selfgcolor,  selbgcolor,  selbordercolor  },
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
    /* xprop(1):
     *	WM_CLASS(STRING) = instance, class
     *	WM_NAME(STRING) = title
     */
    /* class             instance    title     tags mask     isfloating   isterminal noswallow monitor */
    { "Gimp",            NULL,       NULL,     1 << 8,       0,           0,         0,        -1 },
    { "qutebrowser",     NULL,       NULL,     1 << 1,       0,           0,         0,        -1 },
    { "GoldenDict",      NULL,       NULL,     1 << 2,       0,           0,         0,        -1 },
    { "Zathura",         NULL,       NULL,     1 << 8,       0,           0,         0,        -1 },
    { "libreoffice",     NULL,       NULL,     1 << 3,       0,           0,         0,        -1 },
    { "firefox",         NULL,       NULL,     1 << 1,       0,           0,         0,        -1 },
    { "St",              NULL,       NULL,     0,            0,           1,         0,        -1 },
    { "XTerm",           NULL,       NULL,     1 << 7,       0,           1,         0,        -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
#define FORCE_VSPLIT 1  /* nrowgrid layout: force two clients to always split vertically */
#include "vanitygaps.c"
#include "grid.c"
static const Layout layouts[] = {
    /* symbol     arrange function */
    { "[]=",	tile },			        /* Default: Master on left, slaves on right */
    { "TTT",	bstack },		        /* Master on top, slaves on bottom */
    { "[@]",	spiral },		        /* Fibonacci spiral */
    { "[\\]",	dwindle },		        /* Decreasing in size right and leftward */
    // { "H[]",	deck },			        /* Master on left, slaves in monocle-like mode on right */
    // { "[M]",	monocle },		        /* All windows on top of eachother */
    { "|M|",	centeredmaster },		/* Master in middle, slaves on sides */
    { ">M>",	centeredfloatingmaster },	/* Same but master floats */
    { "HHH",    grid},
    { "><>",	NULL },			        /* no layout function means floating behavior */
    { NULL,     NULL },
};

/* key definitions */
#define MODKEY Mod1Mask
#define TAGKEYS(KEY,TAG) \
{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },
#define STACKKEYS(MOD,ACTION) \
{ MOD,	XK_j,	ACTION##stack,	{.i = INC(+1) } }, \
{ MOD,	XK_k,	ACTION##stack,	{.i = INC(-1) } }, \

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbgcolor, "-sf", selfgcolor, NULL };
static const char *termcmd[]  = { "st", NULL };
static const char scratchpadname[] = "scratchpad";
static const char *scratchpadcmd[] = { "st", "-t", scratchpadname, "-g", "120x34", NULL };

#include <X11/XF86keysym.h>
#include "shiftview.c"
static Key keys[] = {
    /* modifier                         key                         function           argument */
    STACKKEYS(MODKEY, focus)
        STACKKEYS(MODKEY|ShiftMask, push)
    TAGKEYS(XK_1, 0)
        TAGKEYS(			XK_2,		1)
        TAGKEYS(			XK_3,		2)
        TAGKEYS(			XK_4,		3)
        TAGKEYS(			XK_5,		4)
        TAGKEYS(			XK_6,		5)
        TAGKEYS(			XK_7,		6)
        TAGKEYS(			XK_8,		7)
        TAGKEYS(			XK_9,		8)
        { MODKEY,			XK_0,		            view,		{.ui = ~0 } },
        { MODKEY|ShiftMask,		XK_0,		            tag,		{.ui = ~0 } },
        { MODKEY,			XK_Tab,		            view,		{0} },
        { MODKEY,			XK_q,		            killclient,	        {0} },
        { MODKEY,			XK_w,		            spawn,		SHCMD("$BROWSER") },
        { MODKEY|ShiftMask,		XK_r,		            quit,		{1} }, 
        { MODKEY|ShiftMask,		XK_e,		            quit,		{0} }, 
        { MODKEY,			XK_t,		            setlayout,	        {.v = &layouts[0]} },
        { MODKEY|ShiftMask,		XK_t,		            setlayout,	        {.v = &layouts[1]} },
        { MODKEY,			XK_y,		            setlayout,	        {.v = &layouts[2]} },
        { MODKEY|ShiftMask,		XK_y,		            setlayout,	        {.v = &layouts[3]} },
        // { MODKEY,			XK_u,		            setlayout,	        {.v = &layouts[4]} },
        // { MODKEY|ShiftMask,		XK_u,		            setlayout,	        {.v = &layouts[5]} },
        { MODKEY,			XK_o,		            setlayout,	        {.v = &layouts[4]} },
        { MODKEY|ShiftMask,		XK_o,		            setlayout,	        {.v = &layouts[5]} },
        { MODKEY,		        XK_u,		            setlayout,	        {.v = &layouts[6]} },
        { MODKEY,			XK_i,		            incnmaster,         {.i = +1 } },
        { MODKEY|ShiftMask,		XK_i,		            incnmaster,         {.i = -1 } },
        { MODKEY,			XK_p,			    spawn,		SHCMD("mpc toggle") },
        { MODKEY,			XK_bracketleft,		    spawn,		SHCMD("mpc seek -10") },
        { MODKEY|ShiftMask,		XK_bracketleft,		    spawn,		SHCMD("mpc seek -120") },
        { MODKEY,			XK_bracketright,	    spawn,		SHCMD("mpc seek +10") },
        { MODKEY|ShiftMask,		XK_bracketright,	    spawn,		SHCMD("mpc seek +120") },
        { MODKEY,			XK_backslash,		    view,		{0} },
        { MODKEY,			XK_d,		            spawn,              {.v = dmenucmd } },
        { MODKEY|ShiftMask,		XK_d,		            togglegaps,	        {0} },
        { MODKEY,			XK_f,		            togglefullscr,	{0} },
        { MODKEY|ShiftMask,		XK_f,		            setlayout,	        {.v = &layouts[8]} },
        { MODKEY,			XK_g,		            shiftview,	        { .i = -1 } },
        { MODKEY,			XK_semicolon,	            shiftview,	        { .i = 1 } },
        { MODKEY,			XK_h,		            setmfact,	        {.f = -0.05} },
        { MODKEY,			XK_l,		            setmfact,      	{.f = +0.05} },
        { MODKEY,			XK_Return,	            spawn,		{.v = termcmd } },
        { MODKEY,		        XK_minus,	            togglescratch,	{.v = scratchpadcmd } },
        { MODKEY,			XK_z,		            incrgaps,	        {.i = +1 } },
        { MODKEY|ShiftMask,		XK_z,		            incrgaps,	        {.i = -1 } },
        { MODKEY,			XK_b,		            togglebar,	        {0} },
        // { 0,	                        XF86XK_AudioMicMute,	    spawn,		SHCMD("pactl set-source-mute 1 toggle") },
        // { 0,	                        XF86XK_AudioMute,	    spawn,		SHCMD("pactl set-sink-mute 0 toggle") },
        // { 0,	                        XF86XK_AudioRaiseVolume,    spawn,		SHCMD("pactl set-sink-volume 0 +5%") },
        // { 0,	                        XF86XK_AudioLowerVolume,    spawn,		SHCMD("pactl set-sink-volume 0 -5%") },
        { 0,	                        XF86XK_AudioMicMute,	    spawn,		SHCMD("amixer -D pulse -q set Capture toggle") },
        { 0,	                        XF86XK_AudioMute,	    spawn,		SHCMD("amixer -D pulse -q set Master toggle" ) },
        { 0,	                        XF86XK_AudioRaiseVolume,    spawn,		SHCMD("amixer -D pulse -q set Master 5%+    ") },
        { 0,	                        XF86XK_AudioLowerVolume,    spawn,		SHCMD("amixer -D pulse -q set Master 5%-    ") },
        { MODKEY,                       XK_F8,	                    spawn,	        SHCMD("touchpad_toggle.sh") },
        { 0,				XK_Print,	            spawn,		SHCMD("scrot ~/Pictures/ScreenShots/%b%d:%H%M%S.png") },
        { ShiftMask,			XK_Print,	            spawn,		SHCMD("scrot -s ~/Pictures/ScreenShots/%b%d:%H%M%S.png") },
        { MODKEY,                       XK_x,	                    spawn,	        SHCMD("turnoff_screen.sh") },
        { MODKEY,			XK_r,	                    spawn,		SHCMD("st -e ranger") },
        { Mod4Mask,			XK_g,	                    spawn,		SHCMD("goldendict") },
        { Mod4Mask,			XK_z,	                    spawn,		SHCMD("zathura") },
        { Mod4Mask,			XK_i,	                    spawn,		SHCMD("ibus-daemon -drx") },
        { Mod4Mask|ShiftMask,           XK_i,	                    spawn,		SHCMD("ibus exit") },
        { MODKEY,			XK_n,		            spawn,		SHCMD("xterm -e ncmpcpp") },
        { MODKEY,			XK_comma,	            spawn,		SHCMD("mpc prev") },
        { MODKEY|ShiftMask,		XK_comma,	            spawn,		SHCMD("mpc seek 0%") },
        { MODKEY,			XK_period,	            spawn,		SHCMD("mpc next") },
        { MODKEY|ShiftMask,		XK_period,	            spawn,		SHCMD("mpc repeat") },
        { MODKEY,			XK_Left,	            focusmon,	        {.i = -1 } },
        { MODKEY|ShiftMask,		XK_Left,	            tagmon,		{.i = -1 } },
        { MODKEY,			XK_Right,	            focusmon,	        {.i = +1 } },
        { MODKEY|ShiftMask,		XK_Right,	            tagmon,		{.i = +1 } },
        { MODKEY,			XK_Page_Up,	            shiftview,	        { .i = -1 } },
        { MODKEY,			XK_Page_Down,	            shiftview,	        { .i = 1 } },
        { MODKEY,			XK_Insert,	            spawn,		SHCMD("notify-send \"📋 Clipboard contents:\" \"$(xclip -o -selection clipboard)\"") },
        { MODKEY,			XK_F1,		            spawn,		SHCMD("groff -mom /usr/local/share/dwm/larbs.mom -Tpdf | zathura -") },
        { MODKEY,			XK_F3,		            spawn,		SHCMD("displayselect") },
        { MODKEY,			XK_space,	            zoom,		{0} },
        { MODKEY|ShiftMask,		XK_space,	            togglefloating,	{0} },

};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
    /* click                event mask      button          function        argument */
    { ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
    { ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
    { ClkWinTitle,          0,              Button2,        zoom,           {0} },
    { ClkStatusText,        0,              Button1,        sigdwmblocks,   {.i = 1} },
    { ClkStatusText,        0,              Button2,        sigdwmblocks,   {.i = 2} },
    { ClkStatusText,        0,              Button3,        sigdwmblocks,   {.i = 3} },
    { ClkStatusText,        0,              Button4,        sigdwmblocks,   {.i = 4} },
    { ClkStatusText,        0,              Button5,        sigdwmblocks,   {.i = 5} },
    { ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
    { ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
    { ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
    { ClkTagBar,            0,              Button1,        view,           {0} },
    { ClkTagBar,            0,              Button3,        toggleview,     {0} },
    { ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
    { ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
    { ClkTagBar,	    0,              Button4,	    shiftview,	    {.i = -1} },
    { ClkTagBar,    	    0,	            Button5,	    shiftview,	    {.i = 1} },
};