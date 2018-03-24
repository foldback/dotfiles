# gzippers.sh

# Create a .tar.gz archive, using `zopfli`, `pigz` or `gzip` for compression
targz() {
  local Tmpfile="${@%/}.tar"
  tar -cvf "${Tmpfile}" --exclude=".DS_Store" "${@}" || return 1

  Size=$(
    stat -f"%z" "${Tmpfile}" 2>/dev/null # macOS `stat`
    #stat -c"%s" "${Tmpfile}" 2>/dev/null # GNU `stat`
  );

  local Cmd="";
  if (( ${Size} < 52428800 )) && hash zopfli 2>/dev/null; then
    # the .tar file is smaller than 50 MB and Zopfli is available; use it
    Cmd="zopfli"
  else
    if hash pigz 2>/dev/null; then
      Cmd="pigz"
    else
      Cmd="gzip"
    fi;
  fi;

  printf "Compressing .tar ($((size / 1000)) kB) using \`${Cmd}\`…\n"
  "${Cmd}" -v "${Tmpfile}" || return 1
  [ -f "${Tmpfile}" ] && rm "${Tmpfile}"

  Zippedsize=$(
    stat -f"%z" "${Tmpfile}.gz" 2>/dev/null; # macOS `stat`
    #stat -c"%s" "${Tmpfile}.gz" 2>/dev/null; # GNU `stat`
  );

  printf "${Tmpfile}.gz ($((Zippedsize / 1000)) kB) created successfully.\n"
}

# Compare original and gzipped file size
gzcompare() {
  local Origsize=$(wc -c < "${1}")
  local Gzipsize=$(gzip -c "${1}" | wc -c)
  local Ratio=$(printf "${Gzipsize} * 100 / ${Origsize}\n" | bc -l)
  printf "orig: %d bytes\n" "${Origsize}"
  printf "gzip: %d bytes (%2.2f%%)\n" "${Gzipsize}" "${Ratio}"
}
