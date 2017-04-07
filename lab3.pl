
#!c:\strawberry\perl\bin\prel.exe

sub cleaveAndBind($$$$);

use strict;
use warnings;

my (@dna1, @dna2, $seq, $pos, $i, $ok);
$dna1[0][0] = "5p-sequence-PPPPPP-GAATTC-QQQQQQ-sequence-3p";
$dna1[1][0] = "3p-sequence-QQQQQQ-CTTAAG-PPPPPP-sequence-5p";

$dna2[0][0] = "5p-sequence-XXXXXX-GAATTC-YYYYYY-sequence-3p";
$dna2[1][0] = "3p-sequence-YYYYYY-CTTAAG-XXXXXX-sequence-5p";

$seq = "GAATTC";
$pos = 1;

$ok = cleaveAndBind(\@dna1, \@dna2, \$seq, \$pos);
print $dna1[0][0], "\n", $dna1[1][0], "\n", $dna2[0][0], "\n", $dna2[1][0], "\n" if($ok);

$seq = "GAACTT";
$ok = cleaveAndBind(\@dna1, \@dna2, \$seq, \$pos);
print $dna1[0][0], "\n", $dna1[1][0], "\n", $dna2[0][0], "\n", $dna2[1][0], "\n" if($ok);

exit;

sub cleaveAndBind($$$$) {
    my $d1 = shift(@_);
    my $d2 = shift(@_);
    my $s = shift(@_);
    my $p = shift(@_);
    my ($rc, $d100 , $d110, $d200 , $d210 );

    $d100 = index($d1->[0][0],$$s);
    $d110 = index($d1->[1][0],reverse($$s));
    $d200 = index($d2->[0][0],$$s);
    $d210 = index($d2->[1][0],reverse($$s));
    if (($d100>0)&&($d110>=0)&&($d200>=0)&&($d210>=0)){
    $rc= 0;
    my ( $d100h1, $d100h2, $d110h1, $d110h2, $d200h1 , $d200h2, $d210h1, $d210h2 );
    $d100h1 = substr($d1->[0][0],0,length($d1->[0][0])-index($d1->[0][0],$$s)-length($$s)+$$p);
    $d100h2 = substr($d1->[0][0],length($d1->[0][0])-index($d1->[0][0],$$s)-length($$s)+$$p,length($d1->[0][0]));
    $d110h1 = substr($d1->[1][0],0,length($d1->[1][0])-index($d1->[1][0],reverse($$s))-$$p); 
    $d110h2 = substr($d1->[1][0],length($d1->[1][0])-index($d1->[1][0],reverse($$s))-$$p,length($d1->[1][0]));
    
    $d200h1 = substr($d2->[0][0],0,length($d2->[0][0])-index($d2->[0][0],$$s)-length($$s)+$$p);
    $d200h2 = substr($d2->[0][0],length($d2->[0][0])-index($d2->[0][0],$$s)-length($$s)+$$p,length($d2->[0][0]));    
    $d210h1 = substr($d2->[1][0],0,length($d2->[1][0])-index($d2->[1][0],reverse($$s))-$$p);
    $d210h2 = substr($d2->[1][0],length($d2->[1][0])-index($d2->[1][0],reverse($$s))-$$p,length($d2->[1][0]));      

    $d1->[0][0] = $d100h1.$d200h2;
    $d1->[1][0] = $d110h1.$d210h2;
    $d2->[0][0] = $d200h1.$d100h2;
    $d2->[1][0] = $d210h1.$d110h2;
    }
    else {
    return $rc;
    }
}