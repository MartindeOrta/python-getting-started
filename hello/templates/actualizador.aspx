<%@ Page Language="VB" AutoEventWireup="false" CodeFile="actualizador.aspx.vb" Inherits="_Default" %>

<!DOCTYPE html> 

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
     <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cotizaciones criptomonedas</title>
    
    <style>
        .resaltar{
    cursor: default;
    background-color: #f0b90b;
    color:#ff0000;

}
body {
    background-color: #eaeaea;
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
}
h2 {
    text-align: center;
    background-color: #fafafa;
     color:#006699; 
  
}

#porcentaje{
    font-weight: bold;
    font-size: xx-large;
}

#SYMBOLO
{
    font-weight: bold;
    font-size: x-large;
   

    

}
a{
    color:#000000;
    }
    

    
    a:hover{
        color:#0080ff;
        }
        


#ATH{
    font-weight: bold;
    
}
.tabla-css {
    margin-left: auto;
    margin-right: auto;
    min-width: 600px;
    box-shadow: 0 0 10px #3d3b3b;
    border-collapse: collapse;
}
.tabla-css thead tr {
    background-color: #f0b90b;
    color:#252a34;
    text-align: center;
}
.tabla-css th,
.tabla-css td {
    padding: 20px 20px;
    text-align: center;
}
.tabla-css tbody tr:nth-of-type(even){
 background-color: #f8c82865;   
}


tr{
    padding: 200px;
    height: 140px;
}

.filaAngosta{

    height: 100%;

}




    </style>
</head>
<body>


<form id="Form1" runat="server">
     <asp:textbox id="json" runat="Server" Height="10px" MaxLength="50000" TextMode="MultiLine" Width="120px" />
     <button id="submit" >cargar</button>
    &nbsp;&nbsp;<asp:Button ID="Button2" runat="server" Height="19px" Text="Button" Width="149px" />&nbsp;
    <span style="font-size: 8pt">
    ORDEN: simbolo volumen porcentajevariacion precio preciomasalto preciomasbajo porcentajeprecioactual<br />
    </span>
    <input type="text"  ID="moneda1"  name="moneda1" Height="11px" TextMode="MultiLine" Width="118px">
    <input type="text"  id="canvasmonedas"  name="canvasmonedas" Height="100px" TextMode="MultiLine" Width="118px">

   
     <button onclick="refsend()">SEND MSN TO BOT</button>
    total de monedas:<p id= "TotalMonedasUSDT"></p></form>
    <h2>Monitor Actualizador final 13mar22</h2>
    <var>
       
    </var>
    <table class="tabla-css">
        <thead>
            <tr class="filaAngosta">
                <th style="height: 100%" >Moneda</th>
                <th style="height: 100%">Volumen</th>
                <th style="height: 100%">Precio</th>
                <th style="height: 100%">distancia precio mas alto </th>
                <th id='cambio' style="height: 100%">% De cambio en 30min</th>
                
                <th style="height: 100%">grafico</th>
            
            </tr>
            
        </thead>
        <tbody id="data">
        </tbody>
    </table>
    <p id= "cargando"></p>
 &nbsp;<script>
 
 minimoporcentaje30= 5
minimoporcentaje120=5



porcentajeMaximo=100
let datosAth=[{"MONEDA":"IMX","ATH":"1.63"},{"MONEDA":"IOTX","ATH":"0.263"},{"MONEDA":"ROSE","ATH":"0.59443"},{"MONEDA":"PEOPLE","ATH":"0.17768"},{"MONEDA":"COTI","ATH":"0.70408"},{"MONEDA":"KNC","ATH":"4.31886"},{"MONEDA":"GTC","ATH":"28.99"},{"MONEDA":"KAVA","ATH":"9.226"},{"MONEDA":"ETC","ATH":"179"},{"MONEDA":"ICP","ATH":"478.87"},{"MONEDA":"CHR","ATH":"1.5086"},{"MONEDA":"ADA","ATH":"3.1052"},{"MONEDA":"ANT","ATH":"14.25"},{"MONEDA":"DUSK","ATH":"1.07711"},{"MONEDA":"NEAR","ATH":"20.6424"},{"MONEDA":"NEO","ATH":"141.379"},{"MONEDA":"CELR","ATH":"0.1985"},{"MONEDA":"ONE","ATH":"0.381"},{"MONEDA":"CELO","ATH":"7.88"},{"MONEDA":"HBAR","ATH":"0.57644"},{"MONEDA":"RUNE","ATH":"21.34"},{"MONEDA":"GALA","ATH":"0.85"},{"MONEDA":"OGN","ATH":"3.4"},{"MONEDA":"RSR","ATH":"0.119"},{"MONEDA":"NKN","ATH":"1.484"},{"MONEDA":"MASK","ATH":"22.5739"},{"MONEDA":"QTUM","ATH":"35.69"},{"MONEDA":"AAVE","ATH":"666.8"},{"MONEDA":"DYDX","ATH":"27.875"},{"MONEDA":"KLAY","ATH":"1.88"},{"MONEDA":"CVC","ATH":"0.98"},{"MONEDA":"DENT","ATH":"0.022747"},{"MONEDA":"ATOM","ATH":"44.789"},{"MONEDA":"HNT","ATH":"60.27"},{"MONEDA":"OMG","ATH":"20.1726"},{"MONEDA":"ANKR","ATH":"0.216781"},{"MONEDA":"LUNA","ATH":"103.61"},{"MONEDA":"AR","ATH":"91.27"},{"MONEDA":"GRT","ATH":"2.86547"},{"MONEDA":"XTZ","ATH":"9.177"},{"MONEDA":"LPT","ATH":"75.785"},{"MONEDA":"AKRO","ATH":"0.08878"},{"MONEDA":"COMP","ATH":"913.02"},{"MONEDA":"TRB","ATH":"164.69"},{"MONEDA":"THETA","ATH":"15.9245"},{"MONEDA":"STORJ","ATH":"3.835"},{"MONEDA":"LIT","ATH":"13.444"},{"MONEDA":"DODO","ATH":"8.94"},{"MONEDA":"FTM","ATH":"3.4908"},{"MONEDA":"LINK","ATH":"53.07"},{"MONEDA":"ALGO","ATH":"2.8717"},{"MONEDA":"ZEN","ATH":"170"},{"MONEDA":"STMX","ATH":"0.09981"},{"MONEDA":"ZRX","ATH":"2.41"},{"MONEDA":"VET","ATH":"0.279824"},{"MONEDA":"RVN","ATH":"0.27369"},{"MONEDA":"CHZ","ATH":"0.958"},{"MONEDA":"UNI","ATH":"45.0876"},{"MONEDA":"CRV","ATH":"6.809"},{"MONEDA":"AUDIO","ATH":"3.9667"},{"MONEDA":"RAY","ATH":"16.97"},{"MONEDA":"SC","ATH":"0.064289"},{"MONEDA":"SAND","ATH":"8.5"},{"MONEDA":"C98","ATH":"6.4588"},{"MONEDA":"LINA","ATH":"0.20453"},{"MONEDA":"MANA","ATH":"5.917"},{"MONEDA":"BAT","ATH":"1.93"},{"MONEDA":"MATIC","ATH":"2.925"},{"MONEDA":"LRC","ATH":"3.8276"},{"MONEDA":"XMR","ATH":"521"},{"MONEDA":"ENS","ATH":"78.342"},{"MONEDA":"BAKE","ATH":"5.9073"},{"MONEDA":"MTL","ATH":"7.2106"},{"MONEDA":"ZEC","ATH":"372.62"},{"MONEDA":"BLZ","ATH":"0.66932"},{"MONEDA":"AVAX","ATH":"148"},{"MONEDA":"BTT","ATH":"0.01096"},{"MONEDA":"HOT","ATH":"0.0319"},{"MONEDA":"BCH","ATH":"1642.62"},{"MONEDA":"EGLD","ATH":"544.95"},{"MONEDA":"BEL","ATH":"5.86197"},{"MONEDA":"SRM","ATH":"13.75"},{"MONEDA":"XLM","ATH":"0.79943"},{"MONEDA":"MKR","ATH":"6344.39"},{"MONEDA":"KSM","ATH":"626.68"},{"MONEDA":"BNB","ATH":"692.9"},{"MONEDA":"EOS","ATH":"14.927"},{"MONEDA":"ONT","ATH":"2.9672"},{"MONEDA":"CTSI","ATH":"1.7295"},{"MONEDA":"SOL","ATH":"260.064"},{"MONEDA":"SXP","ATH":"5.8774"},{"MONEDA":"DOGE","ATH":"0.744178"},{"MONEDA":"REN","ATH":"1.8495"},{"MONEDA":"LTC","ATH":"413.94"},{"MONEDA":"DEFI","ATH":"3847.3"},{"MONEDA":"SUSHI","ATH":"23.4732"},{"MONEDA":"OCEAN","ATH":"1.94873"},{"MONEDA":"NU","ATH":"1.2726"},{"MONEDA":"DOT","ATH":"55.2"},{"MONEDA":"ALPHA","ATH":"2.98"},{"MONEDA":"SNX","ATH":"29.294"},{"MONEDA":"FLM","ATH":"1.25"},{"MONEDA":"ICX","ATH":"3.2055"},{"MONEDA":"BAL","ATH":"75.408"},{"MONEDA":"YFII","ATH":"7829.6"},{"MONEDA":"IOST","ATH":"0.091241"},{"MONEDA":"TRX","ATH":"0.18077"},{"MONEDA":"ENJ","ATH":"4.8547"},{"MONEDA":"ZIL","ATH":"0.25762"},{"MONEDA":"CTK","ATH":"3.97966"},{"MONEDA":"1INCH","ATH":"7.889"},{"MONEDA":"DASH","ATH":"478.49"},{"MONEDA":"ETH","ATH":"4877.54"},{"MONEDA":"SKL","ATH":"1.25214"},{"MONEDA":"XRP","ATH":"1.977"},{"MONEDA":"BTS","ATH":"0.175"},{"MONEDA":"ALICE","ATH":"28.71"},{"MONEDA":"1000SHIB","ATH":"0.089575"},{"MONEDA":"BTCDOM","ATH":"1272.5"},{"MONEDA":"ARPA","ATH":"0.27638"},{"MONEDA":"XEM","ATH":"0.8439"},{"MONEDA":"IOTA","ATH":"2.6864"},{"MONEDA":"REEF","ATH":"0.059075"},{"MONEDA":"KEEP","ATH":"1.2"},{"MONEDA":"RLC","ATH":"16.4"},{"MONEDA":"SFP","ATH":"3.983"},{"MONEDA":"BAND","ATH":"23.3555"},{"MONEDA":"FIL","ATH":"238.511"},{"MONEDA":"TOMO","ATH":"3.9318"},{"MONEDA":"YFI","ATH":"95217.1"},{"MONEDA":"DGB","ATH":"0.18264"},{"MONEDA":"UNFI","ATH":"44.155"},{"MONEDA":"1000XEC","ATH":"0.275"},{"MONEDA":"BTC","ATH":"69198.7"},{"MONEDA":"ATA","ATH":"1.74"},{"MONEDA":"TLM","ATH":"0.5715"},{"MONEDA":"WAVES","ATH":"42"},{"MONEDA":"AXS","ATH":"165.88"}]

