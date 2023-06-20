Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5747369EE
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 12:52:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBYyG-00045h-0R; Tue, 20 Jun 2023 06:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=rj0j=CI=kaod.org=clg@ozlabs.org>)
 id 1qBYyD-000450-AV; Tue, 20 Jun 2023 06:52:21 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=rj0j=CI=kaod.org=clg@ozlabs.org>)
 id 1qBYyB-0007d1-A0; Tue, 20 Jun 2023 06:52:21 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Qlk3d4m59z4x1R;
 Tue, 20 Jun 2023 20:52:13 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qlk3c1mZpz4wjC;
 Tue, 20 Jun 2023 20:52:11 +1000 (AEST)
Message-ID: <18f5f4d7-87af-9413-4a8f-1780841f4629@kaod.org>
Date: Tue, 20 Jun 2023 12:52:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 6/9] ppc/sam460ex: Report an error when run with KVM
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 qemu-devel@nongnu.org
References: <20230620055911.187065-1-clg@kaod.org>
 <20230620055911.187065-7-clg@kaod.org>
 <043c152d-ca2f-4796-b1ce-816fe9999e91@eik.bme.hu>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <043c152d-ca2f-4796-b1ce-816fe9999e91@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=rj0j=CI=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 6/20/23 12:42, BALATON Zoltan wrote:
> On Tue, 20 Jun 2023, Cédric Le Goater wrote:
>> The 'sam460ex' machine never supported KVM. This piece of code was
>> inherited from another model.
> 
> This is the same as for pegasos2, it might work on a BookE host if KVM-PR on that host is still supported so please keep this around unless there's a known problem that can't be fixed.

That sounds like a lot of 'if' for 2 decade old HW and an abandoned HV
implementation. Nevertheless, if KVM is supported one day, we can remove
easily the couple of lines below. I am sure there will be more changes.

Same comment for the pegasos2,

Thanks,

C.

> 
> Regards,
> BALATON Zoltan
> 
>> Cc: BALATON Zoltan <balaton@eik.bme.hu>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>> hw/ppc/sam460ex.c | 15 ++++++---------
>> 1 file changed, 6 insertions(+), 9 deletions(-)
>>
>> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
>> index cf065aae0eae..24f25e5897b7 100644
>> --- a/hw/ppc/sam460ex.c
>> +++ b/hw/ppc/sam460ex.c
>> @@ -18,7 +18,6 @@
>> #include "qapi/error.h"
>> #include "hw/boards.h"
>> #include "sysemu/kvm.h"
>> -#include "kvm_ppc.h"
>> #include "sysemu/device_tree.h"
>> #include "sysemu/block-backend.h"
>> #include "hw/loader.h"
>> @@ -165,14 +164,6 @@ static int sam460ex_load_device_tree(MachineState *machine,
>>     qemu_fdt_setprop_string(fdt, "/chosen", "bootargs",
>>                             machine->kernel_cmdline);
>>
>> -    /* Copy data from the host device tree into the guest. Since the guest can
>> -     * directly access the timebase without host involvement, we must expose
>> -     * the correct frequencies. */
>> -    if (kvm_enabled()) {
>> -        tb_freq = kvmppc_get_tbfreq();
>> -        clock_freq = kvmppc_get_clockfreq();
>> -    }
>> -
>>     qemu_fdt_setprop_cell(fdt, "/cpus/cpu@0", "clock-frequency",
>>                               clock_freq);
>>     qemu_fdt_setprop_cell(fdt, "/cpus/cpu@0", "timebase-frequency",
>> @@ -283,6 +274,12 @@ static void sam460ex_init(MachineState *machine)
>>     uint8_t *spd_data;
>>     int success;
>>
>> +    if (kvm_enabled()) {
>> +        error_report("machine %s does not support the KVM accelerator",
>> +                     MACHINE_GET_CLASS(machine)->name);
>> +        exit(EXIT_FAILURE);
>> +    }
>> +
>>     cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
>>     env = &cpu->env;
>>     if (env->mmu_model != POWERPC_MMU_BOOKE) {
>>


