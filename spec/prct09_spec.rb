require './lib/prct09.rb'

describe Matrix do
        before :each do
		@ma = MatrixDens.new(2,2)
		@ma.rellenar([[Fraccion.new(1,2),2],[1,Fraccion.new(1,2)]])
	
		@mb = MatrixDens.new(2,2)
		@mb.rellenar([[1,1],[1,1]])
		
        end
	
        describe "Suma Matriz " do
                it "Suma" do
			  
                        (@ma + @mb).mostrar.should eq("   1 1 \n   1 1 \n ")
                end
        end
	
	describe "Resta Matriz" do
                it "Resta" do
                        (@ma - @mb).mostrar.should eq("   -2/4 0 \n   2/6 -6/10 \n ")
                end
	end
end
