report 92627 "PTE Cleanup Images (Agiles)"
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
                Dlg.Open('Processing To-dos... #1############ of ' + Format(ToDo.Count));
                ClearImages.ClearSetup();
            end;

            trigger OnAfterGetRecord()
            begin
                i += ClearImages.AddToBufferIfImageExists(ToDo);
                Dlg.Update(1, i);
            end;

            trigger OnPostDataItem()
            begin
                ClearImages.ProcessBuffer(false);
                Dlg.Close();
            end;
        }
    }

    var
        ClearImages: Codeunit "PTE Clear Images (Agiles)";
        i: Integer;
        Dlg: Dialog;
}