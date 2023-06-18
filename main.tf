module "db_authors_table" {
  source = "./modules/dynamodb"

  name    = "Authors"
  context = module.name.context

}

module "db_courses_table" {
  source = "./modules/dynamodb"

  name    = "Courses"
  context = module.name.context
}

module "lambda" {
  source                  = "./modules/lambda"
  context                 = module.name.context
  name                    = "Authors"
  name_courses            = "Courses"
  name_courses_save       = "Courses-save"
  name_courses_get        = "Courses-get"
  name_courses_delete     = "Courses-delete"
  name_courses_update     = "Courses-update"
  table_author_name       = module.db_authors_table.table_name
  table_author_arn        = module.db_authors_table.table_arn
  table_courses_name      = module.db_courses_table.table_name
  table_courses_arn       = module.db_courses_table.table_arn
  lambda_courses_role_arn = module.iam.table_courses_role_arn
  lambda_authors_role_arn = module.iam.table_authors_role_arn
}

resource "aws_iam_user" "the-accounts" {
  for_each = toset(["Todd", "James", "Alice", "Dottie"])
  name     = "${module.name.id}-${each.key}"
}

module "iam" {
  source            = "./modules/iam"
  context           = module.name.context
  name              = "iam"
  table_authors_arn = module.db_authors_table.table_arn
  table_courses_arn = module.db_courses_table.table_arn
}