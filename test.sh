# pattern="<-- Add Content Here --/>"
# replacement="<ng-content></ng-content>"
# sed -i "s@<-- Add Content Here --\/>@<ng-content><\/ng-content>@g" "ui/projects/shared/src/lib/nav/nav.component.html"
# sed -i 's/<!-- Add Content Here -->/<ng-content><\/ng-content>/g'  ui/projects/shared/src/lib/components/nav/nav.component.html
# import { SharedModule } from 'projects/shared/src/public-api';
sed -i '' '15 i\
    SharedModule,
' ui/projects/admin/src/app/app.module.ts

sed -i '' '7 i\
import { SharedModule } from "projects/shared/src/public-api";
' ui/projects/admin/src/app/app.module.ts