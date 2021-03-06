<p class="menu_module">
[
<a href="index.php?file=war&amp;act=histo" title="Historique de vos attaques, et de celle de vos ennemis.">Journal de guerre</a>
]
- 
[
<a href="index.php?file=leg" title="Cr�er, Modifier, D�placer vos L�gions">Gestion des L�gions</a>
] -
[
<a href="index.php?file=war&amp;act=atq" title="Attaquer un autre membre.">Attaquer</a>
] -
[
<a href="index.php?file=war&amp;act=enc" title="Voir les attaques en cours.">Attaques en cours</a>
]
<hr />

</p>

<if cond='!|{leg_act}| OR |{leg_act}| == "edit_leg" OR |{leg_act}| == "del_leg"'>
	<if cond='|{leg_act}| == "edit_leg"'>
		<if cond='|{leg_sub}| == "not_all_input"'>
		<p class="error">Il manque des parametres.</p>
		</if>
		<elseif cond='|{leg_edit}|'>
		<p class="ok">Changement effectu�.</p>
		</elseif>
		<else>
		<p class="error">Erreur</p>
		</else>
	</if>
	<elseif cond='|{leg_act}| == "del_leg"'>
		<if cond='|{leg_sub}| == "no_lid"'>
		<p class="error">Il manque des parametres.</p>
		</if>
		<elseif cond='|{leg_ok}|'>
		<p class="ok">Supprim�e.</p>
		</elseif>
		<else>
		<p class="error">Erreur, il est possible que cette l�gion ne soit pas vide.</p>
		</else>
	</elseif>

<script type="text/javascript">
<!--
	function vide(the_select)
	{
		if(the_select.options.length > 0)
		{	
			the_select.options.length=0;
		}
	}
	
	function ajoute(the_select, value, text){
		the_select.options[the_select.options.length]=new Option(text,value);
	}

	function update_unt()
	{
		var type_unt = document.getElementById("type_unt");
		var from_leg = document.getElementById("from_leg");
		
		var value_from_leg = from_leg.options[from_leg.selectedIndex].value;

		var unt_in_leg = legions[value_from_leg]['unt'];
		
		vide(type_unt);
		
		for(var i = 0; i < unt_in_leg.length; i++)
    {
      if(unt_in_leg[i])
      {
        var unt_nb = unt_in_leg[i][1];
        var unt_type = i;
        var unt_name = unt_in_leg[i][0];
        ajoute(type_unt , unt_type, unt_name + '  (' + unt_nb + ')');
      }
    }
	}

	function make_form()
	{
		var type_unt = document.getElementById("type_unt");
		var from_leg = document.getElementById("from_leg");
		var to_leg = document.getElementById("to_leg");

		vide(from_leg);
		vide(to_leg);
		//ajoute(from_leg, 0, 'Village');
		ajoute(to_leg, -1, 'Nouvelle L�gion');
		for(var i = 0; i < legions.length; i++)
    {
    	if(legions[i])
    	{
    		var leg_lid = i;
    		var leg_name = legions[i]['name'];
    		ajoute(from_leg , leg_lid, leg_name);
    		ajoute(to_leg , leg_lid, leg_name);
    	}
    }
		
		vide(type_unt);
		if(legions[0]['unt'])
		{
		var unt_in_leg = legions[0]['unt'];
		for(var i = 0; i < unt_in_leg.length; i++)
    {
    	if(unt_in_leg[i])
    	{
      	var unt_nb = unt_in_leg[i][1];
      	var unt_type = i;
      	var unt_name = unt_in_leg[i][0];
      	ajoute(type_unt , unt_type, unt_name + '  (' + unt_nb + ')');
      }
     }
     }
	}
	
	function check_leg_name()
	{
		var to_leg = document.getElementById("to_leg");
		var to_leg_value = to_leg.options[to_leg.selectedIndex].value;
		var leg_name = document.getElementById("leg_name");
		
		if(to_leg_value == "-1")
		{
			leg_name.value = '';
			leg_name.disabled = false;
		}else{
			leg_name.value = legions[to_leg_value]['name'];
			leg_name.disabled = "disabled";
		}
	}
		
	var legions = new Array();
	
		legions[0] = new Array();
		legions[0]['name'] = 'Village';
		legions[0]['unt']  = new Array();
		<if cond='is_array(|{unt_array[0]}|)'>
			<foreach cond='|{unt_array[0]}| as |{unt_type}| => |{unt_value}|'>
			<if cond='|{unt_conf[{unt_type}][speed]}|'>
				legions[0]['unt'][{unt_type}] = new Array('<math oper="addslashes(html_entity_decode({unt[{session_user[race]}][alt][{unt_type}]}))" />',{unt_value[unt_nb]});
			</if>
			</foreach>
		</if>
	
	<if cond='is_array(|{leg_array}|)'>
		<foreach cond='|{leg_array}| as |{leg_id}| => |{leg_value}|'>
		<if cond='|{leg_value[leg_etat]}| == 0'>
		legions[{leg_id}] = new Array();
		legions[{leg_id}]['name'] = '<math oper="addslashes(html_entity_decode({leg_value[leg_name]}, ENT_QUOTES))" />';
		legions[{leg_id}]['unt']  = new Array();
		
				<if cond='is_array(|{unt_array[{leg_id}]}|)'>
					<foreach cond='|{unt_array[{leg_id}]}| as |{unt_type}| => |{unt_value}|'>
					legions[{leg_id}]['unt'][{unt_type}]= new Array('<math oper="addslashes(html_entity_decode({unt[{session_user[race]}][alt][{unt_type}]}))" />',{unt_value[unt_nb]});
					</foreach>
				</if>
		</if>
		</foreach>
	</if>
