#!/bin/sh

# Получаем ID окна xmobar (только первое окно)
WIN_ID=$(xdotool search --onlyvisible --name xmobar 2>/dev/null | head -n 1)

if [ -z "$WIN_ID" ]; then
    # Если xmobar скрыт, ищем его ID (включая скрытые окна)
    WIN_ID=$(xdotool search --name xmobar 2>/dev/null | head -n 1)
    [ -n "$WIN_ID" ] && xdotool windowmap "$WIN_ID" 2>/dev/null
else
    # Если xmobar виден, скрываем его
    xdotool windowunmap "$WIN_ID" 2>/dev/null
fi

