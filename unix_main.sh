#Version 1.0  20141223 update for runing on linx server and serverlist define

echo "
*******************************************************************************
*                                                                             *
*                                                                             *
*  Welcome to Unix team script center                                         *
*  before select other subject please use 4 to create mutual trus             *
*  please input the subject number which you want to run                      *
*                                                                             *
*  1.get server info  before change                                           *
*  2.change passwd on all server                                              *
*  3.get HDD info from all server                                             *
*  4.create  mutual trust                                                     *
*  5.run batch command on romote server                                       *
*  6.run batch script on romote server                                        *
*                                                                             *
*                                                                             *
*******************************************************************************
"
#!/bin/bash
function MAIN
{
export SVERDIR="/home/script/server.lst"
export HDDSVERDIR="/home/script/HDDserver.lst"
export LOGDIR="/home/script/log"
export SCRIPTDIR="/home/script/bin"
export USER=`whoami`

if [ "$USER" == "root" ]
then
    echo "please don't use root user to run"
exit
else
    echo "now use $USER to run" 
fi

echo "please input which serverlist you want use( press enter will use default /home/script/server.lst):"
read list
if [ "$list" == "" ]
then
    echo  "now server list is  $SVERDIR "
else 
    export  SVERDIR=`echo "$list"` 
    echo  "now server list is  $SVERDIR "
fi


echo "please input subject Num:"
read num

case $num in
1) echo "start get server info"
         INFOAIX;;

2) echo "start change passwd"
         CHANGEPW;;
         
3) echo "start get HDD info:
 please update HDDserver.lst file (default file:$HDDSVERDIR)"
         HDDINFO;;
         
4) echo "start create mutual trust"
         SSH;;
         
5) echo "start batch command on romote server"
         BATCHJOB;; 
         
6) echo "start run batch script on romote server"
         BATCHSCRIPT;;      
         
*) echo "not correct input"
        MAIN;; 
esac    
}

function INFOAIX
{
echo "please input which server you want run( press enter will run on all server):"
read host

if [ "$host" == "" ]
then 
    for i in `cat $SVERDIR`
    do
      ssh $i 'date'
      if [ $? -eq 0 ]
        then
            echo -e "/n =======start get sysinfo  on $i ==========="
            scp $SCRIPTDIR/getsysinfo.sh  $USER@$i:/home/$USER
            ssh $i 'sudo  /home/$USER/getsysinfo.sh' >> $LOGDIR/`date +%Y%m%d`allsysinfo.$i.log
            ssh $i 'oslevel -s'  >> $LOGDIR/`date +%Y%m%d`mainsysinfo.$i.log
            ssh $i 'sudo instfix -i|grep ML'  >> $LOGDIR/`date +%Y%m%d`mainsysinfo.$i.log
            ssh $i 'sudo emgr -l'  >> $LOGDIR/`date +%Y%m%d`mainsysinfo.$i.log
            ssh $i 'sudo bootlist -m normal -o' >> $LOGDIR/`date +%Y%m%d`mainsysinfo.$i.log
            ssh $i 'ps -ef |grep -i tsm' >> $LOGDIR/`date +%Y%m%d`mainsysinfo.$i.log
            ssh $i 'ps -ef |grep -i itm' >> $LOGDIR/`date +%Y%m%d`mainsysinfo.$i.log
            ssh $i 'df -m' >>$LOGDIR/`date +%Y%m%d`mainsysinfo.$i.log
        else
            echo "can't reach $i,please check by errlog"
        continue
       fi
    done
    echo "*********log path: $LOGDIR/`date +%Y%m%d`allsysinfo.$i.log**********"
    echo "*********log path: $LOGDIR/`date +%Y%m%d`mainsysinfo.$i.log**********"
else
    for i in `echo $host`
    do
      ssh $i 'date'
      if [ $? -eq 0 ]
        then
            echo -e "/n =======start get sysinfo  on $i ==========="
            scp $SCRIPTDIR/getsysinfo.sh  $USER@$i:/home/$USER
            ssh $i 'sudo  /home/$USER/getsysinfo.sh' >> $LOGDIR/`date +%Y%m%d`allsysinfo.$i.log
            ssh $i 'oslevel -s'  >> $LOGDIR/`date +%Y%m%d`mainsysinfo.$i.log
            ssh $i 'sudo instfix -i|grep ML'  >> $LOGDIR/`date +%Y%m%d`mainsysinfo.$i.log
            ssh $i 'sudo emgr -l'  >> $LOGDIR/`date +%Y%m%d`mainsysinfo.$i.log
            ssh $i 'sudo bootlist -m normal -o' >> $LOGDIR/`date +%Y%m%d`mainsysinfo.$i.log
            ssh $i 'ps -ef |grep -i tsm' >> $LOGDIR/`date +%Y%m%d`mainsysinfo.$i.log
            ssh $i 'ps -ef |grep -i itm' >> $LOGDIR/`date +%Y%m%d`mainsysinfo.$i.log
            ssh $i 'df -m' >>$LOGDIR/`date +%Y%m%d`mainsysinfo.$i.log
         else
            echo "can't reach $i,please check by errlog"
         continue
       fi
    done
    echo "*********log path: $LOGDIR/`date +%Y%m%d`allsysinfo.$i.log**********"
    echo "*********log path: $LOGDIR/`date +%Y%m%d`mainsysinfo.$i.log**********"
fi
}