//
var Cantidadmonedascargadasentexto = 2 // 9 es igua a 10 moneadas porque comienza desde 0
var    monedasTelegramArray= [[]]
 var monedasTelegramArray120=[[]]

var    canvasTelegramArray= [[]]
var    canvasTelegramArray120= [[]]
var monedasTelegramJson;

var monedas120minutosJson;

var arrayjson;

var arrayjson120;
let endpoint = ' https://fapi.binance.com/fapi/v1/ticker/24hr'
let ColumnaPorcentaje;
let arrayGrafico_ = [[]]
let arrayGrafico = [[]]

let arrayGrafico120 = [[]]
Cuentagrafico = 0;
let a;
let body = ''
let MonedaTelegram

var conservarsimbolo = []
var conservarsimbolo120 = []


fetch(endpoint)
.then( respuesta => respuesta.json() )
.then( datos =>{ 
 mostrarData(datos)
 setInterval(function(){  
  console.log("hola"),
  button = document.getElementById('submit');


button.click()},20000)

//  mueveReloj()

 //setInterval(function(){  
  //location.reload();
// },10000)


 })

 .catch( e => location.reload())
 // original: .catch( e => console.log(e))

   
  
const mostrarData = (data)=>{
   
   document.getElementById('cargando').innerHTML = "cargando tabla...";
   
   console.log(data[0].highPrice)//precio mas alto 24hs
   console.log(data[0].lowPrice)//precio mas bajo 24hs
  
   
    let contador= 0;
 


    let cantidadantes = data.length 

    for (let i=0; i <  data.length; i++) {

    
      


        
        
     
        
        
      let usdt =data[i].symbol.substr(-4,4)//este toma el simbolo de las monedas para luego filtrar solos los que usan la convercion en dolares 
      let volumen = data[i].quoteVolume
         
        
       if ( usdt== "USDT" && volumen > 50000000) // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvol
       { contador += 1
          let absPriceChange = Math.abs(data[i].priceChangePercent)
          absPriceChange = absPriceChange.toFixed(1)
          

          let link= 'https://fapi.binance.com/fapi/v1/klines?symbol='+ data[i].symbol +'&limit=120&interval=1m'

        
         fetch(link)
          .then(response => response.json())
          .then(data => mostrarData1(data))

  
          const mostrarData1= (data1)=>{
          
            let ATH
             let s=data[i].symbol.substr(-data[i].symbol.length,data[i].symbol.length-4)   


            //  console.log(data[i].highPrice)//precio mas alto 24hs
            //  console.log(data[i].lowPrice)//precio mas bajo 24hs



            //tomamos precio mas alto y mas bajo en 24hs
             precioAlto24hs=parseFloat(data[i].highPrice)
             precioBajo24hs=parseFloat(data[i].lowPrice)
            //  console.log(precioAlto24hs)
            //  console.log(precioBajo24hs)




             for (let index = 0; index < datosAth.length; index++) {
               
               let iSimbolo = datosAth[index].MONEDA;
               if (iSimbolo===s) {
              
                 ATH= datosAth[index].ATH
                
               }

             }
          
          
          ultimoprecio = data1[119][4]
          diferenciaPrecioAlto24hs=precioAlto24hs-precioBajo24hs
          parteDiferencia24hs=diferenciaPrecioAlto24hs/100
          diferenciaPrecioActual24hs=ultimoprecio-precioBajo24hs
          porcentajeDisResistencia=diferenciaPrecioActual24hs/parteDiferencia24hs
          porcentajeDisResistencia= Math.round( porcentajeDisResistencia)



          
          
          //precio5
              
          
            
             preciomasalto = (Math.max(data1[90][2],data1[91][2],data1[92][2],data1[93][2],data1[94][2],data1[95][2],data1[96][2],data1[97][2],data1[98][2],data1[99][2],data1[100][2],data1[101][2],data1[102][2],data1[103][2],data1[104][2],data1[105][2],data1[106][2],data1[107][2],data1[108][2],data1[109][2],data1[110][2],data1[111][2],data1[112][2],data1[113][2],data1[114][2],data1[115][2],data1[116][2],data1[117][2],data1[118][2],data1[119][2]))   
          
             preciomasbajo = (Math.min(data1[90][3],data1[91][3],data1[92][3],data1[93][3],data1[94][3],data1[95][3],data1[96][3],data1[97][3],data1[98][3],data1[99][3],data1[100][3],data1[101][3],data1[102][3],data1[103][3],data1[104][3],data1[105][3],data1[106][3],data1[107][3],data1[108][3],data1[109][3],data1[110][3],data1[111][3],data1[112][3],data1[113][3],data1[114][3],data1[115][3],data1[116][3],data1[117][3],data1[118][3],data1[119][3]))     
            
            
             
  preciomasaltoindex =preciomasalto
preciomasbajoindex = preciomasbajo
precioactual = ultimoprecio
diferenciaenlagrafica=preciomasaltoindex-preciomasbajoindex
porcenenlagrafica100=diferenciaenlagrafica/100
diferenciaactual=precioactual-preciomasbajoindex
porcentajeactual=diferenciaactual/porcenenlagrafica100
            
            
            
            
            
            
            
             PorcentadeVariacionActual =    porcentajeVariacion(preciomasalto,preciomasbajo,ultimoprecio)   
             
             

             
              arrayGrafico_[Cuentagrafico] = [s,data1[90][1],data1[91][1],data1[92][1],data1[93][1],data1[94][1],data1[95][1],data1[96][1],data1[97][1],data1[98][1],data1[99][1],data1[100][1],data1[101][1],data1[102][1],data1[103][1],data1[104][1],data1[105][1],data1[106][1],data1[107][1],data1[108][1],data1[109][1],data1[110][1],data1[111][1],data1[112][1],data1[113][1],data1[114][1],data1[115][1],data1[116][1],data1[117][1],data1[118][1],data1[119][1],data1[119][4],porcentaje=PorcentadeVariacionActual ,Math.round(volumen/1000000), porcentajeDisResistencia,preciomasalto,preciomasbajo]

          //precio60
          
          //precio 120
             preciomasalto120 = (Math.max(data1[0][2],data1[1][2],data1[2][2],data1[3][2],data1[4][2],data1[5][2],data1[6][2],data1[7][2],data1[8][2],data1[9][2],data1[10][2],data1[11][2],data1[12][2],data1[13][2],data1[14][2],data1[15][2],data1[16][2],data1[17][2],data1[18][2],data1[19][2],data1[20][2],data1[21][2],data1[22][2],data1[23][2],data1[24][2],data1[25][2],data1[26][2],data1[27][2],data1[28][2],data1[29][2],data1[30][2],data1[31][2],data1[32][2],data1[33][2],data1[34][2],data1[35][2],data1[36][2],data1[37][2],data1[38][2],data1[39][2],data1[40][2],data1[41][2],data1[42][2],data1[43][2],data1[44][2],data1[45][2],data1[46][2],data1[47][2],data1[48][2],data1[49][2],data1[50][2],data1[51][2],data1[52][2],data1[53][2],data1[54][2],data1[55][2],data1[56][2],data1[57][2],data1[58][2],data1[59][2],data1[60][2],data1[61][2],data1[62][2],data1[63][2],data1[64][2],data1[65][2],data1[66][2],data1[67][2],data1[68][2],data1[69][2],data1[70][2],data1[71][2],data1[72][2],data1[73][2],data1[74][2],data1[75][2],data1[76][2],data1[77][2],data1[78][2],data1[79][2],data1[80][2],data1[81][2],data1[82][2],data1[83][2],data1[84][2],data1[85][2],data1[86][2],data1[87][2],data1[88][2],data1[89][2],data1[90][2],data1[91][2],data1[92][2],data1[93][2],data1[94][2],data1[95][2],data1[96][2],data1[97][2],data1[98][2],data1[99][2],data1[100][2],data1[101][2],data1[102][2],data1[103][2],data1[104][2],data1[105][2],data1[106][2],data1[107][2],data1[108][2],data1[109][2],data1[110][2],data1[111][2],data1[112][2],data1[113][2],data1[114][2],data1[115][2],data1[116][2],data1[117][2],data1[118][2],data1[119][2]))   
          
             preciomasbajo120 = (Math.min(data1[0][3],data1[1][3],data1[2][3],data1[3][3],data1[4][3],data1[5][3],data1[6][3],data1[7][3],data1[8][3],data1[9][3],data1[10][3],data1[11][3],data1[12][3],data1[13][3],data1[14][3],data1[15][3],data1[16][3],data1[17][3],data1[18][3],data1[19][3],data1[20][3],data1[21][3],data1[22][3],data1[23][3],data1[24][3],data1[25][3],data1[26][3],data1[27][3],data1[28][3],data1[29][3],data1[30][3],data1[31][3],data1[32][3],data1[33][3],data1[34][3],data1[35][3],data1[36][3],data1[37][3],data1[38][3],data1[39][3],data1[40][3],data1[41][3],data1[42][3],data1[43][3],data1[44][3],data1[45][3],data1[46][3],data1[47][3],data1[48][3],data1[49][3],data1[50][3],data1[51][3],data1[52][3],data1[53][3],data1[54][3],data1[55][3],data1[56][3],data1[57][3],data1[58][3],data1[59][3],data1[60][3],data1[61][3],data1[62][3],data1[63][3],data1[64][3],data1[65][3],data1[66][3],data1[67][3],data1[68][3],data1[69][3],data1[70][3],data1[71][3],data1[72][3],data1[73][3],data1[74][3],data1[75][3],data1[76][3],data1[77][3],data1[78][3],data1[79][3],data1[80][3],data1[81][3],data1[82][3],data1[83][3],data1[84][3],data1[85][3],data1[86][3],data1[87][3],data1[88][3],data1[89][3],data1[90][3],data1[91][3],data1[92][3],data1[93][3],data1[94][3],data1[95][3],data1[96][3],data1[97][3],data1[98][3],data1[99][3],data1[100][3],data1[101][3],data1[102][3],data1[103][3],data1[104][3],data1[105][3],data1[106][3],data1[107][3],data1[108][3],data1[109][3],data1[110][3],data1[111][3],data1[112][3],data1[113][3],data1[114][3],data1[115][3],data1[116][3],data1[117][3],data1[118][3],data1[119][3]))     
             PorcentadeVariacionActual120 =    porcentajeVariacion(preciomasalto120,preciomasbajo120,ultimoprecio)                             
             arrayGrafico120[Cuentagrafico] = [s,data1[0][1],data1[1][1],data1[2][1],data1[3][1],data1[4][1],data1[5][1],data1[6][1],data1[7][1],data1[8][1],data1[9][1],data1[10][1],data1[11][1],data1[12][1],data1[13][1],data1[14][1],data1[15][1],data1[16][1],data1[17][1],data1[18][1],data1[19][1],data1[20][1],data1[21][1],data1[22][1],data1[23][1],data1[24][1],data1[25][1],data1[26][1],data1[27][1],data1[28][1],data1[29][1],data1[30][1],data1[31][1],data1[32][1],data1[33][1],data1[34][1],data1[35][1],data1[36][1],data1[37][1],data1[38][1],data1[39][1],data1[40][1],data1[41][1],data1[42][1],data1[43][1],data1[44][1],data1[45][1],data1[46][1],data1[47][1],data1[48][1],data1[49][1],data1[50][1],data1[51][1],data1[52][1],data1[53][1],data1[54][1],data1[55][1],data1[56][1],data1[57][1],data1[58][1],data1[59][1],data1[60][1],data1[61][1],data1[62][1],data1[63][1],data1[64][1],data1[65][1],data1[66][1],data1[67][1],data1[68][1],data1[69][1],data1[70][1],data1[71][1],data1[72][1],data1[73][1],data1[74][1],data1[75][1],data1[76][1],data1[77][1],data1[78][1],data1[79][1],data1[80][1],data1[81][1],data1[82][1],data1[83][1],data1[84][1],data1[85][1],data1[86][1],data1[87][1],data1[88][1],data1[89][1],data1[90][1],data1[91][1],data1[92][1],data1[93][1],data1[94][1],data1[95][1],data1[96][1],data1[97][1],data1[98][1],data1[99][1],data1[100][1],data1[101][1],data1[102][1],data1[103][1],data1[104][1],data1[105][1],data1[106][1],data1[107][1],data1[108][1],data1[109][1],data1[110][1],data1[111][1],data1[112][1],data1[113][1],data1[114][1],data1[115][1],data1[116][1],data1[117][1],data1[118][1],data1[119][1],data1[119][4],porcentaje=PorcentadeVariacionActual120 ,Math.round(volumen/1000000), porcentajeDisResistencia,preciomasalto,preciomasbajo]


                     
              /// inicio calculo porcentaje de variacion ultimos 30 min

             
                 
                                                       
             
                          
             

             
          
           
             
             /////////////////////////////////////////
        //    MonedaTelegram = datosAth[1].MONEDA
                    /////////////////////////////fin calculo vaciacion
                    
                    
              // nota arrayGrafico: el antepenultimo valor es el close de la ultima vela, el anteultimo valor es el porcentajedevariacion y el ultimo es el volum y el ultimo es el ATH ¡¡¡¡¡ ///////////////////////////////////////////////////////////////////////
             //array grafico porcentaje variacion 5 minutos esta en la posicion 37
             
             
             
             Cuentagrafico +=1;
             ColumnaPorcentaje= data1;
       
             PRUEVA= (arrayGrafico_.length)
             if (PRUEVA=== parseInt(contador))
             {
             
            

              contadorTelegram=0







              // console.log("desordenado:"+arrayGrafico)
  arrayGrafico_.sort((a,b)=>{
    let keyA=  (a[32])
    let keyB = (b[32])
    if(keyA>keyB) return -1;
    if(keyA<keyB) return 1;
    return 0;
    

  });

   cuentagrafico2=0

 
  for (let p = 0; p < arrayGrafico_.length; p++) {

    preciomasaltoindex = arrayGrafico_[p][35]
preciomasbajoindex = arrayGrafico_[p][36]
precioactual = arrayGrafico_[p][31]
diferenciaenlagrafica=preciomasaltoindex-preciomasbajoindex
porcenenlagrafica100=diferenciaenlagrafica/100
diferenciaactual=precioactual-preciomasbajoindex
porcentajeactual=diferenciaactual/porcenenlagrafica100


if(porcentajeactual>=70){
arrayGrafico[cuentagrafico2]=arrayGrafico_[p]
cuentagrafico2+=1;}

  }
  
  
 
    arrayGrafico120.sort((a,b)=>{
    let keyA=  (a[122])
    let keyB = (b[122])
    if(keyA>keyB) return -1;
    if(keyA<keyB) return 1;
    return 0;
    

  });
  
 
 // console.log("ordenado:"+arrayGrafico)
  for (let index = 0; index < arrayGrafico.length; index++) {
    a = "<a href='https://www.binance.com/es/futures/" + arrayGrafico[index][0] + "USDT' target='blank'>" + arrayGrafico[index][0]+ "</a>";
  
    let grafico = `<canvas id="canvas${index}" width="${anchoGrafico}" height="${altura}"  style="border: 1px solid #000000; background-color: black"></canvas>`
   

    conservarsimbolo[index] = arrayGrafico[index][0] + "  " +arrayGrafico[index][32].toFixed(1)+ " %"

//********************************************************************************************
//********************************************************************************************
//********************************************************************************************
//********************************************************************************************

//  preciomasalto
//  preciomasbajo
//  ultimoprecio
            // preciomasaltosegundo = (Math.max(data1[0][2],data1[1][2],data1[2][2],data1[3][2],data1[4][2],data1[5][2],data1[6][2],data1[7][2],data1[8][2],data1[9][2],data1[10][2],data1[11][2],data1[12][2],data1[13][2],data1[14][2],data1[15][2],data1[16][2],data1[17][2],data1[18][2],data1[19][2],data1[20][2],data1[21][2],data1[22][2],data1[23][2],data1[24][2],data1[25][2],data1[26][2],data1[27][2],data1[28][2],data1[29][2]))   
          
           //  preciomasbajosegundo = (Math.min(data1[0][3],data1[1][3],data1[2][3],data1[3][3],data1[4][3],data1[5][3],data1[6][3],data1[7][3],data1[8][3],data1[9][3],data1[10][3],data1[11][3],data1[12][3],data1[13][3],data1[14][3],data1[15][3],data1[16][3],data1[17][3],data1[18][3],data1[19][3],data1[20][3],data1[21][3],data1[22][3],data1[23][3],data1[24][3],data1[25][3],data1[26][3],data1[27][3],data1[28][3],data1[29][3]))     

// si se cumple esta condicion la moneda es short
// if (preciomasalto-ultimoprecio)<(ultimoprecio-preciomasbajo)

 // if (arrayGrafico[index][32] >= 1.5) { // si porcentaje es mayor a... envio telegram
 // refsend() }
 var tipodeoperacion = ''
 var valorfactortipo = ultimoprecio // * 1.001
 


// /(&%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// SI EL PORCENTAJE NO ES IGUAL A X ENTONCES PONGO NO AL PRINCIPIO DEL TEXTO PARA NO ENVIARLO CON PYTHON &%%%%%%%%%%%%%%%%%%
var pasaminimoporcentaje = ""
if (arrayGrafico[index][32].toFixed(1) < minimoporcentaje30) {
pasaminimoporcentaje = "NO"
}




//********************************************************************************************
//********************************************************************************************
//********************************************************************************************
//******************************************************************************************** 
 // arrayGrafico[index][32].toFixed(1)
 
 
  if (contadorTelegram<=Cantidadmonedascargadasentexto){
 
// orden del array enviado a python
//simbolo
//volumen
//porcentajevariacion
//precio
//preciomasalto
//preciomasbajo
//porcentajeprecioactual
//ath 
  
  preciomasaltoindex = arrayGrafico[index][35]
preciomasbajoindex = arrayGrafico[index][36]
precioactual = arrayGrafico[index][31]
diferenciaenlagrafica=preciomasaltoindex-preciomasbajoindex
porcenenlagrafica100=diferenciaenlagrafica/100
diferenciaactual=precioactual-preciomasbajoindex
porcentajeactual=diferenciaactual/porcenenlagrafica100
console.log(arrayGrafico[index][0])
console.log(porcentajeactual)
porcentajerespectoamasalto = 100 - (((preciomasaltoindex-precioactual) * 100) / (preciomasaltoindex - preciomasbajoindex))
 
    monedasTelegramArray[contadorTelegram]=[arrayGrafico[index][0],arrayGrafico[index][33],parseFloat(arrayGrafico[index][32].toFixed(1)),parseFloat(arrayGrafico[index][31]),arrayGrafico[index][35],arrayGrafico[index][36],parseFloat(porcentajerespectoamasalto.toFixed(0)),arrayGrafico[index][34]]
    contadorTelegram=contadorTelegram+1
     }
     
     
      
    
    
    body += `<tr><td id= "SYMBOLO">${a}</td><td>${arrayGrafico[index][33]+ 'M'}</td><td>${arrayGrafico[index][31]}</td><td id="ATH">${arrayGrafico[index][34]} %</td><td><p id= "porcentaje">${arrayGrafico[index][32].toFixed(1)} %</p></td><td>${grafico}</td></tr>`
  
  

    
  }
  
  for (let index = 0; index < arrayGrafico120.length; index++) {






    a = "<a href='https://www.binance.com/es/futures/" + arrayGrafico120[index][0] + "USDT' target='blank'>" + arrayGrafico120[index][0]+ "</a>";
  
    let grafico = `<canvas id="canvas${index+arrayGrafico.length}" width="${anchoGrafico120}" height="${altura}"  style="border: 1px solid #000000; background-color: black"></canvas>`

    conservarsimbolo120[index] = arrayGrafico120[index][0] + "  " +arrayGrafico120[index][122].toFixed(1)+ " %"
   
  var pasaminimoporcentaje = ""
if (arrayGrafico120[index][122].toFixed(1) < minimoporcentaje120) {
pasaminimoporcentaje = "NO"
}

if (index<=Cantidadmonedascargadasentexto){
 
// orden del array enviado a python
//simbolo
//volumen
//porcentajevariacion
//precio
//preciomasalto
//preciomasbajo
//porcentajeprecioactual
//ath 
  
  preciomasaltoindex = arrayGrafico120[index][125]
preciomasbajoindex = arrayGrafico120[index][126]
precioactual = arrayGrafico120[index][121]
porcentajerespectoamasalto = 100 - (((preciomasaltoindex-precioactual) * 100) / (preciomasaltoindex - preciomasbajoindex))

    monedasTelegramArray120[index]=[arrayGrafico120[index][0],arrayGrafico120[index][123],parseFloat(arrayGrafico120[index][122].toFixed(1)),parseFloat(arrayGrafico120[index][121]),arrayGrafico120[index][125],arrayGrafico120[index][126],parseFloat(porcentajerespectoamasalto.toFixed(0))]

     }

  
   
     body += `<tr><td id= "SYMBOLO">${a}</td><td>${arrayGrafico120[index][123]+ 'M'}</td><td>${arrayGrafico120[index][121]}</td><td id="ATH">-0 %</td><td><p id= "porcentaje">${arrayGrafico120[index][122].toFixed(1)} %</p></td><td>${grafico}</td></tr>`
  
  
  
  
  
  }
  
  
  document.getElementById('data').innerHTML = body
               
               // console.log("PRUEVA DE IGUALDAD"+arrayGrafico.length+" "+ contador)
               arrayjson= JSON.stringify(arrayGrafico)
           
               arrayjson120= JSON.stringify(arrayGrafico120)
          //     console.log(arrayjson)
//*******************************************************************************************************************************+++++ */
//*******************************************************************************************************************************+++++ */
//*******************************************************************************************************************************+++++ */
//*******************************************************************************************************************************+++++ */
 
          //   document.getElementById('cargando').innerHTML=arrayjson

 //window.open("recibirdata.aspx?Id=" + arrayjson, "ventana");

 //$("#button").click(function(event){
  //   alert("Formulario enviado con jQuery");
   //   $('#form').submit();
   //});
//document.forms["Form1"].submit()



//////setTimeout(function(){

    
//////    var texto = document.getElementById('json');
//////    texto.textContent = arrayjson
//////   var button = document.getElementById('Button2');
////// button.click()





    
//////}, 5000);

// funciona:



//********************************************************************************************************************* */
//********************************************************************************************************************* */
//********************************************************************************************************************* */
//********************************************************************************************************************* */
                tabla()
                tabla120()
                 monedasTelegramJson=JSON.stringify(monedasTelegramArray)
                
                 monedas120minutosJson=JSON.stringify(monedasTelegramArray120)


                 canvasTelegramJson=JSON.stringify(canvasTelegramArray)
                textoenviar1 = document.getElementById('moneda1');
                textoenviar1.value=monedasTelegramJson
                textoenviar2 = document.getElementById('canvasmonedas');
                textoenviar2.value=canvasTelegramJson



                textoenviar3 = document.getElementById('moneda3');
                
             
                textoenviar3.textContent=monedas120minutosJson
                // carga de las canvas en texto canvasmonedas
                
                
                                

                
                canvasTelegramJson20=JSON.stringify(canvasTelegramArray120)

                textoenviar4 = document.getElementById('canvasmonedas120');
                textoenviar4.textContent=canvasTelegramJson
             }
             else
             {

                //console.log("NO ES IGUAL"+arrayGrafico.length+" "+ contador)
      
             }
          }
        }

    
    }
    //console.log("prueva")

   
  
    document.getElementById('TotalMonedasUSDT').innerHTML = contador;

 

}



