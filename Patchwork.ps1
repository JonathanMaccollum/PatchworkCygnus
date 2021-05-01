Function New-PatchworkSource
{
    param(
        [String]$Author,
        [String]$Source,
        [String]$Target
    )
    new-object psobject -Property @{
        Author=$Author
        Source=$Source
        Target=$Target
    }
}
import-module "$PSScriptRoot\Bin\DeepZoomTools.DLL"

$sources = @(
    #New-PatchworkSource -Target "50mm.HaFull.2" -Author eigenVector -Source "E:\Astrophotography\50mm\Patchwork Cygnus\Processing\MergeMosaic.Linear.FullRes2.DBE.MS.LHE.PIP.png"
    #New-PatchworkSource -Target "50mm.Oiii2x" -Author eigenVector -Source "E:\Astrophotography\50mm\Patchwork Cygnus\Processing\MergeMosaic.Oiii.2x.Curves.png"
    #New-PatchworkSource -Target "50mm.OSC" -Author eigenVector -Source "E:\Astrophotography\50mm\PatchworkCygnus50OSC\MergeMosaic.2x.DBE.HT.png"
    #New-PatchworkSource -Target "135mm.HaFull" -Author eigenVector -Source "E:\Astrophotography\135mm\PatchworkCygnus135\Processing\MergeMosaic.2x2.Ha.Processed.png"
    #New-PatchworkSource -Target "Annotated" -Author PixInsight -Source "E:\Astrophotography\50mm\Patchwork Cygnus\CatalogStarsAnnotatedTransparent.png"
    #New-PatchworkSource -Target "Annotated" -Author PixInsight -Source "E:\Astrophotography\50mm\Patchwork Cygnus\CatalogStarsBin4xAnnotatedTransparent.png"

    #New-PatchworkSource -Target "Sadr.1000mm" -Author "eigenVector" -Source "E:\Astrophotography\1000mm\Sadr\Processing\Sadr.B.13x60s.G.14x60s.R.13x60s.B.9x120s.G.8x120s.R.8x120s.Ha.6x300s.Ha.40x600s.Draft2.png"
    #New-PatchworkSource -Target "DWB111.135mm" -Author "eigenVector" -Source "E:\Astrophotography\135mm\DWB111\DWB111.BHS_OIII.34x300s.BHS_Sii.55x300s.Ha.2x300s.Ha.36x600s.Oiii.37x600s.Draft6.HOO.SHOStars.png"
    #New-PatchworkSource -Target "Crescent.1000mm" -Author "eigenVector" -Source "D:\Backups\Camera\2019\Crescent Nebula\CrescentNebula.224x120s.drizzle.registered.dbe.bn.cc.pcc.rgbws.Reprocess2020.png"
    #New-PatchworkSource -Target "EyeOfSmaug.1000mm" -Author "eigenVector" -Source "E:\Astrophotography\1000mm\Eye of Smaug in Cygnus\Processing\Eye of Smaug in Cygnus.L3.365x120s.RGB.Crop.DBE.Blend135mmHaIntoR.Blend135mmOiiiIntoB.Draft2.png"
    #New-PatchworkSource -Target "EyeOfSmaug.1000mm.2PanelOSC" -Author "eigenVector" -Source "E:\Astrophotography\1000mm\Eye of Smaug in Cygnus\Mosaic\MergeMosaic.MTStars.DeconStars.Curves.NR.LHE.Curves.MTDeconStars.Curves.DBE.BrightenAndDeconLargerStarCores.png"
    #New-PatchworkSource -Target "DWB111.1000mm" -Author "eigenVector" -Source "E:\Astrophotography\1000mm\DWB111\Processing\DWB111.SynLum.Ha.45x300s.Ha.23x600s.B.37x120s.G.37x120s.R.35x120s.Oiii.9x300s.Sii.7x300s.Oiii.29x600s.SHO.ToneMap.RGBStars.Draft5.png"
    #New-PatchworkSource -Target "" -Author "" -Source ""

    #New-PatchworkSource -Target "RingNebula.1000mm" -Author "eigenVector" -Source "E:\Astrophotography\1000mm\Ring Nebula\Ring Nebula.Ha.5x240s.Ha.9x300s.Ha.2x600s.QuickEdit.png"
    #New-PatchworkSource -Target "M33" -Author "HubbleSpaceTelescope" -Source "E:\Astrophotography\Hubble\M33\STSCI-H-p1901a-f-32073x41147.png"
    #New-PatchworkSource -Target "M33" -Author "eigenVector" -Source "E:\Astrophotography\50mm\Patchwork Cygnus\DZI\eigenVector.M33_files\M33.32x300s.multinight.ln.int.crop.abe.bn.cc.pcc.tgvnr.mmtnr.abe.arcsin.ht.sat.mtstars.combinel.decon.ReAddStarCores.ReAddBg.mmtSharpen.tgvnr.ms.acdnr.astdclrcal.dbe.dss.pip.satgalaxy.um.jpg"
    #New-PatchworkSource -Target "sh2-108" -Author "eigenVector" -Source "E:\Astrophotography\1000mm\Sh 2-108\Processing\Sh 2-108.L3.118x120s.Int2.Drizzled2x.DBE.BN.Solved.PCC.Add135mmHaToR.Rem135mmHaFromGB.TGV.MS.CombineL.DeconStars.Curves.MTStarContours.LHE.HDRStars.Curves.USM.png"
    #New-PatchworkSource -Target "sh2-90" -Author "eigenVector" -Source "E:\Astrophotography\1000mm\Sh2-90\Sh2-90.L3.59x120s.QuickEdit.png"
    New-PatchworkSource -Target "EyeOfSmaug.1000mm.2PanelHa" -Author "eigenVector" -Source "E:\Astrophotography\1000mm\Eye of Smaug in Cygnus\Processing\Eye of Smaug in Cygnus.Ha.21x360s.15x360s.TwoPanel.png"
)
foreach($i in $sources)
{
    $imageList = new-object System.Collections.Generic.List[Microsoft.DeepZoomTools.Image]
    $imageList.Add(
        (new-object Microsoft.DeepZoomTools.Image ($i.Source)))

    
    try
    {
        $sparse = [Microsoft.DeepZoomTools.SparseImageCreator]::new()
        $sparse.MaxLevel=20
        #$sparse.ConversionTileFormat = [Microsoft.DeepZoomTools.ImageFormat]::Png
        $sparse.TileFormat = [Microsoft.DeepZoomTools.ImageFormat]::Png
        $sparse.Create($imageList,"$PSScriptRoot\$($i.Author).$($i.Target).xml")
    }
    catch
    {
        write-warning $_.Exception.ToString()
        throw
    }
}