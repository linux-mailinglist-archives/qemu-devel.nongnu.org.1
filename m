Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAF07F73A9
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 13:20:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6V9T-0005aI-2e; Fri, 24 Nov 2023 07:19:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZyQH=HF=kaod.org=clg@ozlabs.org>)
 id 1r6V9R-0005a2-9p; Fri, 24 Nov 2023 07:19:17 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZyQH=HF=kaod.org=clg@ozlabs.org>)
 id 1r6V9L-0005O3-LR; Fri, 24 Nov 2023 07:19:17 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4ScDYQ36dTz4xQZ;
 Fri, 24 Nov 2023 23:19:06 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4ScDYM3wPyz4xFR;
 Fri, 24 Nov 2023 23:19:03 +1100 (AEDT)
Message-ID: <236fe044-7adb-43c2-8887-0303ee33d6c6@kaod.org>
Date: Fri, 24 Nov 2023 13:19:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] hw/ppc: Add nest1 chiplet model
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>,
 Chalapathi V <chalapathi.v@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, calebs@us.ibm.com,
 chalapathi.v@ibm.com, saif.abrar@linux.vnet.ibm.com
References: <20231124101534.19454-1-chalapathi.v@linux.ibm.com>
 <20231124101534.19454-3-chalapathi.v@linux.ibm.com>
 <CX707LTEH9J0.3UF28GS7L10P7@wheely>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <CX707LTEH9J0.3UF28GS7L10P7@wheely>
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

On 11/24/23 12:26, Nicholas Piggin wrote:
> For this and actually the last patch too, it would be good to mention
> (possibly in a header comment in the file too) what actual functionality
> is being provided/modeled. It looks like it's just modeling behaviour of
> reads and writes for some registers.
> 
> Oh, and sorry I didn't follow development and comments on this too
> closely, so forgive me if I've missed things already said. I'll go
> back and read through the series.
> 
> On Fri Nov 24, 2023 at 8:15 PM AEST, Chalapathi V wrote:
>> The nest1 chiplet handle the high speed i/o traffic over PCIe and others.
>> The nest1 chiplet consists of PowerBus Fabric controller,
>> nest Memory Management Unit, chiplet control unit and more.
>>
>> This commit creates a nest1 chiplet model and initialize and realize the
>> pervasive chiplet model where chiplet control registers are implemented.
>>
>> This commit also implement the read/write method for the powerbus scom
>> registers
> 
> The powerbus scom registers, are those specifically for the PowerBus
> Fabric controller mentioned in the first paragraph, or is it a more
> general set of registers for the chiplet?
> 
>>
>> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
>> ---
>>   include/hw/ppc/pnv_nest_chiplet.h |  36 ++++++
>>   include/hw/ppc/pnv_xscom.h        |   6 +
>>   hw/ppc/pnv_nest1_chiplet.c        | 197 ++++++++++++++++++++++++++++++
>>   hw/ppc/meson.build                |   1 +
>>   4 files changed, 240 insertions(+)
>>   create mode 100644 include/hw/ppc/pnv_nest_chiplet.h
>>   create mode 100644 hw/ppc/pnv_nest1_chiplet.c
>>
>> diff --git a/include/hw/ppc/pnv_nest_chiplet.h b/include/hw/ppc/pnv_nest_chiplet.h
>> new file mode 100644
>> index 0000000000..845030fb1a
>> --- /dev/null
>> +++ b/include/hw/ppc/pnv_nest_chiplet.h
>> @@ -0,0 +1,36 @@
>> +/*
>> + * QEMU PowerPC nest chiplet model
>> + *
>> + * Copyright (c) 2023, IBM Corporation.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + *
>> + * This code is licensed under the GPL version 2 or later. See the
>> + * COPYING file in the top-level directory.
>> + *
>> + */
>> +
>> +#ifndef PPC_PNV_NEST1_CHIPLET_H
>> +#define PPC_PNV_NEST1_CHIPLET_H
>> +
>> +#include "hw/ppc/pnv_pervasive.h"
>> +
>> +#define TYPE_PNV_NEST1 "pnv-nest1-chiplet"
>> +#define PNV_NEST1(obj) OBJECT_CHECK(PnvNest1, (obj), TYPE_PNV_NEST1)
>> +
>> +typedef struct pb_scom {
>> +    uint64_t mode;
>> +    uint64_t hp_mode2_curr;
>> +} pb_scom;
>> +
>> +typedef struct PnvNest1 {
> 
> Naming nitpicking again...
> 
> The main ifndef guard for header files should match the file name, so
> the file should be called pnv_nest1_chiplet.h (and that matches the .c
> file too).
> 
> I think this struct should be called Nest1Chiplet too.

I asked Chalapathi to do the exact opposit :)

