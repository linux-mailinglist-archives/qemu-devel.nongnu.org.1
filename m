Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8917288C4
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 21:37:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7LQJ-0001Vw-Fu; Thu, 08 Jun 2023 15:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q7LQG-0001Ty-0H
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 15:35:52 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q7LQD-0003HC-Ux
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 15:35:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7wWo55T1Eah9kvX4Ff0Wg2h1ovsU7umBTvlWAQjq8II=; b=DUK1vuvmnlJa6BJE6fc22wFh4g
 XQ3Q51sGyvPns3XQBbVY1f1yIewjiuR4TUQkX3jpKe3eLiub7dS9FCA273CXfyp2DwWjdxiUQzoAT
 reyQosB3rALXAczOV8wmqmM8lhDvwF04uml7oiaU15Q0fsaXCCvkI/Zv5kpltiOdHadLS9LfMiCOr
 JfuAkOZlOeti/tiuHpycq/tpNlxByFJFeyqwXoTLTitWUeZBo9W4zGhiTb2cXTCTdUHlXSRNQ6Vgf
 quNtWmTobid4hW+pUqyxnbXP6en0Eo2ehrWMXsu8+u9rKa+D7WitsgqBLG0FZR6mk3LWKbIcIapBF
 EpdBXP8UZDyofBzTKOPIvO6ynWS9LyNML7aXis1bOVosB/kiau7fIkVUTX2+E39iPHn6OVSiUWRB4
 v0qdsv7Gfmq45a6nhi7RrTXa3FEBMOnNlXfy9yGE1HpKQrpnx+BOPGVbp8mG12ID5ghvKEcNgWuQJ
 9WcV/kocZc59jVvIsnwYUNRKRzlqCrYOxZrWMi5tsMu4fPzIGq5/qxxjvSjRllfj7L0Co/VdZwZj+
 5f3utcYc8LQsmCDYI4UN3DZPw1ULGMVNWame4iyebuYho+AyOfdeDaQapt6c44KvoI/jejgQWZZip
 IrrqEkuRaRgWvTKoM3EV/Wq6Ridr7zMbCNl4f+FTo=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q7LQ5-00035k-NO; Thu, 08 Jun 2023 20:35:45 +0100
Message-ID: <5f6e8650-5468-0091-9cd6-eaeeac12a2d5@ilande.co.uk>
Date: Thu, 8 Jun 2023 20:35:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20230607200125.A9988746377@zero.eik.bme.hu>
 <c080f8f6-b1d4-4ffb-7fcb-f29c7ddaf980@ilande.co.uk>
 <20230608111241-mutt-send-email-mst@kernel.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20230608111241-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2] hw/acpi: Fix PM control register access
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 08/06/2023 16:13, Michael S. Tsirkin wrote:

