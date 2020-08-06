#!/bin/bash

if [[ "${#}" == 0 || "${#}" > 2 || "${1}" == "-h" || "${1}" == "--help" ]]; then
  echo "Usage: ${0} [Base Info File] [Rule File]"
  echo -e "Generate Passwords Based on Rules by hashcat\n"
  echo "Examples:"
  echo "  ${0} base.txt"
  echo -e "  ${0} base.txt /usr/share/hashcat/rules/dive.rule\n"
  echo -e "  \$ cat base.txt\n    admin\n    zhangsan\n"
  echo -e "  \$ ls /usr/share/hashcat/rules/"
  exit
fi

base_info_file="${1}"
if [ -z "${2}" ]; then
  rule_file="/usr/share/hashcat/rules/dive.rule"
fi

# Generate origin dict
hashcat --stdout "${base_info_file}" -r "${rule_file}" -o /tmp/hashcat_tmp0.txt
# Filter bad character
strings /tmp/hashcat_tmp0.txt > /tmp/hashcat_tmp1.txt
# Deduplication
sort -u /tmp/hashcat_tmp1.txt > passwds.txt
# Echo dict count
echo -n "Dict Count: "
wc -l passwds.txt
# Remove tmp file
rm /tmp/hashcat_tmp0.txt /tmp/hashcat_tmp1.txt