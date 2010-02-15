use MooseX::Declare;
class StatusShooter::Client {
  has fave_add_method => (
    is      => 'ro' ,
    isa     => 'Str',
    default => 'create_favorite' ,
  );

  has fave_del_method => (
    is      => 'ro' ,
    isa     => 'Str',
    default => 'destroy_favorite' ,
  );

  has 'type' => (
    is  => 'ro' ,
    isa => 'Str' ,
  );

  method get_post ( $id ) {
    my $post;
    eval { $post = $self->show_status( $id ) };
    die $@ if $@;

    my $post_class = $self->post_class;
    return $post_class->new({ post => $post });
  }

  method get_posts {
    my $posts;
    eval { $posts = $self->_client->home_timeline };
    die $@ if $@;

    my $post_class = $self->post_class;
    return [ map { $post_class->new({ post => $_ }) } @$posts ];
  }

  method post_class { return sprintf "StatusShooter::Post::%s" , $self->type }
}
