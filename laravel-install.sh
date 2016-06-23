#############################################################
# Install script for Laravel 5.1 on Ubuntu 
#############################################################

#############################################################
# Instructions to run the script
#############################################################
# sudo chmod +x laravel-install.sh
# ./laravel-install.sh

#############################################################
# Updating system Repo 
#############################################################
echo "Updating System repo"
sudo apt-get -y update

#############################################################
# Installing system dependencies 
#############################################################
echo "Installing system dependencies"
sudo apt-get -y install git unzip curl vim

#############################################################
# Installing PHP dependencies 
#############################################################
echo "Installing PHP dependencies"
sudo apt-get -y install php5-cli php5-mysql

echo "installing composer"
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=. --filename=composer

#############################################################
# Downloading Laravel from Github
#############################################################
echo "Downloading Laravel from Github"
sudo wget -O laravel.zip https://codeload.github.com/laravel/laravel/zip/master

#############################################################
# Unzip the Zip file 
#############################################################
echo "Unzip the laravel in the current folder"
unzip laravel.zip -d .

#############################################################
# Updating the dependencies and creating a vendor folder
#############################################################
echo "Updating the dependencies and creating a vendor folder"
cd laravel-master
php ../composer update
php ../composer install
cd ..

#############################################################
#############################################################
# Now assigning the folders to the apache user www-data 
#############################################################
echo "Now assigning the folders to the apache user www-data"
sudo touch laravel-master/storage/logs/laravel.log
sudo chown -R www-data:www-data laravel-master/storage
sudo chown -R www-data:www-data laravel-master/bootstrap/cache
sudo chmod 755 -R laravel-master/storage
sudo chmod 755 -R laravel-master/bootstrap/cache
sudo chmod 755 -R laravel-master/storage/logs/laravel.log

#############################################################
# Copying Environment file 
#############################################################
echo "Copying .env.exmple to .env"
cd laravel-master/
cp .env.example .env
cd ..

#############################################################
# generating project key
#############################################################
echo "Generating project key"
cd laravel-master/
php artisan key:generate
cd ..
