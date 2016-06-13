@echo off
set /p name="Enter Name:"
set /p email="Enter Email:"

ssh-keygen -t rsa -b 4096 -C "%email%"
cat .ssh/id_rsa.pub
echo "add key => https://github.com/settings/ssh"
pause

git config --global user.name "%name%"
git config --global user.email "%email%"

npm install grunt -g
npm install bower -g
gem install sass
