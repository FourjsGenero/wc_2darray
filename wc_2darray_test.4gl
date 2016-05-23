IMPORT FGL wc_2darray
IMPORT util

MAIN
DEFINE twodarray STRING

    WHILE TRUE
        MENU "2d Array Test" 
            ON ACTION timestable ATTRIBUTES(TEXT="Times Table")
                CALL populate_timestable()
                EXIT MENU
            ON ACTION coloursize ATTRIBUTES(TEXT="Colour Size")
                CALL populate_coloursize()
                EXIT MENU
            ON ACTION calendar ATTRIBUTES(TEXT="Calendar")
                CALL populate_calendar()
                EXIT MENU
            ON ACTION accounting ATTRIBUTES(TEXT="Accounting")
                CALL populate_accounting()
                EXIT MENU
            ON ACTION premiership ATTRIBUTES(TEXT="Premiership")
                CALL populate_premiership()
                EXIT MENU
            ON ACTION close
                EXIT WHILE
        END MENU
        OPEN WINDOW w WITH FORM "wc_2darray_test.per"
        CALL wc_2darray.html_send("formonly.twodarray")    
        INPUT BY NAME twodarray ATTRIBUTES(WITHOUT DEFAULTS=TRUE, UNBUFFERED)
            ON ACTION select ATTRIBUTES(DEFAULTVIEW=NO)
                CALL FGL_WINMESSAGE("Info",twodarray,"")
        END INPUT
        CLOSE WINDOW w
    END WHILE
END MAIN

FUNCTION populate_timestable()
DEFINE x,y INTEGER

    CALL wc_2darray.init()
    -- Define column headers
    FOR x = 1 TO 10
        CALL wc_2darray.col_set(x,x)
        CALL wc_2darray.col_style_set(x,"text-align:right; width:40px")
    END FOR
    -- Define row headers
    FOR y = 1 TO 10
        CALL wc_2darray.row_set(y,y)
        CALL wc_2darray.row_style_set(y,"text-align:right")
    END FOR
    -- Define individual cells
    FOR x = 1 TO 10
        FOR y = 1 TO 10
            CALL wc_2darray.cell_set(x,y,x*y)
            CALL wc_2darray.cell_style_set(x,y,"text-align:right")
        END FOR
    END FOR
END FUNCTION

FUNCTION populate_coloursize()
DEFINE x, y INTEGER

    CALL wc_2darray.init()

    -- Define column headers
    CALL wc_2darray.col_set(1,"Red")
    CALL wc_2darray.col_style_set(1,"text-align:right; width:60px; background-color: red; color:white; font-size:1.25em")
    CALL wc_2darray.col_set(2,"Green")
    CALL wc_2darray.col_style_set(2,"text-align:right; width:60px; background-color: green; color:white; font-size:1.25em")
    CALL wc_2darray.col_set(3,"Blue")
    CALL wc_2darray.col_style_set(3,"text-align:right; width:60px; background-color: blue; color:white; font-size:1.25em")

    -- Define row headers
    FOR y = 1 TO 12
        CALL wc_2darray.row_set(y,y+3)
        CALL wc_2darray.row_style_set(y,"text-align:right; width:60px; background-color: black; color:white; font-size:1.25em")
    END FOR

    -- Define cells, would normally retrieve these from a database with a FETCH per cell e.g.
    -- OPEN get_qty USING color, size
    -- FETCH get_qty INTO qty
    FOR x = 1 TO 3
        FOR y = 1 TO 12
            CALL wc_2darray.cell_set(x,y,util.Math.rand(100))
            CALL wc_2darray.cell_style_set(x,y,"text-align:right")
        END FOR
    END FOR
END FUNCTION

