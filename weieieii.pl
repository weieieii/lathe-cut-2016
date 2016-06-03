#!/usr/bin/perl -w

# 
# Weieieii - Self-Titled (lathe cut 7", Amicables, 2016)
# tracklist:
# A1. SSW
# A2. Snow Wave
# A3. Array
# B1. Homestead
# B2. Travel
#
# 45 RPM
#
# https://amicables.net 
# 002197@gmail.com 

use Crypt::ECB;
if (@ARGV != 2) {
	print STDERR "Usage: $0 [file with encrypted string (path/to/file) or just encrypted string] [key]\n";
	exit 1;
}
my $filename = $ARGV[0];
my $key = $ARGV[1];
my $data;

if ($key !~ /^[a-zA-Z]+$/){
	print "Wrong key. Check ur key. U can find it in release inserts. If ur key is missing...I can't help u, sorry. Contact amicables\n";
	exit 1;
}

if (-e $filename){
	open(my $fh, '<', $filename) or die "All is ok? File '$filename' looks strange, buddy."; {
		while (my $line = <$fh>) {
			chomp $line;
			$data .= $line;
		}
	}
	close($fh);
} else {
	$data = $filename;
}

if ($data !~ /^[\w.]+$/){
	print "Wrong encrypted string, I'm sorry. But thanks for trying! Check ur string and try again.\n";
	exit 1;
}

$crypt = Crypt::ECB->new;
$crypt->padding(PADDING_AUTO);
$crypt->cipher('Blowfish') || die $crypt->errstring;
$crypt->key($key); 
$result = $crypt->decrypt(pack('H*',$data));

# it's simple script, I deliberately do not catch exceptions or smtng. i don't want use many libraries

print "\n" . $result;
print "\n\n" . "if u see some strange shit check ur encrypted string and key" . "\n";

# have a nice day!
