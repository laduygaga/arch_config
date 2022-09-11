##lspconfig
npm i -g pyright or pms pyright  // python
pms gopls // golang
pms ccls // c/c++
npm install -g typescript typescript-language-server // typescript
```

:CocInstall coc-json coc-pyright coc-go
### fix coc-ccls 
```
set -x
existing=~/.config/coc/extensions/node_modules/coc-ccls/node_modules/ws/lib/extension.js
missing=~/.config/coc/extensions/node_modules/coc-ccls/lib/extension.js
if [[ -e "$existing" && ! -e "$missing" ]]; then
  mkdir -p "$(dirname "$missing")"
  ln -s "$existing" "$missing"
fi
set +x
```
**or**
cd ~/.config/coc/extensions/node_modules/coc-ccls
mkdir lib
cd lib
ln -s ../node_modules/ws/lib/extension.js ./extension.js
