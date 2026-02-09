report 92625 "PTE Cleanup Images (Agiles)"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(ToDo; "aWF - To-do")
        {
            trigger OnPreDataItem()
            begin
                Dlg.Open('Processing To-dos... #1############');
                ClearImages.ClearSetup();
            end;

            trigger OnAfterGetRecord()
            begin
                ClearImages.AddToBufferIfImageExists(ToDo);
                Dlg.Update(1, i);
            end;

            trigger OnPostDataItem()
            begin
                ClearImages.ProcessBuffer();
                Dlg.Close();
            end;
        }
    }

    var
        ClearImages: Codeunit "PTE Clear Images (Agiles)";
        i: Integer;
        Dlg: Dialog;
}