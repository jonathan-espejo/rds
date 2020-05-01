multi_az 			= false
db_instance_class 		= "db.t2.micro"       	# DB instance size, burstable t2.micro is 1cpu/1gb, memory optimized r4.large 2cpu/15GB .. larger capacity means larger $$ cost
							# standard class - db.m4.large
db_storage_type 		= "gp2"			# values is either gp2 (ssd) or io2 (provisioned IOPS)
db_allocated_storage 		= 50			# initial database size in GB
db_max_allocated_storage 	= 1000			# maximum database sizei in GB, triggers storage autoscale when capacity almost reach
db_iops 			= 0 			# amount of IOPS > 0 if storage_type is io1
application 			= "jabber"	        	# application name, each application has their own RDS resources allocation	
