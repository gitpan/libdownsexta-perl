package SextaXML;


use warnings;
use strict;
use utf8;
use encoding 'utf8';
use open 'locale';
use Encode;
use LWP::Simple;
use XML::Simple;
use Data::Dumper;

sub new {
    
    my $clase = shift;
    my $self = {@_};
    
    my $base = 'http://www.lasexta.com/';
    my $base_videos = $base . '/videos/';
    
    ###print $self->{URL},"\n";
    
    my @data = split(/\n/, get("$self->{URL}"));
    
    foreach my $l (@data)
      {
      chop $l;
# 	###print $l,"\n";
      if ($l =~ /.*player_capitulo.xml=/)
	{
	my (undef, $xml) = split(/=/, $l);
	$self->{urlXML} = $base . $xml;
	$self->{urlXML} =~ s/('|;)//g;
	last;
	}
      }
    
    ###print "Url del XML: [ $self->{urlXML} ]\n";
    
    $self->{XMLData} = get($self->{urlXML}) or die "No se ha podido obtener $self->{urlXML}" unless defined $self->{XMLData};

    $self->{XMLin} = XMLin("$self->{XMLData}");
    
#     ###print Dumper $self->{XMLin};
    
    my ($content_type, $document_length, undef, undef, undef) = head($self->{XMLin}->{url}->{urlHttpVideo} . $self->{XMLin}->{multimedias}->{multimedia}->{archivoMultimedia}->{archivo});
    my $tamanyo = ($document_length / 1024)/1024;

    $self->{SECCION} = $self->{XMLin}->{multimedias}->{multimedia}->{seccion};
    $self->{NOMBRE} = $self->{XMLin}->{multimedias}->{multimedia}->{nombre};
    $self->{INFO} = $self->{XMLin}->{multimedias}->{multimedia}->{info};
    $self->{DESCRIPCION} = $self->{XMLin}->{multimedias}->{multimedia}->{descripcion};
    $self->{IMAGEN} = $self->{XMLin}->{url}->{urlImg} . $self->{XMLin}->{multimedias}->{multimedia}->{archivoMultimediaMaxi}->{archivo};
    $self->{VIDEO} = $self->{XMLin}->{url}->{urlHttpVideo} . $self->{XMLin}->{multimedias}->{multimedia}->{archivoMultimedia}->{archivo};
    $self->{RTMP} = $self->{XMLin}->{url}->{urlVideoMp4} . $self->{XMLin}->{multimedias}->{multimedia}->{archivoMultimedia}->{archivo};
    $self->{MIMETYPE} = $content_type;
    $self->{TAMANYO} = sprintf("%.2f", $tamanyo);
    
    ###print "SECCION: " . $self->{SECCION} . "\n"; 
    ###print "NOMBRE: " . $self->{NOMBRE} . "\n"; 
    ###print "INFO: " . $self->{INFO} . "\n"; 
    ###print "DESCRIPCION: " . $self->{DESCRIPCION} . "\n"; 
    ###print "IMAGEN: " . $self->{IMAGEN} . "\n"; 
    ###print "VIDEO: " . $self->{VIDEO} . "\n"; 
    ###print "RTMP: " . $self->{RTMP} . "\n"; 
    ###print "MIMETYPE: " . $self->{MIMETYPE} . "\n"; 
    ###print "TAMAÑO: " . $self->{TAMANYO} . "\n"; 
    
    bless $self, $clase;
    
    return $self;
    
    }

sub nombre {
    my $self = shift;
    return $self->{NOMBRE}
    }
    
sub seccion {
    my $self = shift;
    return $self->{SECCION}
    }
    
sub info {
    my $self = shift;
    return $self->{INFO}
    }

sub descripcion {
    my $self = shift;
    return $self->{DESCRIPCION}
    }

sub imagen {
    my $self = shift;
    return $self->{IMAGEN}
    }

sub video {
    my $self = shift;
    return $self->{VIDEO}
    }

sub rtmp {
    my $self = shift;
    return $self->{RTMP}
    }

sub mime {
    my $self = shift;
    return $self->{MIMETYPE}
    }

sub tamanyo {
    my $self = shift;
    return $self->{TAMANYO}
    }



    
1;


#     ###print  $self->{XMLin}->{multimedias}->{multimedia}->{seccion}, "\n";
#     ###print  $self->{XMLin}->{multimedias}->{multimedia}->{nombre}, "\n";;
#     ###print  $self->{XMLin}->{multimedias}->{multimedia}->{info}, "\n";
#     ###print  $self->{XMLin}->{multimedias}->{multimedia}->{descripcion}, "\n";
#     ###print  $self->{XMLin}->{url}->{urlImg} . $self->{XMLin}->{multimedias}->{multimedia}->{archivoMultimediaMaxi}->{archivo}, "\n";;
#     ###print  $self->{XMLin}->{url}->{urlHttpVideo} . $self->{XMLin}->{multimedias}->{multimedia}->{archivoMultimedia}->{archivo}, "\n";;
#     ###print  $self->{XMLin}->{url}->{urlVideoMp4} . $self->{XMLin}->{multimedias}->{multimedia}->{archivoMultimedia}->{archivo}, "\n";;
#     ###print  $self->{XMLin}->{multimedias}->{multimedia}->{aspecto}, "\n";