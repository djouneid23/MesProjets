server {
	listen 80;
	server_name monsite.com www.monsite.com;
	
	root /var/www/monsite.com;
	index index.php index.html index.html;
	location / {
		try_files $uri $uri/ = 404;
		}
	
	location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php8.3-fpm.sock;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
   	 }
	
	location ~ /\.ht {
        deny all;
   	 }
	}
