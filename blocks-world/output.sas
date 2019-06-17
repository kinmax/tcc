begin_version
3
end_version
begin_metric
0
end_metric
17
begin_variable
var0
-1
9
Atom holding(a)
Atom on(a, e)
Atom on(a, h)
Atom on(a, m)
Atom on(a, o)
Atom on(a, r)
Atom on(a, t)
Atom on(a, w)
Atom ontable(a)
end_variable
begin_variable
var1
-1
9
Atom holding(e)
Atom on(e, a)
Atom on(e, h)
Atom on(e, m)
Atom on(e, o)
Atom on(e, r)
Atom on(e, t)
Atom on(e, w)
Atom ontable(e)
end_variable
begin_variable
var2
-1
9
Atom holding(h)
Atom on(h, a)
Atom on(h, e)
Atom on(h, m)
Atom on(h, o)
Atom on(h, r)
Atom on(h, t)
Atom on(h, w)
Atom ontable(h)
end_variable
begin_variable
var3
-1
9
Atom holding(r)
Atom on(r, a)
Atom on(r, e)
Atom on(r, h)
Atom on(r, m)
Atom on(r, o)
Atom on(r, t)
Atom on(r, w)
Atom ontable(r)
end_variable
begin_variable
var4
-1
9
Atom holding(t)
Atom on(t, a)
Atom on(t, e)
Atom on(t, h)
Atom on(t, m)
Atom on(t, o)
Atom on(t, r)
Atom on(t, w)
Atom ontable(t)
end_variable
begin_variable
var5
-1
2
Atom clear(a)
NegatedAtom clear(a)
end_variable
begin_variable
var6
-1
2
Atom clear(e)
NegatedAtom clear(e)
end_variable
begin_variable
var7
-1
2
Atom clear(h)
NegatedAtom clear(h)
end_variable
begin_variable
var8
-1
2
Atom clear(r)
NegatedAtom clear(r)
end_variable
begin_variable
var9
-1
2
Atom clear(t)
NegatedAtom clear(t)
end_variable
begin_variable
var10
-1
2
Atom clear(o)
NegatedAtom clear(o)
end_variable
begin_variable
var11
-1
2
Atom clear(w)
NegatedAtom clear(w)
end_variable
begin_variable
var12
-1
2
Atom handempty()
NegatedAtom handempty()
end_variable
begin_variable
var13
-1
9
Atom holding(o)
Atom on(o, a)
Atom on(o, e)
Atom on(o, h)
Atom on(o, m)
Atom on(o, r)
Atom on(o, t)
Atom on(o, w)
Atom ontable(o)
end_variable
begin_variable
var14
-1
9
Atom holding(w)
Atom on(w, a)
Atom on(w, e)
Atom on(w, h)
Atom on(w, m)
Atom on(w, o)
Atom on(w, r)
Atom on(w, t)
Atom ontable(w)
end_variable
begin_variable
var15
-1
9
Atom holding(m)
Atom on(m, a)
Atom on(m, e)
Atom on(m, h)
Atom on(m, o)
Atom on(m, r)
Atom on(m, t)
Atom on(m, w)
Atom ontable(m)
end_variable
begin_variable
var16
-1
2
Atom clear(m)
NegatedAtom clear(m)
end_variable
9
begin_mutex_group
9
5 0
0 0
1 1
2 1
15 1
13 1
3 1
4 1
14 1
end_mutex_group
begin_mutex_group
9
6 0
0 1
1 0
2 2
15 2
13 2
3 2
4 2
14 2
end_mutex_group
begin_mutex_group
9
7 0
0 2
1 2
2 0
15 3
13 3
3 3
4 3
14 3
end_mutex_group
begin_mutex_group
9
16 0
0 3
1 3
2 3
15 0
13 4
3 4
4 4
14 4
end_mutex_group
begin_mutex_group
9
10 0
0 4
1 4
2 4
15 4
13 0
3 5
4 5
14 5
end_mutex_group
begin_mutex_group
9
8 0
0 5
1 5
2 5
15 5
13 5
3 0
4 6
14 6
end_mutex_group
begin_mutex_group
9
9 0
0 6
1 6
2 6
15 6
13 6
3 6
4 0
14 7
end_mutex_group
begin_mutex_group
9
11 0
0 7
1 7
2 7
15 7
13 7
3 7
4 7
14 0
end_mutex_group
begin_mutex_group
9
12 0
0 0
1 0
2 0
15 0
13 0
3 0
4 0
14 0
end_mutex_group
begin_state
8
8
8
1
7
1
0
0
0
0
1
1
0
8
8
4
0
end_state
begin_goal
4
13 7
14 8
15 4
16 0
end_goal
128
begin_operator
pick-up a
0
3
0 5 0 1
0 12 0 1
0 0 8 0
1
end_operator
begin_operator
pick-up e
0
3
0 6 0 1
0 12 0 1
0 1 8 0
1
end_operator
begin_operator
pick-up h
0
3
0 7 0 1
0 12 0 1
0 2 8 0
1
end_operator
begin_operator
pick-up m
0
3
0 16 0 1
0 12 0 1
0 15 8 0
1
end_operator
begin_operator
pick-up o
0
3
0 10 0 1
0 12 0 1
0 13 8 0
1
end_operator
begin_operator
pick-up r
0
3
0 8 0 1
0 12 0 1
0 3 8 0
1
end_operator
begin_operator
pick-up t
0
3
0 9 0 1
0 12 0 1
0 4 8 0
1
end_operator
begin_operator
pick-up w
0
3
0 11 0 1
0 12 0 1
0 14 8 0
1
end_operator
begin_operator
put-down a
0
3
0 5 -1 0
0 12 -1 0
0 0 0 8
1
end_operator
begin_operator
put-down e
0
3
0 6 -1 0
0 12 -1 0
0 1 0 8
1
end_operator
begin_operator
put-down h
0
3
0 7 -1 0
0 12 -1 0
0 2 0 8
1
end_operator
begin_operator
put-down m
0
3
0 16 -1 0
0 12 -1 0
0 15 0 8
1
end_operator
begin_operator
put-down o
0
3
0 10 -1 0
0 12 -1 0
0 13 0 8
1
end_operator
begin_operator
put-down r
0
3
0 8 -1 0
0 12 -1 0
0 3 0 8
1
end_operator
begin_operator
put-down t
0
3
0 9 -1 0
0 12 -1 0
0 4 0 8
1
end_operator
begin_operator
put-down w
0
3
0 11 -1 0
0 12 -1 0
0 14 0 8
1
end_operator
begin_operator
stack a e
0
4
0 5 -1 0
0 6 0 1
0 12 -1 0
0 0 0 1
1
end_operator
begin_operator
stack a h
0
4
0 5 -1 0
0 7 0 1
0 12 -1 0
0 0 0 2
1
end_operator
begin_operator
stack a m
0
4
0 5 -1 0
0 16 0 1
0 12 -1 0
0 0 0 3
1
end_operator
begin_operator
stack a o
0
4
0 5 -1 0
0 10 0 1
0 12 -1 0
0 0 0 4
1
end_operator
begin_operator
stack a r
0
4
0 5 -1 0
0 8 0 1
0 12 -1 0
0 0 0 5
1
end_operator
begin_operator
stack a t
0
4
0 5 -1 0
0 9 0 1
0 12 -1 0
0 0 0 6
1
end_operator
begin_operator
stack a w
0
4
0 5 -1 0
0 11 0 1
0 12 -1 0
0 0 0 7
1
end_operator
begin_operator
stack e a
0
4
0 5 0 1
0 6 -1 0
0 12 -1 0
0 1 0 1
1
end_operator
begin_operator
stack e h
0
4
0 6 -1 0
0 7 0 1
0 12 -1 0
0 1 0 2
1
end_operator
begin_operator
stack e m
0
4
0 6 -1 0
0 16 0 1
0 12 -1 0
0 1 0 3
1
end_operator
begin_operator
stack e o
0
4
0 6 -1 0
0 10 0 1
0 12 -1 0
0 1 0 4
1
end_operator
begin_operator
stack e r
0
4
0 6 -1 0
0 8 0 1
0 12 -1 0
0 1 0 5
1
end_operator
begin_operator
stack e t
0
4
0 6 -1 0
0 9 0 1
0 12 -1 0
0 1 0 6
1
end_operator
begin_operator
stack e w
0
4
0 6 -1 0
0 11 0 1
0 12 -1 0
0 1 0 7
1
end_operator
begin_operator
stack h a
0
4
0 5 0 1
0 7 -1 0
0 12 -1 0
0 2 0 1
1
end_operator
begin_operator
stack h e
0
4
0 6 0 1
0 7 -1 0
0 12 -1 0
0 2 0 2
1
end_operator
begin_operator
stack h m
0
4
0 7 -1 0
0 16 0 1
0 12 -1 0
0 2 0 3
1
end_operator
begin_operator
stack h o
0
4
0 7 -1 0
0 10 0 1
0 12 -1 0
0 2 0 4
1
end_operator
begin_operator
stack h r
0
4
0 7 -1 0
0 8 0 1
0 12 -1 0
0 2 0 5
1
end_operator
begin_operator
stack h t
0
4
0 7 -1 0
0 9 0 1
0 12 -1 0
0 2 0 6
1
end_operator
begin_operator
stack h w
0
4
0 7 -1 0
0 11 0 1
0 12 -1 0
0 2 0 7
1
end_operator
begin_operator
stack m a
0
4
0 5 0 1
0 16 -1 0
0 12 -1 0
0 15 0 1
1
end_operator
begin_operator
stack m e
0
4
0 6 0 1
0 16 -1 0
0 12 -1 0
0 15 0 2
1
end_operator
begin_operator
stack m h
0
4
0 7 0 1
0 16 -1 0
0 12 -1 0
0 15 0 3
1
end_operator
begin_operator
stack m o
0
4
0 16 -1 0
0 10 0 1
0 12 -1 0
0 15 0 4
1
end_operator
begin_operator
stack m r
0
4
0 16 -1 0
0 8 0 1
0 12 -1 0
0 15 0 5
1
end_operator
begin_operator
stack m t
0
4
0 16 -1 0
0 9 0 1
0 12 -1 0
0 15 0 6
1
end_operator
begin_operator
stack m w
0
4
0 16 -1 0
0 11 0 1
0 12 -1 0
0 15 0 7
1
end_operator
begin_operator
stack o a
0
4
0 5 0 1
0 10 -1 0
0 12 -1 0
0 13 0 1
1
end_operator
begin_operator
stack o e
0
4
0 6 0 1
0 10 -1 0
0 12 -1 0
0 13 0 2
1
end_operator
begin_operator
stack o h
0
4
0 7 0 1
0 10 -1 0
0 12 -1 0
0 13 0 3
1
end_operator
begin_operator
stack o m
0
4
0 16 0 1
0 10 -1 0
0 12 -1 0
0 13 0 4
1
end_operator
begin_operator
stack o r
0
4
0 10 -1 0
0 8 0 1
0 12 -1 0
0 13 0 5
1
end_operator
begin_operator
stack o t
0
4
0 10 -1 0
0 9 0 1
0 12 -1 0
0 13 0 6
1
end_operator
begin_operator
stack o w
0
4
0 10 -1 0
0 11 0 1
0 12 -1 0
0 13 0 7
1
end_operator
begin_operator
stack r a
0
4
0 5 0 1
0 8 -1 0
0 12 -1 0
0 3 0 1
1
end_operator
begin_operator
stack r e
0
4
0 6 0 1
0 8 -1 0
0 12 -1 0
0 3 0 2
1
end_operator
begin_operator
stack r h
0
4
0 7 0 1
0 8 -1 0
0 12 -1 0
0 3 0 3
1
end_operator
begin_operator
stack r m
0
4
0 16 0 1
0 8 -1 0
0 12 -1 0
0 3 0 4
1
end_operator
begin_operator
stack r o
0
4
0 10 0 1
0 8 -1 0
0 12 -1 0
0 3 0 5
1
end_operator
begin_operator
stack r t
0
4
0 8 -1 0
0 9 0 1
0 12 -1 0
0 3 0 6
1
end_operator
begin_operator
stack r w
0
4
0 8 -1 0
0 11 0 1
0 12 -1 0
0 3 0 7
1
end_operator
begin_operator
stack t a
0
4
0 5 0 1
0 9 -1 0
0 12 -1 0
0 4 0 1
1
end_operator
begin_operator
stack t e
0
4
0 6 0 1
0 9 -1 0
0 12 -1 0
0 4 0 2
1
end_operator
begin_operator
stack t h
0
4
0 7 0 1
0 9 -1 0
0 12 -1 0
0 4 0 3
1
end_operator
begin_operator
stack t m
0
4
0 16 0 1
0 9 -1 0
0 12 -1 0
0 4 0 4
1
end_operator
begin_operator
stack t o
0
4
0 10 0 1
0 9 -1 0
0 12 -1 0
0 4 0 5
1
end_operator
begin_operator
stack t r
0
4
0 8 0 1
0 9 -1 0
0 12 -1 0
0 4 0 6
1
end_operator
begin_operator
stack t w
0
4
0 9 -1 0
0 11 0 1
0 12 -1 0
0 4 0 7
1
end_operator
begin_operator
stack w a
0
4
0 5 0 1
0 11 -1 0
0 12 -1 0
0 14 0 1
1
end_operator
begin_operator
stack w e
0
4
0 6 0 1
0 11 -1 0
0 12 -1 0
0 14 0 2
1
end_operator
begin_operator
stack w h
0
4
0 7 0 1
0 11 -1 0
0 12 -1 0
0 14 0 3
1
end_operator
begin_operator
stack w m
0
4
0 16 0 1
0 11 -1 0
0 12 -1 0
0 14 0 4
1
end_operator
begin_operator
stack w o
0
4
0 10 0 1
0 11 -1 0
0 12 -1 0
0 14 0 5
1
end_operator
begin_operator
stack w r
0
4
0 8 0 1
0 11 -1 0
0 12 -1 0
0 14 0 6
1
end_operator
begin_operator
stack w t
0
4
0 9 0 1
0 11 -1 0
0 12 -1 0
0 14 0 7
1
end_operator
begin_operator
unstack a e
0
4
0 5 0 1
0 6 -1 0
0 12 0 1
0 0 1 0
1
end_operator
begin_operator
unstack a h
0
4
0 5 0 1
0 7 -1 0
0 12 0 1
0 0 2 0
1
end_operator
begin_operator
unstack a m
0
4
0 5 0 1
0 16 -1 0
0 12 0 1
0 0 3 0
1
end_operator
begin_operator
unstack a o
0
4
0 5 0 1
0 10 -1 0
0 12 0 1
0 0 4 0
1
end_operator
begin_operator
unstack a r
0
4
0 5 0 1
0 8 -1 0
0 12 0 1
0 0 5 0
1
end_operator
begin_operator
unstack a t
0
4
0 5 0 1
0 9 -1 0
0 12 0 1
0 0 6 0
1
end_operator
begin_operator
unstack a w
0
4
0 5 0 1
0 11 -1 0
0 12 0 1
0 0 7 0
1
end_operator
begin_operator
unstack e a
0
4
0 5 -1 0
0 6 0 1
0 12 0 1
0 1 1 0
1
end_operator
begin_operator
unstack e h
0
4
0 6 0 1
0 7 -1 0
0 12 0 1
0 1 2 0
1
end_operator
begin_operator
unstack e m
0
4
0 6 0 1
0 16 -1 0
0 12 0 1
0 1 3 0
1
end_operator
begin_operator
unstack e o
0
4
0 6 0 1
0 10 -1 0
0 12 0 1
0 1 4 0
1
end_operator
begin_operator
unstack e r
0
4
0 6 0 1
0 8 -1 0
0 12 0 1
0 1 5 0
1
end_operator
begin_operator
unstack e t
0
4
0 6 0 1
0 9 -1 0
0 12 0 1
0 1 6 0
1
end_operator
begin_operator
unstack e w
0
4
0 6 0 1
0 11 -1 0
0 12 0 1
0 1 7 0
1
end_operator
begin_operator
unstack h a
0
4
0 5 -1 0
0 7 0 1
0 12 0 1
0 2 1 0
1
end_operator
begin_operator
unstack h e
0
4
0 6 -1 0
0 7 0 1
0 12 0 1
0 2 2 0
1
end_operator
begin_operator
unstack h m
0
4
0 7 0 1
0 16 -1 0
0 12 0 1
0 2 3 0
1
end_operator
begin_operator
unstack h o
0
4
0 7 0 1
0 10 -1 0
0 12 0 1
0 2 4 0
1
end_operator
begin_operator
unstack h r
0
4
0 7 0 1
0 8 -1 0
0 12 0 1
0 2 5 0
1
end_operator
begin_operator
unstack h t
0
4
0 7 0 1
0 9 -1 0
0 12 0 1
0 2 6 0
1
end_operator
begin_operator
unstack h w
0
4
0 7 0 1
0 11 -1 0
0 12 0 1
0 2 7 0
1
end_operator
begin_operator
unstack m a
0
4
0 5 -1 0
0 16 0 1
0 12 0 1
0 15 1 0
1
end_operator
begin_operator
unstack m e
0
4
0 6 -1 0
0 16 0 1
0 12 0 1
0 15 2 0
1
end_operator
begin_operator
unstack m h
0
4
0 7 -1 0
0 16 0 1
0 12 0 1
0 15 3 0
1
end_operator
begin_operator
unstack m o
0
4
0 16 0 1
0 10 -1 0
0 12 0 1
0 15 4 0
1
end_operator
begin_operator
unstack m r
0
4
0 16 0 1
0 8 -1 0
0 12 0 1
0 15 5 0
1
end_operator
begin_operator
unstack m t
0
4
0 16 0 1
0 9 -1 0
0 12 0 1
0 15 6 0
1
end_operator
begin_operator
unstack m w
0
4
0 16 0 1
0 11 -1 0
0 12 0 1
0 15 7 0
1
end_operator
begin_operator
unstack o a
0
4
0 5 -1 0
0 10 0 1
0 12 0 1
0 13 1 0
1
end_operator
begin_operator
unstack o e
0
4
0 6 -1 0
0 10 0 1
0 12 0 1
0 13 2 0
1
end_operator
begin_operator
unstack o h
0
4
0 7 -1 0
0 10 0 1
0 12 0 1
0 13 3 0
1
end_operator
begin_operator
unstack o m
0
4
0 16 -1 0
0 10 0 1
0 12 0 1
0 13 4 0
1
end_operator
begin_operator
unstack o r
0
4
0 10 0 1
0 8 -1 0
0 12 0 1
0 13 5 0
1
end_operator
begin_operator
unstack o t
0
4
0 10 0 1
0 9 -1 0
0 12 0 1
0 13 6 0
1
end_operator
begin_operator
unstack o w
0
4
0 10 0 1
0 11 -1 0
0 12 0 1
0 13 7 0
1
end_operator
begin_operator
unstack r a
0
4
0 5 -1 0
0 8 0 1
0 12 0 1
0 3 1 0
1
end_operator
begin_operator
unstack r e
0
4
0 6 -1 0
0 8 0 1
0 12 0 1
0 3 2 0
1
end_operator
begin_operator
unstack r h
0
4
0 7 -1 0
0 8 0 1
0 12 0 1
0 3 3 0
1
end_operator
begin_operator
unstack r m
0
4
0 16 -1 0
0 8 0 1
0 12 0 1
0 3 4 0
1
end_operator
begin_operator
unstack r o
0
4
0 10 -1 0
0 8 0 1
0 12 0 1
0 3 5 0
1
end_operator
begin_operator
unstack r t
0
4
0 8 0 1
0 9 -1 0
0 12 0 1
0 3 6 0
1
end_operator
begin_operator
unstack r w
0
4
0 8 0 1
0 11 -1 0
0 12 0 1
0 3 7 0
1
end_operator
begin_operator
unstack t a
0
4
0 5 -1 0
0 9 0 1
0 12 0 1
0 4 1 0
1
end_operator
begin_operator
unstack t e
0
4
0 6 -1 0
0 9 0 1
0 12 0 1
0 4 2 0
1
end_operator
begin_operator
unstack t h
0
4
0 7 -1 0
0 9 0 1
0 12 0 1
0 4 3 0
1
end_operator
begin_operator
unstack t m
0
4
0 16 -1 0
0 9 0 1
0 12 0 1
0 4 4 0
1
end_operator
begin_operator
unstack t o
0
4
0 10 -1 0
0 9 0 1
0 12 0 1
0 4 5 0
1
end_operator
begin_operator
unstack t r
0
4
0 8 -1 0
0 9 0 1
0 12 0 1
0 4 6 0
1
end_operator
begin_operator
unstack t w
0
4
0 9 0 1
0 11 -1 0
0 12 0 1
0 4 7 0
1
end_operator
begin_operator
unstack w a
0
4
0 5 -1 0
0 11 0 1
0 12 0 1
0 14 1 0
1
end_operator
begin_operator
unstack w e
0
4
0 6 -1 0
0 11 0 1
0 12 0 1
0 14 2 0
1
end_operator
begin_operator
unstack w h
0
4
0 7 -1 0
0 11 0 1
0 12 0 1
0 14 3 0
1
end_operator
begin_operator
unstack w m
0
4
0 16 -1 0
0 11 0 1
0 12 0 1
0 14 4 0
1
end_operator
begin_operator
unstack w o
0
4
0 10 -1 0
0 11 0 1
0 12 0 1
0 14 5 0
1
end_operator
begin_operator
unstack w r
0
4
0 8 -1 0
0 11 0 1
0 12 0 1
0 14 6 0
1
end_operator
begin_operator
unstack w t
0
4
0 9 -1 0
0 11 0 1
0 12 0 1
0 14 7 0
1
end_operator
0
