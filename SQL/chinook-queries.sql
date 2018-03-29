-- Provide a query showing Customers (just their full names, customer ID and country) who are not in the US.
SELECT ("FirstName" || ' ' ||"Lastname") AS "FullName", "CustomerId", "FirstName", "LastName", "Country" 
FROM Customer c
WHERE c.country IS NOT "USA"

-- Provide a query only showing the Customers from Brazil.
SELECT ("FirstName" || ' ' ||"Lastname") AS "FullName", "CustomerId", "FirstName", "LastName", "Country" 
FROM Customer c
WHERE c.country IS "Brazil"

-- Provide a query showing the Invoices of customers who are from Brazil. The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country.
SELECT (c.FirstName || ' ' || c.LastName) AS FullName, i.BillingCountry, i.InvoiceDate, i.InvoiceId
FROM Customer c
JOIN Invoice i ON i.CustomerId=c.CustomerId 
WHERE c.country IS "Brazil"

-- Provide a query showing only the Employees who are Sales Agents.
SELECT *
FROM Employee e
WHERE Title IS "Sales Support Agent"

-- Provide a query showing a unique list of billing countries from the Invoice table.
SELECT DISTINCT i.BillingCountry
FROM Invoice i

-- Provide a query that shows the invoices associated with each sales agent. The resultant table should include the Sales Agent's full name.
SELECT (e.FirstName || ' ' || e.Lastname) as FullName, invoice.*
FROM Invoice 
JOIN customer c ON c.CustomerId = invoice.CustomerId
Join Employee e ON e.EmployeeId = c.SupportRepId 


-- Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers.
SELECT (c.FirstName || ' ' || c.LastName) as 'Customer Name', i.Total as 'Invoice Total', i.BillingCountry, (e.FirstName || ' ' || e.Lastname) as 'Sales Agent Name'
FROM Invoice i
JOIN customer c ON c.CustomerId = i.CustomerId
Join Employee e ON e.EmployeeId = c.SupportRepId 


-- How many Invoices were there in 2009 and 2011? What are the respective total sales for each of those years?
SELECT COUNT(i.InvoiceDate) as 'Total Sales', ROUND(SUM(i.Total),2) as "Invoice Total", substr(i.InvoiceDate, 1,4) as "Year"
FROM Invoice i
WHERE i.InvoiceDate LIKE '2009%'
or i.InvoiceDate LIKE '2011%'
GROUP BY substr(i.InvoiceDate, 1,4)


-- Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.
SELECT COUNT(il.InvoiceId) as 'Line Item Total'
FROM InvoiceLine il
where il.InvoiceId = '37'

-- Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice. HINT: GROUP BY
SELECT i.invoiceID, COUNT(il.InvoiceId) as 'Line Item Total'
FROM Invoice i
join InvoiceLine il ON i.invoiceID = il.invoiceID
GROUP BY i.invoiceID

-- Provide a query that includes the track name with each invoice line item.
SELECT il.*, t.name
FROM InvoiceLine il
join Track t ON il.trackid = t.trackID

-- Provide a query that includes the purchased track name AND artist name with each invoice line item.
SELECT il.*, t.name as "Track Name", ar.name as "Artist Name"
FROM InvoiceLine il
join Track t ON il.trackid = t.trackID
join Album ON t.albumid = album.albumid
join Artist ar ON album.artistid = ar.artistid


-- Provide a query that shows the # of invoices per country. HINT: GROUP BY
SELECT COUNT(i.invoiceID) as "Number of Invoices", i.BillingCountry
FROM Invoice i
GROUP BY i.BillingCountry


-- Provide a query that shows the total number of tracks in each playlist. The Playlist name should be included on the resultant table.
SELECT p.name as "Playlist Name", COUNT(t.trackID) as "Total Number of Tracks"
FROM Playlist p
JOIN PlaylistTrack pt ON p.playlistid = pt.playlistid
JOIN Track t ON pt.trackid = t.trackid
GROUP BY p.name

-- Provide a query that shows all the Tracks, but displays no IDs. The resultant table should include the Album name, Media type and Genre.
SELECT t.name as "Track Name", al.title as "Album Title", m.name as "Media Type", g.name as "Genre", t.composer, t.Milliseconds, t.Bytes, t.UnitPrice
FROM Track t
JOIN Album al ON t.albumid = album.albumid
JOIN MediaType m ON t.MediaTypeId = m.MediaTypeId
JOIN Genre g ON t.genreId = g.genreId

-- Provide a query that shows all Invoices but includes the # of invoice line items.
SELECT i.*, COUNT(il.invoiceID) as "Number of Invoice Line Items"
FROM invoice i
JOIN InvoiceLine il ON i.invoiceID = il.invoiceID
GROUP BY i.invoiceID

-- Provide a query that shows total sales made by each sales agent.
SELECT (e.FirstName || ' ' || e.LastName) AS 'Sales Agent Name', ROUND(SUM(i.total),2) as 'Total Sales'
FROM Employee e 
Join Customer c ON c.SupportRepId = e.EmployeeId
JOIN Invoice i ON c.customerId = i.customerId
GROUP BY e.EmployeeId

-- Which sales agent made the most in sales in 2009?

SELECT (e.FirstName || ' ' || e.LastName) AS 'Sales Agent Name', ROUND(SUM(i.total),2) as 'Total Sales'
FROM Employee e 
Join Customer c ON c.SupportRepId = e.EmployeeId
JOIN Invoice i ON c.customerId = i.customerId
WHERE i.InvoiceDate LIKE "2009%"
GROUP BY e.EmployeeId
ORDER BY "Total Sales" DESC limit 1

-- Which sales agent made the most in sales in 2010?
SELECT (e.FirstName || ' ' || e.LastName) AS 'Sales Agent Name', ROUND(SUM(i.total),2) as 'Total Sales'
FROM Employee e 
Join Customer c ON c.SupportRepId = e.EmployeeId
JOIN Invoice i ON c.customerId = i.customerId
WHERE i.InvoiceDate LIKE "2010%"
GROUP BY e.EmployeeId
ORDER BY "Total Sales" DESC limit 1

-- Which sales agent made the most in sales over all?
SELECT (e.FirstName || ' ' || e.LastName) AS 'Sales Agent Name', ROUND(SUM(i.total),2) as 'Total Sales'
FROM Employee e 
JOIN Customer c ON c.SupportRepId = e.EmployeeId
JOIN Invoice i ON c.customerId = i.customerId
GROUP BY e.EmployeeId
ORDER BY "Total Sales" DESC limit 1

-- Provide a query that shows the # of customers assigned to each sales agent.
SELECT (e.Firstname || ' ' || e.Lastname) AS 'Sales Agent Name', c.customerID AS 'Total Customers'
FROM Employee e
JOIN Customer c on c.SupportRepId = e.EmployeeId
GROUP BY e.EmployeeId
ORDER By "Total Customers" DESC 

-- Provide a query that shows the total sales per country. Which country's customers spent the most?
-- Provide a query that shows the most purchased track of 2013.
-- Provide a query that shows the top 5 most purchased tracks over all.
-- Provide a query that shows the top 3 best selling artists.
-- Provide a query that shows the most purchased Media Type.
-- Provide a query that shows the number tracks purchased in all invoices that contain more than one genre.
