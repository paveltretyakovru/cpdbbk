module.exports = ( elDocument ) ->
	console.log 'Satr boom function' , elDocument
	###
		# ____ CONFIGS ____ #
	###

	x_max 			= 500;			# Ширина разрбрасываемого поля
	y_max 			= 500;			# Высота рзрбрасываемого поля
	x_min 			= 0;
	y_min 			= 0;
	x_start 		= x_max / 2;	# Центр разбрасывания координата x
	y_start 		= y_max / 2;	# Центр разбрасывания координана y
	N 					= 1;					# Счетчик-идентификатор для изобр-ий
	on_line 		= 30;					# Количество рисунков в сторону оси
	svg_height 	= 30					# Высота изображений (по умолчанию)

	grow 			= true		# Изменять ли размер изображения
	grow_min 	= -1 			# Минимальный слайчайный масштаб изображения
	grow_max 	= 1.5			# Максимальный случайный масштаб изображения

	rotate 		= true		# Крутить ли предметы
	rotate_min 	= 0 		# Минимальный случайный угол разворота
	rotate_max 	= 270		# Максимальный случайны угол разворота

	# Диапозон значений для времени анимации изображений
	animtaion_time_random_min = 1;
	animation_time_random_max = 3;

	animation_delay = 0;		# задержка перед анимацией
	animation_fun 	= 'ease-out'# функция анимации
	animation_count = '1'		# повторы анимация

	# Отступ изображения от блока контейнера
	svg_margin_left  = '45%'
	svg_margin_top 	 = '45%'

	svg_class 	= 'boom-svg' # Класс контейнер для изображений c svg
	parent			= document.querySelectorAll '.container-swg'	# ID Куда будет вставлятся svg
	console.log 'Parent selector' , parent
	parent 			= parent[0]

	# Вставляемые изображения
	images  = [
			'https://upload.wikimedia.org/wikipedia/commons/3/35/Orange_question_mark.svg' 	,
			'https://upload.wikimedia.org/wikipedia/commons/a/a8/Cannabis_leaf.svg' 		,
			'https://upload.wikimedia.org/wikipedia/commons/a/a0/Circle_-_black_simple.svg' ,
			'https://upload.wikimedia.org/wikipedia/commons/8/80/BSicon_exKDSTr_lime.svg'	,
			'https://upload.wikimedia.org/wikipedia/commons/0/0d/BSicon_exDBHFa_jade.svg' 	,
			'https://upload.wikimedia.org/wikipedia/commons/4/48/BSicon_exGIPl.svg'
		];

	###
		# _____ END CONFIGS ____ #
	####

	getRandom = ( min , max ) ->
		Math.floor(Math.random() * (max - min + 1)) + min

	# Создание элемента в котором будет проиходить анимация 1 эл-а
	# @return OBJECT DIV
	createSvgDiv = ( width , height ) ->
		div = document.createElement 'div'

		div.style.width  		= width  + 'px'
		div.style.height 		= height + 'px'

		# Добавляем класс контейнер для изображений
		# определен выше
		if div.classList
			div.classList.add svg_class
		else
			div.className += ' ' + svg_class

		return div
	#____________________________________

	# Создание иозбражения с svg
	# @return OBJECT IMAGE
	createSvgImage = ( src ) ->
		image = document.createElement('img')

		# добавляем стили
		image.src 		  	 		= src
		image.style.left  	 	= svg_margin_left
		image.style.top 	 		= svg_margin_top
		image.style.position 	= 'relative'
		image.style.height 	 	= svg_height  + 'px'

		return image
	#___________________________

	# Генерация уникльного класса для изображения
	# @return STRING CLASS_NAME
	generateClass = ( x , y ) ->
		styleElement 		= document.createElement 'style'
		styleElement.type 	= 'text/css'

		id 		 = 'svg' + N

		name_class 		= id + '-class'
		name_keyframe 	= id + '-keyframe'

		# Рандомриуем разворот фигур
		deg = 0
		deg = getRandom rotate_min , rotate_max if rotate

		# Рандомируем размер фигру
		size = 1
		size = getRandom grow_min , grow_max if grow

		# Итоговый результат трансформации
		transform_val 	= 'translate('+ x + 'px , ' + y + 'px) rotate(' + deg + 'deg) scale(' + size + ')' + '; opacity: 0; display:none; } ';

		console.log 'N:' + N + '; ' + transform_val

		newStyles = document.createTextNode '' +
		'.' + name_class + '{' 			 +

		' animation:' 	 		+ name_keyframe + ' ' +
		(Math.random() * (animation_time_random_max - animtaion_time_random_min) + animtaion_time_random_min) + 's '  +
		animation_delay + 's '  +
		animation_fun 	+ ' '   +
		animation_count + '; '  +
		'animation-fill-mode: forwards;' +

		'-webkit-animation:\''  + name_keyframe + '\' ' +
		(Math.random() * (animation_time_random_max - animtaion_time_random_min) + animtaion_time_random_min) + 's '  +
		animation_delay + 's '  +
		animation_fun 	+ ' '   +
		animation_count + '; '  +
		'-webkit-animation-fill-mode: forwards;' +

		'} \n'	+

		'@-webkit-keyframes ' + name_keyframe + ' {' + '\n' +
			'from { opacity: 1 }' + '\n' +
			'50%  { opacity: 1; display:none; }' 	+ '\n' +
			'60%  { opacity: 0; display:none; }' 	+ '\n' +
			'to { -webkit-transform: ' + transform_val + '\n' +
		'}' + '\n' +
		'@keyframes ' + name_keyframe + ' {' + '\n' +
			'from { opacity: 1 }' 	+ '\n' +
			'70%  { opacity: 1; display:none; }' 	+ '\n' +
			'80%  { opacity: 0; display:none; }' 	+ '\n' +
			'to { transform: ' 		+ transform_val + '\n' +
		'}'

		# Заносим собранные стили в style элемент
		styleElement.appendChild newStyles
		document.getElementsByTagName('head')[0].appendChild styleElement

		console.log newStyles

		N++

		return name_class

	# ___ Исполнение ___
	showBoom = ->
		parent.innerHTML = ''

		# Заполняем верхнюю ось
		for number in [1..on_line]
			x 			= x_start - Math.floor( (x_max / on_line) * number )
			y 			= y_start * -1
			new_class 	= generateClass x , y
			new_div 	= createSvgDiv x_max , y_max
			new_img 	= createSvgImage images[Math.floor(Math.random()*images.length)]

			if new_img.classList
				new_img.classList.add new_class
			else
				new_img.className += ' ' + new_class

			new_div.appendChild new_img
			parent.appendChild new_div

		# Заполняем правую
		for number in [1..on_line]
			x 			= x_start
			y 			= y_start - Math.floor( (y_max / on_line) * number )
			new_class 	= generateClass x , y
			new_div 	= createSvgDiv x_max , y_max
			new_img 	= createSvgImage images[Math.floor(Math.random()*images.length)]

			if new_img.classList
				new_img.classList.add new_class
			else
				new_img.className += ' ' + new_class

			new_div.appendChild new_img
			parent.appendChild new_div

		# Заполняем нижнюю ось
		for number in [1..on_line]
			x 			= x_start - Math.floor( (x_max / on_line) * number )
			y 			= y_start
			new_class 	= generateClass x , y
			new_div 	= createSvgDiv x_max , y_max
			new_img 	= createSvgImage images[Math.floor(Math.random()*images.length)]

			if new_img.classList
				new_img.classList.add new_class
			else
				new_img.className += ' ' + new_class

			new_div.appendChild new_img
			parent.appendChild new_div

		# Заполняем левую ось
		for number in [1..on_line]
			x 			= x_start * -1
			y 			= y_start - Math.floor( (y_max / on_line) * number )
			new_class 	= generateClass x , y
			new_div 	= createSvgDiv x_max , y_max
			new_img 	= createSvgImage images[Math.floor(Math.random()*images.length)]

			if new_img.classList
				new_img.classList.add new_class
			else
				new_img.className += ' ' + new_class

			new_div.appendChild new_img
			parent.appendChild new_div

	boom = elDocument.querySelectorAll '.button-boom'

	if boom.length > 0
		for el in [0...boom.length]
			console.log 'Test boom' , boom[ el ]
			boom[el].addEventListener 'click' , ->
				console.log 'Boom!'
				showBoom()
