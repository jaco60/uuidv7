package Uuid is
  subtype UUIDv7 is String (1 .. 36) with
    Dynamic_Predicate => (for all C of UUIDv7 => C in '0' .. '9' | 'a' .. 'f');

  function Generate_UUIDv7 return UUIDv7;
private
  function To_Hex (Value : Integer) return Character;
  function Random_Hex return Character;
end Uuid;
