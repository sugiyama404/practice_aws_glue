resource "aws_glue_job" "my_glue_job" {
  name     = "my_glue_job"
  role_arn = "arn:aws:iam::123456789012:role/AWSGlueServiceRole"
  command {
    name            = "glueetl"
    script_location = "s3://path_to_your_glue_script/glue_script.py"
    python_version  = "3"
  }
}