I don't mind really, my argument was that most models represent HW logic
units or subunits of a bigger unit. I don't see the point in adding a
chip/chiplet suffix apart from PnvChip since it represents a socket or
processor.

You choose. I will keep quiet :)

Thanks,

C.



> Nest1 is
> unambiguously the name of a specific chiplet, but it's a little easy
> to miss the 1, and if we get a bunch more chiplets I think it will
> be nicer to have Chiplet in the name.
> 
> Thanks,
> Nick
> 
>> +    DeviceState parent;
>> +    MemoryRegion xscom_pb_eq_regs;
>> +    MemoryRegion xscom_pb_es_regs;
>> +    /* common pervasive chiplet unit */
>> +    PnvPerv perv;
>> +    /* powerbus racetrack registers */
>> +    pb_scom eq[8];
>> +    pb_scom es[4];
>> +} PnvNest1;
>> +#endif /*PPC_PNV_NEST1 */
>> diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
>> index d09d10f32b..df68a1c20e 100644
>> --- a/include/hw/ppc/pnv_xscom.h
>> +++ b/include/hw/ppc/pnv_xscom.h
>> @@ -173,6 +173,12 @@ struct PnvXScomInterfaceClass {
>>   #define PNV10_XSCOM_NEST1_CTRL_CHIPLET_BASE      0x3000000
>>   #define PNV10_XSCOM_CTRL_CHIPLET_SIZE            0x400
>>   
>> +#define PNV10_XSCOM_NEST1_PB_SCOM_EQ_BASE      0x3011000
>> +#define PNV10_XSCOM_NEST1_PB_SCOM_EQ_SIZE      0x200
>> +
>> +#define PNV10_XSCOM_NEST1_PB_SCOM_ES_BASE      0x3011300
>> +#define PNV10_XSCOM_NEST1_PB_SCOM_ES_SIZE      0x100
>> +
>>   #define PNV10_XSCOM_PEC_NEST_BASE  0x3011800 /* index goes downwards ... */
>>   #define PNV10_XSCOM_PEC_NEST_SIZE  0x100
>>   
>> diff --git a/hw/ppc/pnv_nest1_chiplet.c b/hw/ppc/pnv_nest1_chiplet.c
>> new file mode 100644
>> index 0000000000..609d5f1be4
>> --- /dev/null
>> +++ b/hw/ppc/pnv_nest1_chiplet.c
>> @@ -0,0 +1,197 @@
>> +/*
>> + * QEMU PowerPC nest1 chiplet model
>> + *
>> + * Copyright (c) 2023, IBM Corporation.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + *
>> + * This code is licensed under the GPL version 2 or later. See the
>> + * COPYING file in the top-level directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/log.h"
>> +#include "hw/qdev-properties.h"
>> +#include "hw/ppc/pnv.h"
>> +#include "hw/ppc/pnv_xscom.h"
>> +#include "hw/ppc/pnv_nest_chiplet.h"
>> +#include "hw/ppc/pnv_pervasive.h"
>> +#include "hw/ppc/fdt.h"
>> +#include <libfdt.h>
>> +
>> +/*
>> + * The nest1 chiplet contains chiplet control unit,
>> + * PowerBus/RaceTrack/Bridge logic, nest Memory Management Unit(nMMU)
>> + * and more.
>> + */
>> +
>> +#define PB_SCOM_EQ0_HP_MODE2_CURR      0xe
>> +#define PB_SCOM_ES3_MODE               0x8a
>> +
>> +static uint64_t pnv_nest1_pb_scom_eq_read(void *opaque, hwaddr addr,
>> +                                                  unsigned size)
>> +{
>> +    PnvNest1 *nest1 = PNV_NEST1(opaque);
>> +    int reg = addr >> 3;
>> +    uint64_t val = ~0ull;
>> +
>> +    switch (reg) {
>> +    case PB_SCOM_EQ0_HP_MODE2_CURR:
>> +        val = nest1->eq[0].hp_mode2_curr;
>> +        break;
>> +    default:
>> +        qemu_log_mask(LOG_UNIMP, "%s: Invalid xscom read at 0x%" PRIx32 "\n",
>> +                      __func__, reg);
>> +    }
>> +    return val;
>> +}
>> +
>> +static void pnv_nest1_pb_scom_eq_write(void *opaque, hwaddr addr,
>> +                                               uint64_t val, unsigned size)
>> +{
>> +    PnvNest1 *nest1 = PNV_NEST1(opaque);
>> +    int reg = addr >> 3;
>> +
>> +    switch (reg) {
>> +    case PB_SCOM_EQ0_HP_MODE2_CURR:
>> +        nest1->eq[0].hp_mode2_curr = val;
>> +        break;
>> +    default:
>> +        qemu_log_mask(LOG_UNIMP, "%s: Invalid xscom write at 0x%" PRIx32 "\n",
>> +                      __func__, reg);
>> +    }
>> +}
>> +
>> +static const MemoryRegionOps pnv_nest1_pb_scom_eq_ops = {
>> +    .read = pnv_nest1_pb_scom_eq_read,
>> +    .write = pnv_nest1_pb_scom_eq_write,
>> +    .valid.min_access_size = 8,
>> +    .valid.max_access_size = 8,
>> +    .impl.min_access_size = 8,
>> +    .impl.max_access_size = 8,
>> +    .endianness = DEVICE_BIG_ENDIAN,
>> +};
>> +
>> +static uint64_t pnv_nest1_pb_scom_es_read(void *opaque, hwaddr addr,
>> +                                          unsigned size)
>> +{
>> +    PnvNest1 *nest1 = PNV_NEST1(opaque);
>> +    int reg = addr >> 3;
>> +    uint64_t val = ~0ull;
>> +
>> +    switch (reg) {
>> +    case PB_SCOM_ES3_MODE:
>> +        val = nest1->es[3].mode;
>> +        break;
>> +    default:
>> +        qemu_log_mask(LOG_UNIMP, "%s: Invalid xscom read at 0x%" PRIx32 "\n",
>> +                      __func__, reg);
>> +    }
>> +    return val;
>> +}
>> +
>> +static void pnv_nest1_pb_scom_es_write(void *opaque, hwaddr addr,
>> +                                               uint64_t val, unsigned size)
>> +{
>> +    PnvNest1 *nest1 = PNV_NEST1(opaque);
>> +    int reg = addr >> 3;
>> +
>> +    switch (reg) {
>> +    case PB_SCOM_ES3_MODE:
>> +        nest1->es[3].mode = val;
>> +        break;
>> +    default:
>> +        qemu_log_mask(LOG_UNIMP, "%s: Invalid xscom write at 0x%" PRIx32 "\n",
>> +                      __func__, reg);
>> +    }
>> +}
>> +
>> +static const MemoryRegionOps pnv_nest1_pb_scom_es_ops = {
>> +    .read = pnv_nest1_pb_scom_es_read,
>> +    .write = pnv_nest1_pb_scom_es_write,
>> +    .valid.min_access_size = 8,
>> +    .valid.max_access_size = 8,
>> +    .impl.min_access_size = 8,
>> +    .impl.max_access_size = 8,
>> +    .endianness = DEVICE_BIG_ENDIAN,
>> +};
>> +
>> +static void pnv_nest1_realize(DeviceState *dev, Error **errp)
>> +{
>> +    PnvNest1 *nest1 = PNV_NEST1(dev);
>> +
>> +    /* perv chiplet initialize and realize */
>> +    object_initialize_child(OBJECT(nest1), "perv", &nest1->perv, TYPE_PNV_PERV);
>> +    object_property_set_str(OBJECT(&nest1->perv), "parent-obj-name", "nest1",
>> +                                   errp);
>> +    if (!qdev_realize(DEVICE(&nest1->perv), NULL, errp)) {
>> +        return;
>> +    }
>> +
>> +    /* Nest1 chiplet power bus EQ xscom region */
>> +    pnv_xscom_region_init(&nest1->xscom_pb_eq_regs, OBJECT(nest1),
>> +                          &pnv_nest1_pb_scom_eq_ops, nest1,
>> +                          "xscom-nest1-pb-scom-eq-regs",
>> +                          PNV10_XSCOM_NEST1_PB_SCOM_EQ_SIZE);
>> +
>> +    /* Nest1 chiplet power bus ES xscom region */
>> +    pnv_xscom_region_init(&nest1->xscom_pb_es_regs, OBJECT(nest1),
>> +                          &pnv_nest1_pb_scom_es_ops, nest1,
>> +                          "xscom-nest1-pb-scom-es-regs",
>> +                          PNV10_XSCOM_NEST1_PB_SCOM_ES_SIZE);
>> +}
>> +
>> +static int pnv_nest1_dt_xscom(PnvXScomInterface *dev, void *fdt,
>> +                             int offset)
>> +{
>> +    PnvNest1 *nest1 = PNV_NEST1(dev);
>> +    g_autofree char *name = NULL;
>> +    int nest1_offset = 0;
>> +    const char compat[] = "ibm,power10-nest1-chiplet";
>> +    uint32_t reg[] = {
>> +        cpu_to_be32(PNV10_XSCOM_NEST1_PB_SCOM_EQ_BASE),
>> +        cpu_to_be32(PNV10_XSCOM_NEST1_PB_SCOM_EQ_SIZE),
>> +        cpu_to_be32(PNV10_XSCOM_NEST1_PB_SCOM_ES_BASE),
>> +        cpu_to_be32(PNV10_XSCOM_NEST1_PB_SCOM_ES_SIZE)
>> +    };
>> +
>> +    /* populate perv_chiplet control_regs */
>> +    pnv_perv_dt(&nest1->perv, PNV10_XSCOM_NEST1_CTRL_CHIPLET_BASE, fdt, offset);
>> +
>> +    name = g_strdup_printf("nest1@%x", PNV10_XSCOM_NEST1_PB_SCOM_EQ_BASE);
>> +    nest1_offset = fdt_add_subnode(fdt, offset, name);
>> +    _FDT(nest1_offset);
>> +
>> +    _FDT(fdt_setprop(fdt, nest1_offset, "reg", reg, sizeof(reg)));
>> +    _FDT(fdt_setprop(fdt, nest1_offset, "compatible", compat, sizeof(compat)));
>> +    return 0;
>> +}
>> +
>> +static void pnv_nest1_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +    PnvXScomInterfaceClass *xscomc = PNV_XSCOM_INTERFACE_CLASS(klass);
>> +
>> +    xscomc->dt_xscom = pnv_nest1_dt_xscom;
>> +
>> +    dc->desc = "PowerNV nest1 chiplet";
>> +    dc->realize = pnv_nest1_realize;
>> +}
>> +
>> +static const TypeInfo pnv_nest1_info = {
>> +    .name          = TYPE_PNV_NEST1,
>> +    .parent        = TYPE_DEVICE,
>> +    .instance_size = sizeof(PnvNest1),
>> +    .class_init    = pnv_nest1_class_init,
>> +    .interfaces    = (InterfaceInfo[]) {
>> +        { TYPE_PNV_XSCOM_INTERFACE },
>> +        { }
>> +    }
>> +};
>> +
>> +static void pnv_nest1_register_types(void)
>> +{
>> +    type_register_static(&pnv_nest1_info);
>> +}
>> +
>> +type_init(pnv_nest1_register_types);
>> diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
>> index 37a7a8935d..7b8b87596a 100644
>> --- a/hw/ppc/meson.build
>> +++ b/hw/ppc/meson.build
>> @@ -52,6 +52,7 @@ ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
>>     'pnv_homer.c',
>>     'pnv_pnor.c',
>>     'pnv_pervasive.c',
>> +  'pnv_nest1_chiplet.c',
>>   ))
>>   # PowerPC 4xx boards
>>   ppc_ss.add(when: 'CONFIG_PPC405', if_true: files(
> 


