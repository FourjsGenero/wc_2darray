# wc_2darray
A library that uses a Web Component to render two dimensional arrays, that is arrays with both a variable number of rows and a variable number of columns.  It also incorporates some advanced array rendering requirements.

The existing Genero DISPLAY ARRAY and TABLE functionality is very good for displaying rows of data from a relational database table.  That is data with a fixed number of columns and a variable number of rows.  However sometimes you have more complex user interface requirements, and that is where you would incorporate a Web Component into your Genero application.  Some example use cases are shown below ...

In retail environments, you have business case scenarios where you may have a variable number of columns and rows.  For products, that can include variable number of colours and a variable number of sizes per product.  This Web Component can be used to create a user interface that renders this variable number of rows and columns, and allows the user to select data.

![Variable Number of Columns](https://user-images.githubusercontent.com/13615993/32204980-7020f576-be51-11e7-9c9b-400db28edf29.png)

A calendar has complex array functionality when you think of the various time slots of differing lengths.  This Web Component allows you to split and merge cells so that you can represent time slots of different lengths.

![Calendar](https://user-images.githubusercontent.com/13615993/32204979-6fe8c28c-be51-11e7-8839-f926926cd4f0.png)

A timeline can also have complex array requirements.  This included merged cells, subgroups, and styles applied to individual cells.

![Timeline](https://user-images.githubusercontent.com/13615993/32204978-6fabf91a-be51-11e7-8b57-c97927151644.png)

This example shows headings being merged and styles being applied to groups of columns.

![Merged Cells](https://user-images.githubusercontent.com/13615993/32204977-6f5df40e-be51-11e7-93de-475e10b5a0b9.png)

This screenshot shows styles being applied to individual cells.

![Styles for Cells](https://user-images.githubusercontent.com/13615993/32204976-6f22251e-be51-11e7-9672-e231cd48454b.png)

The final screenshot shows multiple lines of aggregates.

![Multiple lines of aggregate](https://user-images.githubusercontent.com/13615993/32205137-71d300b6-be52-11e7-91a4-d247d95880f8.png)

As illustrated, this WebComponent can be used to implement the advanced functionality shown above.

The files consist of a WebComponent wc_2darray.html and a 4gl wc_2darray.4gl you can use as an interface to this in an IMPORT FGL statement.

There is a test file wc_2darray_test.4gl and wc_2darray_test.per that shows some possilibilities.

The code should be fairly self-commenting as in the examples. Essentially the pattern is ...

    IMPORT FGL wc_2darray

    CALL wc_2darray.init()
    -- define styles/classes at the beginning that will be used by the individual cells, columns, and rows 
    -- define individual rows, columns, or cells
    CALL wc_2darray.html_send(fieldname)

Unlike the Genero Table/Array, there is no optimisation about what is sent to the front-end.  If you have large scrolling requirements, you should incorporate some paging functionality into your application before generating the HTML used in the Web Component.  That is try and only generate visible HTML.

Similarly there is no built-in searching, column resizing, column moving (yet) that you will find in a standard Genero Table/Array.