let anchoGrafico120= 600;
let anchoVela120= (anchoGrafico120/120)-3
var altura120=120;

let anchoGrafico= 300;
let anchoVela= (anchoGrafico/30)-3
var altura=120;
//console.log("prueva2")

//************************************************creacion de tabla con grafico***************************************************** */

function tabla(){



 




 var x1;

 var y1;
 var y2;


 var min;
 var max;


 let diferencia;

  //esta variable id sirve para ubicar el canvas que se va a rellenar
 
  //console.log("cantidad de graficos=",arrayGrafico.length)
      //como en la variable contador ya tengo el total de canvas lo coloco como referencia
for (let i=0; i <  arrayGrafico.length; i++){
  altura= 110;
  
 // console.log(arrayGrafico[i])
  //quitamos el primer valor(simbolo)de cada array para trabajar con solo los numeros
  arrayGrafico[i].shift();
// VALORBARRA = VALORBARRA * (120/MAXIMOVALOR)
  
  
    //10/2/22****************************************************************
     canvas= document.getElementById(`canvas${i}`)
     var context =canvas.getContext("2d");
     
      context.beginPath();
  
     context.strokeStyle="#000000";// vela color rojo
   
   
  context.lineWidth=300;// ancho de la vela
  context.moveTo(150, 0);// pocision del open de la vela
  context.lineTo(150,120);//pocicion del close de la vela
  context.stroke();
  context.closePath();//termina el dibujo de la vela
 //10/2/22fin**
  
  
  
  
  //inicializamos lo que voy a dibujar en los graficos html
     var context =document.getElementById(`canvas${i}`).getContext("2d");
     
     
         // reiniciamos las coordenadas
      x1=anchoVela/2
     
       y1=0
       y2= 0
     
      // min=Math.min.apply(null,arrayGrafico[i]);
      // 
      // max=Math.max.apply(null,arrayGrafico[i]);

      //las variables min y max las utilizamos para que el grafico tenga una guia
      //en que porcentaje respecto del ultimo cierre queremos que las velas llegen mas alto y mas vajo del grafico

      min= Math.min(arrayGrafico[i][0],arrayGrafico[i][1],arrayGrafico[i][2],arrayGrafico[i][3],arrayGrafico[i][4],arrayGrafico[i][5],arrayGrafico[i][6],arrayGrafico[i][7],arrayGrafico[i][8],arrayGrafico[i][9],arrayGrafico[i][10],arrayGrafico[i][11],arrayGrafico[i][12],arrayGrafico[i][13],arrayGrafico[i][14],arrayGrafico[i][15],arrayGrafico[i][16],arrayGrafico[i][17],arrayGrafico[i][18],arrayGrafico[i][19],arrayGrafico[i][20],arrayGrafico[i][21],arrayGrafico[i][22],arrayGrafico[i][23],arrayGrafico[i][24],arrayGrafico[i][25],arrayGrafico[i][26],arrayGrafico[i][27],arrayGrafico[i][28],arrayGrafico[i][29],arrayGrafico[i][30])
      max= Math.max(arrayGrafico[i][0],arrayGrafico[i][1],arrayGrafico[i][2],arrayGrafico[i][3],arrayGrafico[i][4],arrayGrafico[i][5],arrayGrafico[i][6],arrayGrafico[i][7],arrayGrafico[i][8],arrayGrafico[i][9],arrayGrafico[i][10],arrayGrafico[i][11],arrayGrafico[i][12],arrayGrafico[i][13],arrayGrafico[i][14],arrayGrafico[i][15],arrayGrafico[i][16],arrayGrafico[i][17],arrayGrafico[i][18],arrayGrafico[i][19],arrayGrafico[i][20],arrayGrafico[i][21],arrayGrafico[i][22],arrayGrafico[i][23],arrayGrafico[i][24],arrayGrafico[i][25],arrayGrafico[i][26],arrayGrafico[i][27],arrayGrafico[i][28],arrayGrafico[i][29],arrayGrafico[i][30])
      
      // console.log(max)
      // console.log(min)
       for(let e=0; e < 30; e++ ){
        
        //console.log("PRECIO OPEN=",arrayGrafico[i][e])
       // console.log("PRECIO CLOSE=",arrayGrafico[i][e+1])
        
       
        diferencia= max-min
       // console.log(diferencia)

        
    
       if (e===0){

         // Open de la vela

         y1= (altura/diferencia * (max - arrayGrafico[i][e]))+5;
         //console.log("posicion grafico open=",y1)
         let open = arrayGrafico[i][e]
         
         //Close
        }else{
          y1=y2
          //console.log("posicion grafico open=",y1)
          
         
        }
          
        Math.abs
     //close de la vela
        y2= (altura/diferencia * (max - arrayGrafico[i][e+1]))+5;
       // console.log("posicion grafico close=",y2)
    
       
// aca se empiesa a dibujar cada vela
//
      context.beginPath();
      if (y1 >y2){
        if (Math.abs(y1-y2)< 3) {

          y2= y2-3
        }
        context.strokeStyle="#0ecb81";// vela color verde
      }else{
        if (Math.abs(y1-y2)< 3) {

          y2= y2+3
        }
        context.strokeStyle="#f6465d";// vela color rojo
      }
      
     context.lineWidth=anchoVela;// ancho de la vela
     context.moveTo(x1, y1);// pocision del open de la vela
     context.lineTo(x1,y2);//pocicion del close de la vela
     context.stroke();
     context.closePath();//termina el dibujo de la vela
     x1 =(anchoGrafico/30)+ x1;// se repocicionan las variable donde va a dibujarse la siguiente vela
     
      }
    /////////////111111111111111111111111
    
   // console.log(i)
    
    ////////////////////111111111111111111111111111
    
    //****cambio13/2/22********************************************************* */

      var txt = canvas.getContext("2d");
   
        tamaniotxt=17
      //tamaño de fuente y tipo de fuente
     // txt.font = tamaniotxt+"px 	Microsoft Sans Serif";
     
    txt.font = tamaniotxt+"px 	Courier";
       //color del texto
      txt.fillStyle= "#FFFFFF";
     //txt.fillStyle= "yellow";
    
      //console.log(Math.sqrt(tamaniotxt))
       

      //lo que va a decir el text y su posicion dentro del cambas 
       txt.fillText("   "+conservarsimbolo[i]  , 0,Math.abs(15));
       
       txt.fillStyle= "grey";
      txt.fillText("www.monitorfuturosbinance.com", 0,Math.abs(118));




      //fin 13/2/22*****************************************************************************************************
  
    ///////////////////////////////222222222222222222222222222222222
    
    if (i<=Cantidadmonedascargadasentexto){
    function RestaurarImagen(canvas){
      var dataURL = canvas.toDataURL()
      dataURL=dataURL.slice(1)
     dataURL=dataURL.slice(1)
     dataURL=dataURL.slice(1)
     dataURL=dataURL.slice(1)
     dataURL=dataURL.slice(1)
     dataURL=dataURL.slice(1)
     dataURL=dataURL.slice(1)
     dataURL=dataURL.slice(1)
     dataURL=dataURL.slice(1)
     dataURL=dataURL.slice(1)
     dataURL=dataURL.slice(1)
     dataURL=dataURL.slice(1)
     dataURL=dataURL.slice(1)
     dataURL=dataURL.slice(1)
     dataURL=dataURL.slice(1)
     dataURL=dataURL.slice(1)
     dataURL=dataURL.slice(1)
     dataURL=dataURL.slice(1)
     dataURL=dataURL.slice(1)
     dataURL=dataURL.slice(1)
     dataURL=dataURL.slice(1)
     dataURL=dataURL.slice(1)      
  //   imagenes=  document.getElementById("Textbox"+(i))
   //  imagenes.textContent=dataURL  
    canvasTelegramArray[i]=dataURL // 
    //  console.log(dataURL)
    }
RestaurarImagen(canvas)
    
}
    
    ///////////////22222222222222222  
      
      
      
      }
   
    
   }


   function tabla120(){





    var x1;

    var y1;
    var y2;
   
   
    var min;
    var max;
   
   
    let diferencia;
   
     //esta variable id sirve para ubicar el canvas que se va a rellenar
    
     //console.log("cantidad de graficos=",arrayGrafico.length)
         //como en la variable contador ya tengo el total de canvas lo coloco como referencia
   for (let i=0; i <  arrayGrafico120.length; i++){
     altura= 110;
     
    // console.log(arrayGrafico[i])
     //quitamos el primer valor(simbolo)de cada array para trabajar con solo los numeros
     arrayGrafico120[i].shift();
   // VALORBARRA = VALORBARRA * (120/MAXIMOVALOR)
     
     //inicializamos lo que voy a dibujar en los graficos html
            canvas= document.getElementById(`canvas${i+arrayGrafico.length}`)
     var context =canvas.getContext("2d");
        
        
            // reiniciamos las coordenadas
         x1=anchoVela120/2
        
          y1=0
          y2= 0
        
         // min=Math.min.apply(null,arrayGrafico[i]);
         // 
         // max=Math.max.apply(null,arrayGrafico[i]);
   
         //las variables min y max las utilizamos para que el grafico tenga una guia
         //en que porcentaje respecto del ultimo cierre queremos que las velas llegen mas alto y mas vajo del grafico
   
         min= Math.min(arrayGrafico120[i][0],arrayGrafico120[i][1],arrayGrafico120[i][2],arrayGrafico120[i][3],arrayGrafico120[i][4],arrayGrafico120[i][5],arrayGrafico120[i][6],arrayGrafico120[i][7],arrayGrafico120[i][8],arrayGrafico120[i][9],arrayGrafico120[i][10],arrayGrafico120[i][11],arrayGrafico120[i][12],arrayGrafico120[i][13],arrayGrafico120[i][14],arrayGrafico120[i][15],arrayGrafico120[i][16],arrayGrafico120[i][17],arrayGrafico120[i][18],arrayGrafico120[i][19],arrayGrafico120[i][20],arrayGrafico120[i][21],arrayGrafico120[i][22],arrayGrafico120[i][23],arrayGrafico120[i][24],arrayGrafico120[i][25],arrayGrafico120[i][26],arrayGrafico120[i][27],arrayGrafico120[i][28],arrayGrafico120[i][29],arrayGrafico120[i][30],arrayGrafico120[i][31],arrayGrafico120[i][32],arrayGrafico120[i][33],arrayGrafico120[i][34],arrayGrafico120[i][35],arrayGrafico120[i][36],arrayGrafico120[i][37],arrayGrafico120[i][38],arrayGrafico120[i][39],arrayGrafico120[i][40],arrayGrafico120[i][41],arrayGrafico120[i][42],arrayGrafico120[i][43],arrayGrafico120[i][44],arrayGrafico120[i][45],arrayGrafico120[i][46],arrayGrafico120[i][47],arrayGrafico120[i][48],arrayGrafico120[i][49],arrayGrafico120[i][50],arrayGrafico120[i][51],arrayGrafico120[i][52],arrayGrafico120[i][53],arrayGrafico120[i][54],arrayGrafico120[i][55],arrayGrafico120[i][56],arrayGrafico120[i][57],arrayGrafico120[i][58],arrayGrafico120[i][59],arrayGrafico120[i][60],arrayGrafico120[i][61],arrayGrafico120[i][62],arrayGrafico120[i][63],arrayGrafico120[i][64],arrayGrafico120[i][65],arrayGrafico120[i][66],arrayGrafico120[i][67],arrayGrafico120[i][68],arrayGrafico120[i][69],arrayGrafico120[i][70],arrayGrafico120[i][71],arrayGrafico120[i][72],arrayGrafico120[i][73],arrayGrafico120[i][74],arrayGrafico120[i][75],arrayGrafico120[i][76],arrayGrafico120[i][77],arrayGrafico120[i][78],arrayGrafico120[i][79],arrayGrafico120[i][80],arrayGrafico120[i][81],arrayGrafico120[i][82],arrayGrafico120[i][83],arrayGrafico120[i][84],arrayGrafico120[i][85],arrayGrafico120[i][86],arrayGrafico120[i][87],arrayGrafico120[i][88],arrayGrafico120[i][89],arrayGrafico120[i][90],arrayGrafico120[i][91],arrayGrafico120[i][92],arrayGrafico120[i][93],arrayGrafico120[i][94],arrayGrafico120[i][95],arrayGrafico120[i][96],arrayGrafico120[i][97],arrayGrafico120[i][98],arrayGrafico120[i][99],arrayGrafico120[i][100],arrayGrafico120[i][101],arrayGrafico120[i][102],arrayGrafico120[i][103],arrayGrafico120[i][104],arrayGrafico120[i][105],arrayGrafico120[i][106],arrayGrafico120[i][107],arrayGrafico120[i][108],arrayGrafico120[i][109],arrayGrafico120[i][110],arrayGrafico120[i][111],arrayGrafico120[i][112],arrayGrafico120[i][113],arrayGrafico120[i][114],arrayGrafico120[i][115],arrayGrafico120[i][116],arrayGrafico120[i][117],arrayGrafico120[i][118],arrayGrafico120[i][119],arrayGrafico120[i][120])
         max= Math.max(arrayGrafico120[i][0],arrayGrafico120[i][1],arrayGrafico120[i][2],arrayGrafico120[i][3],arrayGrafico120[i][4],arrayGrafico120[i][5],arrayGrafico120[i][6],arrayGrafico120[i][7],arrayGrafico120[i][8],arrayGrafico120[i][9],arrayGrafico120[i][10],arrayGrafico120[i][11],arrayGrafico120[i][12],arrayGrafico120[i][13],arrayGrafico120[i][14],arrayGrafico120[i][15],arrayGrafico120[i][16],arrayGrafico120[i][17],arrayGrafico120[i][18],arrayGrafico120[i][19],arrayGrafico120[i][20],arrayGrafico120[i][21],arrayGrafico120[i][22],arrayGrafico120[i][23],arrayGrafico120[i][24],arrayGrafico120[i][25],arrayGrafico120[i][26],arrayGrafico120[i][27],arrayGrafico120[i][28],arrayGrafico120[i][29],arrayGrafico120[i][30],arrayGrafico120[i][31],arrayGrafico120[i][32],arrayGrafico120[i][33],arrayGrafico120[i][34],arrayGrafico120[i][35],arrayGrafico120[i][36],arrayGrafico120[i][37],arrayGrafico120[i][38],arrayGrafico120[i][39],arrayGrafico120[i][40],arrayGrafico120[i][41],arrayGrafico120[i][42],arrayGrafico120[i][43],arrayGrafico120[i][44],arrayGrafico120[i][45],arrayGrafico120[i][46],arrayGrafico120[i][47],arrayGrafico120[i][48],arrayGrafico120[i][49],arrayGrafico120[i][50],arrayGrafico120[i][51],arrayGrafico120[i][52],arrayGrafico120[i][53],arrayGrafico120[i][54],arrayGrafico120[i][55],arrayGrafico120[i][56],arrayGrafico120[i][57],arrayGrafico120[i][58],arrayGrafico120[i][59],arrayGrafico120[i][60],arrayGrafico120[i][61],arrayGrafico120[i][62],arrayGrafico120[i][63],arrayGrafico120[i][64],arrayGrafico120[i][65],arrayGrafico120[i][66],arrayGrafico120[i][67],arrayGrafico120[i][68],arrayGrafico120[i][69],arrayGrafico120[i][70],arrayGrafico120[i][71],arrayGrafico120[i][72],arrayGrafico120[i][73],arrayGrafico120[i][74],arrayGrafico120[i][75],arrayGrafico120[i][76],arrayGrafico120[i][77],arrayGrafico120[i][78],arrayGrafico120[i][79],arrayGrafico120[i][80],arrayGrafico120[i][81],arrayGrafico120[i][82],arrayGrafico120[i][83],arrayGrafico120[i][84],arrayGrafico120[i][85],arrayGrafico120[i][86],arrayGrafico120[i][87],arrayGrafico120[i][88],arrayGrafico120[i][89],arrayGrafico120[i][90],arrayGrafico120[i][91],arrayGrafico120[i][92],arrayGrafico120[i][93],arrayGrafico120[i][94],arrayGrafico120[i][95],arrayGrafico120[i][96],arrayGrafico120[i][97],arrayGrafico120[i][98],arrayGrafico120[i][99],arrayGrafico120[i][100],arrayGrafico120[i][101],arrayGrafico120[i][102],arrayGrafico120[i][103],arrayGrafico120[i][104],arrayGrafico120[i][105],arrayGrafico120[i][106],arrayGrafico120[i][107],arrayGrafico120[i][108],arrayGrafico120[i][109],arrayGrafico120[i][110],arrayGrafico120[i][111],arrayGrafico120[i][112],arrayGrafico120[i][113],arrayGrafico120[i][114],arrayGrafico120[i][115],arrayGrafico120[i][116],arrayGrafico120[i][117],arrayGrafico120[i][118],arrayGrafico120[i][119],arrayGrafico120[i][120])
         
         // console.log(max)
         // console.log(min)
          for(let e=0; e < 120; e++ ){
           
           //console.log("PRECIO OPEN=",arrayGrafico[i][e])
          // console.log("PRECIO CLOSE=",arrayGrafico[i][e+1])
           
          
           diferencia= max-min
          // console.log(diferencia)
   
           
       
          if (e===0){
   
            // Open de la vela
   
            y1= (altura/diferencia * (max - arrayGrafico120[i][e]))+5;
            //console.log("posicion grafico open=",y1)
            let open = arrayGrafico120[i][e]
            
            //Close
           }else{
             y1=y2
             //console.log("posicion grafico open=",y1)
             
            
           }
             
           Math.abs
        //close de la vela
           y2= (altura/diferencia * (max - arrayGrafico120[i][e+1]))+5;
          // console.log("posicion grafico close=",y2)
       
          
   // aca se empiesa a dibujar cada vela
   //
         context.beginPath();
         if (y1 >y2){
           if (Math.abs(y1-y2)< 3) {
   
             y2= y2-3
           }
           context.strokeStyle="#0ecb81";// vela color verde
         }else{
           if (Math.abs(y1-y2)< 3) {
   
             y2= y2+3
           }
           context.strokeStyle="#f6465d";// vela color rojo
         }
         
        context.lineWidth=anchoVela120;// ancho de la vela
        context.moveTo(x1, y1);// pocision del open de la vela
        context.lineTo(x1,y2);//pocicion del close de la vela
        context.stroke();
        context.closePath();//termina el dibujo de la vela
        x1 =(anchoGrafico120/120)+ x1;// se repocicionan las variable donde va a dibujarse la siguiente vela
        
         }
       /////////////111111111111111111111111
       
      // console.log(i)
       
       ////////////////////111111111111111111111111111
       
       //****cambio13/2/22********************************************************* */
   
         var txt = canvas.getContext("2d");
      
           tamaniotxt=17
         //tamaño de fuente y tipo de fuente
        // txt.font = tamaniotxt+"px 	Microsoft Sans Serif";
        
       txt.font = tamaniotxt+"px 	Courier";
          //color del texto
         txt.fillStyle= "#FFFFFF";
        //txt.fillStyle= "yellow";
       
         //console.log(Math.sqrt(tamaniotxt))
          
   
         //lo que va a decir el text y su posicion dentro del cambas 
          txt.fillText(conservarsimbolo120[i]  , 20,Math.abs(15));
          
          txt.fillStyle= "grey";
         txt.fillText("www.monitorfuturosbinance.com", 0,Math.abs(118));
   
   
   
   
         //fin 13/2/22*****************************************************************************************************
     
       ///////////////////////////////222222222222222222222222222222222
       
       if (i<=Cantidadmonedascargadasentexto){
       function RestaurarImagen(canvas){
         var dataURL = canvas.toDataURL()
         dataURL=dataURL.slice(1)
        dataURL=dataURL.slice(1)
        dataURL=dataURL.slice(1)
        dataURL=dataURL.slice(1)
        dataURL=dataURL.slice(1)
        dataURL=dataURL.slice(1)
        dataURL=dataURL.slice(1)
        dataURL=dataURL.slice(1)
        dataURL=dataURL.slice(1)
        dataURL=dataURL.slice(1)
        dataURL=dataURL.slice(1)
        dataURL=dataURL.slice(1)
        dataURL=dataURL.slice(1)
        dataURL=dataURL.slice(1)
        dataURL=dataURL.slice(1)
        dataURL=dataURL.slice(1)
        dataURL=dataURL.slice(1)
        dataURL=dataURL.slice(1)
        dataURL=dataURL.slice(1)
        dataURL=dataURL.slice(1)
        dataURL=dataURL.slice(1)
        dataURL=dataURL.slice(1)      
     //   imagenes=  document.getElementById("Textbox"+(i))
      //  imagenes.textContent=dataURL  
       canvasTelegramArray120[i]=dataURL // 
       //  console.log(dataURL)
       }
   RestaurarImagen(canvas)
       
   }
       
       ///////////////22222222222222222  
         
         
         
         }
      
       
      }
 /////////////////////////////////////////////////////////////////////// /////////////////////////////////////////////////////////////////////// 
