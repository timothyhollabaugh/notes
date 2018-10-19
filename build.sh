
build() {
    echo "Entering directory $1"

    echo "#$1" > "$1/index.md"
    echo "---" >> "$1/index.md"
    echo "" >> "$1/index.md"

    fd . "$1/" -d 1 | while read line; do
        echo $line
        if [ "$line" != ".git" ]; then
            if [ -d "$line" ]; then
                echo "[$line]($line/index.md)" >> "$1/index.md"
                build $line
            else
                echo "[$line]($line)" >> "$1/index.md"
            fi
        fi
    done
}


build .

