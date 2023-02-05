<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ServicesTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $services = array([
            'service' => 'Haircut',
            'price' => '500'
        ],
        [
            'service' => 'Full Head Hair Color with Keratin Mask',
            'price' => '1000'
        ],
        [
            'service' => 'Brazilian Blow Dry Treatment',
            'price' => '1000'
        ],
        [
            'service' => 'Silky Hair Rebond with Keratin Mask',
            'price' => '2000'
        ],
        [
            'service' => 'Hair Color with Highlights and Keratin Mask',
            'price' => '2000'
        ],
        [
            'service' => 'Silky Hair Rebond with Color and Keratin Mask',
            'price' => '2500'
        ],
        [
            'service' => 'Silky Hair Rebond with Color and Brazilian Treatment',
            'price' => '3000'
        ]);
        foreach ($services as $key => $service) {
            DB::table('services')->insert($service);
        }
    }
}