/////////////////////////////////////////////////////////////////////// inicio telegram //////////////

var muestra

const telegram = {
  // Configuración por defecto
  configTelegram: {
    baseURL: 'https://api.telegram.org/bot',
    token: '5077718811:AAEDu3DZFQl1QIbF7QRnUkxfpOWSYNntcjc',
    //chat id cesar 1969326770
    //chat id guillermo 2128803955
    chat_id: '2128803955',
    parse_mode: 'MarkdownV2',
  },

  /** 
   * @description Este método esta pensado para configurar dinámicante el bot de Telegram desde fuera y así poder enviar mensajes a múltiples bot
   * @param {string} token Token API para la validación de nuestro Bot
   * @param {string} chat_id El identificador del bor para comunicarnos con el Bot
   */

  config: (token, chat_id) => {
    telegram.configTelegram.token = token || telegram.configTelegram.token || '';
    telegram.config.chat_id = chat_id || telegram.configTelegram.chat_id || '';
  },

  /** 
   * @description Este método se usa para enviar un mensaje a nuestro Bot
   * @param {string} msn Mensaje que vamos a enviar
   * @param {string} type Es el tipo de mensaje. 'text': Es un mensaje de texto, 'whatever is': Envia una imagen
   * @return 
   */


  send: async (msn = '', type = 'text') => {
    
    const { baseURL, token, chat_id, parse_mode } = telegram.configTelegram;
    const endPoint = type === 'text'?  'sendMessage' : 'sendSticker';
  //  const endPoint = type === 'text'?  'sendPhoto' : 'sendSticker';
   
    const url = new URL(`${baseURL}${token}/${endPoint}`);
    muestra=telegram.configTelegram
    // Imagen de prueba
   // const image =document.getElementById("imagen").value;
    const params = {
      chat_id: chat_id
     // parse_mode: parse_mode
    };
    const hasText = type === 'text';
    params[hasText ? 'text' : 'sticker'] = hasText ? msn : image;
    
    Object.keys(params).forEach(key =>{url.searchParams.append(key, params[key])
       })
    return await (await fetch(url).then(console.log(params))).json().catch(error => error);
  },
};

    //funcion del boton 
