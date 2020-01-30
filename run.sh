#!/bin/bash

hdfscli download --alias=dev -f /user/Samy-K/data_model /data/code/
hdfscli download --alias=dev -f /user/Samy-K/data_station /data/code/
hdfscli download --alias=dev -f /user/Samy-K/le_correcteur /data/code/

Rscript le_correcteur/le_correcteur.R

hdfscli upload --alias=dev -f /data/code/out /user/Samy-K/ 
