<?php

namespace App\Http\Controllers;
use  App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class RegisterController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        //
    }
    public function create (Request $request){
        $user=[
            'name'=>$request->get('name'),
            'email'=>$request->get('email'),
            'phone_number'=>$request->get('phone_number'),
            'password'=>Hash::make($request->get('password')),
            'user_type'=>'costumer'
        ];
        User::create($user);
        return response()->json(['message' => 'Success'], 200);
    }
    //
}
