Descripcion :
    Este script recorre todo los itmes publicados por un cliente y devuelve
    un archivo log con los siguientes campos.
    'id' del item, 'title' del item,'category_id' donde esta publcado,
    'name' de la categoria."
    el archivo log creado va a tener de nombre del seller_idLog.log
    en caso de exitir un archivo con el mismo nombre va a ser
    sobrescrito.

Forma de ejecucion:
    ./lsitarItems.sh  <id> <site_id>
    en caso de queres pasar mas id y sitios
    ./lsitarItems.sh  <id> <site_id> <id> <site_id>" 
    Ejecutar ayuda
    ./lsitarItems.sh -h
    ./lsitarItems.sh -?
    ./lsitarItems.sh --help"
    