class Nuevo
{

  float ancho, alto, x, y, numero;
  String nom, posicion;

  Nuevo(float _x, float _y, float _numero, String _nombre)
  {
    ancho = 450;
    alto = 90;
    x = _x;
    y = _y;
    numero = _numero;
    nom = _nombre;
  }
  void update(float nuevoy, String _posicion)
  {

    y = nuevoy;
    posicion = _posicion;
  }

  float peso()
  {
    float valor = numero;
    return valor;
  }

  String Nombre()
  {
    String NOM = nom;
    return NOM;
  }

  void draw()
  {
    rect(x, y, ancho, alto);
    fill(0);
    text(posicion, x +10, y+22);
    text("Nombre: "+nom, x + 10, y + 47);
    text("Fuerza: "+numero, x + 10, y + 72);
    fill(255);
  }
}

import processing.serial.*;

Serial mipuerto;

float dato = 0;

ArrayList<Nuevo> lista;

String nombre = "";
String Auxnombre = "";
char letras;

String fin = "fin";

PFont myFont, Titulo, Instrucciones;

PFont nuevoFont, finFont;
int t = 0;
int bandera = 1;
float r = 1;

boolean anadir = false;
boolean empezar = false;
boolean escribe = false;
boolean golpee = false;

PImage VAMOS, GOLPE;

int PantallaX = 1366;
int PantallaY = 768;

void setup()
{
  size(1366, 768);
  noLoop();
  background(255);
  mipuerto = new Serial(this, Serial.list()[0], 9600);
  mipuerto.bufferUntil('\n'); 
  lista = new ArrayList<Nuevo>();
  myFont = createFont("Georgia", 25);
  Titulo = createFont("Goudy Stout", 40);
  finFont = createFont("Georgia", 400);
  Instrucciones = createFont("Calibril", 30);
  VAMOS = loadImage("vamos.jpg");
  GOLPE = loadImage("golpe.jpg");
}

void draw()
{
  if (empezar == false)
  {
    image(VAMOS, 0, -20, PantallaX, PantallaY);
    fill(0);
    textFont(Instrucciones);
    text("Presione Intro para iniciar", 30, 670);
  } else
  {

    background(100, 150, 25);

    if (escribe == false)
    {
      textFont(Titulo);
      fill(0);
      text("Nombre: "+ Auxnombre, 30, 300);
      textFont(Instrucciones);
      fill(255);
      text("Introduce un nombre y pulsa una flecha para iniciar", 30, 630);
      text("Introduce 'fin' para finalizar", 30, 670);
    } else
    {
      if (nombre.equals(fin) == false)
      {

        if (golpee == false)
        {
          image(GOLPE, 0, 0, PantallaX, PantallaY);   
          if (dato >= 10)
          {
            golpe(dato);
          }
        } else
        {

          fill(0);

          textFont(Titulo);
          text("TOP 5", 200, 40);
          text("GENERAL", 780, 40);

          textFont(myFont); 

          fill(100);

          rect(50, 60, 500, 100);
          rect(50, 180, 500, 100);
          rect(50, 300, 500, 100);
          rect(50, 420, 500, 100);
          rect(50, 540, 500, 100);

          fill(200);

          rect(700, 60, 500, 580);

          fill(255);
          text("Presione Ctrl para comenzar", 30, 670);

          for (int i = 0; i<lista.size() && i<5; i++)
          {
            Nuevo n = lista.get(i);
            if (i == 0)
            {
              n.update(65, "Primero");
            } 
            else if (i == 1)
            {
              n.update(185, "Segundo");
            } 
            else if (i == 2)
            {
              n.update(305, "Tercero");
            } 
            else if (i == 3)
            {
              n.update(425, "Cuarto");
            } 
            else if (i == 4)
            {
              n.update(545, "Quinto");
            }
            n.draw();
          }
          if (lista.size() >= 20)
          {
            for (int l = 19; l<lista.size(); l++)
            {
              lista.remove(l);
            }
          }

          for (int i = 0; i<lista.size(); i++)
          {
            float Y = 85 + 30*i;
            text((i+1)+"º "+lista.get(i).Nombre()+" con "+lista.get(i).peso(), 710, Y);
          }
        }
      } else if (lista.size() >= 1)
      {
        background(0, 100, 100);
        if (bandera == 1)
        {
          textFont(finFont);
          text("EL GANADOR ES", 1000 - t, 400);
          t=t+5;
        } else
        {
          nuevoFont = createFont("Georgia", r);
          textFont(nuevoFont);
          if (lista.get(0).Nombre().length() >= 6)
          {
            text(lista.get(0).Nombre().substring(0, 6), 470 - r, 400);
          } 
          else
          {
            text(lista.get(0).Nombre(), 470 - r, 400);
          }
          textFont(finFont);
          r = r + 5;
        }

        if ((1000 - t) <= -3200)
        {
          bandera = bandera + 1 ;
        }
        if (r >= 400)
        {
          stop();
          delay(300);
          exit();
        }
      } 
      else
      {
        exit();
      }
    }
  }
}

void golpe(float _Dato)
{
  float _dato = _Dato;
  if (anadir == true)
  {
    if (lista.size() == 0)
    {
      lista.add(new Nuevo(75, 10, _dato, nombre));
    } 
    else if (lista.size() == 1)
    {
      lista.add(new Nuevo(75, 50, _dato, nombre));
    } 
    else if (lista.size() == 2)
    {
      lista.add(new Nuevo(75, 90, _dato, nombre));
    } 
    else if (lista.size() == 3)
    {
      lista.add(new Nuevo(75, 130, _dato, nombre));
    } 
    else if (lista.size() == 4)
    {
      lista.add(new Nuevo(75, 170, _dato, nombre));
    } 
    else
    {
      lista.add(new Nuevo(75, 255, _dato, nombre));
    }
    anadir = false;
    golpee = true;
  }

  if (lista.size() >= 2)
  {
    for (int j = 1; j<lista.size(); j++)
    {
      for (int k = 0; k<j; k++)
      {
        if (lista.get(j).peso() > lista.get(k).peso())
        {
          Nuevo aux2 = lista.get(j);
          lista.set(j, lista.get(k));
          lista.set(k, aux2);
        }
      }
    }
  }
}

void keyPressed()
{
  if (escribe == false)
  {
    if ((keyCode >= 37) && (keyCode <= 40))
    {
      nombre = Auxnombre;
      Auxnombre = "";
      anadir = true;
      escribe = true;
    } else if (keyCode >= 65 && keyCode <=90) {
      letras = key;
      keyPressed = false;
      Auxnombre = Auxnombre + letras;
    } else if (keyCode == 8 && Auxnombre.length() > 0)
    {
      Auxnombre = Auxnombre.substring(0, Auxnombre.length() - 1);
    }
  }
  if (keyCode == 10)
  {
    empezar = true;
  }
  if (keyCode == 17)
  {
    escribe = false;
    golpee = false;
  }
  keyPressed = false;
}

void serialEvent(Serial myport) {
  String str = myport.readStringUntil('\n');
  dato = float(str);
  redraw();
}