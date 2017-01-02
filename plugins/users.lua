local function do_keybaord_credits()
	local keyboard = {}
    keyboard.inline_keyboard = {
    	{
    		{text = _("کانال"), url = 'https://telegram.me/'..config.channel:gsub('@', '')},
    		{text = _("ارتباط با مدیر"), url = 'https://telegram.me/cpp_cs'},
    		{text = _("امتیاز به ربات"), url = 'https://telegram.me/storebot?start='..bot.username},
		}
	}
	return keyboard
end

local function do_keyboard_cache(chat_id)
	local keyboard = {inline_keyboard = {{{text = _("🔄️ تازه کردن کش"), callback_data = 'cc:rel:'..chat_id}}}}
	return keyboard
end

local function get_time_remaining(seconds)
	local final = ''
	local hours = math.floor(seconds/3600)
	seconds = seconds - (hours*60*60)
	local min = math.floor(seconds/60)
	seconds = seconds - (min*60)
	
	if hours and hours > 0 then
		final = final..hours..'h '
	end
	if min and min > 0 then
		final = final..min..'m '
	end
	if seconds and seconds > 0 then
		final = final..seconds..'s'
	end
	
	return final
end

local function get_user_id(msg, blocks)
	if msg.reply then
		print('reply')
		return msg.reply.from.id
	elseif blocks[2] then
		if blocks[2]:match('@[%w_]+$') then --by username
			local user_id = misc.resolve_user(blocks[2])
			if not user_id then
				print('username (not found)')
				return false
			else
				print('username (found)')
				return user_id
			end
		elseif blocks[2]:match('%d+$') then --by id
			print('id')
			return blocks[2]
		elseif msg.mention_id then --by text mention
			print('text mention')
			return msg.mention_id
		else
			return false
		end
	end
end

local function get_name_getban(msg, blocks, user_id)
	if blocks[2] then
		return blocks[2]..' ('..user_id..')'
	else
		return msg.reply.from.first_name..' ('..user_id..')'
	end
end

local function get_ban_info(user_id, chat_id)
	local hash = 'ban:'..user_id
	local ban_info = db:hgetall(hash)
	local text
	if not next(ban_info) then
		text = _("چیزی برای نمایش وجود ندارد\n")
	else
		local ban_index = {
			kick = _("اخراج شد: %d"),
			ban = _("مسدودشد: %d"),
			tempban = _("موقت مسدود شد: %d"),
			flood = _("حذف شد بخاطر اسپم:%d"),
			media = _("حذف شد بخاطر رسانه غیرمجاز: *%d*"),
			warn = _("حذف شد بخاطر اخطار: %d"),
			arab = _("حذف شد بخاطر متن عربی: %d"),
			rtl = _("حذف شد بخاطر راست نویس بودن: %d"),
		}
		text = ''
		for type,n in pairs(ban_info) do
			text = text..ban_index[type]:format(n)..'\n'
		end
		if text == '' then
			return _("چیزی برای نمایش وجود ندارد")
		end
	end
	local warns = (db:hget('chat:'..chat_id..':warns', user_id)) or 0
	local media_warns = (db:hget('chat:'..chat_id..':mediawarn', user_id)) or 0
	text = text..'\n`اخطارها`: '..warns..'\n`اخطارهای رسانه`: '..media_warns
	return text
end

local function do_keyboard_userinfo(user_id)
	local keyboard = {
		inline_keyboard = {
			{{text = _("حذف اخطارها"), callback_data = 'userbutton:remwarns:'..user_id}},
			{{text = _("🔨 مسدود"), callback_data = 'userbutton:banuser:'..user_id}},
		}
	}
	
	return keyboard
end

local function get_userinfo(user_id, chat_id)
	return _("*اطلاعات مسدودیت* (globals):\n") .. get_ban_info(user_id, chat_id)
end

