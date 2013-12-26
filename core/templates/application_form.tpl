<p>
<h2>Staff Application</h2>
</p>
<p>
Thank you for your interest in a staff position at <?php echo SITE_NAME; ?>. Please complete the following form and fill out all fields. Our careers team will get back to you within 48 hours with a responce.
<hr />
 
</p>
<p>
<form method="post" action="<?php echo url('/application'); ?>">

  <table width='100%' border='0'>
    <tr>
      <td><strong>Name: *</strong></td>
      <td>
		<?php
		if(Auth::LoggedIn())
		{
			echo Auth::$userinfo->firstname .' '.Auth::$userinfo->lastname;
			echo '<input type="hidden" name="name" 
					value="'.Auth::$userinfo->firstname 
							.' '.Auth::$userinfo->lastname.'" />';
		}
		else
		{
		?>
		<?php
		}
		?>
      </td>
    </tr>
    <tr>
		<td width="1%" nowrap><strong>Pilot ID: *</strong></td>
		<td>
		<?php
		if(Auth::LoggedIn())
		{
			echo Auth::$userinfo->pilotid;
			echo '<input type="hidden" name="name" 
					value="'.Auth::$userinfo->pilotid.'" />';
		}
		else
		{
		?>
		<?php
		}
		?>
		</td>
	</tr>

	<tr>
		<td><strong>Position: *</strong></td>
	<td>
		<select>
		<option value="Chief Executive Officer">Chief Executive Officer</option>
  		<option value="Cheif Operations Officer">Cheif Operations Officer</option>
 		<option value="Human Resources">Human Resources</option>
  		<option value="Flight Dispatcher">Flight Dispatcher</option>
  		<option value="Webmaster">Webmaster</option>
		</select></td>
	</tr>

	<tr>
		<td><strong>Tell Us About Your Previous VA Experiance: *</strong></td>
		<td><textarea name="message" cols='45' rows='5'><?php echo $_POST['message'];?></textarea></td>
	
	</tr>
    <tr>
      <td><strong>Why Should We Choose You For This Position?: *</strong></td>
      <td>
		<textarea name="message" cols='45' rows='5'><?php echo $_POST['message'];?></textarea>
      </td>
    </tr>
    <tr>
      <td><strong>Do You Have Any Real World Experiance?: (Optional)</strong></td>
      <td>
		<textarea name="message" cols='45' rows='5'><?php echo $_POST['message'];?></textarea>
      </td>
    </tr>
    
    <tr>
		<td width="1%" nowrap><strong>Captcha</strong></td>
		<td>
		<?php
		echo recaptcha_get_html(Config::Get('RECAPTCHA_PUBLIC_KEY'), $captcha_error);
		?>
		</td>
	</tr>
	
    <tr>
		<td>
			<input type="hidden" name="loggedin" value="<?php echo (Auth::LoggedIn())?'true':'false'?>" />
		</td>
		<td>
          <input type="submit" name="submit" value='Send Message'>
		</td>
    </tr>
  </table>
</form>