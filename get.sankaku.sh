#!/bin/bash

# ���������
uag="Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:61.0) Gecko/20100101 Firefox/61.0"

# �������� ����������
if [ ! "$2" = "" ]
then
  tags=$1
  savedir=$2
else
  if [ ! "$1" = "" ]
  then
    tags=$1
    savedir=$1
  else
    echo �������������:
    echo `basename $0` ���� \[�������\]
    exit 1
  fi
fi

# ������� ��� �������
if [ ! -d $savedir ]
then
  echo Creating $savedir
  mkdir "$savedir"
fi
echo Entering $savedir
cd "$savedir"

# ��������� ������ � ������

if [ -f ~/.config/boorulogins.conf ]
then
  . ~/.config/boorulogins.conf
else
  echo ���� � ������� ��� ����������� �� ������!
  echo �������� ���� ~/.config/boorulogins.conf � ��������� � ���� ��������� ������:
  echo sanlogin=��� �����
  echo sanpass=��� ������
  exit 5
fi

# ��������� (���� � sankaku.txt)
# ��������� appkey
username=`echo $sanlogin| tr [:upper:] [:lower:]`
appkey=`echo -n sankakuapp_${username}_Z5NE9YASej|sha1sum|cut -d" " -f1`
echo Logging in...
curl -s -c sankaku.txt -d "user[name]=${sanlogin}&user[password]=${sanpass}&appkey=${appkey}" https://capi-beta.sankakucomplex.com/user/authenticate.json > sanlogin.txt

# �������� ������
checklog=`cat sanlogin.txt |grep 'success":false'|wc -l`
if [ $checklog -ge 1 ]
then
  echo ERROR: ��������� ����� � ������
  rm sanlogin.txt
#  exit 2
else
  echo OK
fi

# �������� ������� ������
if [ -e get.sankaku.txt ]
then
  rm -f get.sankaku.txt
fi

# �������� �� ��� ���, ���� � ������ ����� 0 ������
pagenum=1
picnum=1

until [ $picnum -eq 0 ]
do
  # ��������� ������
  echo Page $pagenum
  curl -# -b sankaku.txt "https://capi-beta.sankakucomplex.com/post/index.json?tags=$tags&page=$pagenum&limit=100" --referer "https://chan.sankakucomplex.com/" -A "$uag" | pcregrep --buffer-size=1M -o -e 'file_url\":\"[^\"]+'|sed -e 's#\\u0026#\&#g' -e 's#file_url":"#https:#g' > tmp.sankaku.txt
  picnum=`cat tmp.sankaku.txt|wc -l`
  if [ $picnum \> 0 ]
  then
    cat tmp.sankaku.txt >> get.sankaku.txt
    pagenum=`expr $pagenum + 1`
  fi
done;

# �������� ����������
postcount=`cat get.sankaku.txt|wc -l`

if [ $postcount -eq 0 ]
then
  echo �� ��������� "$tags" ������ �� �������.
  rm -f tmp.sankaku.txt sankaku.txt
  exit 3
else
  echo �� ��������� "$tags" ������� ������: $postcount
fi

#wget --random-wait --no-check-certificate -nc -i get.sankaku.txt -U "$uag"
aria2c --allow-overwrite=true --auto-file-renaming=false --conditional-get=true --remote-time -x10 -s10 -i get.sankaku.txt

# ������� �� �����
rm -f tmp.sankaku.txt sankaku.txt sanlogin.txt