FUNCTION populate_calendar()
DEFINE x,y INTEGER

    CALL wc_2darray.init()

    -- Define columns 
    CALL wc_2darray.col_set("1", "Monday 4th April 2016")
    CALL wc_2darray.col_set("2", "Tuesday 5th April 2016")
    CALL wc_2darray.col_set("3", "Wednesday 6th April 2016")
    CALL wc_2darray.col_set("4", "Thursday 7th April 2016")
    CALL wc_2darray.col_set("5", "Friday 8th April 2016")
    CALL wc_2darray.col_set("6", "Saturday 9th April 2016")
    CALL wc_2darray.col_set("7", "Sunday 10th April 2016")

    -- Define rows
    CALL wc_2darray.row_set(1,"Bucket Room<br>PUBLIC ROOMS")
    CALL wc_2darray.row_set(2,"Canteen<br>PUBLIC ROOMS")
    CALL wc_2darray.row_set(3,"Copperfield Room<br>PUBLIC ROOMS")
    CALL wc_2darray.row_set(4,"Dorrit Room<br>PUBLIC ROOMS")
    CALL wc_2darray.row_set(5,"Fagin Room<br>PUBLIC ROOMS")
    CALL wc_2darray.row_set(6,"Havisham Room<br>PUBLIC ROOMS")

    -- Define cells, would normally retrieve these from a database
    CALL wc_2darray.cell_set(1,2,"18:00-20:00 Jeffs Pie Eating Seminar")
    CALL wc_2darray.cell_set(1,4,"09:00-All Day Jeffs Pie Eating Seminar")

    CALL wc_2darray.cell_set(2,5,"09:00-All Day Accurate College Photographic Society Expedition")
    CALL wc_2darray.cell_set(3,5,"ALL DAY Accurate College Photographic Society Expedition")
    CALL wc_2darray.cell_set(4,5,"ALL DAY Accurate College Photographic Society Expedition")
    CALL wc_2darray.cell_set(5,5,"All Day-17:00 Accurate College Photographic Society Expedition")

    -- Would probably add more methods to set cell contents rather than so much raw html
    CALL wc_2darray.cell_set(2,3,'<table><tr><td colspan="2">7 Bookings 09:00 - 21:30</td></tr><tr><td>09:00 - 10:30</td><td>Engineering Tutor Meeting</td></tr><tr><td>11:00 - 12:15</td><td>Finance Department</td></tr><tr><td>12:30 - 13:30</td><td>Tutorial Offce Meeting</td></tr><tr><td>14:00 - 15:00</td><td>Finance: Accurate Solutions Demonstration</td></tr><tr><td>15:00 - 16:00</td><td>Finance Department post demo review</td></tr><tr><td>16:00 - 17:00</td><td>Porters Training Session/td></tr><tr><td>18:00 - 21:30</td><td>Chess Club</td></tr></table>')
    CALL wc_2darray.cell_set(2,4,'<table><tr><td colspan="2">2 Bookings 00:00 - 22:00</td></tr><tr><td>Until 17:30</td><td>Jeffs Shephers Pie Eating Seminar</td></tr><tr><td>18:30 - 22:00</td><td>SCR Whiskey Tasking</td></tr></table>')

    FOR y = 1 TO 6 STEP 2
        CALL wc_2darray.row_style_set(y,"background-color: #FFFFCE")
        FOR x = 1 TO 7
            CALL wc_2darray.cell_style_set(x,y,"background-color: #FFFFCE")
        END FOR
    END FOR
END FUNCTION



