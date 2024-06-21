terraform {
    backend "http" {
        address = "https://gitlab.com/api/v4/projects/6309/terraform/state/tf_state"
        username = "rsadhwani"
        password = "glpat-s3BzZCbszcC6oGVBsRmU"
    }
}
