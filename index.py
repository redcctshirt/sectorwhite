#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Lizenz: MIT License
# Datum: 10.04.2015
# Ersteller: info@datenpaul.de
# Version: 0.0.1

# Module importieren
from bottle import route, run, template, debug, static_file, redirect, request, post

import simplejson
import random

# Liste mit den json-Dateien
json_data_files = ['data.json','data2.json']

#@route('/')
#def index():
#    redirect("/one")

@route('/')
def index():
    f = random.randint(1,len(json_data_files))
    # Zufallszahl für Datei ermitteln (1 bis Länge der Dateien-Liste) 	
    json_file_content = open("./data/" + json_data_files[f-1]).read()
    # Dateiinhalt lesen
    json_all_nodes = simplejson.loads(json_file_content)
    # json-Format in eine Dict-Variable packen
    a = random.randint(1,len(json_all_nodes))
    # Zufallszahl für Frage ermitteln
    randoml = range(0,len(json_all_nodes[json_all_nodes.keys()[a-1]]['answer']),1)
    random.shuffle(randoml)
    # Zufallsliste für Antworten erstellen
    return template('index',randomlist=randoml,answer=json_all_nodes[json_all_nodes.keys()[a-1]],key=json_all_nodes.keys()[a-1],filename=json_data_files[f-1])
    # Template wiedergeben, Variablen dem Template geben

@route('/getquestion')
def getquestion():
    f = random.randint(1,len(json_data_files))
    json_file_content = open("./data/" + json_data_files[f-1]).read()
    json_all_nodes = simplejson.loads(json_file_content)
    a = random.randint(1,len(json_all_nodes))
    randoml = range(0,len(json_all_nodes[json_all_nodes.keys()[a-1]]['answer']),1)
    random.shuffle(randoml)
    rdict = json_all_nodes[json_all_nodes.keys()[a-1]]
    rdict["filename"] = json_data_files[f-1]
    rdict["key"] = json_all_nodes.keys()[a-1]
    random.shuffle(rdict['answer'])
    return rdict

@route('/control', method='POST')
def control():
    ranswer = ""
    filename = request.forms.get('filename').decode('utf-8')
    key = request.forms.get('key').decode('utf-8')
    answer_string = request.forms.get('answer_string').decode('utf-8')
    json_file_content = open("./data/" + filename).read()
    json_all_nodes = simplejson.loads(json_file_content)
#    return " " + str(len(json_all_nodes[key]['answer']))
    for i in range(len(json_all_nodes[key]['answer'])):
	if json_all_nodes[key]['answer'][i]['value'] == answer_string:
		if json_all_nodes[key]['answer'][i]['t'] == True:
    			ranswer = "Richtig"
		else:
		   	ranswer = "Falsch"	
    return ranswer

#@route('/Impressum')
#def impressum():
#    return template('impressum')

@route('/views/<filename:re:.*\.(css|png|jpg|ico|js)>')
def viewfiles(filename):
    return static_file(filename, root='./views/')

@route('/json')
def datajson():
    return static_file('data.json', root='./data/')

debug(True)
run(reloader=True)




