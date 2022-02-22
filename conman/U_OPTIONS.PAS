unit u_options;

interface
uses Registry,classes, SysUtils;

type

    TWinPos=record
     X,Y,W,H:integer;
     maxed:integer;
    end;

const
 RegKey='\Software\Code Alliance\ConMan';

var
 Recents:TStringList;
 WinPos:TWinPos=(X:-1;Y:-1;W:-1;H:-1;Maxed:0);
 sizeBarPos:integer=-1;

implementation

var reg:TRegistry;

Function RegReadInt(const name:string;var i:integer):boolean;
begin
 result:=true;
 try
  i:=reg.ReadInteger(name);
 except
  on Exception do result:=false;
 end;
end;

Initialization
begin
 Recents:=TStringList.Create;
 reg:=TRegistry.Create;
 if reg.OpenKey(RegKey,false) then
 begin
  Recents.Add(reg.ReadString('Recent1'));
  Recents.Add(reg.ReadString('Recent2'));
  Recents.Add(reg.ReadString('Recent3'));
  Recents.Add(reg.ReadString('Recent4'));

  RegReadInt('WinPos.X',WinPos.X);
  RegReadInt('WinPos.X',WinPos.X);
  RegReadInt('WinPos.Y',WinPos.Y);
  RegReadInt('WinPos.W',WinPos.W);
  RegReadInt('WinPos.H',WinPos.H);
  RegReadInt('WinPos.Maxed',WinPos.Maxed);

  RegReadInt('SizeBarPos',SizeBarPos);

 end;
 reg.free;
end;

finalization
begin
 reg:=TRegistry.Create;
 reg.OpenKey(RegKey,true);
 reg.WriteString('Recent1',Recents[0]);
 reg.WriteString('Recent2',Recents[1]);
 reg.WriteString('Recent3',Recents[2]);
 reg.WriteString('Recent4',Recents[3]);

 reg.WriteInteger('WinPos.X',WinPos.X);
 reg.WriteInteger('WinPos.Y',WinPos.Y);
 reg.WriteInteger('WinPos.W',WinPos.W);
 reg.WriteInteger('WinPos.H',WinPos.H);
 reg.WriteInteger('WinPos.Maxed',WinPos.Maxed);

 reg.WriteInteger('SizeBarPos',SizeBarPos);

 reg.free;
 Recents.Free;
end;

end.
