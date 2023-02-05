<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;


class UsersTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $users = User::create([
            'name' => 'Admin Sencio', 
            'email' => 'admin.sencio20@gmail.com',
            'phone_number' => '09238701777',
            'password' => Hash::make('adminsencio@2002'),
            'user_type' => 'admin'
        ]);
    }
}