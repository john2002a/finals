<?php

namespace App\Http\Controllers;
use  App\Models\Booking;
use Illuminate\Http\Request; 

class BookingsController extends Controller
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
    public function getHistory() {
        $list  = Booking::select('bookings.id', 'users.name', 'bookings.user_id', 'users.phone_number', 'services.service', 'bookings.service_id', 'services.price', 'bookings.booking_date', 'bookings.booking_status', 'bookings.cancellation_note')
            ->join('users', 'users.id', '=', 'bookings.user_id')
            ->join('services', 'services.id', '=', 'bookings.service_id')
            ->get(); //add booking date and time, status and cancelation note

        return response()->json($list, 200);
    }

    public function create (Request $request){
        $servicesSelected = [
            'service_id'=>$request->get('service_id'),
            'user_id'=>$request->get('user_id'),
            'booking_date'=>$request->get('booking_date'),
            'booking_status'=>'pending', 
            'cancellation_note'=>' ',
        ];
        Booking::create($servicesSelected);
        return response()->json(['message' => 'Successfully Booked'], 200);
    }

    public function getUserHistory(Request $request) {
        $this->validate($request, [
            'showID'=>'required|string'
        ]);
        $input=$request->only('showID');
        $id=$input['showID'];

        $list  = Booking::select('users.name', 'users.phone_number', 'services.service', 'services.price', 'bookings.booking_date', 'bookings.booking_status', 'bookings.cancellation_note')
            ->join('users', 'users.id', '=', 'bookings.user_id') 
            ->where('user_id', '=', $id)
            ->join('services', 'services.id', '=', 'bookings.service_id')
            ->get();

        // return response()->json(['message' => 'Success', 'data' => $list]);
        return response()->json($list, 200);
    }

    public function changeStatus(Request $request){
        $this->validate($request, [
            'id'=>'required|integer',
            'user_id'=>'required|integer',
            'service_id'=>'required|integer',
            'cancellation_note'=>'required|string',
            'booking_status'=>'required|string'
        ]);

        $input=$request->only('id', 'user_id', 'service_id','cancellation_note', 'booking_status');
        $bookID=(int)$input['id'];
        $id=(int)$input['user_id'];
        $sID=(int)$input['service_id'];
        $note=$input['cancellation_note'];
        $status=$input['booking_status'];
        
        $affected = Booking::select("bookings")
                    ->where("id", $bookID)
                    ->where("user_id", $id)
                    ->where("service_id", $sID)
                    ->where("booking_status", "pending")
                    ->update(["cancellation_note" => $note, "booking_status" => $status]);
                    // ->first();
                    
         if($affected){
            return response()->json(['message' => 'Success']);
         }else{
            return response()->json(['message' => 'Error']);
         }
    }
}