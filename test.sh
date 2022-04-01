pattern="<-- Add Content Here --/>"
replacement="<ng-content></ng-content>"
sed -i "s@<-- Add Content Here --\/>@<ng-content><\/ng-content>@g" "ui/projects/shared/src/lib/nav/nav.component.html"

