Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFD67F73CD
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 13:28:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6VHC-0000U5-6v; Fri, 24 Nov 2023 07:27:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZyQH=HF=kaod.org=clg@ozlabs.org>)
 id 1r6VH5-0000S1-10; Fri, 24 Nov 2023 07:27:12 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZyQH=HF=kaod.org=clg@ozlabs.org>)
 id 1r6VH1-0007Yh-UJ; Fri, 24 Nov 2023 07:27:10 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4ScDkY590Nz4xPf;
 Fri, 24 Nov 2023 23:27:01 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4ScDkW1jY3z4xFR;
 Fri, 24 Nov 2023 23:26:58 +1100 (AEDT)
Message-ID: <bac39d18-e922-4979-9c52-216cad088483@kaod.org>
Date: Fri, 24 Nov 2023 13:26:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] hw/ppc: Nest1 chiplet wiring
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>,
 Chalapathi V <chalapathi.v@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, calebs@us.ibm.com,
 chalapathi.v@ibm.com, saif.abrar@linux.vnet.ibm.com
References: <20231124101534.19454-1-chalapathi.v@linux.ibm.com>
 <20231124101534.19454-4-chalapathi.v@linux.ibm.com>
 <CX708Z3P2ZAA.3VDMJRTBIK14W@wheely>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <CX708Z3P2ZAA.3VDMJRTBIK14W@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=ZyQH=HF=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
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

On 11/24/23 12:28, Nicholas Piggin wrote:
> On Fri Nov 24, 2023 at 8:15 PM AEST, Chalapathi V wrote:
>> This part of the patchset connects the nest1 chiplet model to p10 chip.
> 
> Seems fine to me. Should it just be squashed into patch 2?

It is better to keep the model a part from the wiring because the
same model could be plugged in different board/machine. It clarifies
the interfaces, which should be limited to irq connects and memory
mappings and it makes modeling shortcuts more visible: backpointers,
looping on the machine mappings to find a core, etc.

I didn't comment on the PnvChiptod proposal but it could/should
be done the same.

This patch proposal is nice and clean.

Thanks,

C.




> 
> Thanks,
> Nick
> 
>>
>> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
>> ---
>>   include/hw/ppc/pnv_chip.h |  2 ++
>>   hw/ppc/pnv.c              | 14 ++++++++++++++
>>   2 files changed, 16 insertions(+)
>>
>> diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
>> index 0ab5c42308..59a3158a6b 100644
>> --- a/include/hw/ppc/pnv_chip.h
>> +++ b/include/hw/ppc/pnv_chip.h
>> @@ -4,6 +4,7 @@
>>   #include "hw/pci-host/pnv_phb4.h"
>>   #include "hw/ppc/pnv_core.h"
>>   #include "hw/ppc/pnv_homer.h"
>> +#include "hw/ppc/pnv_nest_chiplet.h"
>>   #include "hw/ppc/pnv_lpc.h"
>>   #include "hw/ppc/pnv_occ.h"
>>   #include "hw/ppc/pnv_psi.h"
>> @@ -113,6 +114,7 @@ struct Pnv10Chip {
>>       PnvOCC       occ;
>>       PnvSBE       sbe;
>>       PnvHomer     homer;
>> +    PnvNest1     nest1;
>>   
>>       uint32_t     nr_quads;
>>       PnvQuad      *quads;
>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index 0297871bdd..ba3dfab557 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -1680,6 +1680,7 @@ static void pnv_chip_power10_instance_init(Object *obj)
>>       object_initialize_child(obj, "occ",  &chip10->occ, TYPE_PNV10_OCC);
>>       object_initialize_child(obj, "sbe",  &chip10->sbe, TYPE_PNV10_SBE);
>>       object_initialize_child(obj, "homer", &chip10->homer, TYPE_PNV10_HOMER);
>> +    object_initialize_child(obj, "nest1", &chip10->nest1, TYPE_PNV_NEST1);
>>   
>>       chip->num_pecs = pcc->num_pecs;
>>   
>> @@ -1849,6 +1850,19 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
>>       memory_region_add_subregion(get_system_memory(), PNV10_HOMER_BASE(chip),
>>                                   &chip10->homer.regs);
>>   
>> +    /* nest1 chiplet */
>> +    if (!qdev_realize(DEVICE(&chip10->nest1), NULL, errp)) {
>> +        return;
>> +    }
>> +    pnv_xscom_add_subregion(chip, PNV10_XSCOM_NEST1_CTRL_CHIPLET_BASE,
>> +             &chip10->nest1.perv.xscom_perv_ctrl_regs);
>> +
>> +    pnv_xscom_add_subregion(chip, PNV10_XSCOM_NEST1_PB_SCOM_EQ_BASE,
>> +                           &chip10->nest1.xscom_pb_eq_regs);
>> +
>> +    pnv_xscom_add_subregion(chip, PNV10_XSCOM_NEST1_PB_SCOM_ES_BASE,
>> +                           &chip10->nest1.xscom_pb_es_regs);
>> +
>>       /* PHBs */
>>       pnv_chip_power10_phb_realize(chip, &local_err);
>>       if (local_err) {
> 


