Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7D37F6653
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 19:36:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6EXV-0007DM-AG; Thu, 23 Nov 2023 13:35:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=WthQ=HE=kaod.org=clg@ozlabs.org>)
 id 1r6EXT-0007D5-De; Thu, 23 Nov 2023 13:34:59 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=WthQ=HE=kaod.org=clg@ozlabs.org>)
 id 1r6EXQ-000261-UE; Thu, 23 Nov 2023 13:34:59 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SbmxQ0znZz4x5M;
 Fri, 24 Nov 2023 05:34:50 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SbmxM3qQbz4xWG;
 Fri, 24 Nov 2023 05:34:47 +1100 (AEDT)
Message-ID: <3d3e74bc-d19a-4c45-a23d-de9a3bdc81bf@kaod.org>
Date: Thu, 23 Nov 2023 19:34:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] pnv/chiptod: Implement the ChipTOD to Core transfer
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 qemu-devel@nongnu.org
References: <20231123103018.172383-1-npiggin@gmail.com>
 <20231123103018.172383-6-npiggin@gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231123103018.172383-6-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=WthQ=HE=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

On 11/23/23 11:30, Nicholas Piggin wrote:
> One of the functions of the ChipTOD is to transfer TOD to the Core
> (aka PC - Pervasive Core) timebase facility.
> 
> The ChipTOD can be programmed with a target address to send the TOD
> value to. The hardware implementation seems to perform this by
> sending the TOD value to a SCOM addres.

address

