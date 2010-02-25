
unit SQLite3;

{
  Simplified interface for SQLite.
  Updated for Sqlite 3 by Tim Anderson (tim@itwriting.com)
  Update for use with Dbx4Pg by Thiago Borges de Oliveira (thborges at gmail.com)
  Note: NOT COMPLETE for version 3, just minimal functionality
  Adapted from file created by Pablo Pissanetzky (pablo@myhtpc.net)
  which was based on SQLite.pas by Ben Hochstrasser (bhoc@surfeu.ch)
}

interface

const

  //SQLiteDLL = 'sqlite3.dll';

// Return values for sqlite3_exec() and sqlite3_step()

  __turboFloat: integer = 0;

  SQLITE_OK = 0; // Successful result
  SQLITE_ERROR = 1; // SQL error or missing database
  SQLITE_INTERNAL = 2; // An internal logic error in SQLite
  SQLITE_PERM = 3; // Access permission denied
  SQLITE_ABORT = 4; // Callback routine requested an abort
  SQLITE_BUSY = 5; // The database file is locked
  SQLITE_LOCKED = 6; // A table in the database is locked
  SQLITE_NOMEM = 7; // A malloc() failed
  SQLITE_READONLY = 8; // Attempt to write a readonly database
  SQLITE_INTERRUPT = 9; // Operation terminated by sqlite3_interrupt()
  SQLITE_IOERR = 10; // Some kind of disk I/O error occurred
  SQLITE_CORRUPT = 11; // The database disk image is malformed
  SQLITE_NOTFOUND = 12; // (Internal Only) Table or record not found
  SQLITE_FULL = 13; // Insertion failed because database is full
  SQLITE_CANTOPEN = 14; // Unable to open the database file
  SQLITE_PROTOCOL = 15; // Database lock protocol error
  SQLITE_EMPTY = 16; // Database is empty
  SQLITE_SCHEMA = 17; // The database schema changed
  SQLITE_TOOBIG = 18; // Too much data for one row of a table
  SQLITE_CONSTRAINT = 19; // Abort due to contraint violation
  SQLITE_MISMATCH = 20; // Data type mismatch
  SQLITE_MISUSE = 21; // Library used incorrectly
  SQLITE_NOLFS = 22; // Uses OS features not supported on host
  SQLITE_AUTH = 23; // Authorization denied
  SQLITE_FORMAT = 24; // Auxiliary database format error
  SQLITE_RANGE = 25; // 2nd parameter to sqlite3_bind out of range
  SQLITE_NOTADB = 26; // File opened that is not a database file
  SQLITE_ROW = 100; // sqlite3_step() has another row ready
  SQLITE_DONE = 101; // sqlite3_step() has finished executing

  SQLITE_INTEGER = 1;
  SQLITE_FLOAT = 2;
  SQLITE_TEXT = 3;
  SQLITE_BLOB = 4;
  SQLITE_NULL = 5;

  SQLITE_UTF8     = 1;
  SQLITE_UTF16    = 2;
  SQLITE_UTF16BE  = 3;
  SQLITE_UTF16LE  = 4;
  SQLITE_ANY      = 5;

  SQLITE_TRANSIENT = pointer(-1);
  SQLITE_STATIC = pointer(0);

type
  TSQLiteDB = Pointer;
  TSQLiteResult = ^PAnsiChar;
  TSQLiteStmt = Pointer;

  //function prototype for define own collate
  TCollateXCompare = function(Userdta: pointer; Buf1Len: integer; Buf1: pointer;
    Buf2Len: integer; Buf2: pointer): integer; cdecl;

