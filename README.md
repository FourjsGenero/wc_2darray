# fgl_2darray
A library that uses web component to render 2d array, that is array with a variable number of rows and columns.

The existing Genero DISPLAY ARRAY and TABLE functionality is very good for displaying rows of data from a relational database table.  That is data with a fixed number of columns and variable number of rows.

Sometimes you need to consider a variable number of columns, typically in the retail space where you have variable number of colours, variable number of sizes for a product, or at the stock level, a variable number of products and variable number of warehouses.

![Variable Number of Columns](https://user-images.githubusercontent.com/13615993/32204980-7020f576-be51-11e7-9c9b-400db28edf29.png)

The existing DISPLAY ARRAY and TABLE functionaliy does not also cater well for things like Calendars that this WebComponent can be used for

![Calendar](https://user-images.githubusercontent.com/13615993/32204979-6fe8c28c-be51-11e7-8839-f926926cd4f0.png)

Similarly timelines ...

![Timeline](https://user-images.githubusercontent.com/13615993/32204978-6fabf91a-be51-11e7-8b57-c97927151644.png)

Finally you may want to merge calls (note the headings) ...

![Merged Cells](https://user-images.githubusercontent.com/13615993/32204977-6f5df40e-be51-11e7-93de-475e10b5a0b9.png)

Have styles for individual cells ...

![Styles for Cells](https://user-images.githubusercontent.com/13615993/32204976-6f22251e-be51-11e7-9672-e231cd48454b.png)

And have multiple lines of aggregates.

![Multiple lines of aggregate](https://user-images.githubusercontent.com/13615993/32205137-71d300b6-be52-11e7-91a4-d247d95880f8.png)

This WebComponent can be used to implement the functionality listed above.

The files consist of a WebComponent wc_2darray.html and a 4gl wc_2darray.4gl you can use as an interface to this in an IMPORT FGL statement.

There is a test file wc_2darray_test.4gl and wc_2darray_test.per that shows some possilibilities.

The code should be fairly self-commenting as in the examples. Essentially the pattern is

IMPORT FGL wc_2darray

CALL wc_2darray.init()
-- append some styles
-- define individual rows, columns, or cells
CALL wc_2darray.html_send(fieldname)







