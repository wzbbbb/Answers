#!/bin/sh -x
# Mar. 18th, 2004
# ORSYP Software Inc.
# Zhibing Wang
############################################
############################################


######################
# Variables
######################
Conf=DuMaint.conf
FoundList=DuFound.log
temp=temp$$
NewInstall=""
DiffResult=DiffResult.log
ComNom=
log=DuMaintLog
FileLocation=
MgrLocation=
NumberLines=
Mgrdir=

######################
# Detecting/Creating Configuration files
######################
STEP0 () {
rm -f $FoundList 2> /dev/null
touch $FoundList
if [ -f $Conf ] ; then
	NewInstall="no"
else
	NewInstall="yes"
fi

if [ NewInstall="yes" ] ; then
	touch $Conf
fi
}
######################
# Search $U Company and populate the file 
######################
STEP1 () {
find / -name uxsetenv > $temp
NumberLines=`wc -l $temp`
i=1
while i -le $NumberLines; do  
	FileLocation='sed -n "${i}p" $temp'	#name+dir
	MgrLocation=`grep 'UXMGR=' $FileLocation | cut -c7-` #dir
	Mgrdir=`dirname $FileLocation`
	if [ $Mgrdir = $MgrLocation ] ; then
		echo "$Mgrdir" >> $FoundList #Found a $U	
	fi
done
}

######################
# Comparing the two files and send out the results
######################
STEP2 () {
if [ $NewInstall = "yes" ] ; then
	cp $FoundList $Conf
	mail -s "Notice: First run on `date`" zwa@orsyp.com < $Conf
else
	diff $Conf $FoundList > $DiffResult
	if [ `cat $DiffResult |wc -l` -ne 0 ] ; then
		mail -s "Notice: New $U found on `date`" zwa@orsyp.com < $DiffResult
	fi
fi
}

######################
# Main 
######################
STEP0
STEP1
STEP2
