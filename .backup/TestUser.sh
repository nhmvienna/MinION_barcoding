## set up a test user expriring on 2021-10-26

## generate testuser name
PRE=$1
NAME='test_'${PRE}

## set SUPERSAFE password
PW='test123!!'

## generate user that expires next week
useradd -m ${NAME} -e "2021-11-23"

## set password
echo ${PW} | passwd ${NAME} --stdin

#sudo userdel -rf $name
