<?php

use Illuminate\Database\Seeder;

class user_seeder extends Seeder
{
	/**
	 * Run the database seeds.
	 *
	 * @return void
	 */
	public function run()
	{
		DB::table('users')->insert([
			'name' => 'admin',
			'email' => 'admin',
			'password' => bcrypt('Itp12345678'),
		]);
		DB::table('preferencias')->insert([
			'usuario_id' => 1,
			'estilo' => 'css/style_blue.css'
		]);
	}
}
