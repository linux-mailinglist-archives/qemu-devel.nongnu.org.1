Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 352957EA746
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 01:06:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2gup-0006di-WC; Mon, 13 Nov 2023 19:04:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r2gum-0006cp-9M; Mon, 13 Nov 2023 19:04:24 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r2guk-0001LF-7x; Mon, 13 Nov 2023 19:04:23 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A461975A406;
 Tue, 14 Nov 2023 01:04:43 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9860375607B; Tue, 14 Nov 2023 01:04:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9690D756078;
 Tue, 14 Nov 2023 01:04:43 +0100 (CET)
Date: Tue, 14 Nov 2023 01:04:43 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
cc: Kevin Wolf <kwolf@redhat.com>, jsnow@redhat.com, qemu-block@nongnu.org, 
 qemu-devel@nongnu.org, philmd@linaro.org, shentey@gmail.com
Subject: Re: [PATCH v2 3/3] hw/ide/via: implement legacy/native mode switching
In-Reply-To: <c7f90ce2-7f9d-4219-be11-04c98dddc6cf@ilande.co.uk>
Message-ID: <2435f30d-23da-9c3f-12c4-4f491e5151a6@eik.bme.hu>
References: <20231024224056.842607-1-mark.cave-ayland@ilande.co.uk>
 <20231024224056.842607-4-mark.cave-ayland@ilande.co.uk>
 <ZUj5yTKBkJ99Dbxf@redhat.com>
 <509075f4-38d2-578b-b4f4-770c3b000ae8@eik.bme.hu>
 <ZUoU4FltYjFXdWZm@redhat.com>
 <c7f90ce2-7f9d-4219-be11-04c98dddc6cf@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Virus-Scanned: ClamAV using ClamSMTP
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Mon, 13 Nov 2023, Mark Cave-Ayland wrote:
> On 07/11/2023 10:43, Kevin Wolf wrote:
>> Am 06.11.2023 um 17:13 hat BALATON Zoltan geschrieben:
>>> On Mon, 6 Nov 2023, Kevin Wolf wrote:
>>>> Am 25.10.2023 um 00:40 hat Mark Cave-Ayland geschrieben:
>>>>> Allow the VIA IDE controller to switch between both legacy and native 
>>>>> modes by
>>>>> calling pci_ide_update_mode() to reconfigure the device whenever 
>>>>> PCI_CLASS_PROG
>>>>> is updated.
>>>>> 
>>>>> This patch moves the initial setting of PCI_CLASS_PROG from 
>>>>> via_ide_realize() to
>>>>> via_ide_reset(), and removes the direct setting of PCI_INTERRUPT_PIN 
>>>>> during PCI
>>>>> bus reset since this is now managed by pci_ide_update_mode(). This 
>>>>> ensures that
>>>>> the device configuration is always consistent with respect to the 
>>>>> currently
>>>>> selected mode.
>>>>> 
>>>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>>> Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>>> Tested-by: Bernhard Beschow <shentey@gmail.com>
>>>> 
>>>> As I already noted in patch 1, the interrupt handling seems to be wrong
>>>> here, it continues to use the ISA IRQ in via_ide_set_irq() even after
>>>> switching to native mode.
>>> 
>>> That's a peculiarity of this via-ide device. It always uses 14/15 legacy
>>> interrupts even in native mode and guests expect that so using native
>>> interrupts would break pegasos2 guests. This was discussed and tested
>>> extensively before.
>> 
>> This definitely needs a comment to explain the situation then because
>> this is in violation of the spec. If real hardware behaves like this,
>> it's what we should do, of course, but it's certainly unexpected and we
>> should explicitly document it to avoid breaking it later when someone
>> touches the code who doesn't know about this peculiarity.
>
> It's a little bit more complicated than this: in native mode it is possible 
> to route the IRQs for each individual channel to a small select number of 
> IRQs by configuring special registers on the VIA.

That's documented for VT82c686B but VT8231 doc says other values are 
reserved and only IRQ 14/15 is valid. So even if it worked nothing uses it 
and we don't have to be concerned about it and just using these hard coded 
14/15 is enough. It probably does not worth trying to emulate chip 
functions that no guest uses, especially when we're not sure how the real 
chip works as we can't test on real machine.

Regards,
BALATON Zoltan

> The complication here is that it isn't immediately obvious how the QEMU PCI 
> routing code can do this - I did post about this at 
> https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg10552.html asking 
> the best way to resolve this, but haven't had any replies yet.
>
> Fortunately it seems that all the guests tested so far stick with the IRQ 
> 14/15 defaults which is why this happens to work, so short-term this is a 
> lower priority when looking at consolidating the switching logic.
>
>
> ATB,
>
> Mark.
>
>

