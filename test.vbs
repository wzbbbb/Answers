wscript.echo "helo"
dim strname 'Define the variable
strname = InputBox("Enter your name:") 'Get the name
wscript.echo "helo" & strname ' show the name entered 

Option Explicit

dim birthday, AgeInSecond

'get the user's birthday
birthday = inputbox("Please enter your data of birth:")
