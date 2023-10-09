Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D815B7BED65
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 23:30:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpxol-0003AY-0s; Mon, 09 Oct 2023 17:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qpxoi-0003A1-P3; Mon, 09 Oct 2023 17:29:32 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qpxof-0000zZ-DP; Mon, 09 Oct 2023 17:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ka4H0CT3VT2JcVsLj6lxQmtxMYvQ1HGdDxN98rjZHnQ=; b=hMji0nBACma/SVVNBo3r1n0OD7
 hnhetp/JxJHlnq7C4Z3Zw1cYgagVWvITaetIP8xq/mlqW7WCW95KpFGTvWzfw8zmx79FjhnDszsOd
 eKm/FGw8nhs0uXuao1odzN+GPhFj/kSOpt/XpEduZ/+O5YJbWj1C/XvOJO9sdRCctcuFfiED+os6H
 LwIjiVPxwBHQzXBy20hkJdcIQp/vf1pCWoV8CYyCwc4EtoO9VzV4dbzkCrq3E0pRsJYM2BPajP1xb
 m3s27HBbxxEmp6mQcbG4Q14GchrvmpMjVrV9MlxMKDGh5kvjOKIHowdUlFHuUzZSTcCHHAcc99NTJ
 UyvodX+AD5yXkrxnYG+CEdjt6vAQuk1pD0EqHqPhCwVg5mv0z95u3v5rM8CZX6KrvwPUDfvVw515x
 Hw1WH7AY2SlEsZSk4CXexv33s84PTm/y2nxKSWDDOVgW2WgPbYLQdSSeAn2oPJSdAYCw9gP8qPRM2
 bmdzw8/+tKZ7T+wVmhX1MX5yxAdkQdRaQlIGYzGBr1wg8GfhPnY41GHsSXhD8XA5ozpTUpskAjdK3
 blEh8Wo9q6p0cEotb3X6Yh5mypNNRYA8ElQ6We7FKehCezuAkji3B5X8jzdP+H9z7n32a/W1m8mRX
 /fDB8AicKjYu1vSLW43A7DjmVzB8I58SQmJYTV/xc=;
Received: from [2a00:23c4:8baf:fd00:bd92:8220:89aa:44b7]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qpxoW-0005qU-JS; Mon, 09 Oct 2023 22:29:24 +0100
Message-ID: <881c3003-9e20-4f35-961e-976134b1afc7@ilande.co.uk>
Date: Mon, 9 Oct 2023 22:29:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org,
 philmd@linaro.org, Bernhard Beschow <shentey@gmail.com>,
 Rene Engel <ReneEngel80@emailn.de>, vr_qemu@t-online.de
References: <cover.1696542537.git.balaton@eik.bme.hu>
 <12ce9caa682545cd43318c4679530202140117c0.1696542537.git.balaton@eik.bme.hu>
 <33347356-be91-4dde-8535-5a59ee1c80f1@ilande.co.uk>
 <a7821bf0-5d1f-ddda-f408-f4cd0432ddbf@eik.bme.hu>
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
In-Reply-To: <a7821bf0-5d1f-ddda-f408-f4cd0432ddbf@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8baf:fd00:bd92:8220:89aa:44b7
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 1/3] via-ide: Fix legacy mode emulation
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 08/10/2023 12:08, BALATON Zoltan wrote:

> On Sun, 8 Oct 2023, Mark Cave-Ayland wrote:
>> On 05/10/2023 23:13, BALATON Zoltan wrote:
>>
>>> The initial value for BARs were set in reset method for emulating
>>> legacy mode at start but this does not work because PCI code resets
>>> BARs after calling device reset method.
>>
>> This is certainly something I've noticed when testing previous versions of the VIA 
>> patches. Perhaps it's worth a separate thread to the PCI devs?
> 
> I think I brought up this back then but was told current PCI code won't change and 
> since that could break everything else that makes sense so this is something that we 
> should take as given and accomodate that.

I don't remember the details of that thread, but that's not too much of an issue here 
as the values won't be used.

>>> Additionally the values
>>> written to BARs were also wrong.
>>
>> I don't believe this is correct: according to the datasheet the values on reset are 
>> the ones given in the current reset code, so even if the reset function is 
>> overridden at a later data during PCI bus reset, I would leave these for now since 
>> it is a different issue.
> 
> Those values are missing the IO space bit for one so they can't be correct as a BAR 
> value no matter what the datasheet says. And since they are ineffective now I think 
> it's best to remove them to avoid confusion.

