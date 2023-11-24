Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C777F6CCC
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 08:20:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6QTH-0004Y4-Hr; Fri, 24 Nov 2023 02:19:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZyQH=HF=kaod.org=clg@ozlabs.org>)
 id 1r6QTF-0004Wo-8J; Fri, 24 Nov 2023 02:19:25 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZyQH=HF=kaod.org=clg@ozlabs.org>)
 id 1r6QSy-0001la-Nn; Fri, 24 Nov 2023 02:19:24 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Sc5vC23mgz4x1R;
 Fri, 24 Nov 2023 18:19:03 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sc5v94dvrz4xNG;
 Fri, 24 Nov 2023 18:19:01 +1100 (AEDT)
Message-ID: <aed52fe8-057a-4fff-89d7-1e55cf5cc0d0@kaod.org>
Date: Fri, 24 Nov 2023 08:18:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] pnv/chiptod: Implement the ChipTOD to Core transfer
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 qemu-devel@nongnu.org
References: <20231124064001.198572-1-npiggin@gmail.com>
 <20231124064001.198572-6-npiggin@gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231124064001.198572-6-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=ZyQH=HF=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 11/24/23 07:39, Nicholas Piggin wrote:
> One of the functions of the ChipTOD is to transfer TOD to the Core
> (aka PC - Pervasive Core) timebase facility.
> 
> The ChipTOD can be programmed with a target address to send the TOD
> value to. The hardware implementation seems to perform this by
> sending the TOD value to a SCOM address.
> 
> This implementation grabs the core directly and manipulates the
> timebase facility state in the core. This is a hack, but it works
> enough for now. A better implementation would implement the transfer
> to the PnvCore xscom register and drive the timebase state machine
> from there.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.




