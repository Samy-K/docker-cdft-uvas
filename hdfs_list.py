from hdfs import Config

client = Config().get_client('dev')

files_names = client.list('/user/Samy-K/')
print(files_names)


