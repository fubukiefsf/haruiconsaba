# -*- coding: utf-8 -*-
require 'json'
require 'open-uri' 
Plugin.create(:haruiconsaba) do
	UserConfig[:haruiconsaba_to_system] ||= false
	haruiconApiUri = "http://api.haruicon.com/?g="
	tOfh = "さん"
	tag = " #はるアイコン鯖 "
	command(
		:haruiconsaba,
		name: "はるアイコン鯖のログイン者をつぶやく",
		visible: false,
		icon: "#{File.dirname(__FILE__)}/haruiconsaba.png",
		condition: lambda{|opt| true},
		role: :window
	 ) do |opt|
		Thread.new{
			twiIdInList = JSON.parse(open(haruiconApiUri + "twiIdInList").read)
			mes = ""
			if twiIdInList['playerCount'] != 0
				twiIdInList['idList'].each{|ids|
					mes += ids['mcId'] + tOfh
				}
				mes += "がインしています" + tag
			else	
				mes =  "はるアイコン鯖に誰も居ないよ"
			end
			
			Post.primary_service.update(:message => mes, :system => UserConfig[:haruiconsaba_to_system])
		}
	end

	settings "はるアイコン鯖" do
		boolean "ログイン情報をシステムメッセージで表示", :haruiconsaba_to_system
	end
end
