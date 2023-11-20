Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F7A7F1581
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 15:17:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r553y-0001sf-H5; Mon, 20 Nov 2023 09:15:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r553U-0001ot-FD; Mon, 20 Nov 2023 09:15:17 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r553S-0006Ny-AK; Mon, 20 Nov 2023 09:15:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jJcb3rCVfRSZixhj998bSkkDkhDx4fIQ+xfKT87GFs4=; b=QpaJseEYtrLrJgpWdtMYKQq1O5
 apxhPXLNBqE3RNcpwqpKBjqW0200P15dcfq0drwUAvEGNNhv6iUFuJ3ahvKa3JftSfmOnwTSwOW9h
 7a1PHr8zgKc9K0zQE3Jo1TldB9tYQ9cdwhmpNwWqiLhJCVytGQmtgMvqy34p0ZupGFhLsV+QlVsVu
 rTyA40UIF6CzgJ6Dmn1NLhXN9pk7gdnEsPZWGjNh8ohgJFvlH3IaxQb+RBKd9uQJ+BnSXUWxjGXJt
 BbSBvD2yBmteyer+fVEJun3RfN8YfBiRf5QZEPY+t2A5GUMOWhBMMrBCfPdom/Bl2TzhMM42f2aoz
 0ovKTCV8FpGtjsKuYAxO7ZBwMagJUiPwkILM9w+fC3tzBWl87pcXVIROKqfYmhePch1/N4fH1Q0nF
 S5r8WeXHG2Gcmdro74WiNlpoTozwm8YTVsTglUHmTtdNHXNJbSGGczjBcHrJt6Atfebs06R0wNJWy
 AWXDjZiISmy1Y1fhgORRws2/wD7+7JfHtDBFGhrt7eG7/rJZTfJs0Iw/Jh0KeUbRK5qFsZN0T0HAn
 xAjJj/8RRPeVAs00qKc6FObtBW/vDePzpS3mCFmioGmlF+JT53G+UuqN5U4AZJ0kbjzAloLJsp7uN
 P92QEqqVbykI167Up630GQhvgSooyGWO5J6cY8dik=;
Received: from host86-130-37-248.range86-130.btcentralplus.com
 ([86.130.37.248] helo=[10.8.0.6])
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r5534-000CaW-UJ; Mon, 20 Nov 2023 14:14:55 +0000
Message-ID: <b61f2cce-068f-4130-8c0d-fea80e7026d1@ilande.co.uk>
Date: Mon, 20 Nov 2023 14:15:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, philmd@linaro.org, shentey@gmail.com,
 Rene Engel <ReneEngel80@emailn.de>
References: <20231116103355.588580-1-mark.cave-ayland@ilande.co.uk>
 <c4bb80e8-e985-b6b2-aac1-f6e8d446b8ea@eik.bme.hu>
 <6e7576bd-ac39-424e-ac7e-898c58a6a2fa@ilande.co.uk>
 <3c442b7f-4f9e-5adf-e576-8f2930834bd3@eik.bme.hu>
 <a0a01470-c059-6a0f-21af-32ed43357c25@eik.bme.hu>
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
In-Reply-To: <a0a01470-c059-6a0f-21af-32ed43357c25@eik.bme.hu>
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

On 20/11/2023 13:30, BALATON Zoltan wrote:

> On Mon, 20 Nov 2023, BALATON Zoltan wrote:
>> On Mon, 20 Nov 2023, Mark Cave-Ayland wrote:
>>> On 19/11/2023 21:43, BALATON Zoltan wrote:
>>>> On Thu, 16 Nov 2023, Mark Cave-Ayland wrote:
>>>>> This series adds a simple implementation of legacy/native mode switching for PCI
>>>>> IDE controllers and updates the via-ide device to use it.
>>>>>
>>>>> The approach I take here is to add a new pci_ide_update_mode() function which 
>>>>> handles
>>>>> management of the PCI BARs and legacy IDE ioports for each mode to avoid exposing
>>>>> details of the internal logic to individual PCI IDE controllers.
>>>>>
>>>>> As noted in [1] this is extracted from a local WIP branch I have which contains
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
>>>>> - Move ide_portio_list[] and ide_portio_list2[] to IDE core to prevent 
>>>>> duplication in
>>>>>  hw/ide/pci.c
>>>>> - Don't zero BARs when switching from native mode to legacy mode, instead always 
>>>>> force
>>>>>  them to read zero as suggested in the PCI IDE specification (note: this also 
>>>>> appears
>>>>>  to fix the fuloong2e machine booting from IDE)
>>>>
>>>> Not sure you're getting this, see also:
>>>> https://lists.nongnu.org/archive/html/qemu-devel/2023-11/msg04167.html
>>>> but this seems to break latest version of the AmigaOS driver for some reason. I 
>>>> assume this is the BAR zeroing that causes this as it works with v2 series and 
>>>> nothing else changed in v3 that could cause this. Testing was done by Rene Engel, 
>>>> cc'd so maybe he can add more info. It seems to work with my patch that sets BARs 
>>>> to legacy values and with v2 that sets them to 0 but not with v3 which should 
>>>> also read 0 but maybe something is off here.
>>>
>>> Is this document here accurate as to how it works on real hardware? 
>>> https://intuitionbase.com/hints.php.
>>
>> That should be about right. On QEMU the U-boot env vars won't work because NVRAM is 
>> not emulated yet so they can't be saved but you can call idetool from 
>> startup-sequence boot script instead for same effect (UDMA is enabled a bit later 
>> with that but after that it's the same).
>>
>>> I can't understand why the base OS is attempting any access to BAR 4 if BMDMA 
>>> isn't enabled by default on real hardware due to hardware bugs.
>>
>> Real hardware had problems with DMA (the VIA chip was also infamous for it on PC 
>> hardware and later also the ArticiaS was found to have its own problems) so the 
>> default is to use IDE in PIO mode and UDMA has to be enabled manually. But if it 
>> works (and it should on QEMU) it's much faster so we want to enable it.
>>
>>> Are we sure that the idetool hacks given in the link above to enable BMDMA haven't 
>>> already been run on the AmigaOS install when testing an earlier version of the 
>>> patches?
>>
>> It was tested with my original series and works with that as my patch sets the 
>> default vaules for BARs and the driver reads it correctly. Then we tested your 
>> series too and I've noted for v2 already that it misses the degault value for BAR4. 
>> Other BARs don't matter as it will apparently use ISA IDE ports when it gets 0 or 
>> it knows that in legacy mode these shoud be the port values but seems to read BAR4 
>> for UDMA and only works if the right default value is there, otherwise it lists DMA 
>> BAR 0 on start.
> 
> This probably wasn't clear so what I mean is:
> 
> a1ide.device 53.22 (28.6.2017)
> [a1ide/dev_init] Found chip #0
> [a1ide/init_port] ---> Port 0
> [a1ide/init_port] IOBase 000001F0, AltBase 000003F6
> [a1ide/init_port] bmcr_base 0000CC00
> [a1ide/init_port] MMIOBase 00000000
> 
> This is with my patch: 
> https://patchew.org/QEMU/cover.1697661160.git.balaton@eik.bme.hu/4095e01f4596e77a478759161ae736f0c398600a.1697661160.git.balaton@eik.bme.hu/ With yours bmcr_base is 0 and then when enabling UDMA with idetool it hangs as it needs this value from BAR4.

Right, so what you're saying is that AmigaOS will run fine with the v3 series 
out-of-the-box, but only fails when you try and enable UDMA with idetool (which is 
explicitly changing the configuration from the AmigaOS default)?


ATB,

Mark.


