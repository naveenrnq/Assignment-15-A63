
class generator;
  
  rand bit [4:0] a;
  rand bit [5:0] b;

  int failure_count;

  function new();
    failure_count = 0;
  endfunction

  function void pre_randomize();
    //
  endfunction

  constraint data {
    a inside {[0:8]};
    b inside {[0:5]};
   }

  function void post_randomize();
    $display("a = %0d, b = %0d", a, b);
  endfunction
 
  task automatic display_randomized_error_count();
    $display("The number of times randomization failed is: %0d", failure_count);
  endtask
 
endclass
 

module tb;

 generator g;
 int i = 0;

 initial begin

   g = new();


   for(i = 0; i < 20; i++) begin

     assert(g.randomize()) 
     else begin
       g.failure_count++;
       $display("Toc check");
     end
     #10;
   end
   g.display_randomized_error_count();

 end


endmodule