> 
> This implementation grabs the core directly and manipulates the
> timebase facility state in the core. This is a hack, but it works
> enough for now. A better implementation would implement the transfer
> to the PnvCore xscom register and drive the timebase state machine
> from there.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   include/hw/ppc/pnv_chiptod.h |  3 ++
>   include/hw/ppc/pnv_core.h    |  4 ++
>   target/ppc/cpu.h             |  7 +++
>   hw/ppc/pnv.c                 | 33 +++++++++++++
>   hw/ppc/pnv_chiptod.c         | 92 ++++++++++++++++++++++++++++++++++++
>   5 files changed, 139 insertions(+)
> 
> diff --git a/include/hw/ppc/pnv_chiptod.h b/include/hw/ppc/pnv_chiptod.h
> index e2765c3bfc..ffcc376e80 100644
> --- a/include/hw/ppc/pnv_chiptod.h
> +++ b/include/hw/ppc/pnv_chiptod.h
> @@ -29,6 +29,8 @@ enum tod_state {
>       tod_stopped = 1,
>   };
>   
> +typedef struct PnvCore PnvCore;
> +
>   struct PnvChipTOD {
>       DeviceState xd;
>   
> @@ -40,6 +42,7 @@ struct PnvChipTOD {
>       enum tod_state tod_state;
>       uint64_t tod_error;
>       uint64_t pss_mss_ctrl_reg;
> +    PnvCore *slave_pc_target;
>   };
>   
>   struct PnvChipTODClass {
> diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
> index 4db21229a6..5f52ae7dbf 100644
> --- a/include/hw/ppc/pnv_core.h
> +++ b/include/hw/ppc/pnv_core.h
> @@ -85,4 +85,8 @@ struct PnvQuad {
>       MemoryRegion xscom_regs;
>       MemoryRegion xscom_qme_regs;
>   };
> +
> +PnvCore *pnv_get_core_by_xscom_base(PnvChip *chip, uint32_t xscom_base);
> +PnvCore *pnv_get_core_by_id(PnvChip *chip, uint32_t core_id);
> +
>   #endif /* PPC_PNV_CORE_H */
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 848e583c2d..8df5626939 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1258,6 +1258,13 @@ struct CPUArchState {
>       uint32_t tlb_need_flush; /* Delayed flush needed */
>   #define TLB_NEED_LOCAL_FLUSH   0x1
>   #define TLB_NEED_GLOBAL_FLUSH  0x2
> +
> +#if defined(TARGET_PPC64)
> +    /* Would be nice to put these into PnvCore */

This is going to be complex to do from the insn implementation.


> +    /* PowerNV chiptod / timebase facility state. */
> +    int tb_ready_for_tod; /* core TB ready to receive TOD from chiptod */
> +    int tod_sent_to_tb;   /* chiptod sent TOD to the core TB */
> +#endif
>   #endif
>   
>       /* Other registers */
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 546266ae3d..fa0dc26732 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -2032,6 +2032,39 @@ static void pnv_chip_core_realize(PnvChip *chip, Error **errp)
>       }
>   }
>   
> +PnvCore *pnv_get_core_by_xscom_base(PnvChip *chip, uint32_t xscom_base)

please use a pnv_chip_ prefix and move this routine definition in file
pnv_chiptod.c if possible. We don't want this routine to be used too
widely ... if not possible, please add a comment saying this is a
shortcut to avoid complex modeling of HW which is not exposed to the
software. In any case, add the comment.

> +{
> +    PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
> +    int i;
> +
> +    for (i = 0; i < chip->nr_cores; i++) {
> +        PnvCore *pc = chip->cores[i];
> +        CPUCore *cc = CPU_CORE(pc);
> +        int core_hwid = cc->core_id;
> +
> +        if (pcc->xscom_core_base(chip, core_hwid) == xscom_base) {
> +            return pc;
> +        }
> +    }
> +    return NULL;
> +}
> +
> +PnvCore *pnv_get_core_by_id(PnvChip *chip, uint32_t core_id)

please use a pnv_chip_ prefix and move this routine definition close
to pnv_chip_find_cpu()

> +{
> +    int i;
> +
> +    for (i = 0; i < chip->nr_cores; i++) {
> +        PnvCore *pc = chip->cores[i];
> +        CPUCore *cc = CPU_CORE(pc);
> +
> +        if (cc->core_id == core_id) {
> +            return pc;
> +        }
> +    }
> +    return NULL;
> +}
> +
> +
>   static void pnv_chip_realize(DeviceState *dev, Error **errp)
>   {
>       PnvChip *chip = PNV_CHIP(dev);
> diff --git a/hw/ppc/pnv_chiptod.c b/hw/ppc/pnv_chiptod.c
> index a7bfe4298d..a2c1c83800 100644
> --- a/hw/ppc/pnv_chiptod.c
> +++ b/hw/ppc/pnv_chiptod.c
> @@ -201,6 +201,62 @@ static void pnv_chiptod_xscom_write(void *opaque, hwaddr addr,
>           chiptod->pss_mss_ctrl_reg = val & PPC_BITMASK(0, 31);
>           break;
>   
> +    case TOD_TX_TTYPE_CTRL_REG:
> +        /*
> +         * This register sets the target of the TOD value transfer initiated
> +         * by TOD_MOVE_TOD_TO_TB. The TOD is able to send the address to
> +         * any target register, though in practice only the PC TOD register
> +         * should be used. ChipTOD has a "SCOM addressing" mode which fully
> +         * specifies the SCOM address, and a core-ID mode which uses the
> +         * core ID to target the PC TOD for a given core.
> +         *
> +         * skiboot uses SCOM for P10 and ID for P9, possibly due to hardware
> +         * weirdness. For this reason, that is all we implement here.
> +         */
> +        if (val & PPC_BIT(35)) { /* SCOM addressing */
> +            uint32_t addr2 = val >> 32;
> +            uint32_t reg = addr2 & 0xfff;
> +
> +            if (reg != PC_TOD) {
> +                qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: SCOM addressing: "
> +                              "unimplemented slave register 0x%" PRIx32 "\n",
> +                              reg);
> +                return;
> +            }
> +
> +            /*
> +             * This may not deal with P10 big-core addressing at the moment.
> +             * The big-core code in skiboot syncs small cores, but it targets
> +             * the even PIR (first small-core) when syncing second small-core.
> +             */
> +            chiptod->slave_pc_target =
> +                    pnv_get_core_by_xscom_base(chiptod->chip, addr2 & ~0xfff);
> +            if (!chiptod->slave_pc_target) {
> +                qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: xscom write reg"
> +                              " TOD_TX_TTYPE_CTRL_REG val 0x%" PRIx64
> +                              " invalid slave XSCOM address\n", val);
> +            }
So this is preparing the chiptod to initiate a SCOM memop on the
targetted core.

> +        } else { /* PIR addressing */
> +            uint32_t core_id;

I suppose "PIR addressing" is the previous way of doing the same.

> +
> +            if (!is_power9) {

Please transform 'is_power9' into a class attribute

    bool PnvChipTODClass::pir_addressing

> +                qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: PIR addressing"
> +                              " is only implemented for POWER9\n");

".... for POWER10" or "for this CPU"


> +                return;
> +            }
> +
> +            core_id = GETFIELD(TOD_TX_TTYPE_PIB_SLAVE_ADDR, val) & 0x1f;
> +            chiptod->slave_pc_target = pnv_get_core_by_id(chiptod->chip,
> +                                                           core_id);
> +            if (!chiptod->slave_pc_target) {
> +                qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: xscom write reg"
> +                              " TOD_TX_TTYPE_CTRL_REG val 0x%" PRIx64
> +                              " invalid slave core ID 0x%" PRIx32 "\n",
> +                              val, core_id);
> +            }
> +        }
> +        break;
>       case TOD_ERROR_REG:
>           chiptod->tod_error &= ~val;
>           break;
> @@ -215,6 +271,42 @@ static void pnv_chiptod_xscom_write(void *opaque, hwaddr addr,
>       case TOD_LOAD_TOD_REG:
>           chiptod->tod_state = tod_running;
>           break;
> +    case TOD_MOVE_TOD_TO_TB_REG:
> +        /*
> +         * XXX: it should be a cleaner model to have this drive a SCOM
> +         * transaction to the target address, and implement the state machine
> +         * in the PnvCore. For now, this hack makes things work.
> +         */
> +        if (!(val & PPC_BIT(0))) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: xscom write reg"
> +                          " TOD_MOVE_TOD_TO_TB_REG with bad val 0x%016lx\n",

Use PRIx64 please


> +                          val);
> +        } else if (chiptod->slave_pc_target == NULL) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: xscom write reg"
> +                          " TOD_MOVE_TOD_TO_TB_REG with no slave target\n");
> +        } else {
> +            PowerPCCPU *cpu = chiptod->slave_pc_target->threads[0];
> +            CPUPPCState *env = &cpu->env;
> +
> +            /*
> +             * Moving TOD to TB will set the TB of all threads in a
> +             * core, so skiboot only does this once per thread0, so
> +             * that is where we keep the timebase state machine.
> +             *
> +             * It is likely possible for TBST to be driven from other
> +             * threads in the core, but for now we only implement it for
> +             * thread 0.
> +             */


and here, the memop is done and the status of the transaction should be
read in SPR_TFMR. This is not a friendly HW interface !


Thanks,

C.



> +            if (env->tb_ready_for_tod) {
> +                env->tod_sent_to_tb = 1;
> +            } else {
> +                qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: xscom write reg"
> +                              " TOD_MOVE_TOD_TO_TB_REG with TB not ready to"
> +                              " receive TOD\n");
> +            }
> +        }
> +        break;
>       case TOD_TX_TTYPE_4_REG:
>           if (is_power9) {
>               chiptod_power9_send_remotes(chiptod);
  