local action = function(msg, blocks)
    if blocks[1] == 'adminlist' then
    	if msg.chat.type == 'private' then return end
    	local out
        local creator, adminlist = misc.getAdminlist(msg.chat.id)
		out = _("*سازنده*:\n%s\n\n*مدیران*:\n%s"):format(creator, adminlist)
        if not roles.is_admin_cached(msg) then
        	api.sendMessage(msg.from.id, out, true)
        else
            api.sendReply(msg, out, true)
        end
    end
    if blocks[1] == 'status' then
    	if msg.chat.type == 'private' then return end
    	if roles.is_admin_cached(msg) then
    		if not blocks[2] and not msg.reply then return end
    		local user_id, error_tr_id = misc.get_user_id(msg, blocks)
    		if not user_id then
				api.sendReply(msg, _(error_tr_id), true)
		 	else
		 		local res = api.getChatMember(msg.chat.id, user_id)
		 		if not res then
					api.sendReply(msg, _("این کاربر وچود ندارد"))
		 			return
		 		end
		 		local status = res.result.status
				local name = misc.getname_final(res.result.user)
				local texts = {
					kicked = _("%s از این گروه مسدود است"),
					left = _("%s .از گروه خارج شده یا اخراج شده و یا از لیست مسدودیت در آمده است"),
					administrator = _("%s یک مدیر است"),
					creator = _("%s سازنده این گروه است"),
					unknown = _("%s این کاربر وجود ندارد"),
					member = _("%s عضو چت است")
				}
				api.sendReply(msg, texts[status]:format(name), true)
		 	end
	 	end
 	end
 	if blocks[1] == 'id' then
 		if not(msg.chat.type == 'private') and not roles.is_admin_cached(msg) then return end
 		local id
 		if msg.reply then
 			id = msg.reply.from.id
 		else
 			id = msg.chat.id
 		end
 		api.sendReply(msg, '`'..id..'`', true)
 	end
	if blocks[1] == 'user' then
		if msg.chat.type == 'private' or not roles.is_admin_cached(msg) then return end
		
		if not msg.reply and (not blocks[2] or (not blocks[2]:match('@[%w_]+$') and not blocks[2]:match('%d+$') and not msg.mention_id)) then
			api.sendReply(msg, _(".کاربری را ریپلای کنید یا ای دی او را ارسال کنید"))
			return
		end
		
		------------------ get user_id --------------------------
		local user_id = get_user_id(msg, blocks)
		
		if roles.is_superadmin(msg.from.id) and msg.reply and not msg.cb then
			if msg.reply.forward_from then
				user_id = msg.reply.forward_from.id
			end
		end
		
		if not user_id then
			api.sendReply(msg, _(".من هرگز این کاربر را مشاهده نکرده ام\n"
				.. ".اگر حس میکنید من او را مشاهده کرده ام یک پیام از او برای من فروارد کنید"), true)
		 	return
		end
		-----------------------------------------------------------------------------
		
		local keyboard = do_keyboard_userinfo(user_id)
		
		local text = get_userinfo(user_id, msg.chat.id)
		
		api.sendKeyboard(msg.chat.id, text, keyboard, true)
	end
	if blocks[1] == 'banuser' then
		if not roles.is_admin_cached(msg) then
			api.answerCallbackQuery(msg.cb_id, _("شما یک مدیر نیستید"))
    		return
		end
		
		local user_id = msg.target_id
		
		local res, text = api.banUser(msg.chat.id, user_id, msg.normal_group)
		if res then
			misc.saveBan(user_id, 'ban')
			local name = misc.getname_link(msg.from.first_name, msg.from.username) or msg.from.first_name:escape()
			text = _("_مسدودشد!_\n(مدیر: %s)"):format(name)
		end
		api.editMessageText(msg.chat.id, msg.message_id, text, false, true)
	end
	if blocks[1] == 'remwarns' then
		if not roles.is_admin_cached(msg) then
			api.answerCallbackQuery(msg.cb_id, _("شما یک مدیر نیست"))
    		return
		end
		db:hdel('chat:'..msg.chat.id..':warns', msg.target_id)
		db:hdel('chat:'..msg.chat.id..':mediawarn', msg.target_id)
        
        local name = misc.getname_link(msg.from.first_name, msg.from.username) or msg.from.first_name:escape()
		local text = _("تعداد هشدارهای این کاربر *تغییر کرد*\n(مدیر: %s)")
		api.editMessageText(msg.chat.id, msg.message_id, text:format(name), false, true)
    end
    if blocks[1] == 'cache' then
    	if msg.chat.type == 'private' or not roles.is_admin_cached(msg) then return end
    	local text
    	local hash = 'cache:chat:'..msg.chat.id..':admins'
    	if db:exists(hash) then
    		local seconds = db:ttl(hash)
    		local cached_admins = db:scard(hash)
    		text = '📌 وضعیت: `CACHED`\n⌛ ️باقی مانده: `'..get_time_remaining(tonumber(seconds))..'`\n👥 مدیران ذخیره سازی: `'..cached_admins..'`'
    	else
    		text = 'وضعیت: کش نشده'
    	end
    	local keyboard = do_keyboard_cache(msg.chat.id)
    	api.sendKeyboard(msg.chat.id, text, keyboard, true)
    end
    if blocks[1] == 'msglink' then
    	if roles.is_admin_cached(msg) and msg.reply and msg.chat.username then
    		api.sendReply(msg, '[msg n° '..msg.reply.message_id..'](https://telegram.me/'..msg.chat.username..'/'..msg.reply.message_id..')', true)
    	end
	end
    if blocks[1] == 'cc:rel' and msg.cb then
    	if not roles.is_admin_cached(msg) then
			api.answerCallbackQuery(msg.cb_id, _("شما یک مدیر نیست"))
			return
		end
		local missing_sec = tonumber(db:ttl('cache:chat:'..msg.target_id..':admins') or 0)
		if (config.bot_settings.cache_time.adminlist - missing_sec) < 3600 then
			api.answerCallbackQuery(msg.cb_id, 'لیست مدیران به تازگی به روز شده است. این دکمه در یک ساعت پس از آخرین به روز رسانی در دسترس میباشد', true)
		else
    		local res = misc.cache_adminlist(msg.target_id)
    		if res then
    			local cached_admins = db:smembers('cache:chat:'..msg.target_id..':admins')
    			local time = get_time_remaining(config.bot_settings.cache_time.adminlist)
    			local text = '📌 وضعیت: `CACHED`\n⌛ ️باقی مانده: `'..time..'`\n👥 مدیران ذخیره سازی: `'..#cached_admins..'`'
    			api.answerCallbackQuery(msg.cb_id, '✅ به روز رسانی بعدی در.به روز رسانی شد '..time)
    			api.editMessageText(msg.chat.id, msg.message_id, text, do_keyboard_cache(msg.target_id), true)
    			api.sendLog('#recache\nChat: '..msg.target_id..'\nFrom: '..msg.from.id)
    		end
    	end
    end
end

return {
	action = action,
	triggers = {
		config.cmd..'(id)$',
		config.cmd..'(adminlist)$',
		config.cmd..'(status) (.+)$',
		config.cmd..'(status)$',
		config.cmd..'(cache)$',
		config.cmd..'(msglink)$',
		
		config.cmd..'(user)$',
		config.cmd..'(user) (.*)',
		
		'^###cb:userbutton:(banuser):(%d+)$',
		'^###cb:userbutton:(remwarns):(%d+)$',
		'^###cb:(cc:rel):'
	}
}
