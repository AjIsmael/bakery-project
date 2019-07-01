require 'spreadsheet'

def create_ticket(order,name)
  Spreadsheet.client_encoding = 'UTF-8'
  book = Spreadsheet::Workbook.new
  sheet1 = book.create_worksheet
  sheet1.row(0).concat %w{Order Quantity}
  i = 1
  for x in order do
    sheet1.row(i).push x[0], x[1]
    i += 1
  end
  folder_address = File.expand_path(File.dirname(__FILE__))
  folder_address << "/orders/Order#{name}.xls"
  book.write folder_address
end
