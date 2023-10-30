Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 521137DB86A
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 11:44:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxPkM-0000ZD-Sg; Mon, 30 Oct 2023 06:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qxPkJ-0000Yv-Hm
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 06:43:47 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qxPkH-0001dS-BZ
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 06:43:47 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id CFEE07560A3;
 Mon, 30 Oct 2023 11:43:47 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 976AF756094; Mon, 30 Oct 2023 11:43:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 95DC0756088;
 Mon, 30 Oct 2023 11:43:47 +0100 (CET)
Date: Mon, 30 Oct 2023 11:43:47 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v5 3/5] hw/isa/vt82c686: Reuse acpi_update_sci()
In-Reply-To: <8F8EE81A-9153-4DB9-ADE3-C24B64CD4D1E@gmail.com>
Message-ID: <3b2023fd-8d8d-c926-5a47-a430c9353a45@eik.bme.hu>
References: <20231028091606.23700-1-shentey@gmail.com>
 <20231028091606.23700-4-shentey@gmail.com>
 <4d959097-0c53-c0fd-b1a0-3d8250e1a314@eik.bme.hu>
 <8F8EE81A-9153-4DB9-ADE3-C24B64CD4D1E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Probability: 9%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Mon, 30 Oct 2023, Bernhard Beschow wrote:
> Am 29. Oktober 2023 00:07:00 UTC schrieb BALATON Zoltan <balaton@eik.bme.hu>:
>> On Sat, 28 Oct 2023, Bernhard Beschow wrote:
>>> acpi_update_sci() covers everything pm_update_sci() does. It implements common
>>> ACPI funtionality in a generic fashion. Note that it agnostic to any
>>> Frankenstein usage of the general purpose event registers in other device
>>> models. It just implements a generic mechanism which can be wired to arbitrary
>>> functionality.
>>>
>>> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
>>> ---
>>> hw/isa/vt82c686.c | 20 ++------------------
>>> 1 file changed, 2 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
>>> index 60ca781e03..7b44ad9485 100644
>>> --- a/hw/isa/vt82c686.c
>>> +++ b/hw/isa/vt82c686.c
>>> @@ -145,26 +145,10 @@ static const MemoryRegionOps pm_io_ops = {
>>>     },
>>> };
>>>
>>> -static void pm_update_sci(ViaPMState *s)
>>> -{
>>> -    int sci_level, pmsts;
>>> -
>>> -    pmsts = acpi_pm1_evt_get_sts(&s->ar);
>>> -    sci_level = (((pmsts & s->ar.pm1.evt.en) &
>>> -                  (ACPI_BITMASK_RT_CLOCK_ENABLE |
>>> -                   ACPI_BITMASK_POWER_BUTTON_ENABLE |
>>> -                   ACPI_BITMASK_GLOBAL_LOCK_ENABLE |
>>> -                   ACPI_BITMASK_TIMER_ENABLE)) != 0);
>>> -    qemu_set_irq(s->sci_irq, sci_level);
>>> -    /* schedule a timer interruption if needed */
>>> -    acpi_pm_tmr_update(&s->ar, (s->ar.pm1.evt.en & ACPI_BITMASK_TIMER_ENABLE) &&
>>> -                       !(pmsts & ACPI_BITMASK_TIMER_STATUS));
>>> -}
>>> -
>>> static void pm_tmr_timer(ACPIREGS *ar)
>>> {
>>>     ViaPMState *s = container_of(ar, ViaPMState, ar);
>>> -    pm_update_sci(s);
>>> +    acpi_update_sci(&s->ar, s->sci_irq);
>>
>> To avoid needing an interrupt here maybe you could modify acpi_update_sci() to allow NULL irq then call via_isa_set_irq here so the interrupt routing can be done within the ISA bridge.
>
> Given the interesting behavior of the amigaone boot loader I'd respin this series with the last two patches only.

I guess you could do that just modeling the register and leave out SMI for 
now until we resolve the IRQ routing so then it should not conflict. I 
think you said that nothing uses the interrupt and you just need to be 
able to trigger poweroff with register write?

If you add SMI I think the qemu_irq for that should be in VIAISAState 
where the other irqs are and PM func should call via_isa_set_irq where it 
decides to route the SCI to ISA or SMI based on reg values. You can do 
this in the swich under case PCI_FUNC(of PM device) but if you don't need 
the IRQ this can be added later in a follow up I think.

Regards,
BALATON Zoltan

