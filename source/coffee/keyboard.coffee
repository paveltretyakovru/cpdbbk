Boom = require('./boom.js');

ready = ( fn ) ->
	if document.readyState != 'loading' then fn() else document.addEventListener 'DOMContentLoaded' , fn

# Ожидаем загрузки страницы
ready ->
	keyboardObj = document.getElementById 'keyboard'

	# Ожидаем загрузки клавиатуры
	keyboardObj.addEventListener 'load' , ->
		# Получаем контент клавиатуры
		keyboardDoc = keyboardObj.contentDocument;
		# Собираем клавиши клавиатуры
		keys 		= keyboardDoc.querySelectorAll '.key'

		console.log 'Keyboard loaded' , keys[0]
		Boom keyboardDoc
