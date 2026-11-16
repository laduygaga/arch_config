# Clone & Edit mangobar.c:
git clone https://github.com/mangowm/mangobar.git /tmp/mangobar-build
cd /tmp/mangobar-build

# Change ZWLR_LAYER_SURFACE_V1_ANCHOR_TOP to ZWLR_LAYER_SURFACE_V1_ANCHOR_BOTTOM in mangobar.c:
sed -i 's/ZWLR_LAYER_SURFACE_V1_ANCHOR_TOP/ZWLR_LAYER_SURFACE_V1_ANCHOR_BOTTOM/g' mangobar.c

# Build & Install:
meson setup build
ninja -C build
sudo cp build/mangobar /usr/local/bin/mangobar

# Restart mangobar:
pkill mangobar && mangobar &
