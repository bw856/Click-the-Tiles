% Osu!Mania
% A program by Brandon Wang
% 5/15/2018
import GUI

var font : int := Font.New ("Arial:18")
var title : int := Font.New ("Verdana:40")
var logo : int := Font.New ("Verdana:70")
var playbutton, spdup, spddown, scorerset, endgame, endmenu : int
var start : boolean := true

var ch : string (1)

%Displays
var main : int := Window.Open ("graphics:875;max;position:top;left")
var scorewin, menu : int

%Function
var db, fb, jb, kb : int := 950
var ychange : int := 3

var d : int := 278
var f : int := 346
var j : int := 414      % Coordinates of each collumn (for efficiency)
var k : int := 482
var l : int := 550

var chars : array char of boolean
var combo : int := 0

%   Program

%%%%%% Introduction  -  WELCOME TO OSU + Instructions %%%%%%
Draw.FillBox (0, 0, maxx, maxy, 7)
delay (150)
Draw.Text ("WELCOME TO", 260, 520, title, white)
delay (1300)
cls

Draw.FillBox (0, 0, maxx, maxy, 7)
Draw.FillOval (440, 530, 140, 140, 0)
Draw.FillOval (440, 530, 125, 125, 85)

Draw.Text ("osu!", 343, 505, logo, white)
delay (2000)

procedure clear
    cls
    start := false
end clear
playbutton := GUI.CreateButton (maxx div 3, maxy div 3, 300, "Play", clear)
loop
    if start = false then
	exit
    end if
    exit when GUI.ProcessEvent
end loop
start := true

% Instructions
colorback (7)
Draw.FillBox (maxx, maxy, 0, 0, 7)
Draw.Text ("INSTRUCTIONS", 10, 750, font, 0)
Draw.ThickLine (10, 740, 450, 740, 3, 0)

delay (1500)
Draw.Text ("1. Click the indicated key when the note reaches the gray hit bar!", 10, 700, font, 0)
Draw.Text ("Score will be shown on the right side of the screen.", 10, 670, font, 24)
delay (1500)
Draw.Text ("2. Click the ESC key to bring up the menu!", 10, 620, font, 0)
Draw.Text ("You can change the speed, reset the score, or close the game.", 10, 590, font, 24)
delay (1500)
Draw.Text ("3. Have Fun!", 10, 540, font, 0)
delay (2000)

Draw.Text ("Press any key to begin!", 300, 440, font, 0)
delay (100)
getch (ch)
cls
delay (400)

scorewin := Window.Open ("graphics:375;300;position:top;right")
Window.SetActive (main)
Window.Select (main)

%%%% DRAWING GAME BACKGROUND %%%%

procedure draw_objects             % Creation of the outline
    % Key Box
    Draw.FillBox (278, 0, 346, 92, 86)
    Draw.FillBox (346, 0, 414, 92, 83)
    Draw.FillBox (414, 0, 482, 92, 83)
    Draw.FillBox (482, 0, 550, 92, 86)

    % Outline of Box
    Draw.FillBox (278, 115, 550, maxy, 7)
    Draw.Box (278, 0, 346, maxy, 8)
    Draw.Box (346, 0, 414, maxy, 8)
    Draw.Box (414, 0, 482, maxy, 8)
    Draw.Box (482, 0, 550, maxy, 8)

    % Hit Bar
    Draw.FillBox (278, 92, 550, 161, 15)
    Draw.Box (278, 92, 550, 161, 2)

    % Key Letter (In Box)      
    Draw.Text ("D", 304, 46, font, 7) % D
    Draw.Text ("F", 372, 46, font, 7) % F
    Draw.Text ("J", 444, 46, font, 7) % J
    Draw.Text ("K", 508, 46, font, 7) % K
    
end draw_objects

    % Stars (background)
    Draw.FillStar (500, 600, 30, 30, 68)
    Draw.FillStar (700, 800, 600, 700, 68)
    
%%%% EXIT MENU PROCEDURES %%%%

procedure speed_up
    ychange := ychange + 2
end speed_up

procedure speed_down
    ychange := ychange - 2
    if ychange <= 2 then
	ychange := 1
    end if
end speed_down

procedure score_reset
combo := 0
end score_reset

