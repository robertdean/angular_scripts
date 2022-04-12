# pattern="<-- Add Content Here --/>"
# replacement="<ng-content></ng-content>"
# sed -i "s@<-- Add Content Here --\/>@<ng-content><\/ng-content>@g" "ui/projects/shared/src/lib/nav/nav.component.html"
# sed -i 's/<!-- Add Content Here -->/<ng-content><\/ng-content>/g'  ui/projects/shared/src/lib/components/nav/nav.component.html
sed -i '' '5 i\
import { MaterialModule  } from "./material.module";
' ui/projects/shared/src/lib/shared.module.ts

sed -i '' '6 i\
import { CommonModule  } from "@angular/common";
' ui/projects/shared/src/lib/shared.module.ts


sed -i '' '17 i\
CommonModule, MaterialModule
' ui/projects/shared/src/lib/shared.module.ts
