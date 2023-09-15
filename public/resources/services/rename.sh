#!/bin/bash

# List of files
files=(
"bakery.jpg"
"beauty-services-2.jpg"
"beauty-services-3.jpg"
"beauty-services-4.jpg"
"beauty-services.jpg"
"car-mechanic-2.jpg"
"car-mechanic-3.jpg"
"car-mechanic-4.jpg"
"car-mechanic.jpg"
"cleaning-service-2.jpg"
"cleaning-service-3.jpg"
"cleaning-service.jpg"
"cleaning-services-4.jpg"
"cloth-stiching.jpg"
"cooking.png"
"counselling.jpg"
"electronics repair.jpg"
"food-2.jpg"
"food-3.jpg"
"food.jpg"
"hair-styling.jpg"
"locksmith.jpg"
"package-delivery.jpg"
"pest-control.jpg"
"plumbing-services-2.jpg"
"plumbing-services.jpg"
"relocation-service-2.jpg"
"relocation-service-3.jpg"
"relocation-service.jpg"
)

# Corresponding service names based on service type
serviceNames=(
"Baker Delight.jpg"
"New York Aesthetic Circle.jpg"
"LA Beauty Lounge.jpg"
"Chicago Beauty Bliss.jpg"
"Beauty Box.jpg"
"LA AutoFix.jpg"
"DriveSafe Mechanics.jpg"
"Chicago Car Care.jpg"
"NYC Auto Experts.jpg"
"Dust & Shine.jpg"
"Spotless Chicago.jpg"
"CleanSpace NY.jpg"
"LA Shine Cleaners.jpg"
"LA Stitch & Style.jpg"
"Chef’s Delight.jpg"
"Mindful Sessions.jpg"
"TechFix NY.jpg"
"Foodie’s Paradise.jpg"
"LA Gourmet.jpg"
"NYC Delicacies.jpg"
"Hair Trendz LA.jpg"
"Lock & Key Services.jpg"
"Quick Deliveries.jpg"
"PestBusters.jpg"
"LA Plumbing Pros.jpg"
"Plumb Perfect.jpg"
"LA Movers.jpg"
"Chicago Relocators.jpg"
"EasyMove NYC.jpg"
)

# Rename the files
for ((i=0; i<${#files[@]}; i++)); do
    if [[ -e "${files[$i]}" ]]; then
        mv "${files[$i]}" "${serviceNames[$i]}"
    else
        echo "File ${files[$i]} does not exist!"
    fi
done