procedure close_game
    Window.Close (scorewin)
    Window.Close (menu)
    Window.SetActive (main)
    cls
    Draw.FillBox (maxx, maxy, 0, 0, 7)
    delay (150)
    Draw.Text ("See you next time!", 200, 520, title, 0)
    delay (1000)
    break
end close_game

procedure close_menu
    Window.Select (main)
    Window.SetActive (main)
    Window.Hide (menu)
    start := false
end close_menu

procedure open_menu
    if chars (KEY_ESC) then
	menu := Window.Open ("graphics:400,600;position:center;truemiddle")
	Window.Select (menu)
	Window.SetActive (menu)
	Draw.FillBox (0, 0, maxx, maxy, 7)
	Draw.Text ("MENU", 120, 550, title, 0)
	Draw.ThickLine (90, 540, 310, 540, 3, 0)
	spdup := GUI.CreateButton (50, 480, 300, "Speed Up", speed_up)
	spddown := GUI.CreateButton (50, 380, 300, "Speed Down", speed_down)
	scorerset := GUI.CreateButton (50, 280, 300, "Reset Score", score_reset)
	endgame := GUI.CreateButton (50, 180, 300, "Close Game", close_game)
	endmenu := GUI.CreateButton (50, 80, 300, "Close Menu", close_menu)
	loop
	    if start = false then
		exit
	    end if
	    exit when GUI.ProcessEvent
	end loop
	start := true
    end if
end open_menu

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Score Display

Window.Select (scorewin)
Draw.Text ("Score", 150, 200, font, 7)     % Score Display
Window.Select (main)

%%%%%%%%%% THE GAME %%%%%%%%%%%

loop
    loop
	Input.KeyDown (chars)
	open_menu
	draw_objects
	db := db - ychange              % collumn 1
	if chars ('d') and (db >= 85 and db <= 161) then
	    combo := combo + 1
	    Window.Select (scorewin)
	    cls
	    Draw.Text ("Score", 150, 200, font, 7)     % Score Tracking
	    locatexy (182, 150)
	    put combo
	    Window.Select (main)
	end if
	Draw.FillBox (d, db, f, db - 10, 84)
	kb := 950


	if db < 115 then
	    loop
		Input.KeyDown (chars)
		open_menu
		draw_objects
		fb := fb - ychange                      % collumn 2
		if chars ('f') and (fb >= 85 and fb <= 161) then
		    combo := combo + 1
		    Window.Select (scorewin)
		    cls
		    Draw.Text ("Score", 150, 200, font, 7)     % Score Tracking
		    locatexy (182, 150)
		    put combo
		    Window.Select (main)
		end if
		Draw.FillBox (f, fb, j, fb - 10, 84)
		jb := 950

		if fb < 115 then
		    loop
			Input.KeyDown (chars)
			open_menu
			draw_objects
			jb := jb - ychange                      % collumn 3
			if chars ('j') and (jb >= 85 and jb <= 161) then
			    combo := combo + 1
			    Window.Select (scorewin)
			    cls
			    Draw.Text ("Score", 150, 200, font, 7)     % Score Tracking
			    locatexy (182, 150)
			    put combo
			    Window.Select (main)
			end if
			Draw.FillBox (j, jb, k, jb - 10, 84)
			fb := 950

			if jb < 115 then
			    loop
				Input.KeyDown (chars)
				open_menu
				draw_objects
				kb := kb - ychange                      % collumn 4
				if chars ('k') and (kb >= 85 and kb <= 161) then
				    combo := combo + 1
				    Window.Select (scorewin)
				    cls
				    Draw.Text ("Score", 150, 200, font, 7)     % Score Tracking
				    locatexy (182, 150)
				    put combo
				    Window.Select (main)
				end if
				Draw.FillBox (k, kb, l, kb - 10, 84)
				db := 950

				if kb < 115 then
				    exit
				end if


				delay (15)
				View.Update
			    end loop                 % collumn 4
			end if

			if kb < 115 then
			    exit
			end if
			delay (15)
			View.Update
		    end loop             % collumn 3
		end if

		if kb < 115 then
		    exit
		end if
		delay (15)
		View.Update
	    end loop            % collumn 2
	end if

	if kb < 115 then
	    exit
	end if
	delay (15)
	View.Update           % collumn 1
    end loop
end loop
