DEFINE colArray DYNAMIC ARRAY OF RECORD
    title STRING,
    class STRING,
    style STRING
END RECORD

DEFINE rowArray DYNAMIC ARRAY OF RECORD
    title STRING,
    class STRING,
    style STRING
END RECORD

DEFINE cellArray DYNAMIC ARRAY WITH DIMENSION 2 OF RECORD
    value STRING,
    class STRING,
    style STRING,
    width INTEGER,
    height INTEGER
END RECORD

DEFINE styleArray DYNAMIC ARRAY OF RECORD
    selector STRING,
    style DYNAMIC ARRAY OF RECORD
        att STRING,
        val STRING
    END RECORD
END RECORD


PUBLIC FUNCTION init()
    CALL colArray.clear()
    CALL rowArray.clear()
    CALL cellArray.clear()
    CALL styleArray.clear()
END FUNCTION

PUBLIC FUNCTION row_set(i,t)
DEFINE i INTEGER
DEFINE t STRING
    LET rowArray[i].title = t
END FUNCTION

PUBLIC FUNCTION col_set(i,t)
DEFINE i INTEGER
DEFINE t STRING
    LET colArray[i].title = t
END FUNCTION

PUBLIC FUNCTION row_class_set(i,c)
DEFINE i INTEGER
DEFINE c STRING
    LET rowArray[i].class = c
END FUNCTION

PUBLIC FUNCTION row_style_set(i,s)
DEFINE i INTEGER
DEFINE s STRING
    LET rowArray[i].style = s
END FUNCTION

PUBLIC FUNCTION col_class_set(i,c)
DEFINE i INTEGER
DEFINE c STRING
    LET colArray[i].class = c
END FUNCTION

PUBLIC FUNCTION col_style_set(i,s)
DEFINE i INTEGER
DEFINE s STRING
    LET colArray[i].style = s
END FUNCTION

PUBLIC FUNCTION cell_set(x,y,v)
DEFINE x,y INTEGER
DEFINE v STRING
    LET cellArray[x,y].value = v
END FUNCTION

PUBLIC FUNCTION cell_get(x,y)
DEFINE x,y INTEGER
    RETURN cellArray[x,y].value
END FUNCTION

PUBLIC FUNCTION cell_class_set(x,y,c)
DEFINE x,y INTEGER
DEFINE c STRING
    LET cellArray[x,y].class = c
END FUNCTION

PUBLIC FUNCTION cell_style_set(x,y,s)
DEFINE x,y INTEGER
DEFINE s STRING
    LET cellArray[x,y].style = s
END FUNCTION

PUBLIC FUNCTION cell_style_append(x,y,s)
DEFINE x,y INTEGER
DEFINE s STRING
    LET cellArray[x,y].style = SFMT("%1;%2", cellArray[x,y].style,s)
END FUNCTION

PUBLIC FUNCTION cell_width_set(x,y,w)
DEFINE x,y INTEGER
DEFINE w STRING
    LET cellArray[x,y].width = w
END FUNCTION

PUBLIC FUNCTION cell_height_set(x,y,h)
DEFINE x,y INTEGER
DEFINE h STRING
    LET cellArray[x,y].height = h
END FUNCTION



PUBLIC FUNCTION style_append(selector, att, val)
DEFINE selector, att, val STRING
DEFINE i,j INTEGER

    FOR i = 1 TO styleArray.getLength()
        IF styleArray[i].selector = selector THEN
            EXIT FOR
        END IF
    END FOR
    -- i = style, or create new one
    IF i > styleArray.getLength() THEN
        LET styleArray[i].selector = selector
    END IF
    FOR j = 1 TO styleArray[i].style.getLength()
        IF styleArray[i].style[j].att = att THEN
            # EXIT FOR
        END IF
    END FOR
    -- j = att, or create new one
    IF j > styleArray[i].style.getLength() THEN
        LET styleArray[i].style[j].att = att
    END IF
    LET styleArray[i].style[j].val = val
END FUNCTION
    



FUNCTION generate_html()
DEFINE sb base.StringBuffer
DEFINE x, y INTEGER
DEFINE excludeList DYNAMIC ARRAY OF RECORD
    x INTEGER,
    y INTEGER
