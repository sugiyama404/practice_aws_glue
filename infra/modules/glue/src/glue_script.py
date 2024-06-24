import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job
from pyspark.sql import SparkSession
from pyspark.sql.functions import col, lit

## @params: [JOB_NAME, REDSHIFT_DATABASE, REDSHIFT_USER, REDSHIFT_PASSWORD, REDSHIFT_HOST, REDSHIFT_PORT, RDS_DATABASE, RDS_USER, RDS_PASSWORD, RDS_HOST, RDS_PORT]
args = getResolvedOptions(sys.argv, ['JOB_NAME', 'REDSHIFT_DATABASE', 'REDSHIFT_USER', 'REDSHIFT_PASSWORD', 'REDSHIFT_HOST', 'REDSHIFT_PORT', 'RDS_DATABASE', 'RDS_USER', 'RDS_PASSWORD', 'RDS_HOST', 'RDS_PORT'])

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)

# RDS からデータを読み込む
rds_url = f"jdbc:mysql://{args['RDS_HOST']}:{args['RDS_PORT']}/{args['RDS_DATABASE']}"
df_rds = spark.read.format("jdbc") \
    .option("url", rds_url) \
    .option("driver", "com.mysql.jdbc.Driver") \
    .option("user", args['RDS_USER']) \
    .option("password", args['RDS_PASSWORD']) \
    .option("dbtable", "users") \
    .load()

# Redshift にデータを書き込む
redshift_url = f"jdbc:redshift://{args['REDSHIFT_HOST']}:{args['REDSHIFT_PORT']}/{args['REDSHIFT_DATABASE']}"
df_rds.write \
    .format("jdbc") \
    .option("url", redshift_url) \
    .option("driver", "com.amazon.redshift.jdbc42.Driver") \
    .option("user", args['REDSHIFT_USER']) \
    .option("password", args['REDSHIFT_PASSWORD']) \
    .option("dbtable", "users") \
    .mode("append") \
    .save()

job.commit()
