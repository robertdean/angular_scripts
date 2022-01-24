#!/bin/sh -x
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

echo "${green}${green}creating project shell${reset}"

ng new ui --skipInstall=true --skipGit=true --style=scss --createApplication=false --commit=false 
cd ui
echo "${green}creating admin projectl${reset}"
ng g application admin --prefix=admin  --skipInstall=true --style=scss  --routing=true
echo "${green}creating client projectl${reset}"
ng g application client --prefix=client  --skipInstall=true --style=scss --routing=true
echo "${green}creating shared libraryl${reset}"
ng g library shared --prefix=lib  --skipInstall=true
echo "${green}installing deps ${reset}"
npm i 
echo "${green}adding angular material depsl${reset}"
ng add @angular/material
ng add @angular/cdk
npm install material-design-icons --save
npm install roboto-fontface --save
# npm i json -g 
#                                                                                        
npx json -I -f angular.json -e 'this.projects.admin.architect.build.options.styles[1]="./node_modules/material-design-icons/iconfont/material-icons.css"' 
npx json -I -f angular.json -e 'this.projects.admin.architect.build.options.styles[2]="./node_modules/roboto-fontface/css/roboto/roboto-fontface.css"' 
npx json -I -f angular.json -e 'this.projects.client.architect.build.options.styles[1]="./node_modules/material-design-icons/iconfont/material-icons.css"' 
npx json -I -f angular.json -e 'this.projects.client.architect.build.options.styles[2]="./node_modules/roboto-fontface/css/roboto/roboto-fontface.css"' 

# TODO: fix this line for roboto font json -I -f angular.json -e 'this.projects.admin.architect.build.options.styles[1]="node_modules/roboto/.css"' '

echo "${green} adding shared componentsl${reset}"

ng g c components/page-not-found --project=shared --export=true
ng g c components/access-denied --project=shared --export=true
ng g c components/nav --project=shared --export=true

ng g module users --module=app.module  --project=admin --route=users --routing=true 
ng g module roles --module=app.module  --project=admin --route=roles --routing=true 
ng g module logs --module=app.module  --project=admin --route=logs --routing=true 
ng g module dashboard --module=app.module  --project=admin --route=dashboard --routing=true 

ng generate @angular/material:dashboard main --project=admin --module=dashboard
ng generate @angular/material:table table --project=admin


# ng generate @angular/material:nav nav --project=admin

# ng generate @angular/material:nav src/lib/components/nav --project=shared --module=src/lib/shared.module

# echo "${green}adding stuff to angular.json "
#  cat angular.json | jq '.projects.admin.architect.build.options.styles |= . + ["./node_modules/material-design-icons/iconfont/material-icons.css","./node_modules/roboto-fontface/css/roboto/roboto-fontface.css"]' > angular.json
#  cat angular.json | jq '.projects.client.architect.build.options.styles |= . + ["./node_modules/material-design-icons/iconfont/material-icons.css","./node_modules/roboto-fontface/css/roboto/roboto-fontface.css"]' > angular.json
# echo "${green}done"

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