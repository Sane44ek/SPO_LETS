#!/bin/bash

#check input arguments
if (($# == 0)); then
  echo "Pls write smth"
  exit 1
fi

#записываем входную строку в массив
while read -r -n 1 c; do
  array+=("$c")
done <<<$1

#найдём минимальный и максимальный члены
min=${array[0]}
index_min=0
max=${array[0]}
index_max=0
#счётчик нулей нужен, так как при n-1 нулях у нас будет особое поведение в функции
#(нужно будет найти единственный элемент не равный нулю и поставить его в конец)
zero_counter=0
if (( ${array[0]} == 0 )); then
  zero_counter=$(($zero_counter + 1))
fi
for ((i = 1; i < $((${#array[@]} - 1 )); i++)); do
  if ((${array[$i]} < $min)); then
    min=${array[$i]}
    index_min=$i
  fi
  if ((${array[$i]} > $max)); then
    max=${array[$i]}
    index_max=$i
  fi
  if (( ${array[$i]} == 0 )); then
    zero_counter=$(( $zero_counter + 1 ))
  fi
done

#находим результат
#для случая с n-1 нулями мы сначала выписываем все нули, а потом число не равное нулю
if (( $zero_counter == $((${#array[@]} - 2)) )); then
  result="["
    for ((i = 0; i < ${#array[@]}; i++)); do
      if (( $i == $index_max)); then
        continue
        fi
        result=$result${array[$i]}
    done
    result=$result$max", "$index_max", "$((${#array[@]} - 1))]"]"
#для остальных ситауций мы сначала выписываем минимальный
#из всех элементов, а затем все элементы помимо него
else
  result="["$min
  for ((i = 0; i < ${#array[@]}; i++)); do
    if (( $i == $index_min)); then
      continue
      fi
      result=$result${array[$i]}
  done
  result=$result", "$index_min", 0]"
fi

echo ${result}
exit 0
