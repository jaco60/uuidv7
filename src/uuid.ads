package Uuid is
   --subtype UUIDv7 is String (1 .. 16);
   subtype UUIDv7_Str is String (1 .. 36);

   --function Generate_UUIDv7 return UUIDv7;
   function Generate_UUIDv7_Str return UUIDv7_Str;
private
   function To_Hex (Value : Integer) return Character;
   function Random_Hex return Character;
end Uuid;
