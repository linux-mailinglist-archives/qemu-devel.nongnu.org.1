Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7FC713FFF
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 22:08:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3MfE-0003RL-S4; Sun, 28 May 2023 16:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q3MfD-0003R6-88; Sun, 28 May 2023 16:06:51 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q3MfB-0007Ez-9O; Sun, 28 May 2023 16:06:50 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id C8CBA74633D;
 Sun, 28 May 2023 22:06:43 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 82FB474632B; Sun, 28 May 2023 22:06:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7E49A745720;
 Sun, 28 May 2023 22:06:43 +0200 (CEST)
Date: Sun, 28 May 2023 22:06:43 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Rene Engel <ReneEngel80@emailn.de>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, danielhb413@gmail.com
Subject: Re: [PATCH] ppc/pegasos2: Change default CPU to 7457
In-Reply-To: <7d05d183a4e93e6d85b3a799fe9e63e5@mail.emailn.de>
Message-ID: <16794b12-1d75-d279-ed61-841978e28e75@eik.bme.hu>
References: <20230528152937.B8DAD74633D@zero.eik.bme.hu>
 <7d05d183a4e93e6d85b3a799fe9e63e5@mail.emailn.de>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1364239949-1685304403=:79084"
X-Spam-Probability: 9%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1364239949-1685304403=:79084
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sun, 28 May 2023, Rene Engel wrote:
> --- Ursprüngliche Nachricht ---
> Von: BALATON Zoltan <balaton@eik.bme.hu>
> Datum: 28.05.2023 17:29:37
> An: qemu-devel@nongnu.org,     qemu-ppc@nongnu.org
> Betreff: [PATCH] ppc/pegasos2: Change default CPU to 7457
>
>> Previously 7400 was selected as a safe choice as that is used by other
>> machines so it's better tested but AmigaOS does not know this CPU and
>> disables some features when running on it. The real hardware has
>> 7447/7457 G4 CPU so change the default to match that now that it was
>> confirmed to work better with AmigaOS.
>
> Can't we also increase the memory "mc->default_ram_size = 512 * MiB;" to 1024 for default settings ?
> Long term tests have confirmed that it works very well with 1024 MB memory under AmigaOs4.1.

No, the default memory size is not the largest possible but something sane 
that works bur won't eat all the memory of the host. Nowadays it's less of 
an issue but the default for most machines are still 128MB which I've 
already increased to 512MB for these machines as this is a better value 
for Amiga like OSes running on these machines but larger default may be 
too much. Adding a -memory option is less confusing then picking the right 
CPU type so requiring that for more memory is less of a problem.

Regards,
BALATON Zoltan

>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> Tested-by: Rene Engel <ReneEngel80@emailn.de>
>> ---
>>  hw/ppc/pegasos2.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
>> index f1650be5ee..af5489de26 100644
>> --- a/hw/ppc/pegasos2.c
>> +++ b/hw/ppc/pegasos2.c
>> @@ -524,7 +524,7 @@ static void pegasos2_machine_class_init(ObjectClass *oc,
>> void *data)
>>      mc->block_default_type = IF_IDE;
>>      mc->default_boot_order = "cd";
>>      mc->default_display = "std";
>> -    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("7400_v2.9");
>>
>> +    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("7457_v1.2");
>>
>>      mc->default_ram_id = "pegasos2.ram";
>>      mc->default_ram_size = 512 * MiB;
>>
>> --
>> 2.30.9
>>
>>
>
>
>
--3866299591-1364239949-1685304403=:79084--

