/*Составьте запрос, который выведет имя вида с наименьшим id. 
Результат будет соответствовать букве «М».*/

SELECT type_name
FROM species_type
GROUP BY type_id
ORDER BY type_id
LIMIT 1;

--Answer: человек

/*Составьте запрос, который выведет имя вида 
с количеством представителей более 1800. 
Результат будет соответствовать букве «Б».*/

SELECT species_name
FROM species
WHERE species_amount > 1800
ORDER BY species_name;

--Answer: роза

/*Составьте запрос, который выведет имя вида, 
начинающегося на «п» и относящегося к типу 
с type_id = 5. Результат будет соответствовать 
букве «О».*/

SELECT species_name
FROM species
WHERE species_name LIKE 'п%' AND type_id = 5;

--Answer:подсолнух

/*Составьте запрос, который выведет имя вида, 
заканчивающегося на «са» или количество 
представителей которого равно 5. 
Результат будет соответствовать букве В.*/

SELECT species_name
FROM species
WHERE species_name LIKE '%са' AND species_amount = 5;

--Answer: лиса

/*Составьте запрос, который выведет имя вида, 
появившегося на учете в 2023 году. 
Результат будет соответствовать букве «Ы».*/

SELECT DISTINCT to_char(date_start,'YYYY'), species_name
FROM species
WHERE EXTRACT(YEAR FROM date_start) = 2023;

--Answer: обезьяна

/*Составьте запрос, который выведет названия 
отсутствующего (status = absent) вида, 
расположенного вместе с place_id = 3. 
Результат будет соответствовать букве «С».*/

SELECT s.species_name
FROM species s
JOIN species_in_places sp ON s.species_id = sp.species_id
WHERE sp.place_id = 3 AND s.species_status = 'absent';
--Answer: яблоко

/*Составьте запрос, который выведет название вида, 
расположенного в доме и появившегося в мае, 
а также и количество представителей вида. 
Название вида будет соответствовать букве «П».*/

SELECT s.species_name, s.species_amount
FROM species s 
JOIN species_in_places sp
ON s.species_id=sp.species_id
JOIN places p
ON sp.place_id=p.place_id
WHERE p.place_name='дом' AND EXTRACT(MONTH FROM s.date_start)=5;

--Answer: собака, 30

/*Составьте запрос, который выведет название вида, 
состоящего из двух слов (содержит пробел). 
Результат будет соответствовать знаку !.*/

SELECT species_name
FROM species
WHERE species_name LIKE '% %';

--Answer: голубая рыба

/*Составьте запрос, который вывdtедет имя вида, 
появившегося с малышом в один день. 
Результат будет соответствовать букве «Ч».*/

SELECT s2.species_name
FROM species s2
WHERE DATE(s2.date_start) = 
(SELECT DATE(s1.date_start)
 FROM species s1
 WHERE s1.species_name='малыш'
) AND s2.species_name != 'малыш';
     
--Answer: кошка

/*Составьте запрос, который выведет название вида, 
расположенного в здании с наибольшей площадью. 
Результат будет соответствовать букве «Ж».*/

SELECT *
FROM places;

SELECT s.species_name
FROM species s
JOIN species_in_places sp ON s.species_id = sp.species_id
JOIN (
  SELECT place_id
  FROM places
  WHERE place_name = 'дом' OR place_name = 'сарай'
  ORDER BY place_size DESC
  LIMIT 1
) max_size_indoor_place ON sp.place_id = max_size_indoor_place.place_id;

--Answer: лошадь

/*Составьте запрос/запросы, которые найдут 
название вида, относящегося к 5-й по численности 
группе проживающей дома. 
Результат будет соответствовать букве «Ш».*/

SELECT s.species_name
FROM species s
JOIN species_in_places sp ON s.species_id = sp.species_id
JOIN places p ON sp.place_id = p.place_id
WHERE p.place_name = 'дом' -- Замените 'дом' на имя конкретного дома, если необходимо
ORDER BY s.species_amount DESC
LIMIT 1 OFFSET 4;

--Answer: попугай

/*Составьте запрос, который выведет сказочный вид 
(статус fairy), не расположенный ни в одном месте. 
Результат будет соответствовать букве «Т».*/

SELECT s.species_name
FROM species s
WHERE s.species_status = 'fairy'
AND species_id NOT IN
 (
 	SELECT sp.species_id
	FROM species_in_places sp
 );
 
 --Answer: единорог
 
 --Секретное послание: "ты все можешь!"
