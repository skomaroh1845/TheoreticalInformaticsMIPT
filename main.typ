= Николай Комаров ДЗ 1

#set par(
  justify: true,
)

= Задача 1
Постройте1 машину Тьюринга, вычисляющую функцию $n arrow.r.bar$ (остаток от деления n на 5) в унарной кодировке аргументов. Оцените время вычислений на вашей машине в зависимости от n.

== Решение:
Машина едет по числу и по очереди меняет состояния в диапазоне $\{q_1, ..., q_5\}$ и единички на меченые числа в диапазоне $\{1', ..., 5'\}$. После достижения конца числа машина откатывается до ближайшей $5'$ или $\#$, по дороге заменяя меченые числа нормальными единичками. После достижения $\#$ алгоритм завершается, после достижения $5'$, все символы начиная с этого $5'$ заменяются на $\#$ и затем алгоритм завершается. Суммарно два прохода по числу - назад и вперед, сложность $О(n)$.

$sum = \{1\}$

$Gamma = \{1, \#, 1', 2', 3', 4', 5'\}$

$Q = \{q_0, q_0', q_1, ..., q_5, q_"back", q_"del", q_"f"\}$

$delta:$
- $q_0$ \# $->$ $q_0'$ \# +1 
- $q_0'$ \# $->$ $q_"f"$ \# 0 -- если пустой вход, то выходим
- $q_0'$ 1 $->$ $q_1$ 1 0 -- если вход не пустой, то меняем состояние для прохода по числу

- $q_1$ 1 $->$ $q_2$ $1'$ +1 -- проходим по числу, меняя состояния
- $q_2$ 1 $->$ $q_3$ $2'$ +1 
- $q_3$ 1 $->$ $q_4$ $3'$ +1 
- $q_4$ 1 $->$ $q_5$ $4'$ +1 
- $q_5$ 1 $->$ $q_1$ $5'$ +1 

- $q_1$ \# $->$ $q_"back"$ \# -1 -- когда дошли до конца числа, условия прерывания
- $q_2$ \# $->$ $q_"back"$ \# -1 
- $q_3$ \# $->$ $q_"back"$ \# -1 
- $q_4$ \# $->$ $q_"back"$ \# -1 
- $q_5$ \# $->$ $q_"back"$ \# -1

- $q_"back"$ $vec(1', 2', 3', 4')$ $->$ $q_"back"$ 1 -1 -- едем назад до ближайшей $5'$ или $\#$, ставим номальные 1
- $q_"back"$ $vec(5', \#)$ $->$ $q_"del"$ \# -1 -- начиная с $5'$ переключается на удаление 

- $q_"del"$ $vec(1', 2', 3', 4', 5')$ $->$ $q_"del"$ \# -1
- $q_"del"$ \# $->$ $q_"f"$ \# 0  -- когда все удалили, завершаемся





= Задача 2
Опишите машину Тьюринга, вычисляющую функцию $n, m arrow.r.bar n * m$ в унарной кодировке аргументов. Аргументы разделяются специальным символом $\$ in Gamma backslash Sigma$. Оцените время вычислений на вашей машине в зависимости от длины входа.

== Описание:
Начальная конфигурация: $\#11..1\$11..1\#$.
Пусть первое число n, а второе m.
Алгоритм машины:
0. Проверка на пустой вход.
1. Меняем единицу первого числа на \#, переходим в режим записи второго числа.
2. Машина копирует число m и приписывает результат справа, алгоритм копирования такой же как и алгоритм умножения на 2 разобраннй на занятии, символы, которые скопированы, помечаются, чтобы на следующей итерации число не удваивалось целиком, а копировался только хвост.
3. После копирования машина переходит в новое состояние и возвращается в начало числа n.
4. Цикл повторяется, пока от числа n ничего не останется.
5. Затем машина приводит все технически меченные символы к 1, убирает разделитель и завершается.

Для копирования числа используем алгоритм умного умножения из задачи 3 со сложностью $O(m log m)$. Таких копирований n штук, плюс на каждой итерации копирования надо доехать до правого хвоста единичек, так как в левой части правого числа будет поле "отработавших" уже скопированных меченых единичек, максимальная длина поля меченых единичек $m*(n-2)$. Таким образом общая сложность $O(n * (m log m + m*n) )$.


= Задача 3
Опишите машину Тьюринга, за время $O(n log n)$:

- a) преобразующую унарную запись числа $n$ в бинарную;
- b) преобразующую бинарную запись числа $n$ в унарную;
- c) вычисляющую функцию $n arrow.r.bar 2n$ в унарной кодировке.

== Решение а):
(разбирали на занятии)
1. Головка едет по унарной записи числа и удаляет каждую вторую встретившуюся единицу и имеет два состояния, которые характеризуют четность удаленной единицы.
2. Через какой-нибудь разделитель, головка записывает слева от унарной записи числа 1 или 0 в зависимости от четности последней удаленной единицы перед встречей с \# (1 если нечетное состояние, 0 если четное состояние).
3. После записи, машина возвращается удалять каждые вторые единички, на последующих итерация записывая ответ слева от строющейся бинарной записи числа. Повторяются наши 1-3 пока не пропадут все вторые единички в числе.
4. После окончания бинарной записи, алгоритм зачищает унарную.

Сложность: удаление единичек -- $O(n)$, записть бинарной части -- $O(log n)$, таким образом общая сложность $O(n log n)$.


== Решение b)
1. Вычитаем 1 из записи бинарного числа.
2. Записываем 1 перед бинарным числом слева через спец разделитель.
3. Двигаем бинарную запись числа вправо. Повтряем шаги 1-3 пока бинарное чило не превратиться в нули.
4. После обнуления бинарного числа, зчищаем лишнееи завершаемся.

Сложность: вычитание единицы - $O(log n)$, запись перед бинарником единицы - константа, сдвиг бинарной записи - $O(log n)$, итераций n штук, таким образом общая сложность $O(n log n)$.


== Решение c)
1. Перегоняем унарную запись в бинарную.
2. Дописываем 0 справа от бинарной записи.
3. Перегоняем бинарь обратно в унарь. Profit!

Общая сложность $O(n log n)$.