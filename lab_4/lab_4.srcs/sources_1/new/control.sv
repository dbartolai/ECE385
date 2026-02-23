module control(
    input  logic clk, reset, run, M,
    output logic add_out, sub_out, shift_out, clr_ld, start_multiply
);

    //Internal sigals
    logic [3:0] count;

    //States
    enum logic [2:0] {
        rst,
        check_count,
        add,
        shift,
        sub,
        halt
    } curr_state, next_state;


    //STATE REGISTER
    always_ff @(posedge clk) begin
        if (reset)
            curr_state <= rst;
        else
            curr_state <= next_state;
    end


    //COUNTER
    always_ff @(posedge clk) begin
        if (reset)
            count <= 4'd0;
        else if (curr_state == rst)
            count <= 4'd0;
        else if (curr_state == shift)
            count <= count + 1'b1;
        else if(curr_state == halt)
            count <= 4'd0;
    end
    
    
    //RISING EDGE RUN DETECT
    logic run_d;
    
    always_ff @(posedge clk)
        run_d <= run;
        
    logic run_rise;
     assign run_rise = run & ~run_d;



    //STATE TRANSITIONS
    always_comb begin
        next_state = curr_state;

        unique case (curr_state)

            rst: 
                next_state = halt; //wait in halt so clr_ld isn't high for to long

            check_count:
                if (count == 4'd8)
                    next_state = halt;
                else if (M == 1'b1) begin
                    if (count == 4'd7)
                        next_state = sub;
                    else
                        next_state = add;
                end
                else
                    next_state = shift;

            add:   next_state = shift;
            shift: next_state = check_count;
            sub:   next_state = shift;

            halt:
                if (reset == 1'b1)
                    next_state = rst;
                else if (run_rise) 
                    next_state = check_count;

        endcase
    end



    //OUTPUT LOGIC
    always_comb begin
        add_out        = 1'b0;
        sub_out        = 1'b0;
        shift_out      = 1'b0;
        clr_ld         = 1'b0;
        start_multiply = 1'b0;
        case (curr_state)

            rst: begin
                add_out   = 1'b0;
                sub_out   = 1'b0;
                shift_out = 1'b0;
                clr_ld    = 1'b1;
            end

          
            add: begin
                add_out   = 1'b1;
                sub_out   = 1'b0;
                shift_out = 1'b0;
                clr_ld    = 1'b0;
            end

            sub: begin
                add_out   = 1'b0;
                sub_out   = 1'b1;
                shift_out = 1'b0;
                clr_ld    = 1'b0;
            end

            shift: begin
                add_out   = 1'b0;
                sub_out   = 1'b0;
                shift_out = 1'b1;
                clr_ld    = 1'b0;
            end
            
            halt: begin
                if(run_rise) begin
                    add_out   = 1'b0;
                    sub_out   = 1'b0;
                    shift_out = 1'b0;
                    clr_ld    = 1'b0;
                    start_multiply = 1'b1;
               end
            end

            default: begin
                add_out   = 1'b0;
                sub_out   = 1'b0;
                shift_out = 1'b0;
                clr_ld    = 1'b0;
                start_multiply = 1'b0;
            end

        endcase
    end

endmodule
