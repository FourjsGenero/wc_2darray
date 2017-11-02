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

PUBLIC FUNCTION row_set(row, title)
DEFINE row INTEGER
DEFINE title STRING
    LET rowArray[row].title = title
END FUNCTION

PUBLIC FUNCTION col_set(col, title)
DEFINE col INTEGER
DEFINE title STRING
    LET colArray[col].title = title
END FUNCTION

PUBLIC FUNCTION row_class_set(row, class)
DEFINE row INTEGER
DEFINE class STRING
    LET rowArray[row].class = class
END FUNCTION

PUBLIC FUNCTION row_style_set(row, style)
DEFINE row INTEGER
DEFINE style STRING
    LET rowArray[row].style = style
END FUNCTION

PUBLIC FUNCTION col_class_set(col ,class)
DEFINE col INTEGER
DEFINE class STRING
    LET colArray[col].class = class
END FUNCTION

PUBLIC FUNCTION col_style_set(col, style)
DEFINE col INTEGER
DEFINE style STRING
    LET colArray[col].style = style
END FUNCTION

PUBLIC FUNCTION cell_set(col, row, value)
DEFINE col,row INTEGER
DEFINE value STRING
    LET cellArray[col,row].value = value
END FUNCTION

PUBLIC FUNCTION cell_get(col, row)
DEFINE col, row INTEGER
    RETURN cellArray[col,row].value
END FUNCTION

PUBLIC FUNCTION cell_class_set(col, row, class)
DEFINE col, row INTEGER
DEFINE class STRING
    LET cellArray[col,row].class = class
END FUNCTION

PUBLIC FUNCTION cell_style_set(col, row, style)
DEFINE col, row INTEGER
DEFINE style STRING
    LET cellArray[col,row].style = style
END FUNCTION

PUBLIC FUNCTION cell_style_append(col, row, style)
DEFINE col, row INTEGER
DEFINE style STRING
    LET cellArray[col, row].style = SFMT("%1;%2", cellArray[col, row].style,style)
END FUNCTION

PUBLIC FUNCTION cell_width_set(col, row, width)
DEFINE col, row INTEGER
DEFINE width INTEGER
    LET cellArray[col, row].width = width
END FUNCTION

PUBLIC FUNCTION cell_height_set(col, row, height)
DEFINE col, row INTEGER
DEFINE height INTEGER
    LET cellArray[col, row].height = height
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
DEFINE col, row INTEGER

-- Used to determine if cell should be excluded because it has been merged with a cell above or to the left
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

    FOR col = 1 TO colArray.getLength()
        CALL sb.append(SFMT('<th id="%1" class="%2" style="%3" onclick="execAction(\'%1\')">', col_id(col), colArray[col].class, colArray[col].style))
        CALL sb.append(colArray[col].title)
        CALL sb.append("</th>")
    END FOR
    CALL sb.append("</tr>")

    # for each row
    FOR row = 1 TO rowArray.getLength()
        CALL sb.append("<tr>")
        CALL sb.append(SFMT('<th id="%1" class="%2" style="%3" onclick="execAction(\'%1\')">', row_id(row), rowArray[row].class, rowArray[row].style))
        CALL sb.append(rowArray[row].title)
        CALL sb.append("</th>")
        FOR col = 1 TO colArray.getLength()
            -- Determine if cell previously merged, if so skip
            LET l_exclude = FALSE
            FOR k = 1 TO excludeList.getLength()
                IF excludeList[k].x = col AND excludeList[k].y = row THEN
                    LET l_exclude = TRUE
                    EXIT FOR
                END IF
            END FOR
            IF l_exclude THEN
                CONTINUE FOR
            END IF
            -- draw cell
            CALL sb.append(SFMT('<td id="%1" class="%2" style="%3" onclick="execAction(\'%1\')"', cell_id(col,row), cellArray[col,row].class, cellArray[col,row].style))
            IF cellArray[col,row].width > 1 THEN
                CALL sb.append(SFMT(' colspan="%1"', cellArray[col,row].width))
            END IF
            IF cellArray[col,row].height > 1 THEN
                CALL sb.append(SFMT(' rowspan="%1"', cellArray[col,row].height))
            END IF
            -- add to exclude list
            IF cellArray[col,row].width > 1 OR cellArray[col,row].height > 1 THEN
                FOR i = 1 TO nvl(cellArray[col,row].width,1)
                    FOR j = 1 TO nvl(cellArray[col,row].height,1)
                        LET k = excludeList.getLength()+1
                        LET excludeList[k].x = col+i-1
                        LET excludeList[k].y = row+j-1
                    END FOR
                END FOR
            END IF
            CALL sb.append(">")
            CALL sb.append(cellArray[col,row].value)
            CALL sb.append("</td>")
        END FOR
        CALL sb.append("</tr>")
        
        -- Remove this row entry from excludeList
        FOR k = excludeList.getLength() TO 1 STEP -1
            IF excludeList[k].y <= row THEN
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

FUNCTION col_id(col)
DEFINE col INTEGER
    RETURN SFMT("col_%1", col USING "<<<&")
END FUNCTION

FUNCTION row_id(row)
DEFINE row INTEGER
    RETURN SFMT("row_%1", row USING "<<<&")
END FUNCTION

FUNCTION cell_id(col, row)
DEFINE col, row INTEGER
    RETURN SFMT("cell_%1_%2",col USING "<<<&", row USING "<<<&")
END FUNCTION

 

FUNCTION html_send(fieldname)
DEFINE fieldname STRING
DEFINE l_result STRING

    CALL ui.interface.frontcall("webcomponent","call",[fieldname,"setAttributeById","root", "innerHTML",generate_html()],l_result)
    CALL ui.Interface.frontCall("webcomponent","call",[fieldname,"setAttributeById","udf", "innerHTML",generate_css()], l_result)
END FUNCTION
    

    

