unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids;

type
  TForm1 = class(TForm)
    Label2: TLabel;
    Button1: TButton;
    Label3: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    Label4: TLabel;
    Label5: TLabel;
    Image1: TImage;
    Label1: TLabel;
    Memo3: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  s,ss: string;
  n: integer;

implementation

{$R *.dfm}



//========����������=�=������=����================
procedure ad;
var
  flag: boolean;
  i: integer;
  bufer: string;
begin

  if length(s)=0 then
    exit;


  {���������� ����� � ���� ������}
  Form1.Memo3.Lines.Add(s);
  n:=n+1;
  s:='';


  {���������� ���� � ���������� �������}
  repeat

    flag:=false;
    for i:=0 to n-2 do
      if AnsiCompareText(Form1.Memo3.Lines[i],Form1.Memo3.Lines[i+1])>0 then
        begin
          bufer:=Form1.Memo3.Lines[i];
          Form1.Memo3.Lines[i]:=Form1.Memo3.Lines[i+1];
          Form1.Memo3.Lines[i+1]:=bufer;
          flag:=true;
        end;

  until flag=false;

end;



//===============����������=��������=�����������=���������=========
function res: string;

var
  op1,op2: real;
  resul: string;
  i,j: integer;
  flag: boolean;

begin


  resul:=ss;
  insert(' ',ss,length(ss)+1);


  {���������� �������� ���������}
  repeat

    flag:=false;

    for i:=1 to length(ss) do

        if ss[i] in ['+','-'] then
          begin

            if i=1 then continue; //���� ������ ������ "-", �� ���������� ������ �����

            flag:=true; //������� ����������(+,-)

            op1:=StrToFloat(copy(ss,1,i-1));  //������ �������

            for j:=i+1 to length(ss) do
              if ss[j] in ['+','-',' '] then
                begin
                  op2:=StrToFloat(copy(ss,i+1,j-(i+1)));  //������ �������
                  break;
                end;

            if ss[i]='+' then
              resul:=FloatToStr(op1+op2)
            else
              resul:=FloatToStr(op1-op2);

            delete(ss,1,j-1);
            insert(resul,ss,1);
            break;

          end;

  until flag=false;

  res:=resul;

end;



//===================���������=���������======================
procedure easy(pos1,pos2,pos3: integer);
var
  op1,op2: real;
  znak,result: string;
begin

  op1:=StrToFloat(copy(ss,pos2+1,pos1-(pos2+1))); //������� ����� �� �����
  op2:=StrToFloat(copy(ss,pos1+1,pos3-(pos1+1))); //������� ������ �� �����
  znak:=copy(ss,pos1,1);  //��������(*,/) ����� ����������

  if znak='*' then
    result:=FloatToStr(op1*op2)
  else
    result:=FloatToStr(op1/op2);

  {������ ������������� �������� ��� �����������}
  delete(ss,pos2+1,pos3-(pos2+1));
  insert(result,ss,pos2+1);

end;



//========����������=��������=��������������=��������==========
procedure calculation;
var
  i,j,posPriority,posBegin,posEnd: integer;
  fPriority: boolean;
begin

   Form1.Memo1.Text:=Form1.Memo1.Text+ss+' = '; //����� ������ �������� ���������

   repeat

    posPriority:=0;       //������� ���������(*,/)
    posBegin:=0;          //����������� ������ ������������� ��������
    posEnd:=length(ss)+1; //����������� ����� ������������� ��������

    fPriority:=false;   //�������� ������� ������������� ��������


    {��������� ���������, �.�. ���������� ������������ ��������(*,/)}
    for i:=1 to length(ss) do
    begin

      if ss[i] in ['*','/'] then
        begin

          posPriority:=i;
          fPriority:=true;

          {����������� ������ ������������� ��������}
          for j:=i-1 downto 1 do
            if ss[j] in ['-','+','/','*'] then
              begin
                posBegin:=j;
                break;
              end;

          {����������� ����� ������������� ��������}
          for j:=i+1 to length(ss) do
            if ss[j] in ['-','+','*','/'] then
              begin
                posEnd:=j;
                break;
              end;

          {�������� ������� �� ����}
          if (ss[i]='/') and ((copy(ss,posPriority+1,posEnd-(posPriority+1)))='0') then
            begin
              Form1.Memo1.Text:=Form1.Memo1.Text+'������'+#13+#10;
              exit;
            end;

          easy(posPriority,posBegin,posEnd); //����� ��������� ��������� ���������
          break;

        end;

    end;

   until fPriority=false; //������� ������: ���������� ������������ ��������

   Form1.Memo1.Text:=Form1.Memo1.Text+res+#13+#10;  //����� ������ ����� ���������
                                                    //res - ������� ������������ ���������
end;



//=========�������=��=������="�����"==============
procedure TForm1.Button1Click(Sender: TObject);
var
  i: integer;
  st: string;
  fZnak, fDrob: boolean;
begin


  {�������� �� ������ ����}
  if Form1.Memo2.Text='' then
    begin
      Form1.Label5.Caption:='���� ����� �� ����� ���� ������';
      Form1.Memo1.Text:='(��� ���������)';
      Form1.Memo3.Text:='(��� ����)';
      Form1.Memo2.SetFocus;
      exit;
    end;


  {��������� ������}
  Form1.Memo1.Text:=''; //������� ���� ������ ���������
  Form1.Memo3.Text:=''; //�������� ���� ������ ��� ����
  Form1.Label5.Caption:=''; //������� ���� ������ ������
  ss:=''; //�������� ������ ��� �������������� ��������
  s:='';  //�������� ������ ��� �����
  n:=0;   //��������� ���������� ����� ��� ����

  st:=Form1.Memo2.Text; //��������� ���������� ���������� ���� memo

  fZnak:=false; //�������� ����� ����������(+,-,/,*)
  fDrob:=true;  //�������� ����� �������


  {����� �������������� ��������}
  for i:=1 to length(st)+1 do
    begin

      case st[i] of

        '0'..'9': begin
                    ss:=ss+st[i];
                    ad;
                  end;

        '+','-','*','/': if (length(ss)<>0) then
                            if ss[length(ss)] in ['0'..'9'] then
                              begin
                                ss:=ss+st[i];
                                fZnak:=true;
                                fDrob:=true;
                              end
                            else
                              begin
                                ss:='';
                                ad;
                                fZnak:=false;
                                fDrob:=true;
                              end;

        ',': if (length(ss)<>0) then
                if (ss[length(ss)] in ['0'..'9'])
                  and
                  (fDrob=true) then
                    begin
                      ss:=ss+st[i];
                      fDrob:=false;
                    end
                    else
                      begin
                        fDrob:=true;
                        fZnak:=false;
                        ss:='';
                        ad;
                      end;

      else
        begin

          {����� ���������}
          if length(ss)<>0 then
            if (ss[length(ss)] in ['0'..'9'])
               and (fZnak=true) then
                  calculation;

          ss:=''; //��������� ������
          fDrob:=true;
          fZnak:=false;

          if ((st[i]) in ['�'..'�'])
             or
             ((st[i]) in ['A'..'Z'])
             or
             ((st[i]) in ['a'..'z']) then
            s:=s+st[i]
          else
            ad;

        end;  //�������� else

      end;  //�������� case

    end;  //�������� ����� for

    if Form1.Memo1.Text='' then
      Form1.Memo1.Text:='(��� ���������)';

    if Form1.Memo3.Text='' then
      Form1.Memo3.Text:='(��� ����)';

end;

end.