function _SQLite3_Open(dbname: PAnsiChar; var db: TSqliteDB): integer; cdecl; external;
function _SQLite3_Close(db: TSQLiteDB): integer; cdecl; external;
function _SQLite3_Exec(db: TSQLiteDB; SQLStatement: PAnsiChar; CallbackPtr: Pointer; Sender: TObject; var ErrMsg: PAnsiChar): integer; cdecl; external;
function _SQLite3_Version(): PAnsiChar; cdecl; external;
function _SQLite3_ErrMsg(db: TSQLiteDB): PAnsiChar; cdecl; external;
function _SQLite3_ErrCode(db: TSQLiteDB): integer; cdecl; external;
procedure _SQlite3_Free(P: PAnsiChar); cdecl; external;
function _SQLite3_Get_Table(db: TSQLiteDB; SQLStatement: PAnsiChar; var ResultPtr: TSQLiteResult; var RowCount: Cardinal; var ColCount: Cardinal; var ErrMsg: PAnsiChar): integer; cdecl; external;
procedure _SQLite3_Free_Table(Table: TSQLiteResult); cdecl; external;
function _SQLite3_Complete(P: PAnsiChar): boolean; cdecl; external;
function _SQLite3_Last_Insert_RowID(db: TSQLiteDB): Int64; cdecl; external;
procedure _SQLite3_Interrupt(db: TSQLiteDB); cdecl; external;
procedure _SQLite3_Busy_Handler(db: TSQLiteDB; CallbackPtr: Pointer; Sender: TObject); cdecl; external;
procedure _SQLite3_Busy_Timeout(db: TSQLiteDB; TimeOut: integer); cdecl; external;
function _SQLite3_Changes(db: TSQLiteDB): integer; cdecl; external;
function _SQLite3_Total_Changes(db: TSQLiteDB): integer; cdecl; external;
function _SQLite3_Prepare(db: TSQLiteDB; SQLStatement: PAnsiChar; nBytes: integer; var hStmt: TSqliteStmt; var pzTail: PAnsiChar): integer; cdecl; external;
function _SQLite3_Prepare_v2(db: TSQLiteDB; SQLStatement: PAnsiChar; nBytes: integer; var hStmt: TSqliteStmt; var pzTail: PAnsiChar): integer; cdecl; external;
function _SQLite3_Column_Count(hStmt: TSqliteStmt): integer; cdecl; external;
function _Sqlite3_Column_Name(hStmt: TSqliteStmt; ColNum: integer): PAnsiChar; cdecl; external;
function _Sqlite3_Column_DeclType(hStmt: TSqliteStmt; ColNum: integer): PAnsiChar; cdecl; external;
function _Sqlite3_Step(hStmt: TSqliteStmt): integer; cdecl; external;
function _SQLite3_Data_Count(hStmt: TSqliteStmt): integer; cdecl; external;

//function _Sqlite3_Column_TableName(hStmt: TSqliteStmt; ColNum: integer): PAnsiChar; cdecl; external;

function _Sqlite3_Column_Blob(hStmt: TSqliteStmt; ColNum: integer): pointer; cdecl; external;
function _Sqlite3_Column_Bytes(hStmt: TSqliteStmt; ColNum: integer): integer; cdecl; external;
function _Sqlite3_Column_Double(hStmt: TSqliteStmt; ColNum: integer): double; cdecl; external;
function _Sqlite3_Column_Int(hStmt: TSqliteStmt; ColNum: integer): integer; cdecl; external;
function _Sqlite3_Column_Text(hStmt: TSqliteStmt; ColNum: integer): PAnsiChar; cdecl; external;
function _Sqlite3_Column_Type(hStmt: TSqliteStmt; ColNum: integer): integer; cdecl; external;
function _Sqlite3_Column_Int64(hStmt: TSqliteStmt; ColNum: integer): Int64; cdecl; external;
function _SQLite3_Finalize(hStmt: TSqliteStmt): integer; cdecl; external;
function _SQLite3_Reset(hStmt: TSqliteStmt): integer; cdecl; external;
function _SQLite3_Clear_Bindings(hStmt: TSqliteStmt): integer; cdecl; external;

//
// In the SQL strings input to sqlite3_prepare() and sqlite3_prepare16(),
// one or more literals can be replace by a wildcard "?" or ":N:" where
// N is an integer.  These value of these wildcard literals can be set
// using the routines listed below.
//
// In every case, the first parameter is a pointer to the sqlite3_stmt
// structure returned from sqlite3_prepare().  The second parameter is the
// index of the wildcard.  The first "?" has an index of 1.  ":N:" wildcards
// use the index N.
//
 // The fifth parameter to sqlite3_bind_blob(), sqlite3_bind_text(), and
 //sqlite3_bind_text16() is a destructor used to dispose of the BLOB or
//text after SQLite has finished with it.  If the fifth argument is the
// special value SQLITE_STATIC, then the library assumes that the information
// is in static, unmanaged space and does not need to be freed.  If the
// fifth argument has the value SQLITE_TRANSIENT, then SQLite makes its
// own private copy of the data.
//
// The sqlite3_bind_* routine must be called before sqlite3_step() after
// an sqlite3_prepare() or sqlite3_reset().  Unbound wildcards are interpreted
// as NULL.
//

function _SQLite3_Bind_Blob(hStmt: TSqliteStmt; ParamNum: integer;
  ptrData: pointer; numBytes: integer; ptrDestructor: pointer): integer;
  cdecl; external;
function _SQLite3_Bind_Double(hStmt: TSqliteStmt; ParamNum: integer; Data: Double): integer;
  cdecl; external;
function _SQLite3_Bind_Int(hStmt: TSqLiteStmt; ParamNum: integer; intData: integer): integer;
  cdecl; external;
function _SQLite3_Bind_int64(hStmt: TSqliteStmt; ParamNum: integer; Data: int64): integer;
  cdecl; external;
function _SQLite3_Bind_null(hStmt: TSqliteStmt; ParamNum: integer): integer;
  cdecl; external;
