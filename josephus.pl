#!/usr/bin/perl

# Flavius Josephus was a roman historian of Jewish origin.
# During the Jewish-Roman wars of the first century AD, he was in a cave with fellow soldiers, 40 men in all, surrounded by enemy Roman troops.
# They decided to commit suicide by standing in a ring and counting off each third man. Each man so designated was to commit suicide...
# Josephus, not wanting to die, managed to place himself in the position of the last survivor.

# In the general version of the problem, there are n soldiers numbered from 1 to n and each k-th soldier will be eliminated.
# The count starts from the first soldier. What is the number of the last survivor?

package Person;
use overload q("") => \&to_s;

# Create a new, living Person with the given position
sub new {
    my $invocant = shift;
    my $class = ref($invocant) || $invocant;
    my $pos = shift;
    my $self = { "position" => $pos,
                 "alive" => 1,
                 "succ" => undef };
    return bless($self,$class);
}

# Getter/Setter for successor
sub succ : lvalue {
    my $self = shift;
    $self->{succ}
}

# Create a chain of people
sub createChain {
    my $self = shift;
    my $n = shift;
    return $self unless $n;
    
    my $succ = Person->new($self->{position}+1);
    $self->succ = $succ;
    $succ->createChain($n-1)
}

# Pass on the killing message
sub circularKill {
    my $self = shift;
    my ($pos,$nth,$remaining)=@_;

    return $self->{succ}->circularKill($pos, $nth, $remaining)
        unless $self->{alive};
    return $self unless $remaining > 1;
    
    if ($pos == $nth) {
        $self->{alive} = 0;
        $pos = 0;
        $remaining--;
    }
    $self->{succ}->circularKill($pos+1, $nth, $remaining)
}

# Print descriptive information
sub to_s{ 
    my $self = shift;
    "Person #".$self->{position}.", ".($self->{alive} ? "alive" : "dead")
}

# Circle of $n people, kill every one out of every $m
$m = 3;
$n = 40;

$first = new Person(1);
$last = $first->createChain($n-1);
$last->succ = $first;

$winner = $first->circularKill(1,$m,$n);
print "Winner: ", $winner, "\n";