function refsend() {
console.log('recibido')
  try {
    
  
   telegram.send(document.getElementById('moneda1').value, 'text');
   // telegram.send('hola', 'text');
  } catch (err) {
    console.log(err);
  }}

  function sleep(milliseconds){
   const date11 = Date.now();
  let currentDate = null;
  do 
    currentDate = Date.now();
   while (currentDate - date11 < milliseconds);}
 ///////////////////// para recargar en el segundo 9 solamente 
 function mueveReloj(){


var button = document.getElementById('submit');


button.click()

  //location.reload();


   }
   
   
   function porcentajeVariacion(preciomasalto1,preciomasbajo1,ultimoprecio1){    
            let porcentajeac;                     
             
             porcentajetotal = 100 - (preciomasbajo1 * 100 / preciomasalto1)
                     
             if ( (preciomasalto1 - ultimoprecio1) >= (ultimoprecio1 - preciomasbajo1))
             {

                porcentajeac = 100 - (ultimoprecio1 * 100 / preciomasalto1)

             }
             else 
             {

                porcentajeac = 100 - (ultimoprecio1 * 100 / preciomasbajo1)
                           
             }
              
             porcentajeac =   Math.abs(porcentajeac)
             

             return porcentajeac 
}




   
   
   
   


</script>
   
</body>
 
</html>