function _SQLite3_Bind_text(hStmt: TSqliteStmt; ParamNum: integer;
  Data: PAnsiChar; numBytes: integer; ptrDestructor: pointer): integer;
  cdecl; external;

function _SQLite3_Bind_Parameter_Index(hStmt: TSqliteStmt; zName: PAnsiChar): integer;
  cdecl; external;

function _sqlite3_enable_shared_cache(value: integer): integer; cdecl; external;

//user collate definiton
function _sqlite3_create_collation(db: TSQLiteDB; Name: PAnsiChar; eTextRep: integer;
  UserData: pointer; xCompare: TCollateXCompare): integer; cdecl; external;


function SQLiteFieldType(SQLiteFieldTypeCode: Integer): String;
function SQLiteErrorStr(SQLiteErrorCode: Integer): String;


function _atol(const s:PAnsiChar):integer; cdecl;external 'msvcrt.dll' name 'atol';
function __ftol(f:double):integer; cdecl;external 'msvcrt.dll' name '_ftol';
function __ftoul(f:double):longword; cdecl; external 'msvcrt.dll' name '_ftol';
function _malloc(s:longword):pointer; cdecl;external 'msvcrt.dll' name 'malloc';
procedure _free(p:pointer); cdecl;external 'msvcrt.dll' name 'free';
function _realloc(p:pointer;s:longword):pointer; cdecl;external 'msvcrt.dll' name 'realloc';
function _localtime(const __timer:pointer):pointer; cdecl;external 'msvcrt.dll' name 'localtime';

implementation

uses
  Windows, SysUtils;

{$LINK sqlite3.obj}
{$LINK _ll.obj}
{$LINK strncmp.obj}
{$LINK memset.obj}
{$LINK memcpy.obj}
{$LINK memmove.obj}
{$LINK memcmp.obj}

function SQLiteFieldType(SQLiteFieldTypeCode: Integer): String;
begin
  case SQLiteFieldTypeCode of
    SQLITE_INTEGER: Result := 'Integer';
    SQLITE_FLOAT: Result := 'Float';
    SQLITE_TEXT: Result := 'Text';
    SQLITE_BLOB: Result := 'Blob';
    SQLITE_NULL: Result := 'Null';
  else
    Result := 'Unknown SQLite Field Type Code "' + IntToStr(SQLiteFieldTypeCode) + '"';
  end;
end;

function SQLiteErrorStr(SQLiteErrorCode: Integer): String;
begin
  case SQLiteErrorCode of
    SQLITE_OK: Result := 'Successful result';
    SQLITE_ERROR: Result := 'SQL error or missing database';
    SQLITE_INTERNAL: Result := 'An internal logic error in SQLite';
    SQLITE_PERM: Result := 'Access permission denied';
    SQLITE_ABORT: Result := 'Callback routine requested an abort';
    SQLITE_BUSY: Result := 'The database file is locked';
    SQLITE_LOCKED: Result := 'A table in the database is locked';
    SQLITE_NOMEM: Result := 'A malloc() failed';
    SQLITE_READONLY: Result := 'Attempt to write a readonly database';
    SQLITE_INTERRUPT: Result := 'Operation terminated by sqlite3_interrupt()';
    SQLITE_IOERR: Result := 'Some kind of disk I/O error occurred';
    SQLITE_CORRUPT: Result := 'The database disk image is malformed';
    SQLITE_NOTFOUND: Result := '(Internal Only) Table or record not found';
    SQLITE_FULL: Result := 'Insertion failed because database is full';
    SQLITE_CANTOPEN: Result := 'Unable to open the database file';
    SQLITE_PROTOCOL: Result := 'Database lock protocol error';
    SQLITE_EMPTY: Result := 'Database is empty';
    SQLITE_SCHEMA: Result := 'The database schema changed';
    SQLITE_TOOBIG: Result := 'Too much data for one row of a table';
    SQLITE_CONSTRAINT: Result := 'Abort due to contraint violation';
    SQLITE_MISMATCH: Result := 'Data type mismatch';
    SQLITE_MISUSE: Result := 'Library used incorrectly';
    SQLITE_NOLFS: Result := 'Uses OS features not supported on host';
    SQLITE_AUTH: Result := 'Authorization denied';
    SQLITE_FORMAT: Result := 'Auxiliary database format error';
    SQLITE_RANGE: Result := '2nd parameter to sqlite3_bind out of range';
    SQLITE_NOTADB: Result := 'File opened that is not a database file';
    SQLITE_ROW: Result := 'sqlite3_step() has another row ready';
    SQLITE_DONE: Result := 'sqlite3_step() has finished executing';
  else
    Result := 'Unknown SQLite Error Code "' + IntToStr(SQLiteErrorCode) + '"';
  end;
end;

function ColValueToStr(Value: PAnsiChar): String;
begin
  if (Value = nil) then
    Result := 'NULL'
  else
    Result := String(PAnsiChar(Value));
end;


end.

