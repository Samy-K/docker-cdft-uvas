from hdfs import Config


client = Config().get_client('dev')

fnames = client.list('/user/Samy-K/')
print(fnames)


