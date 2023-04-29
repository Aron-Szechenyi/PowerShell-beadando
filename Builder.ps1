class Builder {
    [array]$Coords 
    [array]$Indexes
    [array]$Content

    Builder([array]$coords,[array]$indexes){
        $this.Indexes = $indexes
        $this.Coords = $coords
    }

    [Builder]Build(){
        $this.BuildHeader()
        $this.BuildBody()
        $this.BuildEndSection()
        
        return $this
    }

    [void]BuildHeader(){
        $this.Content += "0"
        $this.Content += "SECTION"
        $this.Content += "2"
        $this.Content += "ENTITIES"
    }

    [void]BuildBody(){
        $this.Content += "0"

        foreach($index in $this.Indexes){
            $tmp = $index.Split(" ")
            $firstLine = $this.Coords[$tmp[0]].Split(" ")
            $secoundLine = $this.Coords[$tmp[1]].Split(" ")
            $thirdLine = $this.Coords[$tmp[2]].Split(" ")

            $this.Content += "3DFACE"

            $this.Content +=  "10"
            $this.Content += $firstLine[0]
            $this.Content += "20"
            $this.Content += $firstLine[1]
            $this.Content += "30"
            $this.Content += $firstLine[2]
    
            $this.Content += "11"
            $this.Content += $firstLine[0]
            $this.Content += "21"
            $this.Content += $firstLine[1]
            $this.Content += "31"
            $this.Content += $firstLine[2]
    
            $this.Content += "12"
            $this.Content += $secoundLine[0]
            $this.Content += "22"
            $this.Content += $secoundLine[1]
            $this.Content += "32"
            $this.Content += $secoundLine[2]
        
            $this.Content += "13"
            $this.Content += $thirdLine[0]
            $this.Content += "23"
            $this.Content += $thirdLine[1]
            $this.Content += "33"
            $this.Content += $thirdLine[2]

            $this.Content += "0"
        }


        
        $this.Content += "0"
        $this.Content += "ENDSEC"
    }

    [void]BuildEndSection(){
        $this.Content += "0"
        $this.Content += "EOF"
    }


    [Builder]Write([string] $fileName){
        New-Item $fileName
        Clear-Content $fileName
        foreach($line in $this.Content){
            Add-Content $fileName $line
        }
        return $this
    }


}