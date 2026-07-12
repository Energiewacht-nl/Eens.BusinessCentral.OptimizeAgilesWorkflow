//namespace Essent.OptimizeAgilesWorkflow.AgilesWorkflow;

codeunit 92626 "PTE Clear Images (Agiles)"
{
    /// <summary>
    /// Process Clearing Images from buffer. If HideDialog is true, no dialog will be shown.
    /// If HideDialog is false, a dialog will be shown with the progress of clearing images
    /// </summary>
    /// <param name="HideDialog"></param>
    procedure ProcessBuffer(HideDialog: Boolean)
    var
        ToDo: Record "aWF - To-do";
        Code: Code[20];
        Dlg: Dialog;
        i: Integer;
    begin
        if not HideDialog then
            Dlg.Open('Clearing images... #1############ of ' + Format(ToDoBuffer.Count));
        foreach Code in ToDoBuffer do begin
            ToDo.Get(Code);
            Clear(ToDo."Status Picture");
            ToDo.Modify();
            i += 1;
            if not HideDialog then
                Dlg.Update(1, i);
        end;
        if not HideDialog then
            Dlg.Close();
    end;

    /// <summary>
    /// Add aWF To-Do to buffer if a status picture is present
    /// </summary>
    /// <param name="ToDo"></param>
    /// <returns></returns>
    procedure AddToBufferIfImageExists(var ToDo: Record "aWF - To-do"): Integer
    begin
        ToDo.CalcFields("Status Picture");
        if not ToDo."Status Picture".HasValue then
            exit;

        ToDoBuffer.Add(ToDo."No.");
        exit(1);
    end;

    /// <summary>
    /// Add aWF Status Level to buffer if a picture is present
    /// </summary>
    procedure ClearSetup()
    var
        StatusLevel: Record "aWF - Status Level";
    begin
        StatusLevel.SetAutoCalcFields(Picture);
        repeat
            if StatusLevel.Picture.HasValue then begin
                Clear(StatusLevel.Picture);
                StatusLevel.Modify();
            end;
        until StatusLevel.Next() = 0;
    end;

    var
        ToDoBuffer: List of [Code[20]];
}