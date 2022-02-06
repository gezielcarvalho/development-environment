<?php
namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Models\Airline;

class AirlineController extends Controller
{
    public function index()
    {
        $airlines = Airline::all();
        return response()->json($airlines);
    }

    public function store(Request $request)
    {
        $airline = new Airline([
            'airline_name' => $request->input('airline_name'),
            'iata_code' => $request->input('iata_code'),
            'country' => $request->input('country')
        ]);
        $airline->save();
        return response()->json('Airline created!');
    }
    public function show($id)
    {
        $airline = Airline::find($id);
        return response()->json($airline);
    }
    public function update($id, Request $request)
    {
        $airline = Airline::find($id);
        $airline->update($request->all());
        return response()->json('Airline updated!');
    }
    public function destroy($id)
    {
        $airline = Airline::find($id);
        $airline->delete();
        return response()->json('Airline deleted!');
    }
}