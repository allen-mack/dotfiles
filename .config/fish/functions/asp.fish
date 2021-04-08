# Change the AWS_PROFILE env variable to use a different AWS account

function asp --description "AWS Switch Profile"

  # Read the .aws/credentials file in the home directory and grep out all the lines 
  # that are surrounded in square brackets.  Then remove the brackets to make them
  # easier to read.
  set -l accounts (grep "^\\[" ~/.aws/credentials | sed 's/\[//g; s/]//g')
  set -l numAccounts (count $accounts)

  # Print out a menu of choices.
  for i in (seq 1 $numAccounts)
    printf '%2d) %s\n' $i $accounts[$i]
  end 

  # Read in the user's selection.
  read -l -p 'echo "Select account by number: "' choice

  # Validation and error handling
  if test "$choice" = ""
    return 0
  end

  if string match -q -r '^\d+$' $choice
    if test $choice -ge 1 -a $choice -le $numAccounts
      # printf 'You have chosen %s' $accounts[$choice]
      printf '\n'
    else
      echo Error: expected a number between 1 and $numAccounts, got \"$choice\"
      return 1
    end
  else
    echo Error: expected a number between 1 and $numAccounts, got \"$choice\"
    return 1
  end

  # Set the AWS_PROFILE environment variable and let the user know.
  set -x AWS_PROFILE $accounts[$choice]
  echo AWS_PROFILE is now set to $accounts[$choice]

end
