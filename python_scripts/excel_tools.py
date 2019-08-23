import xlwt

class excel_tools:
    def __init__(self):        
        self.workbook = xlwt.Workbook()
        self.mean_std = self.workbook.add_sheet('mean and std') 
        self.statistics = self.workbook.add_sheet('statistics')
        self.mean_std.column_count = 0 
        self.mean_std.row_count = 0
        self.statistics.column_count = 0 
        self.statistics.row_count = 0
        
    def write_column(self, sheet, title, array):       
        sheet.write(sheet.row_count, sheet.column_count, title) 
        row_count = sheet.row_count + 1
        try:
            length = array.shape[0]
            for i in range(length):
                sheet.write(row_count + i, sheet.column_count, array[i].item())
            sheet.column_count += 1
            return
        except AttributeError:        
            length = len(array)
            for i in range(length):
                sheet.write(row_count + i, sheet.column_count, array[i])
            sheet.column_count += 1
            return
        except Exception as e:
            sheet.write(row_count, sheet.column_count, array.item())
            sheet.column_count += 1
            return
        

        
    def write_row(self, sheet, title, array):
        sheet.write(sheet.row_count, sheet.column_count, title) 
        column_count = sheet.column_count + 1
        try:
            length = array.shape[0]
            for i in range(length):
                sheet.write(sheet.row_count, column_count + i, array[i].item())
            sheet.row_count += 1
            return
        except AttributeError:        
            length = len(array)
            for i in range(length):
                sheet.write(sheet.row_count, column_count + i, array[i])
            sheet.row_count += 1
            return
        except Exception as e:
            sheet.write(sheet.row_count, column_count, array.item())
            sheet.row_count += 1
            return
            


        
    
                