use MooseX::Declare;

class StatusShooter::Post::Identica extends StatusShooter::Post {
  use DateTime;
  use Date::Parse;

  has '+post' => ( isa => 'HashRef' );

  # lazy builder for 'date' attr, declared in base class
  method _build_date {
    my $epoch = str2time( $self->post->{created_at} );
    my $dt = DateTime->from_epoch( epoch => $epoch );
    $dt->set_time_zone( 'local' );
    return $dt;
  }

  # lazy builder for 'text' attr, declared in base class
  method _build_text { return $self->post->{text} }

  method author      { return $self->post->{user}{name} }
  method avatar_src  { return $self->post->{user}{profile_image_url} }

  method permalink   {
    return sprintf 'http://twitter.com/%s/notice/%s' ,
      $self->user_handle , $self->post->{id}
  }

  method user_desc   { return $self->post->{user}{description} }
  method user_handle { return $self->post->{user}{screen_name} }
  method user_url    { return sprintf 'http://identi.ca/%s' , $self->user_handle }
}
