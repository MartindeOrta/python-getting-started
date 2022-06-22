


from .models import Greeting
from django import http
from django.shortcuts import render
from django.http import HttpResponse
from numpy import integer
import telegram
import json
import base64
from datetime import datetime


import pandas_ta as ta
from pandas import DataFrame
from binance.client import Client
from time import sleep


import os

# Create your views here.
def index(request):
    # return HttpResponse('Hello from Python!')
    return render(request, "index.html")


def db(request):

    greeting = Greeting()
    greeting.save()

    greetings = Greeting.objects.all()

    return render(request, "db.html", {"greetings": greetings})




client = Client("otbbwxiUqS7UuyASpWYDiwlGqCCknUp5v3EhKPzadBIGHNZoS1wCY1u3KXBu3nzX", "VkywrJzfMJBEzbxUpNA90vqEdg2QZrHNmxO9OIfjv5Ag1MpbJG5VYIHPvrWa9lC0")


def monitor_futuros(request):
    def indicadores(ultimamonedaenviadausdt,temp,velas,rsipunto):
      klines = client.futures_historical_klines(ultimamonedaenviadausdt, temp, velas)

                   
                     #print(len(klines)) # esto debe ser igual a 120 para que sea correcto luego poner comprobacion previa
      dfm=DataFrame() 
      df= DataFrame(klines) 
      dfm['time'] =  df[0].astype(float)
      dfm['open'] =  df[1].astype(float)
      dfm['high'] =  df[2].astype(float)
      dfm['low'] =   df[3].astype(float)
      dfm["close"] = df[4].astype(float)
      dfm['volumen'] = df[5].astype(float)
                 
              
                  
      
      adxtodos= dfm.ta.adx()
          # print(adxtodos)
      adx=round(adxtodos.ADX_14.iloc[-1])
      adxfinal=str(adx)           
      rsiprevio = round(dfm.ta.rsi(14))
      rsifinalnuevo = round(rsiprevio[119])
      
      puntorsi=""
      if rsifinalnuevo >= rsipunto:
        
          
        
          puntorsi="\U0001F7E2"
      rsimoneda = str(rsifinalnuevo)
      rsitext={"punto":puntorsi,"rsi":rsimoneda}

      return {"rsi":rsitext,'adx':adxfinal}







    now = datetime.now()
    indice=1
  
    try:

        jsonmonedas=request.GET["moneda1"]
        jsongrafico=request.GET["canvasmonedas"]
      
        monedas= json.loads(jsonmonedas)
        graficos = json.loads(jsongrafico)
     
        text=""
        for index in range(len(monedas)):
               
                  ultimamonedaenviadausdt = monedas[index][0] + 'USDT'

                  temp1=Client.KLINE_INTERVAL_1MINUTE
                  velas120="120 minute UTC"
                  temp5=Client.KLINE_INTERVAL_5MINUTE
                  velas600="600 minute UTC"
                  rsi_adx1minuto=indicadores(ultimamonedaenviadausdt,temp1,velas120,75)
                  rsi_adx5minutos=indicadores(ultimamonedaenviadausdt,temp5,velas600,70)
                  
                  rsi1minuto=rsi_adx1minuto["rsi"]
                  adx1minuto=rsi_adx1minuto["adx"]
                  rsi5minuto=rsi_adx5minutos["rsi"]
                  adx5minuto=rsi_adx5minutos["adx"]

                  
                  
            
                  imagenalerta = "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"
                  
                 
                  text=f"""${monedas[index][3]}, Vol: {monedas[index][1]}M, ATH24: {monedas[index][7]}%
{rsi1minuto["punto"]}RSI: {rsi1minuto["rsi"]}, {rsi5minuto["punto"]}RSI(5min): {rsi5minuto["rsi"]}, ADX:{adx1minuto}
                  
                
"""               
                #   print(1)
                  # https://t.me/+J6G7Lf_pEjkxYWEx
                 
                  indice=indice+1
                  
      
      
                  base64_img_bytes = graficos[index].encode('utf-8')
      
      
                  decodeit = open('hello_level.jpeg', 'wb') 
                  decodeit.write(base64.b64decode((base64_img_bytes))) 
                  decodeit.close() 
      
                  try:
                     
                      # telegram.Bot(token='5103980716:AAHv5n9I5yp13dKj4DolxKwgFtTiz8-lZ8M').send_message(chat_id='1969326770',text=text )
                      # bot=telegram.Bot(token='5103980716:AAHv5n9I5yp13dKj4DolxKwgFtTiz8-lZ8M')
                      # bot.send_message(chat_id='1969326770',text=text )
                      # bot.send_photo(chat_id='1969326770', photo=decoded_image_data, caption ="prueva")
                      with open('hello_level.jpeg', 'rb') as photo_file:
                        #  '-1001770272090' chat monitor
                         telegram.Bot(token='5380546827:AAFpT0a6e85FaMs4uJUujyys0zvKB23Q7hQ').sendPhoto(chat_id='-1001770272090', photo=photo_file, caption = text)
                         if float(rsi5minuto["rsi"])>=75:
                            
                            telegram.Bot(token='5380546827:AAFpT0a6e85FaMs4uJUujyys0zvKB23Q7hQ').sendPhoto(chat_id='-1001577289281', photo=photo_file, caption = text)
                         
                      print("mensaje enviado por telegram")
                      # botmensaje.send_photo(chat_id=decoded_image_data , photo=decoded_image_data, caption="monedas[index][0]")
      
      
                      
                  except:
                    print("error telegram")
        
        telegram.Bot(token='5380546827:AAFpT0a6e85FaMs4uJUujyys0zvKB23Q7hQ').send_message(chat_id='-1001770272090',text="buscando..." )
       
        if (now.minute) == 30 or (now.minute) == 0:
         telegram.Bot(token='5380546827:AAFpT0a6e85FaMs4uJUujyys0zvKB23Q7hQ').send_message(chat_id='1969326770',text="monitor funcionando" )
         telegram.Bot(token='5380546827:AAFpT0a6e85FaMs4uJUujyys0zvKB23Q7hQ').send_message(chat_id='2128803955',text="monitor funcionando" )
        return render(request, "actualizador.aspx")
        
    except:
        print("primera entrada")
 
        return render(request, "actualizador.aspx")



def buscar (request):
   
    mensaje="articulo buscado: %r" %request.GET["prd"]
   
   
    return HttpResponse(mensaje)



    
    



