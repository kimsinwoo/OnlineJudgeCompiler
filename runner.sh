tempdir=$(mktemp -d)
code="$1"
language="$2"
input="$3"

case "$language" in
  "java")
    echo "$code" > "$tempdir/Main.java"
    compile_cmd="javac $tempdir/Main.java"
    run_cmd="java -cp $tempdir Main"
    ;;
  "c")
    echo "$code" > "$tempdir/main.c"
    compile_cmd="gcc -o $tempdir/main $tempdir/main.c"
    run_cmd="$tempdir/main"
    ;;
  "cpp")
    echo "$code" > "$tempdir/main.cpp"
    compile_cmd="g++ -o $tempdir/main $tempdir/main.cpp"
    run_cmd="$tempdir/main"
    ;;
  "csharp")
    echo "$code" > "$tempdir/main.cs"
    compile_cmd="mcs -out:$tempdir/main.exe $tempdir/main.cs"
    run_cmd="mono $tempdir/main.exe"
    ;;
  "python")
    echo "$code" > "$tempdir/main.py"
    compile_cmd=""
    run_cmd="python3 $tempdir/main.py"
    ;;
  *)
    echo "Unsupported language: $language"
    exit 1
    ;;
esac

if [ -n "$compile_cmd" ]; then
  eval "$compile_cmd"
  if [ $? -ne 0 ]; then
    echo "Compilation failed"
    rm -rf "$tempdir"
    exit 1
  fi
fi

output=$(echo "$input" | eval "$run_cmd")
if [ $? -ne 0 ]; then
  echo "Execution failed"
  rm -rf "$tempdir"
  exit 1
fi

echo "$output"

rm -rf "$tempdir"
