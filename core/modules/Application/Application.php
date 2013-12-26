<?php
/**
* Staff Application v.1.0 Module
*
* phpVMS Module for pilots to submit a staff application sent via email
* This module is released under the Creative Commons Attribution-Noncommercial-Share Alike 3.0 Unported License
* You are free to redistribute and alter this work as you wish but you must keep the original 'copyright' information on all the places it comes in the original work.
* You are not allowed to delete the copyright information and/or gain any profit by adopting or using this module.
*
* @author Chase Morgan
* @copyright Copyright (c) 2013, Chase Morgan
* @license http://creativecommons.org/licenses/by-nc-sa/3.0/
*/


class Application extends CodonModule 
{
	public function index()
	{
	
		if(!Auth::LoggedIn())
		{
			$this->set('message', 'You must be logged in to access this feature!');
			$this->render('core_error.tpl');
			return;
		}
		
		
		require_once CORE_LIB_PATH.'/recaptcha/recaptchalib.php';


		if($this->post->submit)
		{
			
								
				
			
			$resp = recaptcha_check_answer (Config::Get('RECAPTCHA_PRIVATE_KEY'),
				$_SERVER["REMOTE_ADDR"],
				$_POST["recaptcha_challenge_field"],
				$_POST["recaptcha_response_field"]);
			
			// Check the captcha thingy
			if(!$resp->is_valid)
			{
				$this->set('captcha_error', $resp->error);
				$this->set('message', 'You failed the captcha test!');
				$this->render('application_form.tpl');
				return;
			}
			
			if($this->post->subject == '' || trim($this->post->message) == '')
			
			
			$subject = 'New message from '.$this->post->name.' - "'.$this->post->subject.'"';
			$message = DB::escape($this->post->message) . PHP_EOL . PHP_EOL;
			
			unset($_POST['recaptcha_challenge_field']);
			unset($_POST['recaptcha_response_field']);
			
			foreach($_POST as $field=>$value)
			{
				$message.="-$field = $value".PHP_EOL;
			}
			
			$message = nl2br($message);
			$message = utf8_encode($message);
			Util::SendEmail(ADMIN_EMAIL, $subject, $message);
			
			$this->render('application_sent.tpl');
			return;
		}		
		
		# Just a simple addition
		$rand1 = rand(1, 10);
		$rand2 = rand(1, 10);
		
		$this->set('rand1', $rand1);
		$this->set('rand2', $rand2);		
		
		$tot = $rand1 + $rand2;
		//echo "total: $tot <br />";
		SessionManager::Set('captcha_sum', $tot);
		
		//echo 'output of $_SESSION: <br />';
		//print_r($_SESSION);
		
		$this->render('application_form.tpl');
	}
	
}