Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC63171267B
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 14:21:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2WQA-000398-Gc; Fri, 26 May 2023 08:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1q2WQ2-00032l-UK
 for qemu-devel@nongnu.org; Fri, 26 May 2023 08:19:43 -0400
Received: from 9.mo548.mail-out.ovh.net ([46.105.48.137])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1q2WPy-00084O-PX
 for qemu-devel@nongnu.org; Fri, 26 May 2023 08:19:42 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.4.36])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 6CBF622FF7;
 Fri, 26 May 2023 12:19:33 +0000 (UTC)
Received: from kaod.org (37.59.142.101) by DAG4EX2.mxp5.local (172.16.2.32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 26 May
 2023 14:19:32 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G00410c1e69a-c608-4523-ab11-be007501c3df,
 6F597A683095702A73A6C7CDE7888C96B2985428) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <05039b24-856a-ac38-10d9-c1defe0cb823@kaod.org>
Date: Fri, 26 May 2023 14:19:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH] pnv/chiptod: Add basic P9 chiptod model
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
To: Nicholas Piggin <npiggin@gmail.com>, <qemu-ppc@nongnu.org>
CC: <qemu-devel@nongnu.org>, Frederic Barrat <frederic.barrat@fr.ibm.com>
References: <20220811164024.1489017-1-npiggin@gmail.com>
 <a17f118c-c59c-ed77-4743-ae05cc1b5491@kaod.org>
Content-Language: en-US
In-Reply-To: <a17f118c-c59c-ed77-4743-ae05cc1b5491@kaod.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.101]
X-ClientProxiedBy: DAG4EX2.mxp5.local (172.16.2.32) To DAG4EX2.mxp5.local
 (172.16.2.32)
X-Ovh-Tracer-GUID: 51b3da89-361d-493f-821d-16ff7d38fbba
X-Ovh-Tracer-Id: 11805341999002651616
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejledggeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffhvfevfhgjtgfgihesthekredttdefjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeevveehteevjefggfeugfekhfduffeuhfekvdekheeiieeutdetueehfffgtdevteenucffohhmrghinhepghhnuhdrohhrghenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddruddtuddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoegtlhhgsehkrghougdrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepnhhpihhgghhinhesghhmrghilhdrtghomhdpqhgvmhhuqdhpphgtsehnohhnghhnuhdrohhrghdpqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdpfhhrvgguvghrihgtrdgsrghrrhgrthesfhhrrdhisghmrdgtohhmpdfovfetjfhoshhtpehmohehgeekpdhmohguvgepshhmthhpohhuth
Received-SPF: pass client-ip=46.105.48.137; envelope-from=clg@kaod.org;
 helo=9.mo548.mail-out.ovh.net
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.092,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 8/11/22 19:30, Cédric Le Goater wrote:
> On 8/11/22 18:40, Nicholas Piggin wrote:
>> The chiptod is a pervasive facility which can keep a time, synchronise
>> it across multiple chips, and can move that time to or from the core
>> timebase units.
>>
>> This adds a very basic initial emulation of chiptod registers. The
>> interesting thing about chiptod is that it targets cores and interacts
>> with core registers (e.g., TB, TFMR). So far there is no actual time
>> keeping or TB interaction, but core targeting and initial TFMR is
>> implemented.
>>
>> This implements enough for skiboot to boot and go through the chiptod
>> code (with a small patch to remove QUIRK_NO_CHIPTOD from qemu).
>>
>> POWER10 is much the same, not implemented yet because skiboot uses a
>> different core target addressing mode (due to hardware issues) that is
>> not implemented yet.
>>
>> This is not completely tidy yet, just thought I would see if there are
>> comments, particularly with the core TFMR interactions.
> 
> The TFMR implementation should be in its own patch.


This looked like an interesting extension to the baremetal models.
Did you abandon the idea ? if not, it would be good material for
QEMU 8.1.

Thanks,

C.


