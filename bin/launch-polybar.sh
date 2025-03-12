#!/bin/sh

# Завершить запущенные экземпляры Polybar
pkill -x polybar

# Запуск Polybar
polybar main -r >> /tmp/polybar.log 2>&1 & disown

echo "Polybar запущен!"
