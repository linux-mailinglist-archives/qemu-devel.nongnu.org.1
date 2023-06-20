Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4827D736A16
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 12:58:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBZ2w-0006vs-Ab; Tue, 20 Jun 2023 06:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qBZ2s-0006vQ-71; Tue, 20 Jun 2023 06:57:10 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qBZ2q-0000bT-AJ; Tue, 20 Jun 2023 06:57:09 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 1957B74645F;
 Tue, 20 Jun 2023 12:56:58 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id DD5C374638A; Tue, 20 Jun 2023 12:56:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DBBF4746377;
 Tue, 20 Jun 2023 12:56:57 +0200 (CEST)
Date: Tue, 20 Jun 2023 12:56:57 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>
cc: qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>, 
 qemu-devel@nongnu.org
Subject: Re: [PATCH 6/9] ppc/sam460ex: Report an error when run with KVM
In-Reply-To: <18f5f4d7-87af-9413-4a8f-1780841f4629@kaod.org>
Message-ID: <bbc96b0a-0f80-a966-cf45-5910100fc62e@eik.bme.hu>
References: <20230620055911.187065-1-clg@kaod.org>
 <20230620055911.187065-7-clg@kaod.org>
 <043c152d-ca2f-4796-b1ce-816fe9999e91@eik.bme.hu>
 <18f5f4d7-87af-9413-4a8f-1780841f4629@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1143671347-1687258617=:73461"
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

--3866299591-1143671347-1687258617=:73461
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 20 Jun 2023, Cédric Le Goater wrote:
> On 6/20/23 12:42, BALATON Zoltan wrote:
>> On Tue, 20 Jun 2023, Cédric Le Goater wrote:
>>> The 'sam460ex' machine never supported KVM. This piece of code was
>>> inherited from another model.
>> 
>> This is the same as for pegasos2, it might work on a BookE host if KVM-PR 
>> on that host is still supported so please keep this around unless there's a 
>> known problem that can't be fixed.
>
> That sounds like a lot of 'if' for 2 decade old HW and an abandoned HV
> implementation. Nevertheless, if KVM is supported one day, we can remove
> easily the couple of lines below. I am sure there will be more changes.
>
> Same comment for the pegasos2,

If you disable it then nobody can test it so it can't be supported. I need 
people to be able to test it to support it so please leave this enabled. 
(People using these machines don't normally compile their binaries from 
source and don't want to.)

Regards,
BALATON Zoltan

> Thanks,
>
> C.
>
>> 
>> Regards,
>> BALATON Zoltan
>> 
>>> Cc: BALATON Zoltan <balaton@eik.bme.hu>
>>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>>> ---
>>> hw/ppc/sam460ex.c | 15 ++++++---------
>>> 1 file changed, 6 insertions(+), 9 deletions(-)
>>> 
>>> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
>>> index cf065aae0eae..24f25e5897b7 100644
>>> --- a/hw/ppc/sam460ex.c
>>> +++ b/hw/ppc/sam460ex.c
>>> @@ -18,7 +18,6 @@
>>> #include "qapi/error.h"
>>> #include "hw/boards.h"
>>> #include "sysemu/kvm.h"
>>> -#include "kvm_ppc.h"
>>> #include "sysemu/device_tree.h"
>>> #include "sysemu/block-backend.h"
>>> #include "hw/loader.h"
>>> @@ -165,14 +164,6 @@ static int sam460ex_load_device_tree(MachineState 
>>> *machine,
>>>     qemu_fdt_setprop_string(fdt, "/chosen", "bootargs",
>>>                             machine->kernel_cmdline);
>>> 
>>> -    /* Copy data from the host device tree into the guest. Since the 
>>> guest can
>>> -     * directly access the timebase without host involvement, we must 
>>> expose
>>> -     * the correct frequencies. */
>>> -    if (kvm_enabled()) {
>>> -        tb_freq = kvmppc_get_tbfreq();
>>> -        clock_freq = kvmppc_get_clockfreq();
>>> -    }
>>> -
>>>     qemu_fdt_setprop_cell(fdt, "/cpus/cpu@0", "clock-frequency",
>>>                               clock_freq);
>>>     qemu_fdt_setprop_cell(fdt, "/cpus/cpu@0", "timebase-frequency",
>>> @@ -283,6 +274,12 @@ static void sam460ex_init(MachineState *machine)
>>>     uint8_t *spd_data;
>>>     int success;
>>> 
>>> +    if (kvm_enabled()) {
>>> +        error_report("machine %s does not support the KVM accelerator",
>>> +                     MACHINE_GET_CLASS(machine)->name);
>>> +        exit(EXIT_FAILURE);
>>> +    }
>>> +
>>>     cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
>>>     env = &cpu->env;
>>>     if (env->mmu_model != POWERPC_MMU_BOOKE) {
>>> 
>
>
>
--3866299591-1143671347-1687258617=:73461--

