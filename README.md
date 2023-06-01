# Magento 2.4.x Docker + Xdebug(Phpstorm) + MailHog + Elasticsearch 

Magento 2.4.x Docker Environment

Services  : Nginx 1.14, PHP 8.1-fpm-buster, Mariadb 10.4


Magento 2.4.x Docker Setup:

1. Download and install docker app (windows/Mac)

    * Docker > Preferences > Resources > Advanced : at least 4 or 5 CPUs and 8.0 GB RAM
    * Local machine have alteast 16GB RAM(Recommended)    

2. Clone docker-latest-php repository and Build the docker Images:

        * docker-compose build
        * docker-compose up -d

3. Add System variable in environmental settings ```SHELL=/bin/bash``` (windows)

4. To show Running Containers use command ```docker ps```

5. Install magento Instance:

```
           Connect to php container: 
           
           * docker exec -it mage-app bash
           
           * cd /var/www/html
            
           * Install Magento Instance in magento24 ( https://devdocs.magento.com/guides/v2.4/install-gde/composer.html )
          
          	    1. composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition=2.4.3-p1 magento2
          		    * enter your Magento authentication keys
          		    
          		2. Install M2 via CLI(/var/www/magento24):
                       
                       php bin/magento setup:install \
                                --base-url=http://magento2.local:8800 \
                                --db-host=mage-db \
                                --db-name=magento2 \
                                --db-user=manish \
                                --db-password=12345 \
                                --admin-firstname=admin \
                                --admin-lastname=admin \
                                --admin-email=admin@admin.com \
                                --admin-user=admin \
                                --admin-password=Admin@123 \
                                --language=en_US \
                                --currency=USD \
                                --timezone=America/Chicago \
                                --use-rewrites=1 \
                                --search-engine=opensearch \
                                --opensearch-host=mage-elasticsearch \
                                --opensearch-port=9200 \
                                --opensearch-index-prefix=magento2 \
                                --opensearch-timeout=15        
                           
                3. Steps to install module:
                
                    
                    composer config repositories.shopfinder-module vcs https://github.com/manish-ranjann/shopfinder.git
                    composer require vendor/module-shopfinder:dev-main
                    php bin/magento setup:static-content:deploy 
                    php bin/magento setup:upgrade
                    php bin/magento setup:di:compile
                      

6. Configure your hosts file: 127.0.0.1 magento2.local 
   1. In windows:-  c:\Windows\System32\Drivers\etc\hosts.
   2. Mac/Ubuntu:-  /etc/hosts

7. Open http://magento2.local:8800/ 

8. Run Unit Test Case:
php ./vendor/bin/phpunit -c dev/tests/unit/phpunit.xml.dist vendor/vendor/module-shopfinder/Test/Unit

9. GraphQL Endpoints:


    1. Shop List 
    
    query {
      shopList {
        shopfinder_id
        shopname
        identifier
        country
        image
        longitude
        latitude
        store
        is_active
        created_at
        updated_at
      }
    }
  

   2. Shop List By ID
    
    query {
      shopListById (
          id: 2
      ) {
        shopfinder_id
        shopname
        identifier
        country
        image
        longitude
        latitude
        store
        is_active
        created_at
        updated_at
      }
    }


   3. Update Shop
    Request Body
    
    mutation {
      updateShop (
          id: 1
          input : {
              shopname: "2"
              identifier: "somename"
          }
      ) {
        shopfinder_id
        shopname
        identifier
        country
        image
        longitude
        latitude
        store
        is_active
      }
    }
