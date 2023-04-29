class Parser {
    [string]$FileName
    [array]$Coords
    [array]$Indexes
    [bool]$Error
    [string]$ErrorMsg = ""

    Parser([string]$fileName){
        $this.FileName = "./"+$fileName
    }

    [void]Parse(){
        $this.CheckFileIntegrity()
        
        if(!$this.GetError()){
            $regex_index = "<IndexedFaceSet "
            $regex_coords = "<Coordinate "

            foreach($line in Get-Content $this.FileName){

                if($line -match $regex_index){
                    $this.Indexes = $this.ParseByThree($this.SplitByDifferentQuotes($line).Split(" "))
                }

                if($line -match $regex_coords){
                    $this.Coords = $this.ParseByThree($this.SplitByDifferentQuotes($line).Split(" "))
                }
            }
        }
    }

    [string]SplitByDifferentQuotes([string]$line){
        if($line -like "*'*"){
            return $line.Split("'")[1].Split("'")[0]
        }else{
            return $line.Split('"')[1].Split('"')[0]
        }
    }

    [void]CheckFileIntegrity(){
        try {
            [XML]$xml = Get-Content $this.FileName
            $xml.GetElementsByTagName("IndexedFaceSet") # this line needed for the intepreter to cause an error if the [XML] file is not valid
            $this.Error = $false
        }
        catch {
            $this.ErrorMsg = "The XML file is not valid!"
            $this.Error = $true
        }
    }

    [array] ParseByThree([array] $coords){
        $tmp = @()
        for ($i = 0; $i -lt $coords.Count; $i+=3) {
            $tmp += [string]$coords[$i] + " " + [string]$coords[$i+1] + " "+[string]$coords[$i+2]  
        }
        return $tmp
    }


    [array] GetCoords(){
        return $this.Coords
    }

    [array] GetIndexes(){
        return $this.Indexes
    }
    
    [bool] GetError(){
        return $this.Error;
    }

    [string] GetErrorMsg(){
        return $this.ErrorMsg;
    }
}