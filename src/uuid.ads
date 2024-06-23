with Ada.Numerics.Float_Random;
with Ada.Calendar.Conversions;
with Interfaces.C;

package Uuid is
    subtype UUIDv7 is String (1 .. 36);
    function Generate_UUIDv7 return UUIDv7;
private
    function To_Hex (Value : Integer) return Character;
    function Random_Hex return Character;
end Uuid;