-->
</script>
<p class="infos">Les l�gions qui ne sont pas au village ne peuvent �tre modifi�es. Pour comprendre ce que sont les bonus, allez voir le manuel, section "guerre".</p>
<form method="post" action="index.php?file=leg&act=edit_leg" id="unt_form" name="unt_form">
<fieldset>
<legend>Gestion des l�gions</legend>
	D�placer de 
	<select name="from_leg" id="from_leg" onChange="update_unt();">
	<option value="0">Village</value>
	<if cond='is_array(|{leg_array}|)'>
		<foreach cond='|{leg_array}| as |{leg_id}| => |{leg_value}|'>
		<if cond='|{leg_value[leg_etat]}| == 0'>
		<option value="{leg_id}">{leg_value[leg_name]}</value>
		</if>
		</foreach>
	</if>
	</select>
	vers
	<select name="to_leg" id="to_leg" onChange="check_leg_name();">
		<option value="-1">Nouvelle legion</option>
		<if cond='is_array(|{leg_array}|)'>
			<foreach cond='|{leg_array}| as |{leg_id}| => |{leg_value}|'>
				<if cond='|{leg_value[leg_etat]}| == 0'>
				<option value="{leg_id}">{leg_value[leg_name]}</value>
				</if>
			</foreach>
		</if>
	</select><br />
	<label for="leg_name">Nom de la l�gion : </label>
	<input id="leg_name" type="text" name="leg_name" maxlength="20" size="11" />
	<br/>
	<label for="nb_unt">Nombre :</label>
	<input id="nb_unt" type="text" name="nb_unt" maxlength="5" size="5" />
	Type :
	<select id="type_unt" name="type_unt" />
	<if cond='is_array(|{leg_array}|)'>
		<foreach cond='|{leg_array}| as |{leg_id}| => |{leg_value}|'>
		<if cond='|{leg_value[leg_etat]}| == 0'>
				<if cond='is_array(|{unt_array[{leg_id}]}|)'>
					<foreach cond='|{unt_array[{leg_id}]}| as |{unt_type}| => |{unt_value}|'>
					<option value="{unt_type}">{unt_value[unt_nb]} {unt[{session_user[race]}][alt][{unt_type}]} dans {leg_value[leg_name]}</option>
					</foreach>
				</if>
		</if>
		</foreach>
	</if>
	</select>
	<input type="submit" value="Appliquer" />
</fieldset>
</form>

<script type="text/javascript">
	make_form();
</script>