function HDDINFO
{
echo "========================`date`===================="  > $LOGDIR/`date +%Y%m%d`hd_log.txt
echo "please input hostname ( press enter will run by file:$HDDSVERDIR):"
read host

if [ "$host" == "" ]
   then 
       for i in `cat $HDDSVERDIR`
          do
            ssh $i 'date'
            if [ $? -eq 0 ]
               then
                    echo "start get $i info"
                    echo "======================$i=========================="  >> $LOGDIR/`date +%Y%m%d`hd_log.txt
                    scp $SCRIPTDIR/hd_check.sh $USER@$i:/home/$USER
                    ssh $i 'sh /home/$USER/hd_check.sh' >> $LOGDIR/`date +%Y%m%d`hd_log.txt
                else
                    echo "can't reach $i"
                    echo "$i:total:NULL GB" >> $LOGDIR/`date +%Y%m%d`hd_log.txt
                    continue
             fi
          done
else
    for i in `echo $host`
       do
          ssh $i 'date'
            if [ $? -eq 0 ]
               then
                   echo "start get $i info"
                   echo "======================$i=========================="  >> $LOGDIR/`date +%Y%m%d`hd_log.txt
                   scp $SCRIPTDIR/hd_check.sh $USER@$i:/home/$USER
                   ssh $i 'sh /home/$USER/hd_check.sh' >> $LOGDIR/`date +%Y%m%d`hd_log.txt
               else
                   echo "can't reach $i"
                   echo "$i:total:NULL GB" >> $LOGDIR/`date +%Y%m%d`hd_log.txt
                   continue
             fi
       done
fi
echo "*********log path: $LOGDIR/`date +%Y%m%d`hd_log.txt**********"
}

function CHANGEPW
{
echo "please input user name who need change passwd:"
read username 
echo "please input new passwd:"
read passwd

echo "please input which server you want run(run on all server press enter):"
read host

if [ "$host" == "" ]
then 
    for i in `cat $SVERDIR`
    do
      ssh $i 'date'
      if [ $? -eq 0 ]
        then
            echo  "\n ========start change $USER on $i passwd=========== "
            echo $username:$passwd| ssh $i 'sudo chpasswd -c'
            if [ $? -eq 0 ]
               then
                    echo "********successful changepwd on $i********"
               else
                    echo "@@@@@@@@unable changepwd on $i@@@@@@@@" 
               continue
            fi
        else
            echo "can't reach $i,please check by errlog"
        continue
      fi
    done
else
    for i in `echo $host`
    do
      ssh $i 'date'
      if [ $? -eq 0 ]
        then
            echo "start change $USER on $i passwd"
            echo $username:$passwd| ssh $i 'sudo chpasswd -c'
            if [ $? -eq 0 ]
               then
                    echo "successful changepwd on $i"
               else
                    echo "unable changepwd on $i" 
               continue
            fi
        else
           echo "can't reach $i,please check by errlog"
       continue
       fi
     done
fi
}

