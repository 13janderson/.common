read_env(){
  file=$1
  echo "reading $file"
  # Load environment variables if .env exists
  if [[ -f $file ]]; then
    cat $file | while IFS= read -r env; do
    key=$(echo $env | sed -E "s/(.*)=.*/\1/")
    value=$(echo $env | sed -E "s/$key=//")
    export $key=$value
  done
  fi
}

read_env "$HOME/.env" > /dev/null 2>&1
read_env ".env" > /dev/null 2>&1
