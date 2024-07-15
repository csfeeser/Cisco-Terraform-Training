
provider "random" {}

resource "random_pet" "containernamerandom" {
   length    = 3
   separator = "-"
}

output "bravo" {
  value = random_pet.containernamerandom.id
}
