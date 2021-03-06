unit VersionInfo;

interface

uses
  Windows, SysUtils;

function GetVersion(sFileName:string): string;

implementation

function GetVersion(sFileName:string): string;
var 
  VerInfoSize: DWORD; 
  VerInfo: Pointer; 
  VerValueSize: DWORD;
  VerValue: PVSFixedFileInfo;
  Dummy: DWORD; 
begin 
  VerInfoSize := GetFileVersionInfoSize(PChar(sFileName), Dummy);
  GetMem(VerInfo, VerInfoSize);
  GetFileVersionInfo(PChar(sFileName), 0, VerInfoSize, VerInfo); 
  VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize); 
  with VerValue^ do 
  begin 
    Result := IntToStr(dwFileVersionMS shr 16); 
    Result := Result + '.' + IntToStr(dwFileVersionMS and $FFFF); 
    Result := Result + '.' + IntToStr(dwFileVersionLS shr 16); 
    Result := Result + '.' + IntToStr(dwFileVersionLS and $FFFF); 
  end; 
  FreeMem(VerInfo, VerInfoSize); 
end;

end.
