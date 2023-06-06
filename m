Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DC27249AE
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 19:00:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6a2I-0007mb-4G; Tue, 06 Jun 2023 12:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q6a2G-0007m7-JA
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 12:59:56 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q6a2E-0003KJ-7K
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 12:59:56 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 7266C746377;
 Tue,  6 Jun 2023 18:59:48 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3D292746369; Tue,  6 Jun 2023 18:59:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3BD9674635C;
 Tue,  6 Jun 2023 18:59:48 +0200 (CEST)
Date: Tue, 6 Jun 2023 18:59:48 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Igor Mammedov <imammedo@redhat.com>
cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH] hw/acpi: Fix PM control register access
In-Reply-To: <20230606145046.159b6bba@imammedo.users.ipa.redhat.com>
Message-ID: <1639953d-6f1c-cd9c-bba5-bc3b0b9134f1@eik.bme.hu>
References: <20230528135750.4145574633D@zero.eik.bme.hu>
 <20230606145046.159b6bba@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Probability: 9%
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

On Tue, 6 Jun 2023, Igor Mammedov wrote:
> On Sun, 28 May 2023 15:57:50 +0200 (CEST)
> BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
>> On pegasos2 which has ACPI as part of VT8231 south bridge the board
>> firmware writes PM control register by accessing the second byte so
>> addr will be 1. This wasn't handled correctly and the write went to
>> addr 0 instead. This fixes ACPI shutdown with pegasos2 firmware.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>> This is replacing the previous attempt which changed enduanness to
>> NATIVE_ENDIAN that was found to be wrong. I'm still not sure what's
>> happening as these functions are called with addr = 1 and size = 2 but
>> maybe the guest really does word access to addr 1 when wanting to
>> write 1 byte. This fixes the problem and should not break anything
>> else but please review.
>>
>>  hw/acpi/core.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
>> index 6da275c599..bbc599a252 100644
>> --- a/hw/acpi/core.c
>> +++ b/hw/acpi/core.c
>> @@ -593,13 +593,13 @@ void acpi_pm1_cnt_update(ACPIREGS *ar,
>>  static uint64_t acpi_pm_cnt_read(void *opaque, hwaddr addr, unsigned width)
>>  {
>>      ACPIREGS *ar = opaque;
>> -    return ar->pm1.cnt.cnt;
>> +    return ar->pm1.cnt.cnt >> addr * 8;
>>  }
> that looks fine
>
>>
>>  static void acpi_pm_cnt_write(void *opaque, hwaddr addr, uint64_t val,
>>                                unsigned width)
>>  {
>> -    acpi_pm1_cnt_write(opaque, val);
>> +    acpi_pm1_cnt_write(opaque, val << addr * 8);
>>  }
> however, if this is 1 byte write at offset 1,
> wouldn't this wipe out lower byte
> (aka:
> #define ACPI_BITMASK_SCI_ENABLE                 0x0001
> #define ACPI_BITMASK_BUS_MASTER_RLD             0x0002
> #define ACPI_BITMASK_GLOBAL_LOCK_RELEASE        0x0004
> )?

Since this will either reset or power off the machine it probably does not 
really matter. But to fix that more we'd need to rewrite 
acpi_pm1_cnt_write() to replace acpi_pm_cnt_write() and handle that 
internally. Or is there another way to handle this? Does that worth the 
effort when the only known usage is in pegasos2 firmware when it calls 
power off?

Regards,
BALATON Zoltan