<if cond='is_array(|{leg_array}|)'>
		<foreach cond='|{leg_array}| as |{leg_id}| => |{leg_value}|'>
		
		<div class="list_univ" id="leg_{leg_id}">
		<strong>Etat</strong> : {leg[{leg_value[leg_etat]}]} - <strong>Nom</strong> : {leg_value[leg_name]}<br />
		<strong>Experience</strong> : {leg_value[leg_xp]}
		<if cond='|{leg_value[leg_etat]}| != 0'>
		 - <strong>Position</strong> X: {leg_value[map_x]} Y: {leg_value[map_y]} - <strong>Distance</strong> : <math oper="round(sqrt(({leg_value[map_x]}-{mbr_map_x})*({leg_value[map_x]}-{mbr_map_x}) + ({leg_value[map_y]}-{mbr_map_y})*({leg_value[map_y]}-{mbr_map_y})),2)" />
		</if> <br />
			<if cond='is_array(|{unt_array[{leg_id}]}|)'>
				<strong>Force</strong>:
				{leg_value[leg_atq]} <if cond="|{leg_value[leg_bonus][bonus_xp]}| OR |{leg_value[leg_bonus][bonus_atq]}|">(+<math oper="round({leg_value[leg_atq]}*(({leg_value[leg_bonus][bonus_xp]}+{leg_value[leg_bonus][bonus_atq]})/100))" />)</if>
				<img src="img/{session_user[race]}/div/atq.png" alt="Attaque Unit�s" title="Attaque Unit�s" />
				 - 
				{leg_value[leg_atq_btc]} <if cond="|{leg_value[leg_bonus][bonus_xp]}| OR |{leg_value[leg_bonus][bonus_atq]}|">(+<math oper="round({leg_value[leg_atq_btc]}*(({leg_value[leg_bonus][bonus_xp]}+{leg_value[leg_bonus][bonus_atq]})/100))" />)</if>
				<img src="img/{session_user[race]}/div/atq_btc.png" alt="Attaque B�timents" title="Attaque B�timents" />
				 - 
				{leg_value[leg_def]} <if cond="|{leg_value[leg_bonus][bonus_xp]}| OR |{btc_bonus_def}| OR |{leg_value[leg_bonus][bonus_def]}|">(+<math oper="round({leg_value[leg_def]}*{btc_bonus_def}/100)+round({leg_value[leg_def]}*(({leg_value[leg_bonus][bonus_xp]}+{leg_value[leg_bonus][bonus_def]})/100))" />)</if>
				<img src="img/{session_user[race]}/div/def.png" alt="D�fense" title="D�fense" />
				<br/>
				<strong>Bonus</strong>:
				{leg_value[leg_bonus][bonus_atq]}% 
				<img src="img/{session_user[race]}/div/atq.png" alt="Bonus d'Attaque" title="Bonus d'Attaque" />
				-
				{leg_value[leg_bonus][bonus_def]}% 
				<img src="img/{session_user[race]}/div/def.png" alt="Bonus de D�fense" title="Bonus de D�fense" />
				<strong>Bonus XP</strong>: {leg_value[leg_bonus][bonus_xp]}% 
				<br/>
	    			<a id="leg_{leg_id}_toggle" href="javascript:toggle('leg_{leg_id}');"><img src="img/minus.png" alt="-" /></a>
				<table class="border1" id="descr_leg_{leg_id}_0" style="display:block;">
					<tr>
					<th>Type</th>
					<th>Nombre</th>
					<th><img src="img/{session_user[race]}/div/atq.png" alt="Attaque Unit�s" title="Attaque Unit�s" />-<img src="img/{session_user[race]}/div/atq_btc.png" alt="Attaque B�timents" title="Attaque B�timents" />-<img src="img/{session_user[race]}/div/def.png" alt="D�fense" title="D�fense" /> Total</th>
					<th>Bonus</th>
					</tr>
				<foreach cond='|{unt_array[{leg_id}]}| as |{unt_type}| => |{unt_value}|'>
					<tr>
						<td><img src="img/{session_user[race]}/unt/{unt_type}.png" alt="{unt[{session_user[race]}][alt][{unt_type}]}" title="{unt[{session_user[race]}][alt][{unt_type}]}" /> {unt[{session_user[race]}][alt][{unt_type}]}</td>
						<td>{unt_value[unt_nb]}</td>
						<td><math oper="{unt_conf[{unt_type}][attaque]}*{unt_value[unt_nb]}" /><img src="img/{session_user[race]}/div/atq.png" alt="Attaque Unit�s" title="Attaque Unit�s" /> <math oper="{unt_conf[{unt_type}][attaquebat]}*{unt_value[unt_nb]}" /><img src="img/{session_user[race]}/div/atq_btc.png" alt="Attaque B�timents" title="Attaque B�timents" /> <math oper="{unt_conf[{unt_type}][defense]}*{unt_value[unt_nb]}" /><img src="img/{session_user[race]}/div/def.png" alt="D�fense" title="D�fense" /></td>
						<td>
						<set name="bonus_def" value='<math oper="{unt_conf[{unt_type}][bonus][def]}*{unt_value[unt_nb]}" />' />
						<set name="bonus_atq" value='<math oper="{unt_conf[{unt_type}][bonus][atq]}*{unt_value[unt_nb]}" />' />
						<if cond="{bonus_atq}">
							<if cond="|{bonus_def}| < |{GAME_MAX_UNT_BONUS}|">{bonus_atq}</if><else>{GAME_MAX_UNT_BONUS}</else>%
							<img src="img/{session_user[race]}/div/atq.png" alt="Bonus d'Attaque" title="Bonus d'Attaque" />
						</if>
						<if cond="{bonus_def}">
							<if cond="|{bonus_atq}| < |{GAME_MAX_UNT_BONUS}|">{bonus_def}</if><else>{GAME_MAX_UNT_BONUS}</else>%
							<img src="img/{session_user[race]}/div/def.png" alt="Bonus de D�fense" title="Bonus de D�fense"" />
						</if>
						</td>
					</tr>
				</foreach>
				</table>
			</if>
			<else>
				<br />Aucune unit� dans cette L�gion - <a href="index.php?file=leg&act=del_leg&lid={leg_id}" title="Supprimer cette l�gion">Supprimer</a>
		
			</else>
		</div>
		<if cond='is_array(|{unt_array[{leg_id}]}|)'>
			<script type="text/javascript">toggle('leg_{leg_id}');</script>
		</if>
		</foreach>