END RECORD
DEFINE i, j, k INTEGER
DEFINE l_exclude BOOLEAN

    CALL excludeList.clear()
    
    LET sb = base.StringBuffer.create()
    CALL sb.append('<table>')

    # do column heading row
    CALL sb.append("<tr>")
    CALL sb.append("<th></th>")

    FOR x = 1 TO colArray.getLength()
        CALL sb.append(SFMT('<th id="%1" class="%2" style="%3" onclick="execAction(\'%1\')">', col_id(x), colArray[x].class, colArray[x].style))
        CALL sb.append(colArray[x].title)
        CALL sb.append("</th>")
    END FOR
    CALL sb.append("</tr>")

    # for each row
    FOR y = 1 TO rowArray.getLength()
        CALL sb.append("<tr>")
        CALL sb.append(SFMT('<th id="%1" class="%2" style="%3" onclick="execAction(\'%1\')">', row_id(y), rowArray[y].class, rowArray[y].style))
        CALL sb.append(rowArray[y].title)
        CALL sb.append("</th>")
        FOR x = 1 TO colArray.getLength()
            -- Determine if cell previously merged, if so skip
            LET l_exclude = FALSE
            FOR k = 1 TO excludeList.getLength()
                IF excludeList[k].x = x AND excludeList[k].y = y THEN
                    LET l_exclude = TRUE
                    EXIT FOR
                END IF
            END FOR
            IF l_exclude THEN
                CONTINUE FOR
            END IF
            -- draw cell
            CALL sb.append(SFMT('<td id="%1" class="%2" style="%3" onclick="execAction(\'%1\')"', cell_id(x,y), cellArray[x,y].class, cellArray[x,y].style))
            IF cellArray[x,y].width > 1 THEN
                CALL sb.append(SFMT(' colspan="%1"', cellArray[x,y].width))
            END IF
            IF cellArray[x,y].height > 1 THEN
                CALL sb.append(SFMT(' rowspan="%1"', cellArray[x,y].height))
            END IF
            -- add to exclude list
            IF cellArray[x,y].width > 1 OR cellArray[x,y].height > 1 THEN
                FOR i = 1 TO nvl(cellArray[x,y].width,1)
                    FOR j = 1 TO nvl(cellArray[x,y].height,1)
                        LET k = excludeList.getLength()+1
                        LET excludeList[k].x = x+i-1
                        LET excludeList[k].y = y+j-1
                    END FOR
                END FOR
            END IF
            CALL sb.append(">")
            CALL sb.append(cellArray[x,y].value)
            CALL sb.append("</td>")
        END FOR
        CALL sb.append("</tr>")
        
        -- Remove this row entry from excludeList
        FOR k = excludeList.getLength() TO 1 STEP -1
            IF excludeList[k].y <= y THEN
                CALL excludeList.deleteElement(k)
            END IF
        END FOR
    END FOR
    CALL sb.append("</table>")
    #DISPLAY sb.toString()
    RETURN sb.toString()
END FUNCTION

FUNCTION generate_css()
DEFINE sb base.StringBuffer
DEFINE i, j INTEGER

    LET sb = base.StringBuffer.create()
    FOR i = 1 TO styleArray.getLength()
    
        CALL sb.append(styleArray[i].selector)
        CALL sb.append(" {")
        FOR j = 1 TO styleArray[i].style.getLength()
            CALL sb.append(SFMT(" %1 : %2; ",styleArray[i].style[j].att,styleArray[i].style[j].val))
        END FOR
        CALL sb.append("} ")
    END FOR
    #DISPLAY sb.toString()
    RETURN sb.toString()
END FUNCTION

FUNCTION col_id(x)
DEFINE x INTEGER
    RETURN SFMT("col_%1",x USING "<<<&")
END FUNCTION

FUNCTION row_id(y)
DEFINE y INTEGER
    RETURN SFMT("row_%1",y USING "<<<&")
END FUNCTION

FUNCTION cell_id(x,y)
DEFINE x, y INTEGER
    RETURN SFMT("cell_%1_%2",x USING "<<<&",y USING "<<<&")
END FUNCTION

 

FUNCTION html_send(fieldname)
DEFINE fieldname STRING
DEFINE l_result STRING

    CALL ui.interface.frontcall("webcomponent","call",[fieldname,"setById","root",generate_html()],l_result)
    CALL ui.Interface.frontCall("webcomponent","call",[fieldname,"setById","udf", generate_css()], l_result)
END FUNCTION
    

    

