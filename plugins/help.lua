local function get_helped_string(key)
	if key == 'private' then
		return _([[
سلام *%s* 👋🏼, ازملاقاتت خوشحالم!
من مستر بات هستم یک نگهبان همیشه آنلاین برای گروهتون کافیه منو اد کنید تو گروهتون و منو مدیر کنید.
]])
	elseif key == 'all' then
		return _([[
*دستورات برای همه*:
`/dashboard` : با ارسال این دستور در گروه یک منو به خصوصی شما ارسال میشه که میتونید اونو تنظیم کنید
`/rules` : با ارسال این دستور در گروه قوانین گروه برای شما نشان داده میشود
`/adminlist` : با ارسال این دستور در گروه لیست تمامی مدیران گروه نمایش داده میشود
`/kickme` :با ارسال این دستور در گروه شما از گروه اخراج میشید
`/echo [text]` : با ارسال این دستور در گروه متن شما نشانه دار میشود
`/info` : با ارسال این دستور برخی اطلاعات مفید در مورد ربات نشان داده میشود
`/groups` : با ارسال این دستور لیست گروه های موجود نمایش داده میشود
`/help` : با ارسال این دستور همین پیغام نشان داده میشه
]])
	elseif key == 'mods_info' then
		return _([[
*درباره گروه: مدیران*

`/setrules [group rules]` = با ارسال این دستور در گروه قوانین برای گروه تنظیم میشه
`/setrules -` =با ارسال این دستور در گروه قوانین موجود حذف میشه.

*نکته: اگه تو این قسمت مشکلی داشتید*
, میتونید [این پست](https://telegram.me/antispamer/3)
روبخونید.
`/setlink [link|-]`: با ارسال این دستور در گروه لینک گروه رو میتونید تنظیم کنید.
`/link`: با ارسال این مطلب در گروه لینک گروه نمایش داده میشود.
`/msglink`: با ارسال این دستور فقط در سوپر گروه ها میتونید لینک پیام مورد نظر رو دریافت کنید

*نکته: ربات فقط میتواند لینک گروه های معتبر رو تشخیص دهد اگه معتبر نباشه پیامی دریافت نمیکنید*
]])
	elseif key == 'mods_banhammer' then
		return _([[
*مسدودکردن: مدیران*

`/kick [by reply|username|id|text mention]` = با ریپلای کردن این دستور روی شخص مورد نظر میتونید اونو از گروه اخراج کنید.
`/ban [by reply|username|id|text mention]` = با ریپلای کردن این دستور روی شخص مورد نظر میتونید اونو از گروه مسدود کنید.
`/tempban [hours|nd nh]` = با ریپلای کردن این دستور روی شخص مورد نظر میتونید اونو از گروه مسدود کنید با این تفاوت که میتونید براش زمان تعیین کنید. مثال: `/tempban 1d 7h`
`/unban [by reply|username|id|text mention]` = با ریپلای کردن این دستور روی شخص مورد نظر میتونید اونو از مسدود بودن خارج کنید.
`/user [by reply|username|id|text mention]` = با ریپلای کردن این دستور روی فردی که بهش اخطار دادید میتونید اخطار هاشو کم کنید.
`/status [username|id]` =وضعیت و آمار گروه `(member|kicked/left the chat|banned|admin/creator|never seen)`
]])
	elseif key == 'mods_flood' then
		return _([[
*تنظیمات اسپم: مدیران*

`/config`*با ارسال این دستور در گروه ربات فعال میشه و منوی تنظیمات گروهو براتون میفرسته خصوصی و شما روی گزینه ضد اسپم باید کلیک کنید.*
`/antiflood [number]` = با ارسال این دستور در گروه میتونید حساسیت اسپم رو بالا ببرید و کسایی که تو پنج ثانیه پشت هم پیام بدن از گروه اخراج میکنه
_نکته: تعداد هم باید بالای سه و زیر بیست و شش باشد_
]])
	elseif key == 'mods_media' then
		return _([[
*تنظیمات رسانه: مدیران*

`/config` دکمه, دستور `media` = این دستورهمانطور که گفته شد منوی تنظیمات گروهو براتون در خصوصی میفرسته و شما باید گزینه رسانه رو انتخاب کنید.
`/warnmax media [number]` = میتونید سقف اخطار برای هر رسانه رو تنظیم کنید.
`/nowarns` = تنظیم مجدد اخطار برای هر کاربر.

*لیست رسانه های مجاز*: 
_عکس, آهنگ, ویدیو, استیکر, گیف, صدا, مخطب, فایل, لینک, لینک های تلگرامی_
]])
	elseif key == 'mods_welcome' then
		return _([[
*تنظیمات خوش آمد: مدیران*

`/config`= ابتدا این دستورو در گروه بفرستید بعد ربات یک پیام به خصوصی شما میده و روی دکمه ولکام کلیک کنید.

*پیام های سفارشی خوش آمد*:
`/welcome Welcome $name, enjoy the group!`
باید دستورو این شکلی بنویسید `/welcome` شما میتونید از گزینه های زیر هم برای پیام خوش آمد استفاده کنید. پیام خوش آمد شما
فقط باید بعد از دستور ولکام بزاریدشون:
`$username`: _نام کاربری فرد را در گروه نمایش میده_
`$name`: _نام فرد رو در گروه نشون میده_
`$id`: _شناسه را در گروه نمایش میدهد_
`$title`: _نام گروه رو نشون میده_
`$surname`: _فامیلی فرد رو نشون میده در گروه_
`$rules`:در گروه قوانین رو نشون میده
_مشکلی پیش اومد به مدیر پیام بده _ [مدیر ربات](https://telegram.me/javad7070) _اگه انلاین نبود کمی صبر کنید بزودی جوابتونو میده_

*پیام خوش آمد با استیکر وگیف*
شما میتونید از گیف و استیکر هم به عنوان پیام خوش آمد استفاده کنید برای این کار اول دستور ولکام رو تایپ کنید سپس روی استیکر وگیف مورد نظر ریپلای کنید `/welcome`
]])
	elseif key == 'mods_extra' then
		return _([[
*دستورات تگ: مدیران*

`/extra [#trigger] [reply]` = با ارسال این دستور در گروه رسانه یا پیغام مورد نظر خود را تگ کنید.
_مثال_ :"`/extra #hello Good morning!`".
شما میتونید هر رسانه ای از قبیل 
(_عکس, فایل, صدا, ویدیو, گیف, آهنگ_) با دستور `/extra #yourtrigger` تگ و ذخیره کنید 
`/extra list` = با ارسال این دستور در گروه لیست پیام ها یا رسانه هایی که تگ کردید نشون داده میشه.
`/extra del [#trigger]` = با ارسال این دستور درگروه میتونید تگ های مورد نظر رو حذف کنید.

به مدیر پیام بدید, اگه مشکلی دارید [مدیر ربات](https://telegram.me/cpp_cs).
]])
	elseif key == 'mods_warns' then
		return _([[
*اخطارها: مدیران*

`/warn` = با ریپلای کردن این دستور روی فرد مورد نظر اونو از گروه اخراج کنید.
`/nowarns` = با ریپلای کردن این دستور وری فرد مورد نظر اونو از گروه مسدود کنید.
`/warnmax [number]` = با ارسال این دستور درگروه میتونید سقف اخطارات برای مسدود و اخراج کردن تنظیم کنید.
`/warnmax media [number]` = با ارسال این دستور درگروه میتونید سقف اخطارات برای ارسال رسانه رو تنظیم کنید.


]])
	elseif key == 'mods_chars' then
		return _([[
*شخصیت های خاص: مدیران*

`/config` = با ارسال این دستور در گروه ربات یک پیام به خصوصی شما میفرسته و از اون پیامی که براتون فرستاده گزینه منو رو انتخاب کنید.
دو گزینه خاص این قسمت: _Arab and RTL_.

*Arab*:وقتی عرب آن مجاز نیست (🚫)، اگر یک شخصیت عرب در گروه باشد و چیزی ارسال کنید که به زبان عربی باشد از گروه اخراج میشود.
*Rtl*: پیام را برای گیرندگان چپ دست به سمت راست میاره.
وقتی این گزینه غیرمجاز باشد(🚫), فرد از گروه اخراج میشود.
]])
	elseif key == 'mods_pin' then
		return _([[
*سنجاق: مدیران*

`/pin [text]`: با ارسال این دستور درگروه پیام مورد نظر شما سنجاق گروه میشود`/editpin [new text]` با این دستورم میتونید اونو ویرایش کنید
`/editpin [new text]`: با ارسال این دستور میتونید پیامی که از قبل سنجاق شده ویرایش کنید
`/pin`: با این دستور ربات اونو پیدا میکنه `/pin [text]`, اگه هنوز پیام وجود داشته باشه

*نکته*: `/pin` and `/editpin` این دستورات پشتیبانی میشود`$rules` 
در قوانین گروه
]])
	elseif key == 'mods_langs' then
		-- TRANSLATORS: leave your contact information for reports mistakes in translation
		return _([[
*زبان گروه: مدیران*"
`/lang` = با ارسال این دستور درگروه لیست زبان های موجود برای شما ارسال میشه و میتونید زبان دلخواه رو انتخاب کنید.

*نکته: ما همواره در حال اضافه کردن زبان های جدید هستیم*

اگه زبانی دوست داشتید که در ربات نبود بما اطلاع دهید [مدیر ربات](https://telegram.me/cpp_cs) .
شما میتوانید دستور `/strings` ارسال کنید و فاایل `.po` مورد نظر رو درافت کنید و اونو ترجمه کنید
]])
	elseif key == 'mods_settings' then
		return _([[
*تنظیمات گروه: مدیران*

`/config` = طبق گفته هامون با ارسال این دستور یک پیام ربات به خصوصی شما میده و شما از بخش اطلاعات گروه میتونید کاراتونو انجام بدید.


*منو: بخش مهم ترین تنظیمات گروه*
*ضداسپم: بخش خاموش یا روشن کردن اسپم و تنظیم حسایت آن*
*رسانه: بخش غیرمجاز یا مجاز کردن رسانه های مختلف*
]])
	else
		error('bad key')
	end
end

local function make_keyboard(mod, mod_current_position)
	local keyboard = {}
	keyboard.inline_keyboard = {}
	if mod then --extra options for the mod
	    local list = {
	        [_("مسدود کردن")] = 'banhammer',
	        [_("اطلاعات گروه")] = 'info',
	        [_("اسپم")] = 'flood',
	        [_("تنظیمات رسانه")] = 'media',
	        [_("خوش آمدگویی")] = 'welcome',
	        [_("تنظیمات عمومی")] = 'settings',
	        [_("دستورات تگ")] = 'extra',
	        [_("اخطارها")] = 'warns',
	        [_("شخصیت ها")] = 'char',
	        [_("سنجاق")] = 'pin',
	        [_("زبان")] = 'lang'
        }
        local line = {}
        for k,v in pairs(list) do
            if next(line) then
                local button = {text = '📍'..k, callback_data = v}
                --change emoji if it's the current position button
                if mod_current_position == v then button.text = '💡 '..k end
                table.insert(line, button)
                table.insert(keyboard.inline_keyboard, line)
                line = {}
            else
                local button = {text = '📍'..k, callback_data = v}
                --change emoji if it's the current position button
                if mod_current_position == v:gsub('!', '') then button.text = '💡 '..k end
                table.insert(line, button)
            end
        end
        if next(line) then --if the numer of buttons is odd, then add the last button alone
            table.insert(keyboard.inline_keyboard, line)
        end
    end
    local bottom_bar
    if mod then
		bottom_bar = {{text = _("🔰 دستورات کاربر"), callback_data = 'user'}}
	else
	    bottom_bar = {{text = _("🔰 دستورات مدیر"), callback_data = 'mod'}}
	end
	table.insert(bottom_bar, {text = _("اطلاعات"), callback_data = 'fromhelp:about'}) --insert the "Info" button
	table.insert(keyboard.inline_keyboard, bottom_bar)
	return keyboard
end

local function do_keyboard_private()
    local keyboard = {}
    keyboard.inline_keyboard = {
    	{
    		{text = _("👥 منو در گروه اد کن"), url = 'https://telegram.me/'..bot.username..'?startgroup=new'},
    		{text = _("📢 کانال ربات"), url = 'https://telegram.me/'..config.channel:gsub('@', '')},
	    },
	    {
	        {text = _("📕 تمامی دستورات"), callback_data = 'user'}
        }
    }
    return keyboard
end

local function do_keyboard_startme()
    local keyboard = {}
    keyboard.inline_keyboard = {
    	{
    		{text = _("من را استارت کن"), url = 'https://telegram.me/'..bot.username}
	    }
    }
    return keyboard
end

local action = function(msg, blocks)
    -- save stats
    if blocks[1] == 'start' then
        if msg.chat.type == 'private' then
            local message = get_helped_string('private'):format(msg.from.first_name:escape())
            local keyboard = do_keyboard_private()
            api.sendKeyboard(msg.from.id, message, keyboard, true)
        end
        return
    end
    if blocks[1] == 'help' then
    	if msg.chat.type == 'private' then
			local keyboard = make_keyboard()
			api.sendKeyboard(msg.from.id, get_helped_string('all'), keyboard, true)
        end
    end
    if msg.cb then
        local query = blocks[1]
        local text
        if query == 'info_button' then
            local keyboard = do_keybaord_credits()
		    api.editMessageText(msg.chat.id, msg.message_id, _("مفید *لینک های*:"), keyboard, true)
		    return
		end
        local with_mods_lines = true
        if query == 'user' then
            text = get_helped_string('all')
            with_mods_lines = false
        elseif query == 'mod' then
            text = _("_منوی آموزش گاردگروپ:برای دیدن آموزش ها روی دکمه مورد نظر کلیک کنید_")
        elseif query == 'info' then
        	text = get_helped_string('mods_info')
        elseif query == 'banhammer' then
        	text = get_helped_string('mods_banhammer')
        elseif query == 'flood' then
        	text = get_helped_string('mods_flood')
        elseif query == 'media' then
        	text = get_helped_string('mods_media')
        elseif query == 'welcome' then
        	text = get_helped_string('mods_welcome')
        elseif query == 'extra' then
        	text = get_helped_string('mods_extra')
        elseif query == 'warns' then
        	text = get_helped_string('mods_warns')
        elseif query == 'char' then
        	text = get_helped_string('mods_chars')
        elseif query == 'pin' then
        	text = get_helped_string('mods_pin')
        elseif query == 'lang' then
        	text = get_helped_string('mods_langs')
        elseif query == 'settings' then
        	text = get_helped_string('mods_settings')
        end
        local keyboard = make_keyboard(with_mods_lines, query)
        local res, code = api.editMessageText(msg.chat.id, msg.message_id, text, keyboard, true)
        if not res and code and code == 111 then
            api.answerCallbackQuery(msg.cb_id, _("❗️ درحال حاضر در این برگه میباشید"))
		elseif query == 'info' then
			api.answerCallbackQuery(msg.cb_id, _("💡 اطلاعات گروه: مدیران"))
		elseif query == 'banhammer' then
			api.answerCallbackQuery(msg.cb_id, _("💡 مسدودکردن: مدیران"))
		elseif query == 'flood' then
			api.answerCallbackQuery(msg.cb_id, _("💡 اسپم: مدیران"))
		elseif query == 'media' then
			api.answerCallbackQuery(msg.cb_id, _("💡 تنظیمات رسانه: مدیران"))
		elseif query == 'pin' then
			api.answerCallbackQuery(msg.cb_id, _("💡 سنجاق: مدیران"))
		elseif query == 'lang' then
			api.answerCallbackQuery(msg.cb_id, _("💡 زبان: مدیران"))
		elseif query == 'welcome' then
			api.answerCallbackQuery(msg.cb_id, _("💡 خوش آمدگویی: مدیران"))
		elseif query == 'extra' then
			api.answerCallbackQuery(msg.cb_id, _("💡 دستورات تگ: مدیران"))
		elseif query == 'warns' then
			api.answerCallbackQuery(msg.cb_id, _("💡 اخطارها: مدیران"))
		elseif query == 'char' then
			api.answerCallbackQuery(msg.cb_id, _("💡 شخصیت ها: مدیران"))
		elseif query == 'settings' then
			api.answerCallbackQuery(msg.cb_id, _("💡 تنظیمات عمومی: مدیران"))
        end
    end
end

return {
	action = action,
	admin_not_needed = true,
	triggers = {
	    config.cmd..'(start)$',
	    config.cmd..'(help)$',
	    '^###cb:(user)$',
	    '^###cb:(mod)$',
	    '^###cb:(info)$',
	    '^###cb:(banhammer)$',
	    '^###cb:(flood)$',
	    '^###cb:(media)$',
	    '^###cb:(pin)$',
	    '^###cb:(lang)$',
	    '^###cb:(welcome)$',
	    '^###cb:(extra)$',
	    '^###cb:(warns)$',
	    '^###cb:(char)$',
	    '^###cb:(settings)$',
    }
}