> 
>>
>> Thanks,
>> Nick
>>
>> ---
>>   hw/ppc/meson.build           |   1 +
>>   hw/ppc/pnv.c                 |   9 +
>>   hw/ppc/pnv_chiptod.c         | 320 +++++++++++++++++++++++++++++++++++
>>   hw/ppc/pnv_xscom.c           |   2 +
>>   hw/ppc/trace-events          |   4 +
>>   include/hw/ppc/pnv.h         |   2 +
>>   include/hw/ppc/pnv_chiptod.h |  51 ++++++
>>   include/hw/ppc/pnv_xscom.h   |   6 +
>>   target/ppc/cpu.h             |  13 ++
>>   target/ppc/cpu_init.c        |   2 +-
>>   target/ppc/helper.h          |   2 +
>>   target/ppc/misc_helper.c     |  25 +++
>>   target/ppc/spr_common.h      |   2 +
>>   target/ppc/translate.c       |  10 ++
>>   14 files changed, 448 insertions(+), 1 deletion(-)
>>   create mode 100644 hw/ppc/pnv_chiptod.c
>>   create mode 100644 include/hw/ppc/pnv_chiptod.h
>>
>> diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
>> index 62801923f3..7eb5031055 100644
>> --- a/hw/ppc/meson.build
>> +++ b/hw/ppc/meson.build
>> @@ -45,6 +45,7 @@ ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
>>     'pnv_core.c',
>>     'pnv_lpc.c',
>>     'pnv_psi.c',
>> +  'pnv_chiptod.c',
>>     'pnv_occ.c',
>>     'pnv_sbe.c',
>>     'pnv_bmc.c',
>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index 7ff1f464d3..bdd641381c 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -1395,6 +1395,8 @@ static void pnv_chip_power9_instance_init(Object *obj)
>>       object_initialize_child(obj, "lpc", &chip9->lpc, TYPE_PNV9_LPC);
>> +    object_initialize_child(obj, "chiptod", &chip9->chiptod, TYPE_PNV9_CHIPTOD);
>> +
>>       object_initialize_child(obj, "occ", &chip9->occ, TYPE_PNV9_OCC);
>>       object_initialize_child(obj, "sbe", &chip9->sbe, TYPE_PNV9_SBE);
>> @@ -1539,6 +1541,13 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
>>       chip->dt_isa_nodename = g_strdup_printf("/lpcm-opb@%" PRIx64 "/lpc@0",
>>                                               (uint64_t) PNV9_LPCM_BASE(chip));
>> +    /* ChipTOD */
>> +    if (!qdev_realize(DEVICE(&chip9->chiptod), NULL, errp)) {
>> +        return;
>> +    }
>> +    pnv_xscom_add_subregion(chip, PNV9_XSCOM_CHIPTOD_BASE,
>> +                            &chip9->chiptod.xscom_regs);
>> +
>>       /* Create the simplified OCC model */
>>       if (!qdev_realize(DEVICE(&chip9->occ), NULL, errp)) {
>>           return;
>> diff --git a/hw/ppc/pnv_chiptod.c b/hw/ppc/pnv_chiptod.c
>> new file mode 100644
>> index 0000000000..9ef463e640
>> --- /dev/null
>> +++ b/hw/ppc/pnv_chiptod.c
>> @@ -0,0 +1,320 @@
>> +/*
>> + * QEMU PowerPC PowerNV Emulation of some CHIPTOD behaviour
>> + *
>> + * Copyright (c) 2022, IBM Corporation.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License, version 2, as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "target/ppc/cpu.h"
>> +#include "qapi/error.h"
>> +#include "qemu/log.h"
>> +#include "qemu/module.h"
>> +#include "hw/irq.h"
>> +#include "hw/qdev-properties.h"
>> +#include "hw/ppc/fdt.h"
>> +#include "hw/ppc/pnv.h"
>> +#include "hw/ppc/pnv_xscom.h"
>> +#include "hw/ppc/pnv_chiptod.h"
>> +#include "trace.h"
>> +
>> +#include <libfdt.h>
>> +
>> +/* TOD chip XSCOM addresses */
>> +#define TOD_MASTER_PATH_CTRL            0x00000000 /* Master Path ctrl reg */
>> +#define TOD_PRI_PORT0_CTRL              0x00000001 /* Primary port0 ctrl reg */
>> +#define TOD_PRI_PORT1_CTRL              0x00000002 /* Primary port1 ctrl reg */
>> +#define TOD_SEC_PORT0_CTRL              0x00000003 /* Secondary p0 ctrl reg */
>> +#define TOD_SEC_PORT1_CTRL              0x00000004 /* Secondary p1 ctrl reg */
>> +#define TOD_SLAVE_PATH_CTRL             0x00000005 /* Slave Path ctrl reg */
>> +#define TOD_INTERNAL_PATH_CTRL          0x00000006 /* Internal Path ctrl reg */
>> +
>> +/* -- TOD primary/secondary master/slave control register -- */
>> +#define TOD_PSMS_CTRL                   0x00000007
>> +#define  TOD_PSMSC_PM_TOD_SELECT        PPC_BIT(1)  /* Primary Master TOD */
>> +#define  TOD_PSMSC_PM_DRAW_SELECT       PPC_BIT(2)  /* Primary Master Drawer */
>> +#define  TOD_PSMSC_SM_TOD_SELECT        PPC_BIT(9)  /* Secondary Master TOD */
>> +#define  TOD_PSMSC_SM_DRAW_SELECT       PPC_BIT(10) /* Secondary Master Draw */
>> +
>> +/* -- TOD primary/secondary master/slave status register -- */
>> +#define TOD_STATUS                      0x00000008
>> +#define   TOD_ST_TOPOLOGY_SELECT        PPC_BITMASK(0, 2)
>> +#define   TOD_ST_MPATH0_STEP_VALID      PPC_BIT(6)  /* MasterPath0 step valid */
>> +#define   TOD_ST_MPATH1_STEP_VALID      PPC_BIT(7)  /* MasterPath1 step valid */
>> +#define   TOD_ST_SPATH0_STEP_VALID      PPC_BIT(8)  /* SlavePath0 step valid */
>> +#define   TOD_ST_SPATH1_STEP_VALID      PPC_BIT(10) /* SlavePath1 step valid */
>> +/* Primary master/slave path select (0 = PATH_0, 1 = PATH_1) */
>> +#define   TOD_ST_PRI_MPATH_SELECT       PPC_BIT(12) /* Primary MPath Select */
>> +#define   TOD_ST_PRI_SPATH_SELECT       PPC_BIT(15) /* Primary SPath Select */
>> +/* Secondary master/slave path select (0 = PATH_0, 1 = PATH_1) */
>> +#define   TOD_ST_SEC_MPATH_SELECT       PPC_BIT(16) /* Secondary MPath Select */
>> +#define   TOD_ST_SEC_SPATH_SELECT       PPC_BIT(19) /* Secondary SPath Select */
>> +#define   TOD_ST_ACTIVE_MASTER          PPC_BIT(23)
>> +#define   TOD_ST_BACKUP_MASTER          PPC_BIT(24)
>> +
>> +/* TOD chip XSCOM addresses */
>> +#define TOD_CHIP_CTRL                   0x00000010 /* Chip control register */
>> +#define TOD_TTYPE_0                     0x00000011
>> +#define TOD_TTYPE_1                     0x00000012 /* PSS switch */
>> +#define TOD_TTYPE_2                     0x00000013 /* Enable step checkers */
>> +#define TOD_TTYPE_3                     0x00000014 /* Request TOD */
>> +#define TOD_TTYPE_4                     0x00000015 /* Send TOD */
>> +#define TOD_TTYPE_5                     0x00000016 /* Invalidate TOD */
>> +#define TOD_CHIPTOD_TO_TB               0x00000017
>> +#define TOD_LOAD_TOD_MOD                0x00000018
>> +#define TOD_CHIPTOD_VALUE               0x00000020
>> +#define TOD_CHIPTOD_LOAD_TB             0x00000021
>> +#define TOD_CHIPTOD_FSM                 0x00000024
>> +
>> +/* -- TOD PIB Master reg -- */
>> +#define TOD_PIB_MASTER                  0x00000027
>> +#define   TOD_PIBM_ADDR_CFG_MCAST       PPC_BIT(25)
>> +#define   TOD_PIBM_ADDR_CFG_SLADDR      PPC_BITMASK(26, 31)
>> +#define   TOD_PIBM_TTYPE4_SEND_MODE     PPC_BIT(32)
>> +#define   TOD_PIBM_TTYPE4_SEND_ENBL     PPC_BIT(33)
>> +
>> +/* -- TOD Error interrupt register -- */
>> +#define TOD_ERROR                       0x00000030
>> +/* SYNC errors */
>> +#define   TOD_ERR_CRMO_PARITY           PPC_BIT(0)
>> +#define   TOD_ERR_OSC0_PARITY           PPC_BIT(1)
>> +#define   TOD_ERR_OSC1_PARITY           PPC_BIT(2)
>> +#define   TOD_ERR_PPORT0_CREG_PARITY    PPC_BIT(3)
>> +#define   TOD_ERR_PPORT1_CREG_PARITY    PPC_BIT(4)
>> +#define   TOD_ERR_SPORT0_CREG_PARITY    PPC_BIT(5)
>> +#define   TOD_ERR_SPORT1_CREG_PARITY    PPC_BIT(6)
>> +#define   TOD_ERR_SPATH_CREG_PARITY     PPC_BIT(7)
>> +#define   TOD_ERR_IPATH_CREG_PARITY     PPC_BIT(8)
>> +#define   TOD_ERR_PSMS_CREG_PARITY      PPC_BIT(9)
>> +#define   TOD_ERR_CRITC_PARITY          PPC_BIT(13)
>> +#define   TOD_ERR_MP0_STEP_CHECK        PPC_BIT(14)
>> +#define   TOD_ERR_MP1_STEP_CHECK        PPC_BIT(15)
>> +#define   TOD_ERR_PSS_HAMMING_DISTANCE  PPC_BIT(18)
>> +#define   TOD_ERR_DELAY_COMPL_PARITY    PPC_BIT(22)
>> +/* CNTR errors */
>> +#define   TOD_ERR_CTCR_PARITY           PPC_BIT(32)
>> +#define   TOD_ERR_TOD_SYNC_CHECK        PPC_BIT(33)
>> +#define   TOD_ERR_TOD_FSM_PARITY        PPC_BIT(34)
>> +#define   TOD_ERR_TOD_REGISTER_PARITY   PPC_BIT(35)
>> +#define   TOD_ERR_OVERFLOW_YR2042       PPC_BIT(36)
>> +#define   TOD_ERR_TOD_WOF_LSTEP_PARITY  PPC_BIT(37)
>> +#define   TOD_ERR_TTYPE0_RECVD          PPC_BIT(38)
>> +#define   TOD_ERR_TTYPE1_RECVD          PPC_BIT(39)
>> +#define   TOD_ERR_TTYPE2_RECVD          PPC_BIT(40)
>> +#define   TOD_ERR_TTYPE3_RECVD          PPC_BIT(41)
>> +#define   TOD_ERR_TTYPE4_RECVD          PPC_BIT(42)
>> +#define   TOD_ERR_TTYPE5_RECVD          PPC_BIT(43)
>> +
>> +/* -- TOD Error interrupt register -- */
>> +#define TOD_ERROR_INJECT                0x00000031
>> +
>> +/* PC unit PIB address which recieves the timebase transfer from TOD */
>> +#define   PC_TOD                        0x4A3
>> +
>> +static uint64_t pnv_chiptod_xscom_read(void *opaque, hwaddr addr,
>> +                                          unsigned size)
>> +{
>> +    PnvChipTOD *chiptod = PNV_CHIPTOD(opaque);
>> +    uint32_t offset = addr >> 3;
>> +    uint64_t val = 0;
>> +
>> +    switch (offset) {
>> +    case TOD_ERROR:
>> +        val = chiptod->tod_error;
>> +        break;
>> +    case TOD_CHIPTOD_FSM:
>> +        if (chiptod->tod_state == tod_running) {
>> +            val |= PPC_BIT(4);
>> +        }
>> +        break;
>> +    default:
>> +        qemu_log_mask(LOG_UNIMP, "CHIPTOD Unimplemented register: Ox%"
>> +                      HWADDR_PRIx "\n", addr >> 3);
>> +    }
>> +
>> +    trace_pnv_chiptod_xscom_read(addr >> 3, val);
>> +
>> +    return val;
>> +}
>> +
>> +static void pnv_chiptod_xscom_write(void *opaque, hwaddr addr,
>> +                                       uint64_t val, unsigned size)
>> +{
>> +    PnvChipTOD *chiptod = PNV_CHIPTOD(opaque);
>> +    uint32_t offset = addr >> 3;
>> +
>> +    trace_pnv_chiptod_xscom_write(addr >> 3, val);
>> +
>> +    switch (offset) {
>> +    case TOD_PIB_MASTER:
>> +        if (val & PPC_BIT(35)) {
>> +            /* SCOM addressing */
>> +            /* XXX: todo */
>> +        } else {
>> +            /* PIR addressing */
>> +            /* This implementation is POWER9 specific */
>> +            uint32_t pir = (GETFIELD(TOD_PIBM_ADDR_CFG_SLADDR, val) & 0x1f) << 2;
>> +            CPUState *cs;
>> +
>> +            chiptod->slave_cpu_target = NULL;
>> +            CPU_FOREACH(cs) {
>> +                PowerPCCPU *cpu = POWERPC_CPU(cs);
>> +                CPUPPCState *env = &cpu->env;
>> +                if (env->spr_cb[SPR_PIR].default_value == pir) {
>> +                    chiptod->slave_cpu_target = cpu;
>> +                    break;
>> +                }
>> +            }
> 
> You could use :
> 
>      chiptod->slave_cpu_target = ppc_get_vcpu_by_pir(pir).
> 
> 
>> +            if (chiptod->slave_cpu_target == NULL) {
>> +                printf("CHIPTOD NO SLAVE!\n");
> 
> It should be a guest error.
> 
>> +            }
>> +        }
>> +        break;
>> +    case TOD_ERROR:
>> +        chiptod->tod_error &= ~val;
>> +        break;
>> +    case TOD_LOAD_TOD_MOD:
>> +        chiptod->tod_state = tod_not_set;
>> +        break;
>> +    case TOD_CHIPTOD_LOAD_TB:
>> +        chiptod->tod_state = tod_running;
>> +        break;
>> +    case TOD_CHIPTOD_TO_TB:
>> +        if (chiptod->slave_cpu_target == NULL) {
>> +            printf("CHIPTOD NO SLAVE!\n");
> 
> It should be a guest error.
> 
>> +        } else {
>> +            PowerPCCPU *cpu = chiptod->slave_cpu_target;
>> +            CPUPPCState *env = &cpu->env;
>> +            uint64_t tfmr = env->spr[SPR_TFMR];
>> +
>> +            if (!(tfmr & TFMR_MOVE_CHIP_TOD_TO_TB)) {
>> +                printf("CORE TFMR NOT READY TO RECEIVE!\n");
>> +                break;
>> +            }
>> +            env->spr[SPR_TFMR] &= ~TFMR_MOVE_CHIP_TOD_TO_TB;
>> +            env->spr[SPR_TFMR] |= TFMR_TB_VALID;
>> +        }
>> +        break;
>> +    default:
>> +        qemu_log_mask(LOG_UNIMP, "CHIPTOD Unimplemented register: Ox%"
>> 7+                      HWADDR_PRIx "\n", addr >> 3);
>> +    }
>> +}
>> +
>> +static const MemoryRegionOps pnv_chiptod_xscom_ops = {
>> +    .read = pnv_chiptod_xscom_read,
>> +    .write = pnv_chiptod_xscom_write,
>> +    .valid.min_access_size = 8,
>> +    .valid.max_access_size = 8,
>> +    .impl.min_access_size = 8,
>> +    .impl.max_access_size = 8,
>> +    .endianness = DEVICE_BIG_ENDIAN,
>> +};
>> +
>> +static int pnv_chiptod_dt_xscom(PnvXScomInterface *dev, void *fdt,
>> +                                int xscom_offset,
>> +                                const char compat[], size_t compat_size)
>> +{
>> +    static bool primary = false;
>> +    char *name;
>> +    int offset;
>> +    uint32_t lpc_pcba = PNV9_XSCOM_CHIPTOD_BASE;
>> +    uint32_t reg[] = {
>> +        cpu_to_be32(lpc_pcba),
>> +        cpu_to_be32(PNV9_XSCOM_CHIPTOD_SIZE)
>> +    };
>> +
>> +    name = g_strdup_printf("chiptod@%x", lpc_pcba);
>> +    offset = fdt_add_subnode(fdt, xscom_offset, name);
>> +    _FDT(offset);
>> +    g_free(name);
>> +
>> +    if (!primary) {
>> +        primary = true;
>> +        _FDT((fdt_setprop(fdt, offset, "primary", NULL, 0)));
>> +    }
>> +
>> +    _FDT((fdt_setprop(fdt, offset, "reg", reg, sizeof(reg))));
>> +    _FDT((fdt_setprop(fdt, offset, "compatible", compat, compat_size)));
>> +    return 0;
>> +}
>> +
>> +static int pnv_chiptod_power9_dt_xscom(PnvXScomInterface *dev, void *fdt,
>> +                             int xscom_offset)
>> +{
>> +    const char compat[] = "ibm,power-chiptod\0ibm,power9-chiptod";
>> +
>> +    return pnv_chiptod_dt_xscom(dev, fdt, xscom_offset, compat, sizeof(compat));
>> +}
>> +
>> +static void pnv_chiptod_power9_class_init(ObjectClass *klass, void *data)
>> +{
>> +//    PnvChipTODClass *psc = PNV_CHIPTOD_CLASS(klass);
> 
> That's a left over I guess ?
> 
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +    PnvXScomInterfaceClass *xdc = PNV_XSCOM_INTERFACE_CLASS(klass);
>> +
>> +    dc->desc = "PowerNV CHIPTOD Controller (POWER9)";
>> +
>> +    xdc->dt_xscom = pnv_chiptod_power9_dt_xscom;
>> +}
>> +
>> +static const TypeInfo pnv_chiptod_power9_type_info = {
>> +    .name          = TYPE_PNV9_CHIPTOD,
>> +    .parent        = TYPE_PNV_CHIPTOD,
>> +    .instance_size = sizeof(PnvChipTOD),
>> +    .class_init    = pnv_chiptod_power9_class_init,
>> +    .interfaces    = (InterfaceInfo[]) {
>> +        { TYPE_PNV_XSCOM_INTERFACE },
>> +        { }
>> +    }
>> +};
>> +
>> +static void pnv_chiptod_realize(DeviceState *dev, Error **errp)
>> +{
>> +    PnvChipTOD *chiptod = PNV_CHIPTOD(dev);
>> +//    PnvChipTODClass *psc = PNV_CHIPTOD_GET_CLASS(chiptod);
>> +
>> +    chiptod->tod_state = tod_running;
>> +
>> +    /* XScom regions for CHIPTOD registers */
>> +    pnv_xscom_region_init(&chiptod->xscom_regs, OBJECT(dev),
>> +                          &pnv_chiptod_xscom_ops, chiptod, "xscom-chiptod",
>> +                          PNV_XSCOM_CHIPTOD_SIZE);
>> +}
>> +
>> +static void pnv_chiptod_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +
>> +    dc->realize = pnv_chiptod_realize;
>> +    dc->desc = "PowerNV ChipTOD Controller";
>> +    dc->user_creatable = false;
>> +}
>> +
>> +static const TypeInfo pnv_chiptod_type_info = {
>> +    .name          = TYPE_PNV_CHIPTOD,
>> +    .parent        = TYPE_DEVICE,
>> +    .instance_size = sizeof(PnvChipTOD),
>> +    .class_init    = pnv_chiptod_class_init,
>> +    .class_size    = sizeof(PnvChipTODClass),
>> +    .abstract      = true,
>> +};
>> +
>> +static void pnv_chiptod_register_types(void)
>> +{
>> +    type_register_static(&pnv_chiptod_type_info);
>> +    type_register_static(&pnv_chiptod_power9_type_info);
>> +}
>> +
>> +type_init(pnv_chiptod_register_types);
>> diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
>> index 79f10de57f..10d2d9edd4 100644
>> --- a/hw/ppc/pnv_xscom.c
>> +++ b/hw/ppc/pnv_xscom.c
>> @@ -297,6 +297,8 @@ int pnv_dt_xscom(PnvChip *chip, void *fdt, int root_offset,
>>       _FDT((fdt_setprop(fdt, xscom_offset, "scom-controller", NULL, 0)));
>>       if (chip->chip_id == 0) {
>>           _FDT((fdt_setprop(fdt, xscom_offset, "primary", NULL, 0)));
>> +    } else if (chip->chip_id == 1) {
>> +        _FDT((fdt_setprop(fdt, xscom_offset, "secondary", NULL, 0)));
>>       }
>>       args.fdt = fdt;
>> diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
>> index f6990439d1..60c0a1c42c 100644
>> --- a/hw/ppc/trace-events
>> +++ b/hw/ppc/trace-events
>> @@ -95,6 +95,10 @@ vof_write(uint32_t ih, unsigned cb, const char *msg) "ih=0x%x [%u] \"%s\""
>>   vof_avail(uint64_t start, uint64_t end, uint64_t size) "0x%"PRIx64"..0x%"PRIx64" size=0x%"PRIx64
>>   vof_claimed(uint64_t start, uint64_t end, uint64_t size) "0x%"PRIx64"..0x%"PRIx64" size=0x%"PRIx64
>> +# pnv_chiptod.c
>> +pnv_chiptod_xscom_read(uint64_t addr, uint64_t val) "addr 0x%" PRIx64 " val 0x%" PRIx64
>> +pnv_chiptod_xscom_write(uint64_t addr, uint64_t val) "addr 0x%" PRIx64 " val 0x%" PRIx64
>> +
>>   # pnv_sbe.c
>>   pnv_sbe_xscom_ctrl_read(uint64_t addr, uint64_t val) "addr 0x%" PRIx64 " val 0x%" PRIx64
>>   pnv_sbe_xscom_ctrl_write(uint64_t addr, uint64_t val) "addr 0x%" PRIx64 " val 0x%" PRIx64
>> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
>> index 37c303bf36..501e9b0138 100644
>> --- a/include/hw/ppc/pnv.h
>> +++ b/include/hw/ppc/pnv.h
>> @@ -26,6 +26,7 @@
>>   #include "hw/ppc/pnv_lpc.h"
>>   #include "hw/ppc/pnv_pnor.h"
>>   #include "hw/ppc/pnv_psi.h"
>> +#include "hw/ppc/pnv_chiptod.h"
>>   #include "hw/ppc/pnv_occ.h"
>>   #include "hw/ppc/pnv_sbe.h"
>>   #include "hw/ppc/pnv_homer.h"
>> @@ -100,6 +101,7 @@ struct Pnv9Chip {
>>       PnvXive      xive;
>>       Pnv9Psi      psi;
>>       PnvLpcController lpc;
>> +    PnvChipTOD   chiptod;
>>       PnvOCC       occ;
>>       PnvSBE       sbe;
>>       PnvHomer     homer;
>> diff --git a/include/hw/ppc/pnv_chiptod.h b/include/hw/ppc/pnv_chiptod.h
>> new file mode 100644
>> index 0000000000..44700bbd81
>> --- /dev/null
>> +++ b/include/hw/ppc/pnv_chiptod.h
>> @@ -0,0 +1,51 @@
>> +/*
>> + * QEMU PowerPC PowerNV Emulation of some CHIPTOD behaviour
>> + *
>> + * Copyright (c) 2022, IBM Corporation.
>> + *
>> + * This library is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU Lesser General Public
>> + * License as published by the Free Software Foundation; either
>> + * version 2.1 of the License, or (at your option) any later version.
>> + *
>> + * This library is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * Lesser General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU Lesser General Public
>> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#ifndef PPC_PNV_CHIPTOD_H
>> +#define PPC_PNV_CHIPTOD_H
>> +
>> +#include "qom/object.h"
>> +
>> +#define TYPE_PNV_CHIPTOD "pnv-chiptod"
>> +OBJECT_DECLARE_TYPE(PnvChipTOD, PnvChipTODClass, PNV_CHIPTOD)
>> +#define TYPE_PNV9_CHIPTOD TYPE_PNV_CHIPTOD "-POWER9"
>> +DECLARE_INSTANCE_CHECKER(PnvChipTOD, PNV9_CHIPTOD, TYPE_PNV9_CHIPTOD)
>> +#define TYPE_PNV10_CHIPTOD TYPE_PNV_CHIPTOD "-POWER10"
>> +DECLARE_INSTANCE_CHECKER(PnvChipTOD, PNV10_CHIPTOD, TYPE_PNV10_CHIPTOD)
>> +
>> +enum tod_state {
>> +    tod_running = 1,
>> +    tod_not_set,
>> +};
>> +
>> +struct PnvChipTOD {
>> +    DeviceState xd;
>> +
>> +    enum tod_state tod_state;
>> +    uint64_t tod_error;
>> +    PowerPCCPU *slave_cpu_target;
>> +
>> +    MemoryRegion xscom_regs;
>> +};
>> +
>> +struct PnvChipTODClass {
>> +    DeviceClass parent_class;
> 
> Will PnvChipTODClass become useful with P10 ?
> 
>> +};
>> +
>> +#endif /* PPC_PNV_CHIPTOD_H */
>> diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
>> index c6e9ef8dd2..a8bd15401f 100644
>> --- a/include/hw/ppc/pnv_xscom.h
>> +++ b/include/hw/ppc/pnv_xscom.h
>> @@ -63,6 +63,9 @@ struct PnvXScomInterfaceClass {
>>   #define PNV_XSCOM_PSIHB_BASE      0x2010900
>>   #define PNV_XSCOM_PSIHB_SIZE      0x20
>> +#define PNV_XSCOM_CHIPTOD_BASE    0x0040000
>> +#define PNV_XSCOM_CHIPTOD_SIZE    0x31
>> +
>>   #define PNV_XSCOM_OCC_BASE        0x0066000
>>   #define PNV_XSCOM_OCC_SIZE        0x6000
>> @@ -89,6 +92,9 @@ struct PnvXScomInterfaceClass {
>>       ((uint64_t)(((core) & 0x1C) + 0x40) << 22)
>>   #define PNV9_XSCOM_EQ_SIZE        0x100000
>> +#define PNV9_XSCOM_CHIPTOD_BASE   PNV_XSCOM_CHIPTOD_BASE
>> +#define PNV9_XSCOM_CHIPTOD_SIZE   PNV_XSCOM_CHIPTOD_SIZE
>> +
>>   #define PNV9_XSCOM_OCC_BASE       PNV_XSCOM_OCC_BASE
>>   #define PNV9_XSCOM_OCC_SIZE       0x8000
>> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
>> index a4c893cfad..7edb3447fa 100644
>> --- a/target/ppc/cpu.h
>> +++ b/target/ppc/cpu.h
>> @@ -1135,6 +1135,11 @@ struct CPUArchState {
>>       uint32_t tlb_need_flush; /* Delayed flush needed */
>>   #define TLB_NEED_LOCAL_FLUSH   0x1
>>   #define TLB_NEED_GLOBAL_FLUSH  0x2
>> +
>> +#if defined(TARGET_PPC64)
>> +    /* PowerNV timebase facility */
>> +    int tfmr_op_timeout;
>> +#endif
>>   #endif
>>       /* Other registers */
>> @@ -2471,6 +2476,14 @@ enum {
>>       HMER_XSCOM_STATUS_MASK      = PPC_BITMASK(21, 23),
>>   };
>> +/* TFMR */
>> +enum {
>> +    TFMR_LOAD_TOD_MOD           = PPC_BIT(16),
>> +    TFMR_MOVE_CHIP_TOD_TO_TB    = PPC_BIT(18),
>> +    TFMR_CLEAR_TB_ERRORS        = PPC_BIT(24),
>> +    TFMR_TB_VALID               = PPC_BIT(41),
>> +};
>> +
>>   /*****************************************************************************/
>>   #define is_isa300(ctx) (!!(ctx->insns_flags2 & PPC2_ISA300))
>> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
>> index d1493a660c..6d555e16b9 100644
>> --- a/target/ppc/cpu_init.c
>> +++ b/target/ppc/cpu_init.c
>> @@ -5392,7 +5392,7 @@ static void register_book3s_ids_sprs(CPUPPCState *env)
>>       spr_register_hv(env, SPR_TFMR, "TFMR",
>>                    SPR_NOACCESS, SPR_NOACCESS,
>>                    SPR_NOACCESS, SPR_NOACCESS,
>> -                 &spr_read_generic, &spr_write_generic,
>> +                 &spr_read_tfmr, &spr_write_tfmr,
>>                    0x00000000);
>>       spr_register_hv(env, SPR_LPIDR, "LPIDR",
>>                    SPR_NOACCESS, SPR_NOACCESS,
>> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
>> index 159b352f6e..643c9457c7 100644
>> --- a/target/ppc/helper.h
>> +++ b/target/ppc/helper.h
>> @@ -720,6 +720,8 @@ DEF_HELPER_FLAGS_1(load_dpdes, TCG_CALL_NO_RWG, tl, env)
>>   DEF_HELPER_FLAGS_2(store_dpdes, TCG_CALL_NO_RWG, void, env, tl)
>>   DEF_HELPER_2(book3s_msgsndp, void, env, tl)
>>   DEF_HELPER_2(book3s_msgclrp, void, env, tl)
>> +DEF_HELPER_1(load_tfmr, tl, env)
>> +DEF_HELPER_2(store_tfmr, void, env, tl)
>>   #endif
>>   DEF_HELPER_2(store_sdr1, void, env, tl)
>>   DEF_HELPER_2(store_pidr, void, env, tl)
>> diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
>> index b0a5e7ce76..d979d936b3 100644
>> --- a/target/ppc/misc_helper.c
>> +++ b/target/ppc/misc_helper.c
>> @@ -191,6 +191,31 @@ void helper_store_dpdes(CPUPPCState *env, target_ulong val)
>>           env->pending_interrupts &= ~(1 << PPC_INTERRUPT_DOORBELL);
>>       }
>>   }
>> +
>> +target_ulong helper_load_tfmr(CPUPPCState *env)
>> +{
>> +    if (env->tfmr_op_timeout) {
>> +        env->tfmr_op_timeout--;
>> +        if (!env->tfmr_op_timeout) {
>> +            env->spr[SPR_TFMR] &= ~(TFMR_LOAD_TOD_MOD |
>> +                                    TFMR_CLEAR_TB_ERRORS);
>> +        }
>> +    }
>> +
>> +    return env->spr[SPR_TFMR];
>> +}
>> +
>> +void helper_store_tfmr(CPUPPCState *env, target_ulong val)
>> +{
>> +    env->spr[SPR_TFMR] = val;
>> +
>> +    if (val & TFMR_LOAD_TOD_MOD) {
>> +        env->tfmr_op_timeout = 3;
> 
> why 3 ?
> 
>> +    }
>> +    if (val & TFMR_CLEAR_TB_ERRORS) {
>> +        env->tfmr_op_timeout = 3;
>> +    }
>> +}
> 
> This should generate an exception if not in HV mode ?
> 
>>   #endif /* defined(TARGET_PPC64) */
>>   void helper_store_pidr(CPUPPCState *env, target_ulong val)
>> diff --git a/target/ppc/spr_common.h b/target/ppc/spr_common.h
>> index b5a5bc6895..7acf7df451 100644
>> --- a/target/ppc/spr_common.h
>> +++ b/target/ppc/spr_common.h
>> @@ -194,6 +194,8 @@ void spr_write_ebb(DisasContext *ctx, int sprn, int gprn);
>>   void spr_read_ebb_upper32(DisasContext *ctx, int gprn, int sprn);
>>   void spr_write_ebb_upper32(DisasContext *ctx, int sprn, int gprn);
>>   void spr_write_hmer(DisasContext *ctx, int sprn, int gprn);
>> +void spr_read_tfmr(DisasContext *ctx, int sprn, int gprn);
>> +void spr_write_tfmr(DisasContext *ctx, int sprn, int gprn);
>>   void spr_write_lpcr(DisasContext *ctx, int sprn, int gprn);
>>   #endif
>> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
>> index 388337f81b..e235334944 100644
>> --- a/target/ppc/translate.c
>> +++ b/target/ppc/translate.c
>> @@ -1173,6 +1173,16 @@ void spr_write_hmer(DisasContext *ctx, int sprn, int gprn)
>>       tcg_temp_free(hmer);
>>   }
>> +void spr_read_tfmr(DisasContext *ctx, int gprn, int sprn)
>> +{
>> +    gen_helper_load_tfmr(cpu_gpr[gprn], cpu_env);
>> +}
>> +
>> +void spr_write_tfmr(DisasContext *ctx, int sprn, int gprn)
>> +{
>> +    gen_helper_store_tfmr(cpu_env, cpu_gpr[gprn]);
>> +}
>> +
>>   void spr_write_lpcr(DisasContext *ctx, int sprn, int gprn)
>>   {
>>       gen_helper_store_lpcr(cpu_env, cpu_gpr[gprn]);
> 