> On Thu, Jun 08, 2023 at 12:37:08PM +0100, Mark Cave-Ayland wrote:
>> On 07/06/2023 21:01, BALATON Zoltan wrote:
>>
>>> On pegasos2 which has ACPI as part of VT8231 south bridge the board
>>> firmware writes PM control register by accessing the second byte so
>>> addr will be 1. This wasn't handled correctly and the write went to
>>> addr 0 instead. Remove the acpi_pm1_cnt_write() function which is used
>>> only once and does not take addr into account and handle non-zero
>>> address in acpi_pm_cnt_{read|write}. This fixes ACPI shutdown with
>>> pegasos2 firmware.
>>>
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>>    hw/acpi/core.c | 52 +++++++++++++++++++++++++-------------------------
>>>    1 file changed, 26 insertions(+), 26 deletions(-)
>>>
>>> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
>>> index 6da275c599..00b1e79a30 100644
>>> --- a/hw/acpi/core.c
>>> +++ b/hw/acpi/core.c
>>> @@ -551,30 +551,6 @@ void acpi_pm_tmr_reset(ACPIREGS *ar)
>>>    }
>>>    /* ACPI PM1aCNT */
>>> -static void acpi_pm1_cnt_write(ACPIREGS *ar, uint16_t val)
>>> -{
>>> -    ar->pm1.cnt.cnt = val & ~(ACPI_BITMASK_SLEEP_ENABLE);
>>> -
>>> -    if (val & ACPI_BITMASK_SLEEP_ENABLE) {
>>> -        /* change suspend type */
>>> -        uint16_t sus_typ = (val >> 10) & 7;
>>> -        switch (sus_typ) {
>>> -        case 0: /* soft power off */
>>> -            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
>>> -            break;
>>> -        case 1:
>>> -            qemu_system_suspend_request();
>>> -            break;
>>> -        default:
>>> -            if (sus_typ == ar->pm1.cnt.s4_val) { /* S4 request */
>>> -                qapi_event_send_suspend_disk();
>>> -                qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
>>> -            }
>>> -            break;
>>> -        }
>>> -    }
>>> -}
>>> -
>>>    void acpi_pm1_cnt_update(ACPIREGS *ar,
>>>                             bool sci_enable, bool sci_disable)
>>>    {
>>> @@ -593,13 +569,37 @@ void acpi_pm1_cnt_update(ACPIREGS *ar,
>>>    static uint64_t acpi_pm_cnt_read(void *opaque, hwaddr addr, unsigned width)
>>>    {
>>>        ACPIREGS *ar = opaque;
>>> -    return ar->pm1.cnt.cnt;
>>> +    return ar->pm1.cnt.cnt >> addr * 8;
>>
>> This shift here...
>>
>>>    }
>>>    static void acpi_pm_cnt_write(void *opaque, hwaddr addr, uint64_t val,
>>>                                  unsigned width)
>>>    {
>>> -    acpi_pm1_cnt_write(opaque, val);
>>> +    ACPIREGS *ar = opaque;
>>> +
>>> +    if (addr == 1) {
>>> +        val = val << 8 | (ar->pm1.cnt.cnt & 0xff);
>>> +    }
>>
>> and this shift here look similar to my workaround in https://patchew.org/QEMU/20230524211104.686087-1-mark.cave-ayland@ilande.co.uk/20230524211104.686087-31-mark.cave-ayland@ilande.co.uk/
>> which is a symptom of https://gitlab.com/qemu-project/qemu/-/issues/360.
>>
>> Whilst there is no imminent fix for the above issue, it may be worth a few
>> mins to determine if this is the same issue and if so document it with
>> comments accordingly as I did so that the workaround can be removed at a
>> later date.
> 
> So I will add
> this triggers a but in memory core,
> (see
> https://gitlab.com/qemu-project/qemu/-/issues/360 for more detail)
> 
> ?

Well it was just an observation based on its similarity to my patch, but it would 
need a quick check with the debugger to step back up from the access to confirm if it 
were caused by the same issue (see the above issue #360 for detail).

As per my previous message no objection to the patch, but if it does have the same 
underlying cause then it could explain why this has been a tricky problem to solve 
(as in general the memory API "just works") and also provide another test case for a 
potential fix.

>>> +    ar->pm1.cnt.cnt = val & ~(ACPI_BITMASK_SLEEP_ENABLE);
>>> +
>>> +    if (val & ACPI_BITMASK_SLEEP_ENABLE) {
>>> +        /* change suspend type */
>>> +        uint16_t sus_typ = (val >> 10) & 7;
>>> +        switch (sus_typ) {
>>> +        case 0: /* soft power off */
>>> +            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
>>> +            break;
>>> +        case 1:
>>> +            qemu_system_suspend_request();
>>> +            break;
>>> +        default:
>>> +            if (sus_typ == ar->pm1.cnt.s4_val) { /* S4 request */
>>> +                qapi_event_send_suspend_disk();
>>> +                qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
>>> +            }
>>> +            break;
>>> +        }
>>> +    }
>>>    }
>>>    static const MemoryRegionOps acpi_pm_cnt_ops = {


ATB,

Mark.


