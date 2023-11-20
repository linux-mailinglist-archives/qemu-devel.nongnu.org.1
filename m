Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C34957F15B2
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 15:29:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r55GR-0005jF-4w; Mon, 20 Nov 2023 09:28:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r55GP-0005iu-1h; Mon, 20 Nov 2023 09:28:37 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r55GN-0001Cx-9i; Mon, 20 Nov 2023 09:28:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HiQffiJl1AP8TPNUTjOteOI5/9HmkBqogbFCA/PBfzE=; b=KhBHBqMqaiMxjvu1NruRV1MHvd
 urLIg7SJpYQc/VspJvPoMR52KTkCaMZX5kBmyldta5ru8tQE6PJKW2vbR/mBwlI2OTXkh67sIDShs
 FDjIpVIGKQ57x4W+wTMlAstQgHELNHQ5VOM7wWRZx8FvoDgyzXLgfXezNd46RZ07s1PCHVBNRCTNw
 WKkREoUtcHV/xL36CUiWoXWRBVqo9Qx3+t/ypbaGhZrZH7LJtcfj/9YbLcoWEgdT+zzSiV5wTeYKN
 1yf9Hanq1NaHNJMOee1cCcLyDYI9UsvjIAFcNOzNAxnjiCihNFkYrCQUsIu35UbCiQLEFDhhckvuS
 a4Bo4AeDCux+LtBc2iUFo0WmuACoH3/IFaMYcj+qm3H/T3Sa9BS31jXyTCO/kPlpipU2ZHf8swZFm
 j1KYTmNvGuxzygdtVNNsVGZTs67Ejd0OULPRij1Y5FW7Sppl5YnshMwO+adhL6NZLHJeL4pFWRUFs
 k02z9w1JF3jCJ9z/6LaCx8eRzc2gjO0671KwP89f+W5KMHS9KsLVr8UfAJPn32KMSVeU4c2C6Es++
 Aai1haPsdJgyOXX71bKSL+ODgqqt3Z5H1IE22aAE01i5Lo+B7DkIFG38jWCNwCVBvDeUSfGDZ+aTg
 CAypSDXud6uPN0aHQI2TtibbLedZeUB4nE99fg1Rk=;
Received: from host86-130-37-248.range86-130.btcentralplus.com
 ([86.130.37.248] helo=[10.8.0.6])
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r55G1-000Cg6-G2; Mon, 20 Nov 2023 14:28:17 +0000
Message-ID: <fad96d99-bbdc-4330-bf40-974eb745e2d3@ilande.co.uk>
Date: Mon, 20 Nov 2023 14:28:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: jsnow@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 philmd@linaro.org, shentey@gmail.com, Rene Engel <ReneEngel80@emailn.de>
References: <20231116103355.588580-1-mark.cave-ayland@ilande.co.uk>
 <c4bb80e8-e985-b6b2-aac1-f6e8d446b8ea@eik.bme.hu>
 <295aec31-e9c1-49d8-9bea-edad8f7b81e4@ilande.co.uk>
 <63ff9c1a-5d05-985a-bf2f-69420b72db90@eik.bme.hu>
 <ZVtiV8XXHxS+cw8o@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <ZVtiV8XXHxS+cw8o@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.248
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 0/4] ide: implement simple legacy/native mode switching
 for PCI IDE controllers
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 20/11/2023 13:42, Kevin Wolf wrote:

> Am 20.11.2023 um 14:09 hat BALATON Zoltan geschrieben:
>> On Mon, 20 Nov 2023, Mark Cave-Ayland wrote:
>>> On 19/11/2023 21:43, BALATON Zoltan wrote:
>>>> On Thu, 16 Nov 2023, Mark Cave-Ayland wrote:
>>>>> This series adds a simple implementation of legacy/native mode
>>>>> switching for PCI
>>>>> IDE controllers and updates the via-ide device to use it.
>>>>>
>>>>> The approach I take here is to add a new pci_ide_update_mode()
>>>>> function which handles
>>>>> management of the PCI BARs and legacy IDE ioports for each mode
>>>>> to avoid exposing
>>>>> details of the internal logic to individual PCI IDE controllers.
>>>>>
>>>>> As noted in [1] this is extracted from a local WIP branch I have
>>>>> which contains
>>>>> further work in this area. However for the moment I've kept it simple (and
>>>>> restricted it to the via-ide device) which is good enough for Zoltan's PPC
>>>>> images whilst paving the way for future improvements after 8.2.
>>>>>
>>>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>>>
>>>>> [1] https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg05403.html
>>>>>
>>>>> v3:
>>>>> - Rebase onto master
>>>>> - Move ide_portio_list[] and ide_portio_list2[] to IDE core to
>>>>> prevent duplication in
>>>>>   hw/ide/pci.c
>>>>> - Don't zero BARs when switching from native mode to legacy
>>>>> mode, instead always force
>>>>>   them to read zero as suggested in the PCI IDE specification
>>>>> (note: this also appears
>>>>>   to fix the fuloong2e machine booting from IDE)
>>>>
>>>> Not sure you're getting this, see also:
>>>> https://lists.nongnu.org/archive/html/qemu-devel/2023-11/msg04167.html
>>>> but this seems to break latest version of the AmigaOS driver for
>>>> some reason. I assume this is the BAR zeroing that causes this as it
>>>> works with v2 series and nothing else changed in v3 that could cause
>>>> this. Testing was done by Rene Engel, cc'd so maybe he can add more
>>>> info. It seems to work with my patch that sets BARs to legacy values
>>>> and with v2 that sets them to 0 but not with v3 which should also
>>>> read 0 but maybe something is off here.
>>>
>>> I've been AFK for a few days, so just starting to catch up on various
>>> bits and pieces.
>>
>> OK just wasn't sure if you saw my emails at all as it happened before that
>> some spam filters disliked my mail server and put messages in the spam
>> folder.
>>
>>> The only difference I can think of regarding the BAR zeroing is that the
>>> BMDMA BAR is zeroed here. Does the following diff fix things?
>>
>> This helps, with this the latest driver does not crash but still reads BAR4
>> as 0 instead of 0xcc00 so UDMA won't work but at least it boots.
> 
> And disabling only the first four BARs is actually what the spec says,
> too. So I'll make this change to the queued patches.

That was definitely something that I thought about: what should happen to BARs 
outside of the ones mentioned in the PCI IDE controller specification? It seems 
reasonable to me just to consider BARS 0-3 for zeroing here.

> If I understand correctly, UDMA didn't work before this series either,
> so it's a separate goal and doing it in its own patch is best anyway.
> 
> As we don't seem to have a good place to set a default, maybe just
> overriding it in via_ide_cfg_read(), too, and making it return 0xcc01 in
> compatibility mode is enough?

It's difficult to know whether switching to legacy mode on the via-ide device resets 
BAR4 to its default value, or whether it is simply left unaltered. For 8.2 I don't 
mind too much as long as the logic is separate from the BAR zeroing logic (which will 
eventually be lifted up into hw/ide/pci.c).


ATB,

Mark.