Maybe, or perhaps just fix up the missing IO space bit and add a comment pointing out 
these are the defaults, but currently they are erased on PCI bus reset? I have found 
it useful to have the values around to save having to reference the datasheet.

>>> Move setting the BARs to a callback on writing the PCI config regsiter
>>> that sets the compatibility mode (which firmwares needing this mode
>>> seem to do) and fix their values to program it to use legacy port
>>> numbers. As noted in a comment, we only do this when the BARs were
>>> unset before, because logs from real machine show this is how real
>>> chip works, even if it contradicts the data sheet which is not very
>>> clear about this.
>>>
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>>   hw/ide/via.c | 35 ++++++++++++++++++++++++++++++-----
>>>   1 file changed, 30 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/hw/ide/via.c b/hw/ide/via.c
>>> index fff23803a6..8186190207 100644
>>> --- a/hw/ide/via.c
>>> +++ b/hw/ide/via.c
>>> @@ -132,11 +132,6 @@ static void via_ide_reset(DeviceState *dev)
>>>       pci_set_word(pci_conf + PCI_STATUS, PCI_STATUS_FAST_BACK |
>>>                    PCI_STATUS_DEVSEL_MEDIUM);
>>>   -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_0, 0x000001f0);
>>> -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_1, 0x000003f4);
>>> -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_2, 0x00000170);
>>> -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_3, 0x00000374);
>>> -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_4, 0x0000cc01); /* BMIBA: 20-23h */
>>>       pci_set_long(pci_conf + PCI_INTERRUPT_LINE, 0x0000010e);
>>>         /* IDE chip enable, IDE configuration 1/2, IDE FIFO Configuration*/
>>> @@ -159,6 +154,35 @@ static void via_ide_reset(DeviceState *dev)
>>>       pci_set_long(pci_conf + 0xc0, 0x00020001);
>>>   }
>>>   +static void via_ide_cfg_write(PCIDevice *pd, uint32_t addr,
>>> +                              uint32_t val, int len)
>>> +{
>>> +    pci_default_write_config(pd, addr, val, len);
>>> +    /*
>>> +     * Only set BARs if they are unset. Logs from real hardware show that
>>> +     * writing class_prog to enable compatibility mode after BARs were set
>>> +     * (possibly by firmware) it will use ports set by BARs not ISA ports
>>> +     * (e.g. pegasos2 Linux does this and calls it non-100% native mode).
>>
>> Can you remind me again where the references are to non-100% native mode? The only 
>> thing I can find in Linux is 
>> https://github.com/torvalds/linux/blob/master/arch/powerpc/platforms/chrp/pci.c#L360 but that simply forces a switch to legacy mode, with no mention of "non-100% native mode".
> 
> It was discussed somewhere in the via-ide thread we had when this was last touched 
> for pegasos2 in March 2020. Basically the non-100% native mode is when ports are set 
> by BARs but IRQs are still hard coded to 14-15. Linux can work with all 3 possible 
> modes: legacy (both ports and IRQs are hard coded to ISA values), native (using BARs 
> and PCI config 0x3c for a single interrupt for both channels, vt82c686 data sheet 
> does not document this but vt8231 has a comment saying native mode only) and non-100% 
> native mode where BARs are effective to set port addresses but IRQs don't respect 
> 0x3c but use 14-15 as in legacy mode. Some machines only work in non-100% native mode 
> such as pegasos2 and Linux has some quirks for this. Other OSes running on this 
> machine work with what the firmware has set up and can't work with anything else so 
> we need to emulate what those OSes want (which matches real hardware) because Linux 
> can usually cope anyway. On pegasso2 MorphOS uses BARs but expects IRQ 14-15 which is 
> what the firmware also sets up by setting mode to native in the PCI config of the IDE 
> func yet IRQs are fixed at 14-15. Linux forces its driver to use legacy interrupts by 
> setting mode back to legacy but it still uses BARs and this is what it calls non-100% 
> native mode. On amigaone firmware sets legacy mode and AmigaOS does not change this 
> but uses it with legacy ports and IRQs. Linux finds the same and uses legacy mode on 
> amigaone.

Thanks for summarising: there have been a number of threads and changes over the 
years, so it is easy to lose track of where things are. From the above then 
everything except MorphOS that explicitly sets legacy/native mode should just work?

Just to double check I don't think we ever managed to get the PCI configuration 
information from real hardware to confirm how the hardware thinks it is set? Is it 
possible to dump the PCI config space of the PCI-ISA bridge and the VIA IDE from a 
real Pegasos2 booted into Smart Firmware? You can get the information using the Forth 
below:


: dump-single-config ( addr )
   dup 100 + swap do i u. " : " type i " config-b@" $call-parent u. cr loop
;

" /pci@80000000/isa@C" open-dev to my-self
800 c * 100 0 * + dump-single-config cr cr
800 c * 100 1 * + dump-single-config cr cr


With the corresponding MorphOS debug log that will help to confirm the routing being 
used. Also it would be useful to get the output of any MorphOS program that can dump 
the current kernel IRQ routing configuration.

The reason for wanting to double-check this now is because my work with the Mac q800 
machine showed that both legacy and modern IRQ routing worked, so it would be good to 
confirm exactly what IRQ is currently active on real hardware.

>>> +     * But if 0x8a is written after reset without setting BARs then we want
>>> +     * legacy ports (this is done by AmigaOne firmware for example).
>>> +     */
>>
>> What should happen here is that writing 0x8a should *always* switch to legacy mode, 
>> so the BARs are unused...
> 
> Yes, but as we've found before that can't be emulated in QEMU due to ISA emulation 
> being static and only allows adding ports but not removing them later

Fortunately this bug has been fixed, so it should now be possible using 
portio_list_*() functions: see 
https://gitlab.com/qemu-project/qemu/-/commit/690705ca0b0f1ed24a34ccd14c9866fbe47c69a6. 
With that (and a bit of refactoring to allow the sharing of the IDE ioport list) I 
was able to switch between compatibility and native modes at will in my PoC. Once 
that is working then it doesn't matter if the default BARs aren't set correctly.

> so we can't 
> switch between legacy ISA and PCI here so we use the BARs for legacy ports as well to 
> emulate that. The reason we only do this if BARs are not yet set is because Linux 
> changes this back to legacy mode on pegasos2 but still uses BARs as shown in boot 
> logs from real hardware so it seems BARs take priority over legacy mode on real chip 
> and Linux only uses the mode reg to decide what IRQs to use. On amigaone firmware 
> writes 0x8a right after reset in which case we want legacy mode so this works for 
> both machines.
> 
>>> +    if (addr == PCI_CLASS_PROG && val == 0x8a &&
>>> +        pci_get_long(pd->config + PCI_BASE_ADDRESS_0) ==
>>> +        PCI_BASE_ADDRESS_SPACE_IO) {
>>> +        pci_set_long(pd->config + PCI_BASE_ADDRESS_0, 0x1f0
>>> +                     | PCI_BASE_ADDRESS_SPACE_IO);
>>> +        pci_set_long(pd->config + PCI_BASE_ADDRESS_1, 0x3f6
>>> +                     | PCI_BASE_ADDRESS_SPACE_IO);
>>> +        pci_set_long(pd->config + PCI_BASE_ADDRESS_2, 0x170
>>> +                     | PCI_BASE_ADDRESS_SPACE_IO);
>>> +        pci_set_long(pd->config + PCI_BASE_ADDRESS_3, 0x376
>>> +                     | PCI_BASE_ADDRESS_SPACE_IO);
>>> +        /* BMIBA: 20-23h */
>>> +        pci_set_long(pd->config + PCI_BASE_ADDRESS_4, 0xcc00
>>> +                     | PCI_BASE_ADDRESS_SPACE_IO);
>>> +    }
>>> +}
>>
>> ... but what you're doing here is effectively forcing the PCI BARs to the legacy 
>> addresses. The reason we know this is because that is why you have the off-by-2 
>> error in BARs 1 and 3.
>>
>> I could live with this approach for now if you're willing to adjust the comments 
>> accordingly clarifying that forcing the PCI BARs to the legacy addresses is a hack 
>> to be replaced in future with proper legacy ioports. At some point I will revive my 
>> PoC series on top of Bernhard's last series that implements this properly.
> 
> That's fair enoough, I can try to clarify thid more in the comments and commit 
> message. I'll try to come up with something for v2.
> 
> Regards,
> BALATON Zoltan
> 
>>>   static void via_ide_realize(PCIDevice *dev, Error **errp)
>>>   {
>>>       PCIIDEState *d = PCI_IDE(dev);
>>> @@ -221,6 +245,7 @@ static void via_ide_class_init(ObjectClass *klass, void *data)
>>>       /* Reason: only works as function of VIA southbridge */
>>>       dc->user_creatable = false;
>>>   +    k->config_write = via_ide_cfg_write;
>>>       k->realize = via_ide_realize;
>>>       k->exit = via_ide_exitfn;
>>>       k->vendor_id = PCI_VENDOR_ID_VIA;


ATB,

Mark.


