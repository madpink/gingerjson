function gingerJson pJson
   local tLevel = 0
   local tMaxLevel = 0
   local tComma = false
   put true into tEscape
   put false into tColon
   put false into tJArray
   put empty into tPretty
   repeat for each char tChar in pJson
      switch tChar
         case "{"
            if tEscape is false then
               if (tComma is true and tColon is false) or \
                     (tJArray is true and tColon is false)  then
                  put tabCount(tLevel) after tPretty
                  put false into tComma
               end if
               put "{" & cr after tPretty
               add 1 to tLevel
               put tabCount(tLevel) after tPretty
            else
               put "{" after tPretty
               put false into tEscape
            end if
            break
         case "}"
            if tEscape is false then
               subtract 1 from tLevel
               put cr & tabCount(tLevel) & "}" after tPretty
            else
               put "}" after tPretty
               put false into tEscape
            end if
            break
         case "["
            if tEscape is false then
               if tComma is true and tColon is false then
                  put tabCount(tLevel) after tPretty
                  put false into tComma
               end if
               put "[" & cr after tPretty
               add 1 to tLevel
               put true into tJArray
               put tabCount(tLevel) after tPretty
            else
               put "[" after tPretty
               put false into tEscape
            end if
            break
         case "]"
            if tEscape is false then
               subtract 1 from tLevel
               put cr & tabCount(tLevel) & "]" after tPretty
            else
               put "]" after tPretty
               put false into tEscape
            end if
            break
         case colon
            if tEscape is false then put true into tColon
            put colon after tPretty
            break
         case slash
            if tEscape is true then put false into tEscape else put true into tEscape
            put slash after tPretty
            break
         case comma
            if tEscape is false then
               put comma & cr & tabCount(tLevel) after tPretty
               put true into tComma
            else
               put comma after tPretty
               put false into tEscape
            end if
            break
         default
            put tChar after tPretty
            put false into tColon
      end switch
      if tLevel > tMaxLevel then put tLevel into tMaxLevel
   end repeat

   repeat with x=1 to tMaxLevel
      replace cr&tabCount(x)&cr with cr in tPretty
   end repeat
   return tPretty
end gingerJson

function tabCount pCount
   local tReturn
   repeat with x = 1 to pCount
      put tab after tReturn
   end repeat
   return tReturn
end tabCount

function snapJson pJson
   replace tab with empty in pJson
   replace cr with empty in pJson
   return pJson
 end snapJson
