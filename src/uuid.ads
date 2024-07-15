package Uuid is

   type Byte is mod 2**8;
   type UUIDv7_Bin is array (1 .. 16) of Byte;
   subtype UUIDv7_Str is String (1 .. 36);

   type UUIDv7 is record
      Binary : UUIDv7_Bin;
      String : UUIDv7_Str;
   end record;

   function Generate_UUIDv7 (Binary : Boolean := True) return UUIDv7;

private
   function To_Hex (Value : Integer) return Character;
   function Random_Hex return Character;
end Uuid;
