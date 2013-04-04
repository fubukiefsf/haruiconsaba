# -*- coding: utf-8 -*-
require 'json'
require 'open-uri' 
Plugin.create(:haruiconsaba) do
	haruiconApiUri = "http://api.haruicon.com/?g="
	tOfh = "さん"
	tag = " #はるアイコン鯖 "
	command(
		:haruiconsaba,
		name: "はるアイコン鯖のログイン者をつぶやく",
		visible: false,
		icon: "#{File.dirname(__FILE__)}/haruicon.png",
		condition: lambda{|opt| true},
		role: :window
	 ) do |opt|
		Thread.new{
			twiIdInList = JSON.parse(open(haruiconApiUri + "twiIdInList").read)
			if twiIdInList['playerCount'] != 0
				mes = ""
				twiIdInList['idList'].each{|ids|
					mes += ids['mcId'] + tOfh
				}
				mes += "がインしています" + tag
				Post.primary_service.update(:message => mes)
			else	
				Post.primary_service.update(:message => "はるアイコン鯖に誰も居ないよ")
			end
		}
	end
end
