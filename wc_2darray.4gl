DEFINE colArray DYNAMIC ARRAY OF RECORD
    title STRING,
    style STRING
END RECORD

DEFINE rowArray DYNAMIC ARRAY OF RECORD
    title STRING,
    style STRING
END RECORD

DEFINE cellArray DYNAMIC ARRAY WITH DIMENSION 2 OF RECORD
    value STRING,
    style STRING
END RECORD


PUBLIC FUNCTION init()
    CALL colArray.clear()
    CALL rowArray.clear()
    CALL cellArray.clear()
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

PUBLIC FUNCTION row_style_set(i,s)
DEFINE i INTEGER
DEFINE s STRING
    LET rowArray[i].style = s
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

PUBLIC FUNCTION cell_style_set(x,y,s)
DEFINE x,y INTEGER
DEFINE s STRING
    LET cellArray[x,y].style = s
END FUNCTION

FUNCTION generate_html()
DEFINE sb base.StringBuffer
DEFINE x, y INTEGER

    LET sb = base.StringBuffer.create()
    CALL sb.append('<table>')

    # do column heading row
    CALL sb.append("<tr>")
    CALL sb.append("<th></th>")

    FOR x = 1 TO colArray.getLength()
        CALL sb.append(SFMT('<th id="%1" style="%2" onclick="execAction(\'%1\')">', col_id(x), colArray[x].style))
        CALL sb.append(colArray[x].title)
        CALL sb.append("</th>")
    END FOR
    CALL sb.append("</tr>")

    # for each row
    FOR y = 1 TO rowArray.getLength()
        CALL sb.append("<tr>")
        CALL sb.append(SFMT('<th id="%1" style="%2" onclick="execAction(\'%1\')">', row_id(y), rowArray[y].style))
        CALL sb.append(rowArray[y].title)
        CALL sb.append("</th>")
        FOR x = 1 TO colArray.getLength()
            CALL sb.append(SFMT('<td id="%1" style="%2" onclick="execAction(\'%1\')">', cell_id(x,y), cellArray[x,y].style))
            CALL sb.append(cellArray[x,y].value)
            CALL sb.append("</td>")
        END FOR
        CALL sb.append("</tr>")
    END FOR
    CALL sb.append("</table>")
    DISPLAY sb.toString()
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
END FUNCTION
    

    

