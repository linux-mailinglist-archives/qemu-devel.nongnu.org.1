Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 954A27360F5
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 03:01:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBPjh-0003fE-97; Mon, 19 Jun 2023 21:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1qBPjY-0003f1-4r
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 21:00:36 -0400
Received: from jedlik.phy.bme.hu ([152.66.102.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1qBPjV-0003wp-NW
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 21:00:35 -0400
Received: by jedlik.phy.bme.hu (Postfix, from userid 1000)
 id 8427EA0117; Tue, 20 Jun 2023 02:50:55 +0200 (CEST)
Date: Tue, 20 Jun 2023 02:50:55 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: "Michael S. Tsirkin" <mst@redhat.com>
cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, 
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] hw/acpi: Fix PM control register access
In-Reply-To: <a37ca4bf-ad22-9086-b3a8-3c0d4f55da27@eik.bme.hu>
Message-ID: <alpine.LMD.2.03.2306200248390.24060@eik.bme.hu>
References: <20230607200125.A9988746377@zero.eik.bme.hu>
 <c080f8f6-b1d4-4ffb-7fcb-f29c7ddaf980@ilande.co.uk>
 <20230608111241-mutt-send-email-mst@kernel.org>
 <a37ca4bf-ad22-9086-b3a8-3c0d4f55da27@eik.bme.hu>
User-Agent: Alpine 2.03 (LMD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Received-SPF: none client-ip=152.66.102.83;
 envelope-from=balaton@jedlik.phy.bme.hu; helo=jedlik.phy.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 8 Jun 2023, BALATON Zoltan wrote:
> On Thu, 8 Jun 2023, Michael S. Tsirkin wrote:
>> On Thu, Jun 08, 2023 at 12:37:08PM +0100, Mark Cave-Ayland wrote:
>>> On 07/06/2023 21:01, BALATON Zoltan wrote:
>>> 
>>>> On pegasos2 which has ACPI as part of VT8231 south bridge the board
>>>> firmware writes PM control register by accessing the second byte so
>>>> addr will be 1. This wasn't handled correctly and the write went to
>>>> addr 0 instead. Remove the acpi_pm1_cnt_write() function which is used
>>>> only once and does not take addr into account and handle non-zero
>>>> address in acpi_pm_cnt_{read|write}. This fixes ACPI shutdown with
>>>> pegasos2 firmware.
>>>> 
>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>> ---
>>>>   hw/acpi/core.c | 52 +++++++++++++++++++++++++-------------------------
>>>>   1 file changed, 26 insertions(+), 26 deletions(-)
>>>> 
>>>> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
>>>> index 6da275c599..00b1e79a30 100644
>>>> --- a/hw/acpi/core.c
>>>> +++ b/hw/acpi/core.c
>>>> @@ -551,30 +551,6 @@ void acpi_pm_tmr_reset(ACPIREGS *ar)
>>>>   }
>>>>   /* ACPI PM1aCNT */
>>>> -static void acpi_pm1_cnt_write(ACPIREGS *ar, uint16_t val)
>>>> -{
>>>> -    ar->pm1.cnt.cnt = val & ~(ACPI_BITMASK_SLEEP_ENABLE);
>>>> -
>>>> -    if (val & ACPI_BITMASK_SLEEP_ENABLE) {
>>>> -        /* change suspend type */
>>>> -        uint16_t sus_typ = (val >> 10) & 7;
>>>> -        switch (sus_typ) {
>>>> -        case 0: /* soft power off */
>>>> -            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
>>>> -            break;
>>>> -        case 1:
>>>> -            qemu_system_suspend_request();
>>>> -            break;
>>>> -        default:
>>>> -            if (sus_typ == ar->pm1.cnt.s4_val) { /* S4 request */
>>>> -                qapi_event_send_suspend_disk();
>>>> - 
>>>> qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
>>>> -            }
>>>> -            break;
>>>> -        }
>>>> -    }
>>>> -}
>>>> -
>>>>   void acpi_pm1_cnt_update(ACPIREGS *ar,
>>>>                            bool sci_enable, bool sci_disable)
>>>>   {
>>>> @@ -593,13 +569,37 @@ void acpi_pm1_cnt_update(ACPIREGS *ar,
>>>>   static uint64_t acpi_pm_cnt_read(void *opaque, hwaddr addr, unsigned 
>>>> width)
>>>>   {
>>>>       ACPIREGS *ar = opaque;
>>>> -    return ar->pm1.cnt.cnt;
>>>> +    return ar->pm1.cnt.cnt >> addr * 8;
>>> 
>>> This shift here...
>>>
>>>>   }
>>>>   static void acpi_pm_cnt_write(void *opaque, hwaddr addr, uint64_t val,
>>>>                                 unsigned width)
>>>>   {
>>>> -    acpi_pm1_cnt_write(opaque, val);
>>>> +    ACPIREGS *ar = opaque;
>>>> +
>>>> +    if (addr == 1) {
>>>> +        val = val << 8 | (ar->pm1.cnt.cnt & 0xff);
>>>> +    }
>>> 
>>> and this shift here look similar to my workaround in 
>>> https://patchew.org/QEMU/20230524211104.686087-1-mark.cave-ayland@ilande.co.uk/20230524211104.686087-31-mark.cave-ayland@ilande.co.uk/
>>> which is a symptom of https://gitlab.com/qemu-project/qemu/-/issues/360.
>>> 
>>> Whilst there is no imminent fix for the above issue, it may be worth a few
>>> mins to determine if this is the same issue and if so document it with
>>> comments accordingly as I did so that the workaround can be removed at a
>>> later date.
>> 
>> So I will add
>> this triggers a but in memory core,
>> (see
>> https://gitlab.com/qemu-project/qemu/-/issues/360 for more detail)
>> 
>> ?
>
> Apart from the typo but -> bug I'm not sure this is related to that issue but 
> in any case this does not trigger but works around some possible bug so maybe 
> "This work around may be related to issue URL" or something like that maybe? 
> I'm also not sure what comment to add where so I'd appreciate if you can 
> handle this on merging.

Ping? Is this queued somewhere or will it be merged? Maybe Adding Buglink 
tag to commit message could be sufficient or just mentioning the link in 
the commit message. I'm still not sure what the best way to do that so I 
hope you could take care of that.

Regards,
BALATON Zoltan

>>>> +    ar->pm1.cnt.cnt = val & ~(ACPI_BITMASK_SLEEP_ENABLE);
>>>> +
>>>> +    if (val & ACPI_BITMASK_SLEEP_ENABLE) {
>>>> +        /* change suspend type */
>>>> +        uint16_t sus_typ = (val >> 10) & 7;
>>>> +        switch (sus_typ) {
>>>> +        case 0: /* soft power off */
>>>> +            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
>>>> +            break;
>>>> +        case 1:
>>>> +            qemu_system_suspend_request();
>>>> +            break;
>>>> +        default:
>>>> +            if (sus_typ == ar->pm1.cnt.s4_val) { /* S4 request */
>>>> +                qapi_event_send_suspend_disk();
>>>> + 
>>>> qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
>>>> +            }
>>>> +            break;
>>>> +        }
>>>> +    }
>>>>   }
>>>>   static const MemoryRegionOps acpi_pm_cnt_ops = {
>>> 
>>> 
>>> ATB,
>>> 
>>> Mark.
>> 
>> 
>
>

