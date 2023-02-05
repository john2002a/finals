<?php
 
namespace App\Models;
 
use Illuminate\Auth\Authenticatable;
use Laravel\Lumen\Auth\Authorizable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Contracts\Auth\Authenticatable as AuthenticatableContract;
use Illuminate\Contracts\Auth\Access\Authorizable as AuthorizableContract;

use Tymon\JWTAuth\Contracts\JWTSubject;
 
class Booking extends Model
{
    use Authenticatable, Authorizable;
    protected $casts = ['booking_date' => 'datetime:Y-m-d h:m'];
    protected $fillable = ['user_id', 'service_id', 'booking_date', 'cancellation_note'];
}
