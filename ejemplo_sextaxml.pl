#!/usr/bin/perl

use warnings;
use strict;
use utf8;
use encoding 'utf8';
use open 'locale';
use Encode;
use DownVideos::DataSexta;
use DownVideos::SextaXML;

my $sexta = DataSexta->new();

my $noticias = $sexta->get_noticias;

print "Programas de noticias:\n\n";
for my $p (@$noticias)
  {
  for my $k (keys $p)
    {
    print "\t$k\n";
    }
  }

my $capitulos = $sexta->get_capitulos("Tiempo");

my $xml = SextaXML->new(URL => $$capitulos[0]->{URL});

print "\n\n\nObteniendo datos del primer capítulo de Tiempo:\n\n";
print "\tNombre:\t\t" . $xml->nombre . "\n";
print "\tSección:\t" . $xml->seccion . "\n";
print "\tDescripción:\t" . $xml->descripcion . "\n";
print "\tImagen:\t\t" . $xml->imagen . "\n";
print "\tVideo:\t\t" . $xml->video . "\n";
print "\tTamaño:\t\t" . $xml->tamanyo . " Megas\n\n\n";

