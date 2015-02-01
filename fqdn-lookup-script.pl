#!/usr/bin/perl

#
#
# BIND DNS Lookup Script
# Script does a Lookup of Included FQDN's with an EXCLUDE File
# There are 2 External Filenames, include.txt and exclude.txt
# It should be obvious... 1 FQDN per line .. 1 IP Per Exclude per Line
# 
# License = Your Mileage May Vary
# Provided by XSS.Cx
# April 5, 2012
#

# Setup the Includes

use Net::DNS;
use Net::Netmask;
$|=1;

# sub : gather A records by hostname

sub fdns( $ ) {
  $dns = Net::DNS::Resolver->new;
  my $name = shift;
  my @addys;

  $q = $dns->search($name);

  if ($q) { 
    foreach my $r ($q->answer) {
      next unless $r->type eq "A";
      push(@addys, $r->address);
    }
    return @addys;
  } else {
    warn $name, "\:\:FAIL ", $dns->errorstring, "\n";
  }
}

# sub : parse & translate excluded ips

sub excludes ( $ ) {
  my $file = shift;

  open(F, $file);
  while (<F>) {
    ($a,$b,$c,$d) = split(/\./);
    if ($d =~ m/\//) { 
      $block = new Net::Netmask($_);
      for $i ($block->enumerate()) { 
        $excludes{$i} = 1;
      }
    } else {
      $excludes{$_} = 1;
    }
  }
  close (F);
  return %excludes;
}

# sub : inhale names for resolution

sub inhale ( $ ) {
  my $file = shift;

  open (F, $file);
  while (<F>) { 
    chomp;
    push(@data,$_);
  }
  close (F);
  return @data;
}

###
# main
###

# load excludes
%excluded = excludes("exclude.txt");
print "loaded ".scalar(keys %excluded)." excluded ips\n";

# load names include
@names = inhale("include.txt");
print "loaded ".scalar(@names)." names to resolve\n";

# resolve names + output to stdout
foreach $name (@names) {
  @ips = fdns($name);
  foreach $ip (@ips) { 
    print $name .":". $ip;
    if ($excluded{$ip}) { print ":XX"; }
    else { print ":OK"; }
    print "\n";
  }
}

#foreach (keys %excluded) { print; print "\n"; }
