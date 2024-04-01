/*
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
*/

% 1a
is_palindrome(L) :- reverse(L, L).

% 1b
interleave([], [], []).
interleave([X|L1], [Y|L2], [X,Y|L3]) :- interleave(L1, L2, L3).

% 1c
duplicate_elements([], []).
duplicate_elements([X|L1], [X,X|L2]) :- duplicate_elements(L1, L2).

% 2a
knowledge_tree(kt(m, [kt(a, [kt(r, []), kt(s, [])]),
                      kt(g, []),
                      kt(i, []),
                      kt(c, [kt(h, [])])])).

% 2b
node_depth(kt(Node, _), Node, s(0)).
node_depth(kt(Char, Forest), Node, s(Depth)) :-
    Char \= Node, 
    member(kt(SubChar, SubForest), Forest), 
    node_depth(kt(SubChar, SubForest), Node, Depth). 

% 2c
num_node(kt(_, []), s(0)).
num_node(kt(_, Forest), N) :-
    num_nodes_in_forest(Forest, s(0), N).

num_nodes_in_forest([], Acc, Acc).
num_nodes_in_forest([Tree|Rest], Acc, N) :-
    num_node(Tree, NumSubTree),
    add(NumSubTree, Acc, NewAcc),
    num_nodes_in_forest(Rest, NewAcc, N).

add(0, N, N).
add(s(N), M, s(O)) :- add(N, M, O).

% 2d
num_leaf(kt(_, []), s(0)).
num_leaf(kt(_, Forest), N) :-
    Forest \= [],  
    num_leaf_forest(Forest, N).

num_leaf_forest([], 0).
num_leaf_forest([Tree|Rest], N) :-
    num_leaf(Tree, NumLeafTree),
    num_leaf_forest(Rest, NumLeafRest),
    add(NumLeafTree, NumLeafRest, N).

% 2e
path_to_node(kt(Node, _), Node, [Node]).
path_to_node(kt(Char, Forest), Node, [Char | PathToNode]) :-
    Char \= Node, 
    member(SubTree, Forest), 
    path_to_node(SubTree, Node, PathToNode). 

