#!/usr/bin/ruby

require './lib/racional.rb'

#---------------------------------------------------------------------------------------------------------------------------------

# Clase Matrix Padre, es la clase de la que se va heredar la incializción de los matrices hijos con sus filas y columnas

 class Matrix
  attr_reader:m, :n, :val, :matrix
    def initialize(m,n)
      @m = m
      @n = n
      @matrix = Array.new(@m){Array.new(@n){0}}
    end       
 end
    
 #---------------------------------------------------------------------------------------------------------------------------------

 # La Clase MatrixDensa hija de Matrix se implementan todas las operaciones a realizar por las Matrice Densas 
 
 class MatrixDens < Matrix
    attr_accessor :matrixD
    
#      Incialización de matriz

    def initialize(rows,cols)
         @matrixD = Array.new(rows) {Array.new(cols)}
         super
     end
     
#    Método para rellenar y asignar valores a la matriz  
     
     def rellenar (val)
      for i in 0...@m
	for j in 0...@n
	  self.matrixD[i][j] = val[i][j] 
	end
      end
    end    
    
#    Utlizo este método mostrar para imprimir los matrices
    
     def mostrar
      mr = " "
      for i in 0...@m
        mr << " "
        for j in 0...@n
         mr << "#{matrixD[i][j]} "
        end
        mr << "\n "
      end
      print mr
      return mr
    end
    
#    La suma matrices densa, cuyo valores obtenido se rellenan con el objeto de mr 
     
     def + (other)
	aux = Array.new(@m){Array.new(@n){0}}
	for i in 0...@m do
	  for j in 0...@n do
	     aux[i][j] = self.matrixD[i][j] + other.matrixD[i][j]
	  end
	end
	mr = MatrixDens.new(other.m, other.n)
	mr.rellenar(aux)
	return(mr)
    end
   
#   La resta matrices densa, cuyo valores obtenido se rellenan con el objeto de mr 
       
    def - (other)
       aux = Array.new(@m){Array.new(@n){0}}
	for i in 0...@m do
	  for j in 0...@n do
	    aux[i][j] = self.matrixD[i][j] - other.matrixD[i][j]
	  end
	end
	mr = MatrixDens.new(other.m, other.n)
	mr.rellenar(aux)
	return (mr)
    end
    
 end 
  
#--------------------------------------------------------------------------------------------------------------------------------- 
 
# La Clase SparseMatrix  otra hija de Matrix que se caracteriza por tener el 60% de los elementos nulos implementan 
# todas las operaciones a realizar por las Matrices Disperas 
 
 class SparseMatrix < Matrix
  
  attr_reader:hash , :matrixD
   
#      Incialización de matriz
  
  def initialize(a,b)
    super(a, b)
    posaux = 0
    @hash = Hash.new(0) 
  end
  
#    Utlizo este método mostrar para imprimir los matrices
  
  def mostrarD
    @matrixD.each{|key, value| puts "  #{key} #{value}" } 
  end
  
  #    Método para rellenar y asignar valores a la matriz  
  
  def rellenar(val)
    @matrixD = Array.new(val)     
     for i in 0...@m do
       for j in 0...@n do
               posaux ="#{i}#{j}"
		if (val[i][j].is_a?Fraccion)
		  a = val[i][j].num
		  b = val[i][j].denom
		  @hash[posaux] = Fraccion.new(a,b)             
		else
		  @hash[posaux] = val[i][j]
		end
	end
      end
  end
  
#   La suma matrices dispersa, que tras comprobar si el tipo de objeto pasado por parametro. se realiza una operacion o la otra
#  los valores obtenido se rellenan con el objeto de mr  
  
  def + (other)
    if (other.is_a?SparseMatrix)
      hash_aux = self.hash.merge(other.hash){|key, val1, val2| val1.merge(val2){|key2, val1_2, val2_2|val2_2 + val1_2}}
      mr = SparseMatrix.new(self.m, self.n)
      mr.rellenar(hash_aux)
      return (mr)
  
    else
       aux = Array.new(@m){Array.new(@n){0}}
	for i in 0...@m do
	  for j in 0...@n do
	     aux[i][j] = self.matrixD[i][j] + other.matrixD[i][j]
	  end
	end
      mr = MatrixDens.new(other.m, other.n)
      mr.rellenar(aux)
      return (mr)
    end
  end
   
#  La resta matrices dispersa, que tras comprobar si el tipo de objeto pasado por parametro, se realiza una operacion o la otra
#  los valores obtenido se rellenan con el objeto de mr  
  
  def - (other)
    if (other.is_a?SparseMatrix)
      hash_aux = self.data.merge(other.data){|key, val1, val2| val1.merge(val2){|key2, val1_2, val2_2|val2_2 - val1_2}}
      mr = SparseMatrix.new(self.fil, self.col, hash_aux)
      return (mr)
      
    else
      aux = Array.new(@m){Array.new(@n){0}}
	for i in 0...@m do
	  for j in 0...@n do
	     aux[i][j] = self.matrixD[i][j] - other.matrixD[i][j]
	  end
	end
      mr = MatrixDens.new(other.m, other.n)
      mr.rellenar(aux)
      return (mr)
   end
    
 end
      
end
#---------------------------------------------------------------------------------------------------------------------------------  

#   Subprograma Main para comprobar los métodos y las operaciones con las matrices

 puts "--Practica 10--" 
 puts
 ma = MatrixDens.new(2,2)
 ma.rellenar([[Fraccion.new(1,2),2],[1,Fraccion.new(1,2)]])
 puts "Matriz Densa A"
 ma.mostrar()
 puts
 
 mb = MatrixDens.new(2,2)
 mb.rellenar([[1,1],[1,1]])
 puts "Matriz Densa B"
 mb.mostrar()
 puts
 
 mr = MatrixDens.new(2,2)
 mr = ma + mb
 puts "Suma Matrices Densas"
 mr.mostrar()
 puts
 
 mr = MatrixDens.new(2,2)
 mr = ma - mb
 puts "Resta de Matrices Densas" 
 mr.mostrar()
 puts

 mc = SparseMatrix.new(2,2)
 mc.rellenar([[1,0],[0,0]])
 puts "Matriz Dispersa A"
 mc.mostrarD()
 puts
 
 mr = MatrixDens.new(2,2)
 mr = mc + mb
 puts "Suma Matriz Densa con Dispersa"
 mr.mostrar()
 puts

 mr = MatrixDens.new(2,2)
 mr = mb - mc
 puts "Resta Matriz Densa con Dispersa"
 mr.mostrar()
 puts
 
 mr = MatrixDens.new(2,2)
 mr = mc - mb
 puts "Resta Matriz Dispersa con Densa"
 mr.mostrar()
 puts
 
#  mr = MatrixDens.new(2,2)
#  mr = mc + ma
#  puts "Suma Matriz Densa Racional con Dispersa"
#  mr.mostrar()
#  puts
 
 md = SparseMatrix.new(2,2)
 md.rellenar([[0,Fraccion.new(1,2)],[0,0]])
 puts "Matriz Dispersa B"
 md.mostrarD()
 puts
 
#  mr = SparseMatrix.new(2,2)
#  mr = mc + md
#  puts "Suma Matrices Dispersas"
#  mr.mostrarD()
#  puts