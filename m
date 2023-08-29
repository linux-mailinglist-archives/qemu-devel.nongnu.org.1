Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 880C578C7E1
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 16:47:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qazz2-0002Zf-AL; Tue, 29 Aug 2023 10:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=bkLz=EO=kaod.org=clg@ozlabs.org>)
 id 1qazyS-0002Z5-JH; Tue, 29 Aug 2023 10:45:45 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=bkLz=EO=kaod.org=clg@ozlabs.org>)
 id 1qazyO-0004NL-Hr; Tue, 29 Aug 2023 10:45:44 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RZqwY4FYwz4wxn;
 Wed, 30 Aug 2023 00:45:33 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RZqwX09X7z4wd0;
 Wed, 30 Aug 2023 00:45:31 +1000 (AEST)
Message-ID: <bc069058-28d0-3cba-2fb5-c5701049a5d9@kaod.org>
Date: Tue, 29 Aug 2023 16:45:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.2 2/3] pnv/lpc: Hook up xscom region for P9/P10
Content-Language: en-US
To: Frederic Barrat <fbarrat@linux.ibm.com>, Joel Stanley <joel@jms.id.au>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20230808083445.4613-1-joel@jms.id.au>
 <20230808083445.4613-3-joel@jms.id.au>
 <61cf0069-e845-3a07-2a55-659594e886be@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <61cf0069-e845-3a07-2a55-659594e886be@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=bkLz=EO=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-1.242, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/9/23 16:56, Frederic Barrat wrote:
> Hello Joel,
> 
> So we're re-using the same xscom ops as on P8. A quick look at the definition of those 4 registers on P8 (0xb0020) and on P9/P10 (0x00090040) seem to show they are not the same though. Am i missing something?

Joel, are we ok ? Should we grab this patch ? or not.

Thanks,

C.


> 
>    Fred
> 
> 
> On 08/08/2023 10:34, Joel Stanley wrote:
>>  From P9 on the LPC bus is memory mapped. However the xscom access still
>> is possible, so add it too.
>>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> ---
>>   include/hw/ppc/pnv_xscom.h | 6 ++++++
>>   hw/ppc/pnv.c               | 4 ++++
>>   hw/ppc/pnv_lpc.c           | 6 ++++++
>>   3 files changed, 16 insertions(+)
>>
>> diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
>> index 9bc64635471e..42601bdf419d 100644
>> --- a/include/hw/ppc/pnv_xscom.h
>> +++ b/include/hw/ppc/pnv_xscom.h
>> @@ -96,6 +96,9 @@ struct PnvXScomInterfaceClass {
>>   #define PNV9_XSCOM_SBE_CTRL_BASE  0x00050008
>>   #define PNV9_XSCOM_SBE_CTRL_SIZE  0x1
>> +#define PNV9_XSCOM_LPC_BASE       0x00090040
>> +#define PNV9_XSCOM_LPC_SIZE       PNV_XSCOM_LPC_SIZE
>> +
>>   #define PNV9_XSCOM_SBE_MBOX_BASE  0x000D0050
>>   #define PNV9_XSCOM_SBE_MBOX_SIZE  0x16
>> @@ -155,6 +158,9 @@ struct PnvXScomInterfaceClass {
>>   #define PNV10_XSCOM_SBE_CTRL_BASE  PNV9_XSCOM_SBE_CTRL_BASE
>>   #define PNV10_XSCOM_SBE_CTRL_SIZE  PNV9_XSCOM_SBE_CTRL_SIZE
>> +#define PNV10_XSCOM_LPC_BASE       PNV9_XSCOM_LPC_BASE
>> +#define PNV10_XSCOM_LPC_SIZE       PNV9_XSCOM_LPC_SIZE
>> +
>>   #define PNV10_XSCOM_SBE_MBOX_BASE  PNV9_XSCOM_SBE_MBOX_BASE
>>   #define PNV10_XSCOM_SBE_MBOX_SIZE  PNV9_XSCOM_SBE_MBOX_SIZE
>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index afdaa25c2b26..a5db655b41b6 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -1566,6 +1566,8 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
>>       }
>>       memory_region_add_subregion(get_system_memory(), PNV9_LPCM_BASE(chip),
>>                                   &chip9->lpc.mmio_regs);
>> +    pnv_xscom_add_subregion(chip, PNV9_XSCOM_LPC_BASE,
>> +                            &chip9->lpc.xscom_regs);
>>       chip->fw_mr = &chip9->lpc.isa_fw;
>>       chip->dt_isa_nodename = g_strdup_printf("/lpcm-opb@%" PRIx64 "/lpc@0",
>> @@ -1785,6 +1787,8 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
>>       }
>>       memory_region_add_subregion(get_system_memory(), PNV10_LPCM_BASE(chip),
>>                                   &chip10->lpc.mmio_regs);
>> +    pnv_xscom_add_subregion(chip, PNV10_XSCOM_LPC_BASE,
>> +                            &chip10->lpc.xscom_regs);
>>       chip->fw_mr = &chip10->lpc.isa_fw;
>>       chip->dt_isa_nodename = g_strdup_printf("/lpcm-opb@%" PRIx64 "/lpc@0",
>> diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
>> index caf5e10a5f96..6c6a3134087f 100644
>> --- a/hw/ppc/pnv_lpc.c
>> +++ b/hw/ppc/pnv_lpc.c
>> @@ -666,6 +666,12 @@ static void pnv_lpc_power9_realize(DeviceState *dev, Error **errp)
>>       /* P9 uses a MMIO region */
>>       memory_region_init_io(&lpc->mmio_regs, OBJECT(lpc), &pnv_lpc_mmio_ops,
>>                             lpc, "lpcm", PNV9_LPCM_SIZE);
>> +
>> +    /* but the XSCOM region still exists */
>> +    pnv_xscom_region_init(&lpc->xscom_regs, OBJECT(lpc),
>> +                          &pnv_lpc_xscom_ops, lpc, "xscom-lpc",
>> +                          PNV_XSCOM_LPC_SIZE);
>> +
>>   }
>>   static void pnv_lpc_power9_class_init(ObjectClass *klass, void *data)