FUNCTION populate_accounting()
DEFINE y INTEGER
DEFINE l_a, l_b, l_v DECIMAL(11,2)
DEFINE l_acct CHAR(5)

    CALL wc_2darray.init()

    -- Define columns
    CALL wc_2darray.col_set("1", "")
    CALL wc_2darray.col_set("2", "")
    CALL wc_2darray.col_set("3", "")
    CALL wc_2darray.col_set("4", "")
    CALL wc_2darray.col_set("5", "")
    CALL wc_2darray.col_set("6", "")
    CALL wc_2darray.col_set("7", "")

    CALL wc_2darray.col_style_set(1,"width: 8em")
    CALL wc_2darray.col_style_set(2,"width: 8em")
    CALL wc_2darray.col_style_set(3,"width: 8em")
    CALL wc_2darray.col_style_set(4,"width: 8em")
    CALL wc_2darray.col_style_set(5,"width: 8em")
    CALL wc_2darray.col_style_set(6,"width: 8em")
    CALL wc_2darray.col_style_set(7,"width: 8em")
    

    --  Define rows 
    CALL wc_2darray.row_set("1", "")
    CALL wc_2darray.row_set("2", "")
    
    -- Define grouped column headers
    CALL wc_2darray.cell_set(1,1, "Account Code")
    CALL wc_2darray.cell_height_set(1,1,2)

    CALL wc_2darray.cell_set(2,1,"Last Year")
    CALL wc_2darray.cell_width_set(2,1,3)
    CALL wc_2darray.cell_style_set(2,1,"text-align:center")

    CALL wc_2darray.cell_set(5,1,"This Year")
    CALL wc_2darray.cell_width_set(5,1,3)
    CALL wc_2darray.cell_style_set(5,1,"text-align:center")

    CALL wc_2darray.cell_set(2,2,"Budget")
    CALL wc_2darray.cell_style_set(2,2,"text-align:right")
    CALL wc_2darray.cell_set(3,2,"Actual")
    CALL wc_2darray.cell_style_set(3,2,"text-align:right")
    CALL wc_2darray.cell_set(4,2,"Variance")
    CALL wc_2darray.cell_style_set(4,2,"text-align:right")
    CALL wc_2darray.cell_set(5,2,"Budget")
    CALL wc_2darray.cell_style_set(5,2,"text-align:right")
    CALL wc_2darray.cell_set(6,2,"Actual")
    CALL wc_2darray.cell_style_set(6,2,"text-align:right")
    CALL wc_2darray.cell_set(7,2,"Variance")
    CALL wc_2darray.cell_style_set(7,2,"text-align:right")

    -- Define cell contents
    FOR y = 3 TO 50
        CALL wc_2darray.row_set(y, "")
        LET l_acct = util.Math.rand(90000)+10000
        CALL wc_2darray.cell_set(1,y,l_acct USING "&&&&&")
        LET l_b = util.math.rand(100000)/100
        LET l_v = 100.00 - util.Math.rand(20000)/100 
        LET l_a = l_b + l_v
        CALL wc_2darray.cell_set(2,y, l_b USING "$$$,$$&.&&")
        CALL wc_2darray.cell_style_set(2,y,"text-align:right")
        CALL wc_2darray.cell_set(3,y, l_a USING "$$$,$$&.&&")
        CALL wc_2darray.cell_style_set(3,y,"text-align:right")
        CALL wc_2darray.cell_set(4,y, l_v USING "($$$$,$$&.&&)")
        CALL wc_2darray.cell_style_set(4,y,"text-align:right")
        LET l_b = 100 - util.Math.rand(20000)/100  + l_b
        LET l_v = 100.00 - util.Math.rand(20000)/100 
        LET l_a = l_b + l_v
        CALL wc_2darray.cell_set(5,y, l_b USING "$$$,$$&.&&")
        CALL wc_2darray.cell_style_set(5,y,"text-align:right")
        CALL wc_2darray.cell_set(6,y, l_a USING "$$$,$$&.&&")
        CALL wc_2darray.cell_style_set(6,y,"text-align:right")
        CALL wc_2darray.cell_set(7,y, l_v USING "($$$$,$$&.&&)")
        CALL wc_2darray.cell_style_set(7,y,"text-align:right")

        -- Define bacjground colours with mix odd/even and different color for this year/last year
        CALL wc_2darray.cell_style_append(2,1,"background-color: #EEF504")
        CALL wc_2darray.cell_style_append(2,2,"background-color: #EEF504")
        CALL wc_2darray.cell_style_append(3,2,"background-color: #EEF504")
        CALL wc_2darray.cell_style_append(4,2,"background-color: #EEF504")
        CALL wc_2darray.cell_style_append(5,1,"background-color: #00F2F2")
        CALL wc_2darray.cell_style_append(5,2,"background-color: #00F2F2")
        CALL wc_2darray.cell_style_append(6,2,"background-color: #00F2F2")
        CALL wc_2darray.cell_style_append(7,2,"background-color: #00F2F2")
        IF y MOD 2 == 0 THEN
            CALL wc_2darray.cell_style_append(2,y,"background-color: #EEF504")
            CALL wc_2darray.cell_style_append(3,y,"background-color: #EEF504")
            CALL wc_2darray.cell_style_append(4,y,"background-color: #EEF504")
            CALL wc_2darray.cell_style_append(5,y,"background-color: #00F2F2")
            CALL wc_2darray.cell_style_append(6,y,"background-color: #00F2F2")
            CALL wc_2darray.cell_style_append(7,y,"background-color: #00F2F2")
        ELSE
            CALL wc_2darray.cell_style_append(1,y,"background-color: #E0E0E0")
            CALL wc_2darray.cell_style_append(2,y,"background-color: #DED500")
            CALL wc_2darray.cell_style_append(3,y,"background-color: #DED500")
            CALL wc_2darray.cell_style_append(4,y,"background-color: #DED500")
            CALL wc_2darray.cell_style_append(5,y,"background-color: #00E2E2")
            CALL wc_2darray.cell_style_append(6,y,"background-color: #00E2E2")
            CALL wc_2darray.cell_style_append(7,y,"background-color: #00E2E2")
        END IF
    END FOR 
