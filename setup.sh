#!/bin/sh -x
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

echo "${green}${green}creating project shell${reset}"

ng new ui --skipInstall=true --skipGit=true --style=scss --createApplication=false --commit=false 
cd ui
echo "${green}creating admin project${reset}"
ng g application admin --prefix=admin  --skipInstall=true --style=scss  --routing=true
echo "${green}creating client project${reset}"
ng g application client --prefix=client  --skipInstall=true --style=scss --routing=true
echo "${green}creating shared library${reset}"
ng g library shared --prefix=lib  --skipInstall=true
echo "${green}installing deps ${reset}"
npm i 
echo "${green}adding angular material deps${reset}"
ng add @angular/material
ng add @angular/cdk
npm install material-design-icons --save
npm install roboto-fontface --save
# *does not work* ng config projects.admin.architect.build.options.styles[1] "./node_modules/material-design-icons/iconfont/material-icons.css"
# *does not work* ng config projects.admin.architect.build.options.styles[1] "./node_modules/material-design-icons/iconfont/material-icons.css"

# npm i json -g 
#                                                                                        
echo "${green} adding stylesheets to projects ${reset}"
#  npx json -I -f  angular.json -e 'this.projects.admin.architect.build.options.styles=[]'

 npx json -I -f angular.json -e 'this.projects.admin.architect.build.options.styles[0]="projects/admin/src/styles.scss"' 
 npx json -I -f angular.json -e 'this.projects.admin.architect.build.options.styles[1]="./node_modules/material-design-icons/iconfont/material-icons.css"' 
 npx json -I -f angular.json -e 'this.projects.admin.architect.build.options.styles[2]="./node_modules/roboto-fontface/css/roboto/roboto-fontface.css"' 
 npx json -I -f angular.json -e 'this.projects.admin.architect.build.options.styles[3]="./node_modules/@angular/material/prebuilt-themes/indigo-pink.css"'
#  npx json -I -f  angular.json -e 'this.projects.client.architect.build.options.styles=[]'
 
 npx json -I -f angular.json -e 'this.projects.client.architect.build.options.styles[0]="projects/admin/src/styles.scss"' 
 npx json -I -f angular.json -e 'this.projects.client.architect.build.options.styles[1]="./node_modules/material-design-icons/iconfont/material-icons.css"' 
 npx json -I -f angular.json -e 'this.projects.client.architect.build.options.styles[2]="./node_modules/roboto-fontface/css/roboto/roboto-fontface.css"' 
 npx json -I -f angular.json -e 'this.projects.client.architect.build.options.styles[3]="./node_modules/@angular/material/prebuilt-themes/indigo-pink.css"'

echo "${green} adding shared components${reset}"

ng g c components/page-not-found --project=shared --export=true
ng g c components/access-denied --project=shared --export=true


ng g module users --module=app.module  --project=admin --route=users --routing=true 
ng g module roles --module=app.module  --project=admin --route=roles --routing=true 
ng g module logs --module=app.module  --project=admin --route=logs --routing=true 
ng g module dashboard --module=app.module  --project=admin --route=dashboard --routing=true 

ng generate @angular/material:dashboard main --project=admin --module=dashboard
ng generate @angular/material:table table --project=admin --module=dashboard

ng generate @angular/material:nav components/nav  --project=shared --skip-import

sed -i.bak 's/<!-- Add Content Here -->/<ng-content><\/ng-content>/g'  projects/shared/src/lib/components/nav/nav.component.html 


cp ../material.module.ts projects/shared/src/lib/material.module.ts
sed -i '' '5 i\
import { MaterialModule  } from "./material.module";
' projects/shared/src/lib/shared.module.ts

sed -i '' '6 i\
import { CommonModule  } from "@angular/common";
' projects/shared/src/lib/shared.module.ts

sed -i '' '17 i\
CommonModule, MaterialModule
' projects/shared/src/lib/shared.module.ts

sed -i '' '15 i\
    SharedModule,
' projects/admin/src/app/app.module.ts

sed -i '' '7 i\
import { SharedModule } from "projects/shared/src/public-api";
' projects/admin/src/app/app.module.ts


sed -i '' '15 i\
    SharedModule,
' projects/client/src/app/app.module.ts

sed -i '' '7 i\
import { SharedModule } from "projects/shared/src/public-api";
' projects/client/src/app/app.module.ts


echo "<lib-nav><router-outlet></router-outlet></lib-nav>" > projects/admin/src/app/app.component.html  
echo "<lib-nav><router-outlet></router-outlet></lib-nav>" > projects/client/src/app/app.component.html  

#//TODO: add to client if this works

#//TODO:   { path: '**', component: PageNotFoundComponent } 
# ng generate @angular/material:nav nav --project=admin
# ng generate @angular/material:nav src/lib/components/nav --project=shared --module=src/lib/shared.module


# ng add @ngx-formly/schematics --ui-theme=material

# npm install @ngrx/{store,effects,entity,store-devtools} --save
# ng generate @ngrx/schematics:store State --root --module app.module.ts
# ng generate @ngrx/schematics:effect App --root --module app.module.ts
# ng g module users --module=app.module  --project=admin --route=users --routing=true 



# 
# const routes: Routes = [
#   { path: '', component: DashboardComponent },
#   { path: 'table', component: TableComponent },
#   { path: '404', component: PageNotFoundComponent },
#   { path: '401', component: AccessDeniedComponent },
#   { path: 'users', loadChildren: () => import('./users/users.module').then(m => m.UsersModule) },
#   { path: '**',   redirectTo: '/404', pathMatch: 'full' },
# 
# ];