//9 bit adder takes inputs made of 9 full adders in a CRA design

//1 bit full adder
module full_adder(  input logic a, b, cin,
                    output logic s, cout);
                    assign s = a ^ b ^ cin;
                    assign  cout = (a & b) | (a & cin) | (b & cin);

endmodule


//9bit adder/subtractor

module adder9(  input logic [8:0] A, B,
                input logic sub_select,
                output logic [8:0] S,
                output logic cout);
                
                //interanl logic
                logic [9:0] C; //carry for all adders and cout  
                assign C[0] = sub_select;
                logic [8:0] B_updated; //ammend b if subtraction select is chosen 
                //-B = ~B + 1
                always_comb begin
                    B_updated = B;      //base case
                    if(sub_select) begin      //if sub_select 1 invert B for subtraction
                        B_updated = ~B;
                    end
                end
                
                //instanite modules
                full_adder FA0 (.a(A[0]), .b(B_updated[0]), .cin(C[0]), .s(S[0]), .cout(C[1]));
                full_adder FA1 (.a(A[1]), .b(B_updated[1]), .cin(C[1]), .s(S[1]), .cout(C[2]));
                full_adder FA2 (.a(A[2]), .b(B_updated[2]), .cin(C[2]), .s(S[2]), .cout(C[3]));
                full_adder FA3 (.a(A[3]), .b(B_updated[3]), .cin(C[3]), .s(S[3]), .cout(C[4]));
                full_adder FA4 (.a(A[4]), .b(B_updated[4]), .cin(C[4]), .s(S[4]), .cout(C[5]));
                full_adder FA5 (.a(A[5]), .b(B_updated[5]), .cin(C[5]), .s(S[5]), .cout(C[6]));
                full_adder FA6 (.a(A[6]), .b(B_updated[6]), .cin(C[6]), .s(S[6]), .cout(C[7]));
                full_adder FA7 (.a(A[7]), .b(B_updated[7]), .cin(C[7]), .s(S[7]), .cout(C[8]));
                full_adder FA8 (.a(A[8]), .b(B_updated[8]), .cin(C[8]), .s(S[8]), .cout(C[9]));

                assign cout = C[9];
                
                
endmodule