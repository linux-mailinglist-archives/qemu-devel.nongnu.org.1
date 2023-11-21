Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA737F265B
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 08:31:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5LCg-0004Xu-QE; Tue, 21 Nov 2023 02:29:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=nm9w=HC=kaod.org=clg@ozlabs.org>)
 id 1r5LCf-0004Xh-1h; Tue, 21 Nov 2023 02:29:49 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=nm9w=HC=kaod.org=clg@ozlabs.org>)
 id 1r5LCc-0007Vu-Fs; Tue, 21 Nov 2023 02:29:48 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SZGGr3pjxz4xVW;
 Tue, 21 Nov 2023 18:29:40 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SZGGp4cMyz4xVV;
 Tue, 21 Nov 2023 18:29:38 +1100 (AEDT)
Message-ID: <31af40b3-a6c8-467c-8ef0-63e370465a9a@kaod.org>
Date: Tue, 21 Nov 2023 08:29:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/11] ppc/pnv: New powernv10-rainier machine type
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>
References: <20231120235112.1951342-1-milesg@linux.vnet.ibm.com>
 <20231120235112.1951342-4-milesg@linux.vnet.ibm.com>
 <CX43Q4CXT43G.16NTWUAWGGXCB@wheely>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <CX43Q4CXT43G.16NTWUAWGGXCB@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=nm9w=HC=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

On 11/21/23 02:33, Nicholas Piggin wrote:
> On Tue Nov 21, 2023 at 9:51 AM AEST, Glenn Miles wrote:
>> Create a new powernv machine type, powernv10-rainier, that
>> will contain rainier-specific devices.
> 
> Is the plan to have a base powernv10 common to all and then
> powernv10-rainier looks like a Rainier? Or would powernv10
> just be a rainier?
> 
> It's fine to structure code this way, I'm just wondering about
> the machine types available to user. Is a base powernv10 machine
> useful to run?

There are multiple P10 boards defined in Linux :

   aspeed-bmc-ibm-bonnell.dts
   aspeed-bmc-ibm-everest.dts
   aspeed-bmc-ibm-rainier-1s4u.dts
   aspeed-bmc-ibm-rainier-4u.dts
   aspeed-bmc-ibm-rainier.dts

and we could model the machines above with a fixed number of sockets.
The "powernv10" would be the generic system that can be customized
at will on the command line, even I2C devices. There is also the
P10 Denali which is FSP based. This QEMU machine would certainly be
very different. I thought of doing the same for P9 with a -zaius
and include NPU2 models for it. I lacked time and the interest was
small at the time of OpenPOWER.

Anyhow, adding a new machine makes sense and it prepares ground for
possible new ones. I am OK with or without. As primary users, you are
the ones that can tell if there will be a second machine.
  
Thanks,

C.


> 
>>
>> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
>> ---
>>   hw/ppc/pnv.c | 29 +++++++++++++++++++++++++++--
>>   1 file changed, 27 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index 9c29727337..3481a1220e 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -2249,7 +2249,7 @@ static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
>>       machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);
>>   }
>>   
>> -static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
>> +static void pnv_machine_p10_common_class_init(ObjectClass *oc, void *data)
>>   {
>>       MachineClass *mc = MACHINE_CLASS(oc);
>>       PnvMachineClass *pmc = PNV_MACHINE_CLASS(oc);
>> @@ -2261,7 +2261,6 @@ static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
>>           { TYPE_PNV_PHB_ROOT_PORT, "version", "5" },
>>       };
>>   
>> -    mc->desc = "IBM PowerNV (Non-Virtualized) POWER10";
>>       mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power10_v2.0");
>>       compat_props_add(mc->compat_props, phb_compat, G_N_ELEMENTS(phb_compat));
>>   
>> @@ -2274,6 +2273,23 @@ static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
>>       machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);
>>   }
>>   
>> +static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
>> +{
>> +    MachineClass *mc = MACHINE_CLASS(oc);
>> +
>> +    pnv_machine_p10_common_class_init(oc, data);
>> +    mc->desc = "IBM PowerNV (Non-Virtualized) POWER10";
>> +
>> +}
>> +
>> +static void pnv_machine_p10_rainier_class_init(ObjectClass *oc, void *data)
>> +{
>> +    MachineClass *mc = MACHINE_CLASS(oc);
>> +
>> +    pnv_machine_p10_common_class_init(oc, data);
>> +    mc->desc = "IBM PowerNV (Non-Virtualized) POWER10 rainier";
>> +}
>> +
>>   static bool pnv_machine_get_hb(Object *obj, Error **errp)
>>   {
>>       PnvMachineState *pnv = PNV_MACHINE(obj);
>> @@ -2379,6 +2395,15 @@ static void pnv_machine_class_init(ObjectClass *oc, void *data)
>>       }
>>   
>>   static const TypeInfo types[] = {
>> +    {
>> +        .name          = MACHINE_TYPE_NAME("powernv10-rainier"),
>> +        .parent        = TYPE_PNV_MACHINE,
>> +        .class_init    = pnv_machine_p10_rainier_class_init,
>> +        .interfaces = (InterfaceInfo[]) {
>> +            { TYPE_XIVE_FABRIC },
>> +            { },
>> +        },
>> +    },
>>       {
>>           .name          = MACHINE_TYPE_NAME("powernv10"),
>>           .parent        = TYPE_PNV_MACHINE,
> 


