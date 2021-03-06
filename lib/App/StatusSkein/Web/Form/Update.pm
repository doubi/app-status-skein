package App::StatusSkein::Web::Form::Update;

use HTML::FormHandler::Moose;
extends 'HTML::FormHandler';
with 'HTML::FormHandler::Render::Simple';

use namespace::autoclean;

has '+name' => ( default => 'update-form' );

has_field 'status' => (
  type             => 'Text' ,
  label            => 'Status' ,
  required         => 1 ,
  required_message => 'You must enter a status' ,
  size             => 140 ,
  maxlength        => 140 ,
);

has_field 'accounts' => (
  type             => 'Multiple' ,
  widget           => 'CheckboxGroup' ,
  required         => 1 ,
  required_message => 'You must select one or more accounts' ,
);

has_field 'in_reply_to' => (
  type => 'Hidden' ,
);

has_field 'submit' => (
  type  => 'Submit' ,
  value => 'Post' ,
);

1;