function SSH
{
echo "please input user who you want help ceate mutual trust:"
read usr

echo "please input which server you want run(run on all server press enter):"
read host

sudo chmod -R 777 /home/$usr

if [ "$host" == "" ]
then 
    for i in `cat $SVERDIR`
    do
      echo  "\n =================$i====================" 
      ssh $i 'date' > /dev/null 2>&1
      if [ $? -eq 0 ]
        then
#            ssh $i sudo ls -l /home/$usr/.ssh/authorized_keys  >/dev/null 2>&1
#            if [ $? -eq 0 ]
#              then
#                  echo "$i mutral trust has been created"
#              else
                  echo "start create mutual trust on $i"
                  ssh $i sudo mkdir -p /home/$usr/.ssh  > /dev/null 2>&1
                  ssh $i sudo chmod -R 777 /home/$usr 
                  scp /home/$usr/.ssh/id_[rd]sa.pub  $i:/home/$usr/.ssh/authorized_keys
                  scp /home/$usr/.ssh/sshd_cmd_logger  $i:/home/$usr/.ssh/sshd_cmd_logger
                  ssh $i ls -l /home/$usr/.ssh/authorized_keys >/dev/null 2>&1
                  if [ $? -eq 0 ]
                    then
                        echo "copy publickey sucessful"
                    else
                        echo "copy publickey failed"
                    continue
                  fi
            ssh $i sudo chown -R $usr:szadmin /home/$usr
            ssh $i sudo chmod -R 755 /home/$usr
#       fi
    else 
        echo "can't reach $i,please check by errlog"
        continue
    fi
    done
else 
    for i in `echo $host`
    do
    echo  "\n =================$i====================" 
      ssh $i 'date' > /dev/null 2>&1
      if [ $? -eq 0 ]
        then
#            ssh $i sudo ls -l /home/$usr/.ssh/authorized_keys  >/dev/null 2>&1
#            if [ $? -eq 0 ]
#              then
#                  echo "$i mutral trust has been created"
#              else
                  echo "start create mutual trust on $i"
                  ssh $i sudo mkdir -p /home/$usr/.ssh  > /dev/null 2>&1
                  ssh $i sudo chmod -R 777 /home/$usr 
                  scp /home/$usr/.ssh/id_[rd]sa.pub  $i:/home/$usr/.ssh/authorized_keys
                  scp /home/$usr/.ssh/sshd_cmd_logger  $i:/home/$usr/.ssh/sshd_cmd_logger
                  ssh $i ls -l /home/$usr/.ssh/authorized_keys >/dev/null 2>&1
                  if [ $? -eq 0 ]
                    then
                        echo "copy publickey sucessful"
                    else
                        echo "copy publickey failed"
                    continue
                  fi
                ssh $i sudo chown -R $usr:szadmin /home/$usr
                ssh $i sudo chmod -R 755 /home/$usr
#             fi
      else 
          echo "can't reach $i,please check by errlog"
          continue
      fi
    done
fi
    sudo chmod -R 755 /home/$usr/*
    sudo chmod -R 700 /home/$usr/.ssh/*
    sudo chmod -R 755 /home/$usr/.ssh/sshd_cmd_logger
}

function  BATCHJOB
{
echo "please input command what you want run:"
read command

echo "please input which server you want run(run on all server press enter):"
read host

if [ "$host" == "" ]
then 
   for i in `cat $SVERDIR`
   do
     ssh $i 'date'  > /dev/null 2>&1
     if [ $? -eq 0 ]
        then
            echo  "\n ================start run $command on $i============= " |tee -a $LOGDIR/`date +%Y%m%d`command_log.txt 
            ssh $i $command >> $LOGDIR/`date +%Y%m%d`command_log.txt 2>&1
            if [ $? -eq 0 ]
               then
                   echo "successful run command on $i"
               else
                   echo "unable run command on $i" 
               continue
            fi
        else
            echo "can't reach $i,please check by errlog"
        continue
     fi
   done
else 
    for i in `echo $host`
    do
     ssh $i 'date'
     if [ $? -eq 0 ]
        then
            echo -e "/n ================start run $command on $i============= " |tee -a $LOGDIR/`date +%Y%m%d`command_log.txt
            ssh $i $command >> $LOGDIR/`date +%Y%m%d`command_log.txt 2>&1
            if [ $? -eq 0 ]
               then
                   echo "successful run command on $i"
               else
                   echo "unable run command on $i" 
               continue
            fi
        else
            echo "can't reach $i,please check by errlog"
        continue
     fi
   done
fi 
echo "log path: $LOGDIR/`date +%Y%m%d`command_log.txt"
}

function  BATCHSCRIPT
{
echo "please input script path as /home/script/bin/hd_check.sh:"
read command

echo "please input which server you want run(run on all server press enter):"
read host

if [ "$host" == "" ]
then 
   for i in `cat $SVERDIR`
   do
     ssh $i 'date'  > /dev/null 2>&1
     if [ $? -eq 0 ]
        then
            echo "\n ================start run $command on $i============= "  |tee -a $LOGDIR/`date +%Y%m%d`script_log.txt
            ssh $i "`cat $command`" >> $LOGDIR/`date +%Y%m%d`script_log.txt 2>&1
            if [ $? -eq 0 ]
               then
                   echo "successful run script on $i"
               else
                   echo "unable run script on $i" 
               continue
            fi
        else
            echo "can't reach $i,please check by errlog"
        continue
     fi
   done
   echo "log path:$LOGDIR/`date +%Y%m%d`script_log.txt"
else 
    for i in `echo $host`
    do
     ssh $i 'date'
     if [ $? -eq 0 ]
        then
            echo -e "\n ================start run $command on $i============= " |tee -a $LOGDIR/`date +%Y%m%d`script_log.txt
            ssh $i "`cat $command`" >> $LOGDIR/`date +%Y%m%d`script_log.txt 2>&1
            if [ $? -eq 0 ]
               then
                   echo "successful run command on $i"
               else
                   echo "unable run command on $i" 
               continue
            fi
        else
            echo "can't reach $i,please check by errlog"
        continue
     fi
   done
fi 
echo "log path: $LOGDIR/`date +%Y%m%d`script_log.txt"
}

MAIN
