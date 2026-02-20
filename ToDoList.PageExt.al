pageextension 92627 "PTE To-Do List" extends "aWF - To-do List"
{
    layout
    {
        modify("Status Picture")
        {
            Visible = false;
        }
        addafter("Status Picture")
        {
            field(Status; StatusLevelBuffer.Name)
            {
                ApplicationArea = All;
                StyleExpr = StatusStyle;
            }
        }
    }

    trigger OnOpenPage()
    var
        StatusLevel: Record "aWF - Status Level";
        aWFTextTranslationMgt: Codeunit "aWF - Text Translation Mgt.";
    begin
        StatusLevelBuffer.DeleteAll();
        StatusLevel.FindSet();
        repeat
            StatusLevelBuffer := StatusLevel;
            StatusLevelBuffer.Name :=
                    aWFTextTranslationMgt.GetTextFieldTranslationDescription(Database::"aWF - Status Level", StatusLevelBuffer.FieldNo(Name), 0, '', StatusLevelBuffer.Level, false, true);
            StatusLevelBuffer.Insert();
        until StatusLevel.Next() = 0;
    end;

    trigger OnafterGetRecord()
    begin
        StatusLevelBuffer.Get(Rec."Status Level");
        case StatusLevelBuffer.Style of
            StatusLevelBuffer.Style::Standard:
                StatusStyle := 'Standard';
            StatusLevelBuffer.Style::StandardAccent:
                StatusStyle := 'StandardAccent';
            StatusLevelBuffer.Style::Strong:
                StatusStyle := 'Strong';
            StatusLevelBuffer.Style::StrongAccent:
                StatusStyle := 'StrongAccent';
            statuslevelbuffer.Style::Attention:
                StatusStyle := 'Attention';
            StatusLevelBuffer.Style::AttentionAccent:
                StatusStyle := 'AttentionAccent';
            StatusLevelBuffer.Style::Favorable:
                StatusStyle := 'Favorable';
            StatusLevelBuffer.Style::Unfavorable:
                StatusStyle := 'Unfavorable';
            StatusLevelBuffer.Style::Ambiguous:
                StatusStyle := 'Ambiguous';
            StatusLevelBuffer.Style::Subordinate:
                StatusStyle := 'Subordinate';
        end;
    end;

    trigger OnafterGetCurrRecord()
    begin
        //StatusLevelBuffer.Get(Rec."Status Level");
        //StatusStyle := Format(StatusLevelBuffer.Style);
    end;

    var
        test: Page "aWF - Status Level List";
        StatusLevelBuffer: Record "aWF - Status Level" temporary;
        StatusStyle: Text;
}