</if>
<if cond='is_array(|{unt_array[0]}|)'>
	<div class="list_univ">
	Unit�s sans l�gion.<br />
			<img src="img/{session_user[race]}/div/atq.png" alt="Attaque" title="Attaque" />
			{leg_village[leg_atq]} - 
			<img src="img/{session_user[race]}/div/atq_btc.png" alt="Attaque B�timents" title="Attaque B�timents" />
			{leg_village[leg_atq_btc]} - 
			<img src="img/{session_user[race]}/div/def.png" alt="D�fense" title="D�fense" />
			{leg_village[leg_def]}<br/>
	<foreach cond='|{unt_array[0]}| as |{unt_type}| => |{unt_value}|'>
		<if cond='|{unt_conf[{unt_type}][speed]}|'>
			{unt_value[unt_nb]} <img src="img/{session_user[race]}/unt/{unt_type}.png" alt="{unt[{session_user[race]}][alt][{unt_type}]}" title="{unt[{session_user[race]}][alt][{unt_type}]}" />
		</if>
	</foreach>
	</div>
</if>
	<h2>Total :</h2> 
	<img src="img/{session_user[race]}/div/atq.png" alt="Attaque" title="Attaque" />
	{leg_total[leg_atq]} - 
	<img src="img/{session_user[race]}/div/atq_btc.png" alt="Attaque B�timents" title="Attaque B�timents" />
	{leg_total[leg_atq_btc]} - 
	<img src="img/{session_user[race]}/div/def.png" alt="D�fense" title="D�fense" />
	{leg_total[leg_def]}
	<hr/>
	<h2>Village</h2>
	D�fense du village : {btc_def} <img src="img/{session_user[race]}/div/def.png" alt="D�fense des B�timents" />
	Bonus de d�fense pour les unit�s: {btc_bonus_def}% <img src="img/{session_user[race]}/div/def.png" alt="Bonus de D�fense des B�timents" />
</if>
