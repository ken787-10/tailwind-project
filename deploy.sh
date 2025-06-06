#!/bin/bash

# Xserver自動アップロードスクリプト
echo "🚀 Xserverへ自動デプロイ開始"

# Xserver設定
XSERVER_HOST="sv10823.xserver.jp"
XSERVER_USER="admin@marslink.co.jp"
XSERVER_PASS="ss560320"
<<<<<<< HEAD
REMOTE_PATH="/home/ken787-10/marslink.co.jp/public_html/"

echo "📥 最新の変更を取得中..."
git pull origin main

echo "🔨 CSSをビルド中..."
=======
REMOTE_PATH="/marslink.co.jp/public_html/"

echo "📦 最新の変更を取得中..."
git pull origin main

echo "🎨 CSSをビルド中..."
>>>>>>> 86a5292a44ba1811e4a315871a60b1c8320223d0
if [ -f "package.json" ]; then
    npm run build-css 2>/dev/null || echo "CSSビルドをスキップ"
fi

echo "📁 アップロード対象ファイルを確認中..."
ls -la *.html css/ js/ 2>/dev/null

echo "🌐 Xserverにアップロード中..."
lftp -c "
set ftp:ssl-allow no
set ftp:list-options -a
set ftp:passive-mode on
open ftp://$XSERVER_USER:$XSERVER_PASS@$XSERVER_HOST
lcd $(pwd)
cd $REMOTE_PATH
mput *.html
mirror --reverse --delete --verbose css/ css/
<<<<<<< HEAD
mirror --reverse --delete --verbose js/ js/
mirror --reverse --delete --verbose assets/images/ assets/images/ || echo '画像フォルダなし'
=======
mirror --reverse --delete --verbose js/ js/ || echo 'JSフォルダなし'
mirror --reverse --delete --verbose assets/images/ assets/ images/ || echo '画像フォルダなし'
>>>>>>> 86a5292a44ba1811e4a315871a60b1c8320223d0
bye
"

if [ $? -eq 0 ]; then
    echo "✅ Xserverへのデプロイ完了！"
    echo "🌐 ウェブサイト: http://marslink.co.jp"
else
    echo "❌ アップロードに失敗しました"
fi
