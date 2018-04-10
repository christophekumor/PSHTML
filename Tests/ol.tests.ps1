$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

Context "Testing PSHTML"{
    Describe "Testing ol" {
        

        $Class = "MyClass"
        $Id = "MyID"
        $Style = "Background:green"
        $CustomAtt = @{"MyAttribute1"='MyValue1';"MyAttribute2"="MyValue2"}
        $string = ol {"woop"} -Attributes $CustomAtt -Style $Style -Class $class -id $id
       
        if($string -is [array]){
            $string = $String -join "" 
        }

        it "Should contain opening and closing tags" {
            $string -match '^<ol.*>' | should be $true
            $string -match '.*</ol>$' | should be $true
            
        }

        it "Testing content in child element"{
            $string -match "^.*>woop<.*" | should be $true
        }

        it "Testing common parameters: Class"{
            $string -match '^<ol.*class="myclass".*>' | should be $true
        }
        it "Testing common parameters: ID"{
            $string -match '^<ol.*id="myid".*>' | should be $true
        }
        it "Testing common parameters: Style"{
            $string -match '^<ol.*style=".+".*>' | should be $true
        }

        it "Testing Attributes parameters"{

            foreach($at in $CustomAtt.Keys){
                $val = $null
                $val = $CustomAtt[$at]
                $string -match "^<ol.*$at=`"$val`".*>" | should be $true
            }

            
        }

        
    }
    
}

Pop-Location