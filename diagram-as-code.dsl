workspace {

    model {
        softwareSystem = softwareSystem "Newsfeed System" {
            
            nginx = container "nginx" "" "nginx:latest"{}
            webserver = container "Web Server"  "Replica: 3" "httpd:latest" "Replicas: 3"{
                tags "Google Cloud Platform - Cloud Storage"
            }
            
            db = container "db" "database" "postgres:14.1-alpine"  {
                tags "Google Cloud Platform - Cloud SQL"
            }
            cache = container "cache" "" "redis:6.2-alpine"{
                tags "Google Cloud Platform - Cloud Memorystore"
            }
            postservice = container "postservice" "" "casestudy/postservice" {
                tags "Google Cloud Platform - Cloud APIs"
            }
            fanoutservice = container "fanoutservice" "" "casestudy/fanoutservice"{
                tags "Google Cloud Platform - Cloud APIs"
            }
           
            redis = container "redis" "" "redis:6.2-alpine"{
                tags "Google Cloud Platform - Cloud PubSub"
            }
            
            worker = container "worker" "" "worker-image:latest"{
                tags "Google Cloud Platform - Cloud Jobs API"
            }
            
            nginx -> webserver ""
            webserver -> fanoutservice ""
            webserver -> postservice ""
            postservice -> db ""
            postservice -> cache ""
            fanoutservice -> db ""
            fanoutservice -> cache ""
            fanoutservice -> redis ""
            worker -> redis ""
            
        }
    }

    views {
        systemContext softwareSystem {
            include *
            autolayout lr
        }

        container softwareSystem {
            include *
            autolayout lr
        }
        
    styles {
            element "Element" {
                shape roundedbox
                background #ffffff

            }
            element "Webserver"{
                background #3e3e3e 
            }
            element "database" {
                shape cylinder
            }
            element "Infrastructure Node" {
                shape roundedbox
            }
        }

        theme https://static.structurizr.com/themes/google-cloud-platform-v1.5/theme.json

}