END FUNCTION



FUNCTION populate_premiership()
DEFINE i INTEGER
DEFINE l_pld, l_pts, l_gd INTEGER

    -- Inspiration https://en.wikipedia.org/wiki/2015%E2%80%9316_Premier_League#League_table

    CALL wc_2darray.init()

    -- Define column headers
    CALL wc_2darray.col_set(1,"Pos")
    CALL wc_2darray.col_set(2,"Team")
    CALL wc_2darray.col_set(3,"Pld")
    CALL wc_2darray.col_set(4,"W")
    CALL wc_2darray.col_set(5,"D")
    CALL wc_2darray.col_set(6,"L")
    CALL wc_2darray.col_set(7,"F")
    CALL wc_2darray.col_set(8,"A")
    CALL wc_2darray.col_set(9,"GD")
    CALL wc_2darray.col_set(10,"Pts")
    CALL wc_2darray.col_set(11,"Qualification or Relegation")
    FOR i = 1 TO 20
        CALL wc_2darray.row_set(i,"")
    END FOR
    CALL wc_2darray.col_style_set(1,"text-align: right")
    CALL wc_2darray.col_style_set(2,"text-align: center")
    FOR i = 3 TO 10
        CALL wc_2darray.col_style_set(i,"text-align: right")
    END FOR

    -- Define each cell
    CALL wc_2darray.cell_set(1,1,"1")
    CALL wc_2darray.cell_set(2,1,"Leicester City")
    CALL wc_2darray.cell_style_set(2,1,"background-color: blue; color: white")
    CALL wc_2darray.cell_set(4,1,"23")
    CALL wc_2darray.cell_set(5,1,"12")
    CALL wc_2darray.cell_set(6,1,"3")
    CALL wc_2darray.cell_set(7,1,"68")
    CALL wc_2darray.cell_set(8,1,"36")

    CALL wc_2darray.cell_set(1,2,"2")
    CALL wc_2darray.cell_set(2,2,"Arsenal")
    CALL wc_2darray.cell_style_set(2,2,"background-color: red; color: white")
    CALL wc_2darray.cell_set(4,2,"20")
    CALL wc_2darray.cell_set(5,2,"11")
    CALL wc_2darray.cell_set(6,2,"7")
    CALL wc_2darray.cell_set(7,2,"65")
    CALL wc_2darray.cell_set(8,2,"36")

    CALL wc_2darray.cell_set(1,3,"3")
    CALL wc_2darray.cell_set(2,3,"Tottenham Hotspur")
    CALL wc_2darray.cell_style_set(2,3,"background-color: white; color: blue")
    CALL wc_2darray.cell_set(4,3,"19")
    CALL wc_2darray.cell_set(5,3,"13")
    CALL wc_2darray.cell_set(6,3,"6")
    CALL wc_2darray.cell_set(7,3,"69")
    CALL wc_2darray.cell_set(8,3,"35")

    CALL wc_2darray.cell_set(1,4,"4")
    CALL wc_2darray.cell_set(2,4,"Manchester City")
    CALL wc_2darray.cell_style_set(2,4,"background-color: #6CAEFF; color: white")
    CALL wc_2darray.cell_set(4,4,"19")
    CALL wc_2darray.cell_set(5,4,"9")
    CALL wc_2darray.cell_set(6,4,"10")
    CALL wc_2darray.cell_set(7,4,"71")
    CALL wc_2darray.cell_set(8,4,"41")

    CALL wc_2darray.cell_set(1,5,"5")
    CALL wc_2darray.cell_set(2,5,"Manchester United ")
    CALL wc_2darray.cell_style_set(2,5,"background-color: red; color: white; text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black;")
    CALL wc_2darray.cell_set(4,5,"19")
    CALL wc_2darray.cell_set(5,5,"9")
    CALL wc_2darray.cell_set(6,5,"10")
    CALL wc_2darray.cell_set(7,5,"49")
    CALL wc_2darray.cell_set(8,5,"35")
    
    CALL wc_2darray.cell_set(1,6,"6")
    CALL wc_2darray.cell_set(2,6,"Southampton")
    CALL wc_2darray.cell_style_set(2,6,"background: repeating-linear-gradient(to right, red, red 10px, white 10px, white 20px); color: black")
    CALL wc_2darray.cell_set(4,6,"18")
    CALL wc_2darray.cell_set(5,6,"9")
    CALL wc_2darray.cell_set(6,6,"11")
    CALL wc_2darray.cell_set(7,6,"59")
    CALL wc_2darray.cell_set(8,6,"41")

    CALL wc_2darray.cell_set(1,7,"7")
    CALL wc_2darray.cell_set(2,7,"West Ham United ")
    CALL wc_2darray.cell_style_set(2,7,"background-color: #710022; color: #6CAEFF")
    CALL wc_2darray.cell_set(4,7,"16")
    CALL wc_2darray.cell_set(5,7,"14")
    CALL wc_2darray.cell_set(6,7,"8")
    CALL wc_2darray.cell_set(7,7,"65")
    CALL wc_2darray.cell_set(8,7,"51")

    CALL wc_2darray.cell_set(1,8,"8")
    CALL wc_2darray.cell_set(2,8,"Liverpool")
    CALL wc_2darray.cell_style_set(2,8,"background-color: red; color: yellow")
    CALL wc_2darray.cell_set(4,8,"16")
    CALL wc_2darray.cell_set(5,8,"12")
    CALL wc_2darray.cell_set(6,8,"10")
    CALL wc_2darray.cell_set(7,8,"63")
    CALL wc_2darray.cell_set(8,8,"50")

    CALL wc_2darray.cell_set(1,9,"9")
    CALL wc_2darray.cell_set(2,9,"Stoke City")
    CALL wc_2darray.cell_style_set(2,9,"background: repeating-linear-gradient(to right, red, red 10px, white 10px, white 20px); color: white; text-shadow: -1px 0 red, 0 1px red, 1px 0 red, 0 -1px red;")
    CALL wc_2darray.cell_set(4,9,"14")
    CALL wc_2darray.cell_set(5,9,"9")
    CALL wc_2darray.cell_set(6,9,"15")
    CALL wc_2darray.cell_set(7,9,"41")
    CALL wc_2darray.cell_set(8,9,"55")

    CALL wc_2darray.cell_set(1,10,"10")
    CALL wc_2darray.cell_set(2,10,"Chelsea")
    CALL wc_2darray.cell_style_set(2,10,"background-color: blue; color: white")
    CALL wc_2darray.cell_set(4,10,"12")
    CALL wc_2darray.cell_set(5,10,"14")
    CALL wc_2darray.cell_set(6,10,"12")
    CALL wc_2darray.cell_set(7,10,"59")
    CALL wc_2darray.cell_set(8,10,"53")
    
    CALL wc_2darray.cell_set(1,11,"11")
    CALL wc_2darray.cell_set(2,11,"Everton")
    CALL wc_2darray.cell_style_set(2,11,"background-color: blue; color: white")
    CALL wc_2darray.cell_set(4,11,"11")
    CALL wc_2darray.cell_set(5,11,"14")
    CALL wc_2darray.cell_set(6,11,"13")
    CALL wc_2darray.cell_set(7,11,"59")
    CALL wc_2darray.cell_set(8,11,"55")
    
    CALL wc_2darray.cell_set(1,12,"12")
    CALL wc_2darray.cell_set(2,12,"Swansea")
    CALL wc_2darray.cell_style_set(2,12,"background-color: white; color: black")
    CALL wc_2darray.cell_set(4,12,"12")
    CALL wc_2darray.cell_set(5,12,"11")
    CALL wc_2darray.cell_set(6,12,"15")
    CALL wc_2darray.cell_set(7,12,"42")
    CALL wc_2darray.cell_set(8,12,"52")

    CALL wc_2darray.cell_set(1,13,"13")
    CALL wc_2darray.cell_set(2,13,"Watford")
    CALL wc_2darray.cell_style_set(2,13,"background-color: yellow; color: black")
    CALL wc_2darray.cell_set(4,13,"12")
    CALL wc_2darray.cell_set(5,13,"9")
    CALL wc_2darray.cell_set(6,13,"17")
    CALL wc_2darray.cell_set(7,13,"40")
    CALL wc_2darray.cell_set(8,13,"50") 

    CALL wc_2darray.cell_set(1,14,"14")
    CALL wc_2darray.cell_set(2,14,"West Bromwich Albion")
    CALL wc_2darray.cell_style_set(2,14,"background: repeating-linear-gradient(to right, white, white 10px, #00003E 10px, #00003E 20px); color: white; text-shadow: -1px 0 #00003E, 0 1px #00003E, 1px 0 #00003E, 0 -1px #00003E;")
    CALL wc_2darray.cell_set(4,14,"10")
    CALL wc_2darray.cell_set(5,14,"13")
    CALL wc_2darray.cell_set(6,14,"15")
    CALL wc_2darray.cell_set(7,14,"34")
    CALL wc_2darray.cell_set(8,14,"48")

    CALL wc_2darray.cell_set(1,15,"9")
    CALL wc_2darray.cell_set(2,15,"Crystal Palace")
    CALL wc_2darray.cell_style_set(2,15,"background: repeating-linear-gradient(to right, red, red 10px, blue 10px, blue 20px); color: white")
    CALL wc_2darray.cell_set(4,15,"11")
    CALL wc_2darray.cell_set(5,15,"9")
    CALL wc_2darray.cell_set(6,15,"18")
    CALL wc_2darray.cell_set(7,15,"39")
    CALL wc_2darray.cell_set(8,15,"51")

    CALL wc_2darray.cell_set(1,16,"16")
    CALL wc_2darray.cell_set(2,16,"AFC Bournemouth")
    CALL wc_2darray.cell_style_set(2,16,"background: repeating-linear-gradient(to right, black, black 10px, red 10px, red 20px); color: black; text-shadow: -1px 0 red, 0 1px red, 1px 0 red, 0 -1px red;")
    CALL wc_2darray.cell_set(4,16,"11")
    CALL wc_2darray.cell_set(5,16,"9")
    CALL wc_2darray.cell_set(6,16,"18")
    CALL wc_2darray.cell_set(7,16,"45")
    CALL wc_2darray.cell_set(8,16,"67")

    CALL wc_2darray.cell_set(1,17,"17")
    CALL wc_2darray.cell_set(2,17,"Sunderland")
    CALL wc_2darray.cell_style_set(2,17,"background: repeating-linear-gradient(to right, red, red 10px, white 10px, white 20px); color: black")
    CALL wc_2darray.cell_set(4,17,"9")
    CALL wc_2darray.cell_set(5,17,"12")
    CALL wc_2darray.cell_set(6,17,"17")
    CALL wc_2darray.cell_set(7,17,"48")
    CALL wc_2darray.cell_set(8,17,"62")

    CALL wc_2darray.cell_set(1,18,"18")
    CALL wc_2darray.cell_set(2,18,"Newcastle United")
    CALL wc_2darray.cell_style_set(2,18,"background: repeating-linear-gradient(to right, white, white 10px, black 10px, black 20px); color: white; text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black;")
    CALL wc_2darray.cell_set(4,18,"9")
    CALL wc_2darray.cell_set(5,18,"10")
    CALL wc_2darray.cell_set(6,18,"19")
    CALL wc_2darray.cell_set(7,18,"44")
    CALL wc_2darray.cell_set(8,18,"65")

    CALL wc_2darray.cell_set(1,19,"19")
    CALL wc_2darray.cell_set(2,19,"Norwich")
    CALL wc_2darray.cell_style_set(2,19,"background-color: yellow; color: green")
    CALL wc_2darray.cell_set(4,19,"9")
    CALL wc_2darray.cell_set(5,19,"7")
    CALL wc_2darray.cell_set(6,19,"22")
    CALL wc_2darray.cell_set(7,19,"39")
    CALL wc_2darray.cell_set(8,19,"67") 

    CALL wc_2darray.cell_set(1,20,"20")
    CALL wc_2darray.cell_set(2,20,"Aston Villa")
    CALL wc_2darray.cell_style_set(2,20,"background-color: #710022; color: #6CAEFF")
    CALL wc_2darray.cell_set(4,20,"3")
    CALL wc_2darray.cell_set(5,20,"8")
    CALL wc_2darray.cell_set(6,20,"27")
    CALL wc_2darray.cell_set(7,20,"27")
    CALL wc_2darray.cell_set(8,20,"76")

    -- Calc some values automatically
    FOR i = 1 TO 20
        LET l_pld = wc_2darray.cell_get(4,i)+wc_2darray.cell_get(5,i)+wc_2darray.cell_get(6,i)
        CALL wc_2darray.cell_set(3, i,l_pld)

        LET l_pts = 3*wc_2darray.cell_get(4,i)+wc_2darray.cell_get(5,i)
        CALL wc_2darray.cell_set(10, i, l_pts)

        LET l_gd = wc_2darray.cell_get(7,i)-wc_2darray.cell_get(8,i)
        CALL wc_2darray.cell_set(9, i, l_gd)

        -- Set styles
        CALL wc_2darray.cell_style_set(1,i,"width:3ex; text-align: right")
        CALL wc_2darray.cell_style_set(3,i,"width:3ex; text-align: right")
        CALL wc_2darray.cell_style_set(4,i,"width:3ex; text-align: right")
        CALL wc_2darray.cell_style_set(5,i,"width:3ex; text-align: right")
        CALL wc_2darray.cell_style_set(6,i,"width:3ex; text-align: right")
        CALL wc_2darray.cell_style_set(7,i,"width:3ex; text-align: right")
        CALL wc_2darray.cell_style_set(8,i,"width:3ex; text-align: right")
        CALL wc_2darray.cell_style_set(9,i,"width:3ex; text-align: right")
        CALL wc_2darray.cell_style_set(10,i,"width:3ex; text-align: right")

        CALL wc_2darray.cell_style_append(2,i,"width:22ex; text-align: center; font-weight: bold")
        CALL wc_2darray.cell_style_set(11,i,"width:30ex;")
    END FOR

    -- Define last column
    CALL wc_2darray.cell_height_set(11,1,3)
    CALL wc_2darray.cell_set(11,1,"Qualification for the Champions League group stage")
    CALL wc_2darray.cell_style_set(11,1,"background-color: #ADF5AB")
    CALL wc_2darray.cell_set(11,4,"Qualification for the Champions League play-off stage")
    CALL wc_2darray.cell_style_set(11,4,"background-color: #C1FBBF")
    CALL wc_2darray.cell_height_set(11,5,2)
    CALL wc_2darray.cell_set(11,5,"Qualification for the Europa League group stage")
    CALL wc_2darray.cell_style_set(11,5,"background-color: #ADF1FF")
    CALL wc_2darray.cell_set(11,7,"Qualification for the Europa League third qualifying round")
    CALL wc_2darray.cell_style_set(11,7,"background-color: #C1F8FF")
    CALL wc_2darray.cell_height_set(11,18,3)
    CALL wc_2darray.cell_set(11,18,"Relegation to the Football League Championship")
    CALL wc_2darray.cell_style_set(11,18,"background-color: #FFABAC")
END FUNCTION
