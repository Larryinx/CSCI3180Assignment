(*
* CSCI3180 Principles of Programming Languages
*
* --- Declaration ---
* I declare that the assignment here submitted is original except for source
* materials explicitly acknowledged. I also acknowledge that I am aware of
* University policy and regulations on honesty in academic work, and of the
* disciplinary guidelines and procedures applicable to breaches of such policy
* and regulations, as contained in the website
* http://www.cuhk.edu.hk/policy/academichonesty/
*
* Name: LI Yinxi
* Student ID: 1155160255
* Email Address: 1155160255@link.cuhk.edu.hk
*
* Source material acknowledgements (if any):
*
* Students whom I have discussed with (if any):
*
*)

(* Part 1 *)

(* Q1 (a): Reverse a list using the @ operator. *)
fun reverse lst : int list =
    case lst of
        [] => []
      | x::xs => (reverse xs) @ [x];

(* Test cases *)
reverse [];  (* This should return [] *)
reverse [3, 1, 8, 0];  (* This should return [0, 8, 1, 3] *)


(* Q1 (b): Reverse a list without using the rev function and @ operator. *)
fun reverse lst : int list =
    let
        fun aux lst acc =
            case lst of
                [] => acc
              | x::xs => aux xs (x::acc)
    in
        aux lst []
    end;

(* Test cases *)
reverse [];  (* This should return [] *)
reverse [3, 1, 8, 0];  (* This should return [0, 8, 1, 3] *)


(* Q2: Partial derivative of bivariate polynomials *)
(* constructers *)
datatype term = Term of int * int * int;
datatype variable = Variable of string;
datatype poly = Poly of variable * variable * term list;

(* Several functions you may find helpful for computations over polynomials *)
fun expon_x (Term(e, _, _)) = e;
fun expon_y (Term(_, e, _)) = e;
fun coeff (Term(_, _, c)) = c;

exception VariableMismatch; 

(* Derivative of terms in a polynomial list *)
fun diff_terms (l : term list, v : variable) : term list = 
    let
        fun extract_var (Variable s) = s

        val var_str = extract_var v

        fun diff_single_term (Term(e, f, c), var) =
            case var of
                 "x" => if e > 0 then [Term(e-1, f, e * c)] else []
               | "y" => if f > 0 then [Term(e, f-1, f * c)] else []

        fun diff_list ([], _) = []
          | diff_list (term::terms, var) =
            diff_single_term (term, var) @ diff_list (terms, var)
    in
        diff_list (l, var_str)
    end
;

fun diff_poly (Poly(xx, yy, l), v) : poly =
    if (xx = v) orelse (yy = v) then
        Poly(xx, yy, diff_terms (l, v))
    else
        raise VariableMismatch
;


(*
* We assume the all polynomials are bivariate with variables x and y.
* And all the inputs strictly follow the data structures defined above.
* You are not required to raise any exceptions or do any type checking in the implementation. 
*)
val x = Variable "x";
val y = Variable "y";

(* Test cases *)
val p = Poly(x, y, [Term(3, 1, 3), Term(2, 0, 1), Term(0, 2, ~4), Term(1, 1, 2), Term(0, 0, 1)]);
diff_poly(p, x);  (* Should return Poly(Variable "x", Variable "y", [Term(2, 1, 9), Term(1, 0, 2), Term(0, 1, 2)]) *)
diff_poly(p, y);  (* Should return Poly(Variable "x", Variable "y", [Term(3, 0, 3), Term(0, 1, ~8), Term(1, 0, 2)]) *)


(* Task 1: Function to check if any three cards out of five total to a multiple of 10 *)
fun check_bull cards =
    case cards of
        [a, b, c, d, e] =>
            (a + b + c) mod 10 = 0
            orelse (a + b + d) mod 10 = 0
            orelse (a + b + e) mod 10 = 0
            orelse (a + c + d) mod 10 = 0
            orelse (a + c + e) mod 10 = 0
            orelse (a + d + e) mod 10 = 0
            orelse (b + c + d) mod 10 = 0
            orelse (b + c + e) mod 10 = 0
            orelse (b + d + e) mod 10 = 0
            orelse (c + d + e) mod 10 = 0
      | _ => raise Fail "Invalid input: List must contain exactly five elements."
;

(* Test cases of Task 1*)
val result_1_1 = check_bull ([10, 2, 6, 2, 4]);
val result_1_2 = check_bull ([3, 7, 4, 6, 5]);


(* Task 2: Function to calculate points when the list is a Bull *)
fun get_point_bull cards =
    case cards of
        [a, b, c, d, e] =>
            if (a + b + c) mod 10 = 0 then (d + e) mod 10
            else if (a + b + d) mod 10 = 0 then (c + e) mod 10
            else if (a + b + e) mod 10 = 0 then (c + d) mod 10
            else if (a + c + d) mod 10 = 0 then (b + e) mod 10
            else if (a + c + e) mod 10 = 0 then (b + d) mod 10
            else if (a + d + e) mod 10 = 0 then (b + c) mod 10
            else if (b + c + d) mod 10 = 0 then (a + e) mod 10
            else if (b + c + e) mod 10 = 0 then (a + d) mod 10
            else if (b + d + e) mod 10 = 0 then (a + c) mod 10
            else if (c + d + e) mod 10 = 0 then (a + b) mod 10
            else 0
      | _ => raise Fail "Invalid input: List must contain exactly five elements."
;

(* Test cases of Task 2*)
val result_2_1 = get_point_bull ([10, 2, 6, 2, 4]);
val result_2_2 = get_point_bull ([7, 3, 10, 2, 8]);


(* Task 3: Function to get the maximum point value from a list of five non-Bull cards *)
fun get_point_non_bull cards =
    case cards of
        [a, b, c, d, e] =>
            let
                fun max (x, y) = if x > y then x else y
            in
                max (a, max (b, max (c, max (d, e))))
            end
      | _ => raise Fail "Invalid input: List must contain exactly five elements."
;

(* Test cases of Task 3*)
val result_3 = get_point_non_bull([3, 7, 4, 6, 5]);


(* Task 4: Function to compare the results of two players and decide the winner or if there is a tie *)
fun compare_result (lst1, lst2) =
    let
        (* Determine if each player has a Bull *)
        val isBull1 = check_bull lst1
        val isBull2 = check_bull lst2
        (* Calculate points for each player *)
        val points1 = if isBull1 then get_point_bull lst1 else get_point_non_bull lst1
        val points2 = if isBull2 then get_point_bull lst2 else get_point_non_bull lst2
    in
        if isBull1 andalso not isBull2 then "Player 1 wins"
        else if not isBull1 andalso isBull2 then "Player 2 wins"
        else if points1 > points2 then "Player 1 wins"
        else if points1 < points2 then "Player 2 wins"
        else "This is a tie"
    end

(* Test cases of Task 4*)
val lst1 = [10, 2, 6, 2, 4];
val lst2 = [3, 7, 4, 6, 5];
val result_4 = compare_result (lst1, lst2);