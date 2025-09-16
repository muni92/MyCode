/* Alta3 Research - rzfeeser@alta3.com
   An example of creating an intentional delay with Terraform. In most cases,
   doing something like this should be considered a "work-around". */

resource "null_resource" "next" { #5
  depends_on = [time_sleep.wait_30_seconds]
}

terraform {
  required_providers { #1
    null = {
      source = "hashicorp/null"
      version = "3.1.1"
    }
  }
}

// if no customizations are present
// the provider block is optional

resource "null_resource" "previous" {
  provisioner "local-exec" { #3
    command = "echo 'foo' > file.txt"
  }
}



resource "time_sleep" "wait_30_seconds" { #4
  depends_on = [null_resource.previous]
  create_duration = "2s"   // pause this long when a creation occurs
  destroy_duration = "2s"  // pause this long when a destroy occurs
}

provider "null" {
  # Configuration options #2
}