> ---
>   include/hw/ppc/pnv.h         |   2 +
>   include/hw/ppc/pnv_chiptod.h |   4 ++
>   target/ppc/cpu.h             |   7 ++
>   hw/ppc/pnv.c                 |  15 ++++
>   hw/ppc/pnv_chiptod.c         | 132 +++++++++++++++++++++++++++++++++++
>   5 files changed, 160 insertions(+)
> 
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index 7e5fef7c43..005048d207 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -28,6 +28,7 @@
>   
>   #define TYPE_PNV_CHIP "pnv-chip"
>   
> +typedef struct PnvCore PnvCore;
>   typedef struct PnvChip PnvChip;
>   typedef struct Pnv8Chip Pnv8Chip;
>   typedef struct Pnv9Chip Pnv9Chip;
> @@ -56,6 +57,7 @@ DECLARE_INSTANCE_CHECKER(PnvChip, PNV_CHIP_POWER9,
>   DECLARE_INSTANCE_CHECKER(PnvChip, PNV_CHIP_POWER10,
>                            TYPE_PNV_CHIP_POWER10)
>   
> +PnvCore *pnv_chip_find_core(PnvChip *chip, uint32_t core_id);
>   PowerPCCPU *pnv_chip_find_cpu(PnvChip *chip, uint32_t pir);
>   
>   typedef struct PnvPHB PnvPHB;
> diff --git a/include/hw/ppc/pnv_chiptod.h b/include/hw/ppc/pnv_chiptod.h
> index f873901ee7..b021ec81fe 100644
> --- a/include/hw/ppc/pnv_chiptod.h
> +++ b/include/hw/ppc/pnv_chiptod.h
> @@ -25,6 +25,8 @@ enum tod_state {
>       tod_stopped = 1,
>   };
>   
> +typedef struct PnvCore PnvCore;
> +
>   struct PnvChipTOD {
>       DeviceState xd;
>   
> @@ -36,12 +38,14 @@ struct PnvChipTOD {
>       enum tod_state tod_state;
>       uint64_t tod_error;
>       uint64_t pss_mss_ctrl_reg;
> +    PnvCore *slave_pc_target;
>   };
>   
>   struct PnvChipTODClass {
>       DeviceClass parent_class;
>   
>       void (*broadcast_ttype)(PnvChipTOD *sender, uint32_t trigger);
> +    PnvCore *(*tx_ttype_target)(PnvChipTOD *chiptod, uint64_t val);
>   
>       int xscom_size;
>       const MemoryRegionOps *xscom_ops;
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 848e583c2d..d7cfdeb3b6 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1258,6 +1258,13 @@ struct CPUArchState {
>       uint32_t tlb_need_flush; /* Delayed flush needed */
>   #define TLB_NEED_LOCAL_FLUSH   0x1
>   #define TLB_NEED_GLOBAL_FLUSH  0x2
> +
> +#if defined(TARGET_PPC64)
> +    /* PowerNV chiptod / timebase facility state. */
> +    /* Would be nice to put these into PnvCore */
> +    int tb_ready_for_tod; /* core TB ready to receive TOD from chiptod */
> +    int tod_sent_to_tb;   /* chiptod sent TOD to the core TB */
> +#endif
>   #endif
>   
>       /* Other registers */
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 546266ae3d..f42e70d716 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -2065,6 +2065,21 @@ static void pnv_chip_class_init(ObjectClass *klass, void *data)
>       dc->desc = "PowerNV Chip";
>   }
>   
> +PnvCore *pnv_chip_find_core(PnvChip *chip, uint32_t core_id)
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
>   PowerPCCPU *pnv_chip_find_cpu(PnvChip *chip, uint32_t pir)
>   {
>       int i, j;
> diff --git a/hw/ppc/pnv_chiptod.c b/hw/ppc/pnv_chiptod.c
> index 88d285a332..c494daac7f 100644
> --- a/hw/ppc/pnv_chiptod.c
> +++ b/hw/ppc/pnv_chiptod.c
> @@ -210,6 +210,79 @@ static void chiptod_power10_broadcast_ttype(PnvChipTOD *sender,
>       }
>   }
>   
> +static PnvCore *pnv_chip_get_core_by_xscom_base(PnvChip *chip,
> +                                                uint32_t xscom_base)
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
> +static PnvCore *chiptod_power9_tx_ttype_target(PnvChipTOD *chiptod,
> +                                               uint64_t val)
> +{
> +    /*
> +     * skiboot uses Core ID for P9, though SCOM should work too.
> +     */
> +    if (val & PPC_BIT(35)) { /* SCOM addressing */
> +        uint32_t addr = val >> 32;
> +        uint32_t reg = addr & 0xfff;
> +
> +        if (reg != PC_TOD) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: SCOM addressing: "
> +                          "unimplemented slave register 0x%" PRIx32 "\n", reg);
> +            return NULL;
> +        }
> +
> +        return pnv_chip_get_core_by_xscom_base(chiptod->chip, addr & ~0xfff);
> +
> +    } else { /* Core ID addressing */
> +        uint32_t core_id = GETFIELD(TOD_TX_TTYPE_PIB_SLAVE_ADDR, val) & 0x1f;
> +        return pnv_chip_find_core(chiptod->chip, core_id);
> +    }
> +}
> +
> +static PnvCore *chiptod_power10_tx_ttype_target(PnvChipTOD *chiptod,
> +                                               uint64_t val)
> +{
> +    /*
> +     * skiboot uses SCOM for P10 because Core ID was unable to be made to
> +     * work correctly. For this reason only SCOM addressing is implemented.
> +     */
> +    if (val & PPC_BIT(35)) { /* SCOM addressing */
> +        uint32_t addr = val >> 32;
> +        uint32_t reg = addr & 0xfff;
> +
> +        if (reg != PC_TOD) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: SCOM addressing: "
> +                          "unimplemented slave register 0x%" PRIx32 "\n", reg);
> +            return NULL;
> +        }
> +
> +        /*
> +         * This may not deal with P10 big-core addressing at the moment.
> +         * The big-core code in skiboot syncs small cores, but it targets
> +         * the even PIR (first small-core) when syncing second small-core.
> +         */
> +        return pnv_chip_get_core_by_xscom_base(chiptod->chip, addr & ~0xfff);
> +
> +    } else { /* Core ID addressing */
> +        qemu_log_mask(LOG_UNIMP, "pnv_chiptod: TX TTYPE Core ID "
> +                      "addressing is not implemented for POWER10\n");
> +        return NULL;
> +    }
> +}
> +
>   static void pnv_chiptod_xscom_write(void *opaque, hwaddr addr,
>                                       uint64_t val, unsigned size,
>                                       bool is_power9)
> @@ -232,6 +305,22 @@ static void pnv_chiptod_xscom_write(void *opaque, hwaddr addr,
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
> +         */
> +        chiptod->slave_pc_target = pctc->tx_ttype_target(chiptod, val);
> +        if (!chiptod->slave_pc_target) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: xscom write reg"
> +                          " TOD_TX_TTYPE_CTRL_REG val 0x%" PRIx64
> +                          " invalid slave address\n", val);
> +        }
> +        break;
>       case TOD_ERROR_REG:
>           chiptod->tod_error &= ~val;
>           break;
> @@ -257,6 +346,47 @@ static void pnv_chiptod_xscom_write(void *opaque, hwaddr addr,
>               }
>           }
>           break;
> +
> +    case TOD_MOVE_TOD_TO_TB_REG:
> +        /*
> +         * XXX: it should be a cleaner model to have this drive a SCOM
> +         * transaction to the target address, and implement the state machine
> +         * in the PnvCore. For now, this hack makes things work.
> +         */
> +        if (chiptod->tod_state != tod_running) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: xscom write reg"
> +                          " TOD_MOVE_TOD_TO_TB_REG in bad state %d\n",
> +                          chiptod->tod_state);
> +        } else if (!(val & PPC_BIT(0))) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: xscom write reg"
> +                          " TOD_MOVE_TOD_TO_TB_REG with bad val 0x%" PRIx64"\n",
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
> +
> +            if (env->tb_ready_for_tod) {
> +                env->tod_sent_to_tb = 1;
> +            } else {
> +                qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: xscom write reg"
> +                              " TOD_MOVE_TOD_TO_TB_REG with TB not ready to"
> +                              " receive TOD\n");
> +            }
> +        }
> +        break;
>       case TOD_START_TOD_REG:
>           if (chiptod->tod_state != tod_stopped) {
>               qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: LOAD_TOG_REG in "
> @@ -347,6 +477,7 @@ static void pnv_chiptod_power9_class_init(ObjectClass *klass, void *data)
>       xdc->dt_xscom = pnv_chiptod_power9_dt_xscom;
>   
>       pctc->broadcast_ttype = chiptod_power9_broadcast_ttype;
> +    pctc->tx_ttype_target = chiptod_power9_tx_ttype_target;
>   
>       pctc->xscom_size = PNV_XSCOM_CHIPTOD_SIZE;
>       pctc->xscom_ops = &pnv_chiptod_power9_xscom_ops;
> @@ -399,6 +530,7 @@ static void pnv_chiptod_power10_class_init(ObjectClass *klass, void *data)
>       xdc->dt_xscom = pnv_chiptod_power10_dt_xscom;
>   
>       pctc->broadcast_ttype = chiptod_power10_broadcast_ttype;
> +    pctc->tx_ttype_target = chiptod_power10_tx_ttype_target;
>   
>       pctc->xscom_size = PNV_XSCOM_CHIPTOD_SIZE;
>       pctc->xscom_ops = &pnv_chiptod_power10_xscom_ops;


