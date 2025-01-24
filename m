Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 854EEA1B646
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Jan 2025 13:48:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbJ5s-00010Q-W9; Fri, 24 Jan 2025 07:47:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tbJ5X-0000or-VW; Fri, 24 Jan 2025 07:47:16 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tbJ5R-0004uo-Vy; Fri, 24 Jan 2025 07:47:06 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EBC3A4E6032;
 Fri, 24 Jan 2025 13:46:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id tOb1376-V8UP; Fri, 24 Jan 2025 13:46:57 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 019954E601A; Fri, 24 Jan 2025 13:46:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id F3FE674577C;
 Fri, 24 Jan 2025 13:46:56 +0100 (CET)
Date: Fri, 24 Jan 2025 13:46:56 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Subject: Re: [PATCH] hw/usb/hcd-ehci: Fix debug printf format string
In-Reply-To: <afabb48c-2bf9-42dc-9aa9-f4341285ec38@linaro.org>
Message-ID: <e5da814c-4f9b-9cd1-8866-a95ab4ff5ec0@eik.bme.hu>
References: <20250123214831.401B54E601A@zero.eik.bme.hu>
 <afabb48c-2bf9-42dc-9aa9-f4341285ec38@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1842695708-1737722816=:4769"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1842695708-1737722816=:4769
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 23 Jan 2025, Philippe Mathieu-Daudé wrote:
> Hi Zoltan,
>
> On 23/1/25 22:48, BALATON Zoltan wrote:
>> The variable is uint64_t so needs %ld instead of %d.
>> 
>
> Actually the format is PRIu64.
>
> Fixes: 3ae7eb88c47 ("ehci: fix overflow in frame timer code")
>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>   hw/usb/hcd-ehci.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
>> index 6c4c14c895..23b3e20fdb 100644
>> --- a/hw/usb/hcd-ehci.c
>> +++ b/hw/usb/hcd-ehci.c
>> @@ -2287,7 +2287,7 @@ static void ehci_work_bh(void *opaque)
>>               ehci_update_frindex(ehci, skipped_uframes);
>>               ehci->last_run_ns += UFRAME_TIMER_NS * skipped_uframes;
>>               uframes -= skipped_uframes;
>> -            DPRINTF("WARNING - EHCI skipped %d uframes\n", 
>> skipped_uframes);
>> +            DPRINTF("WARNING - EHCI skipped %ld uframes\n", 
>> skipped_uframes);
>
> Should we take the opportunity to convert to warn_report()?

I'd leave that to someone else. Sent a v3 fixing the commit message as 
well and adding R-b from Peter.

Regards,
BALATON Zoltan

>>           }
>>             for (i = 0; i < uframes; i++) {
>
>
--3866299591-1842695708-1737722816=:4769--

