require "./lib/matriz.rb"
#require "matriz.rb"        

        describe Matrix do
                before :each do
		   @ma = MatrixDens.new(2,2)
		   @ma.rellenar([[Fraccion.new(1,2),2],[1,Fraccion.new(1,2)]])
		   @mb = MatrixDens.new(2,2)
		   @mb.rellenar([[1,1],[1,1]])
		   @mr = MatrixDens.new(2,2)
		   @mc = SparseMatrix.new(2,2)
		   @mc.rellenar([[1,0],[0,0]])
# 		   @md = SparseMatrix.new(2,2)
# 		   @md.rellenar([[0,Fraccion.new(1,2)],[0,0]])

                end
               
                describe "Comprobación de:" do
                  it "filas de la matriz" do
                     @ma.m.should eq(2)
                  end
                  it "columnas de la matriz" do
                     @ma.n.should eq(2)
                  end
                end
                                    
                
                describe "Mostración de Matrices: " do
                
                 it " Matriz densa con racionales" do
                        @ma.mostrar.should eq("  1/2 2 \n  1 1/2 \n ")
                 end
		  
                 it " Matriz densa normal" do
                        @mb.mostrar.should eq("  1 1 \n  1 1 \n ")
                 end
		  
                 it " Matriz dispersa" do
                        @mc.mostrarD.should eq ([[1, 0], [0, 0]])
		 end
		 
# 		 it " Matriz dispersa con racional" do
#                         @md.mostrarD.should eq ([[0, 1/2], [0, 0]])
# 		 end
                
                end
                
                describe "Operaciones con matrices densas: " do
                
                 it " Suma de matrices" do
		  @mr = @ma+@mb
		  @mr.mostrar.should eq("  3/2 3 \n  2 3/2 \n ")
                 end
		 
		 it " Resta de matrices" do
		  @mr = @ma-@mb
		  @mr.mostrar.should eq("  -1/2 1 \n  0 -1/2 \n ")
                 end     
		 
		end
                
		 describe "Operaciones con matrices densas y dispersas: " do
                
                 it " Suma de matrices" do
		    @mr = @mb+@mc
		    @mr.mostrar.should eq("  2 1 \n  1 1 \n ")
                 end
		 
		  it " Resta de matrices 1 (Densa - Dispersa)" do
		    @mr = @mb-@mc
		    @mr.mostrar.should eq("  0 1 \n  1 1 \n ")
                 end     
		 
		  it " Resta de matrices 2 (Dispersa - Densa)" do
		    @mr = @mc-@mb
		    @mr.mostrar.should eq("  0 -1 \n  -1 -1 \n ")
		  end    
		  
		end
                  
       end