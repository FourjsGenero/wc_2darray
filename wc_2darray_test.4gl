IMPORT FGL wc_2darray
IMPORT util

MAIN
DEFINE twodarray STRING
DEFINE pos, x, y INTEGER

    WHILE TRUE
        MENU "" 
            ON ACTION timestable ATTRIBUTES(TEXT="Times Table")
                CALL populate_timestable()
                EXIT MENU
            ON ACTION coloursize ATTRIBUTES(TEXT="Colour Size")
                CALL populate_coloursize()
                EXIT MENU
            ON ACTION calendar ATTRIBUTES(TEXT="Calendar")
                CALL populate_calendar()
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
    FOR x = 1 TO 10
        CALL wc_2darray.col_set(x,x)
        CALL wc_2darray.col_style_set(x,"text-align:right; width:40px")
    END FOR
    FOR y = 1 TO 10
        CALL wc_2darray.row_set(y,y)
        CALL wc_2darray.row_style_set(y,"text-align:right")
    END FOR
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
    CALL wc_2darray.col_set(1,"Red")
    CALL wc_2darray.col_style_set(1,"text-align:right; width:60px; background-color: red; color:white; font-size:1.25em")
    CALL wc_2darray.col_set(2,"Green")
    CALL wc_2darray.col_style_set(2,"text-align:right; width:60px; background-color: green; color:white; font-size:1.25em")
    CALL wc_2darray.col_set(3,"Blue")
    CALL wc_2darray.col_style_set(3,"text-align:right; width:60px; background-color: blue; color:white; font-size:1.25em")
    
    FOR y = 1 TO 12
        CALL wc_2darray.row_set(y,y+3)
        CALL wc_2darray.row_style_set(y,"text-align:right; width:60px; background-color: black; color:white; font-size:1.25em")
    END FOR

    -- Would normally retrieve these from a database
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
    CALL wc_2darray.col_set("1", "Monday 4th April 2016")
    CALL wc_2darray.col_set("2", "Tuesday 5th April 2016")
    CALL wc_2darray.col_set("3", "Wednesday 6th April 2016")
    CALL wc_2darray.col_set("4", "Thursday 7th April 2016")
    CALL wc_2darray.col_set("5", "Friday 8th April 2016")
    CALL wc_2darray.col_set("6", "Saturday 9th April 2016")
    CALL wc_2darray.col_set("7", "Sunday 10th April 2016")

    CALL wc_2darray.row_set(1,"Bucket Room<br>PUBLIC ROOMS")
    CALL wc_2darray.row_set(2,"Canteen<br>PUBLIC ROOMS")
    CALL wc_2darray.row_set(3,"Copperfield Room<br>PUBLIC ROOMS")
    CALL wc_2darray.row_set(4,"Dorrit Room<br>PUBLIC ROOMS")
    CALL wc_2darray.row_set(5,"Fagin Room<br>PUBLIC ROOMS")
    CALL wc_2darray.row_set(6,"Havisham Room<br>PUBLIC ROOMS")

    -- Would normally retrieve these from a database
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
