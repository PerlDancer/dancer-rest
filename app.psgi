# PSGI application bootstraper for Dancer
use lib 'lib';
use Dancer;
load_app 'dancerREST';

use Dancer::Config 'setting';
setting apphandler => 'PSGI';
Dancer::Config->load;
use Plack::Builder;

my $app = sub {
    my $env     = shift;
    my $request = Dancer::Request->new($env);
    Dancer->dance($request);
};

builder {
    enable "Auth::Basic", authenticator => \&authen_cb;
    $app;
};

sub authen_cb {
    my ( $username, $password ) = @_;
    return $username eq 'admin' && $password eq 'admin';
}
