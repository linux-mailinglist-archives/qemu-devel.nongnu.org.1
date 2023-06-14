Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1DA72F875
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 10:56:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9MII-00078H-Tc; Wed, 14 Jun 2023 04:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=UREO=CC=kaod.org=clg@ozlabs.org>)
 id 1q9MIH-00077x-GR; Wed, 14 Jun 2023 04:55:57 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=UREO=CC=kaod.org=clg@ozlabs.org>)
 id 1q9MIF-0004Yb-Bb; Wed, 14 Jun 2023 04:55:57 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Qgzm86ZNGz4x41;
 Wed, 14 Jun 2023 18:55:52 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qgzm73Z6Gz4x3m;
 Wed, 14 Jun 2023 18:55:51 +1000 (AEST)
Message-ID: <ddf471e7-4662-eff9-0f67-022468db2ec1@kaod.org>
Date: Wed, 14 Jun 2023 10:55:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/4] target/ppc: Implement core timebase state machine and
 TFMR
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20230603233612.125879-1-npiggin@gmail.com>
 <20230603233612.125879-5-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230603233612.125879-5-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=UREO=CC=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.098, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 6/4/23 01:36, Nicholas Piggin wrote:
> This implements the core timebase state machine, which is the core side
> of the time-of-day system in POWER processors. This facility is operated
> by control fields in the TFMR register, which also contains status
> fields.
> 
> The core timebase interacts with the chiptod hardware, primarily to
> receive TOD updates, to synchronise timebase with other cores. This
> model does not actually update TB values with TOD or updates received
> from the chiptod, as timebases are always synchronised. It does step
> through the states required to perform the update.
> 
> There are several asynchronous state transitions. These are modelled
> using using mfTFMR to drive state changes, because it is expected that
> firmware poll the register to wait for those states. This is good enough
> to test basic firmware behaviour without adding real timers. The values
> chosen are arbitrary.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Looks correct,

Acked-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>   target/ppc/cpu.h             |  34 ++++++++
>   target/ppc/timebase_helper.c | 147 ++++++++++++++++++++++++++++++++++-
>   2 files changed, 179 insertions(+), 2 deletions(-)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index d73cce8474..b1520ea4db 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1177,6 +1177,13 @@ struct CPUArchState {
>       /* PowerNV chiptod / timebase facility state. */
>       int tb_ready_for_tod; /* core TB ready to receive TOD from chiptod */
>       int tod_sent_to_tb;   /* chiptod sent TOD to the core TB */
> +
> +    /*
> +     * Timers for async events are simulated by mfTFAC because TFAC is to be
> +     * polled for event.
> +     */
> +    int tb_state_timer;
> +    int tb_sync_pulse_timer;
>   #endif
>   #endif
>   
> @@ -2527,6 +2534,33 @@ enum {
>       HMER_XSCOM_STATUS_MASK      = PPC_BITMASK(21, 23),
>   };
>   
> +/* TFMR */
> +enum {
> +    TFMR_CONTROL_MASK           = PPC_BITMASK(0, 24),
> +    TFMR_MASK_HMI               = PPC_BIT(10),
> +    TFMR_TB_ECLIPZ              = PPC_BIT(14),
> +    TFMR_LOAD_TOD_MOD           = PPC_BIT(16),
> +    TFMR_MOVE_CHIP_TOD_TO_TB    = PPC_BIT(18),
> +    TFMR_CLEAR_TB_ERRORS        = PPC_BIT(24),
> +    TFMR_STATUS_MASK            = PPC_BITMASK(25, 63),
> +    TFMR_TBST_ENCODED           = PPC_BITMASK(28, 31), /* TBST = TB State */
> +    TFMR_TBST_LAST              = PPC_BITMASK(32, 35), /* Previous TBST */
> +    TFMR_TB_ENABLED             = PPC_BIT(40),
> +    TFMR_TB_VALID               = PPC_BIT(41),
> +    TFMR_TB_SYNC_OCCURED        = PPC_BIT(42),
> +};
> +
> +/* TFMR TBST */
> +enum {
> +    TBST_RESET                  = 0x0,
> +    TBST_SEND_TOD_MOD           = 0x1,
> +    TBST_NOT_SET                = 0x2,
> +    TBST_SYNC_WAIT              = 0x6,
> +    TBST_GET_TOD                = 0x7,
> +    TBST_TB_RUNNING             = 0x8,
> +    TBST_TB_ERROR               = 0x9,
> +};
> +
>   /*****************************************************************************/
>   
>   #define is_isa300(ctx) (!!(ctx->insns_flags2 & PPC2_ISA300))
> diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.c
> index 34b1d5ad05..11a06fafe6 100644
> --- a/target/ppc/timebase_helper.c
> +++ b/target/ppc/timebase_helper.c
> @@ -272,14 +272,157 @@ void helper_store_booke_tsr(CPUPPCState *env, target_ulong val)
>   
>   #if defined(TARGET_PPC64)
>   /* POWER processor Timebase Facility */
> +static unsigned int tfmr_get_tb_state(uint64_t tfmr)
> +{
> +    return (tfmr & TFMR_TBST_ENCODED) >> (63 - 31);
> +}
> +
> +static uint64_t tfmr_new_tb_state(uint64_t tfmr, unsigned int tbst)
> +{
> +    tfmr &= ~TFMR_TBST_LAST;
> +    tfmr |= (tfmr & TFMR_TBST_ENCODED) >> 4; /* move state to last state */
> +    tfmr &= ~TFMR_TBST_ENCODED;
> +    tfmr |= (uint64_t)tbst << (63 - 31); /* move new state to state */
> +
> +    if (tbst == TBST_TB_RUNNING) {
> +        tfmr |= TFMR_TB_VALID;
> +    } else {
> +        tfmr &= ~TFMR_TB_VALID;
> +    }
> +
> +    return tfmr;
> +}
> +
> +static void tb_state_machine_step(CPUPPCState *env)
> +{
> +    uint64_t tfmr = env->spr[SPR_TFMR];
> +    unsigned int tbst = tfmr_get_tb_state(tfmr);
> +
> +    if (!(tfmr & TFMR_TB_ECLIPZ) || tbst == TBST_TB_ERROR) {
> +        return;
> +    }
> +
> +    if (env->tb_sync_pulse_timer) {
> +        env->tb_sync_pulse_timer--;
> +    } else {
> +        tfmr |= TFMR_TB_SYNC_OCCURED;
> +        env->spr[SPR_TFMR] = tfmr;
> +    }
> +
> +    if (env->tb_state_timer) {
> +        env->tb_state_timer--;
> +        return;
> +    }
> +
> +    if (tfmr & TFMR_LOAD_TOD_MOD) {
> +        tfmr &= ~TFMR_LOAD_TOD_MOD;
> +        if (tbst == TBST_GET_TOD) {
> +            tfmr = tfmr_new_tb_state(tfmr, TBST_TB_ERROR);
> +        } else {
> +            tfmr = tfmr_new_tb_state(tfmr, TBST_SEND_TOD_MOD);
> +            /* State seems to transition immediately */
> +            tfmr = tfmr_new_tb_state(tfmr, TBST_NOT_SET);
> +        }
> +    } else if (tfmr & TFMR_MOVE_CHIP_TOD_TO_TB) {
> +        if (tbst == TBST_SYNC_WAIT) {
> +            tfmr = tfmr_new_tb_state(tfmr, TBST_GET_TOD);
> +            env->tb_state_timer = 3;
> +        } else if (tbst == TBST_GET_TOD) {
> +            if (env->tod_sent_to_tb) {
> +                tfmr = tfmr_new_tb_state(tfmr, TBST_TB_RUNNING);
> +                tfmr &= ~TFMR_MOVE_CHIP_TOD_TO_TB;
> +                env->tb_ready_for_tod = 0;
> +                env->tod_sent_to_tb = 0;
> +            }
> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR, "TFMR error: MOVE_CHIP_TOD_TO_TB "
> +                          "state machine in invalid state 0x%x\n", tbst);
> +            tfmr = tfmr_new_tb_state(tfmr, TBST_TB_ERROR);
> +            env->tb_ready_for_tod = 0;
> +        }
> +    }
> +
> +    env->spr[SPR_TFMR] = tfmr;
> +}
> +
>   target_ulong helper_load_tfmr(CPUPPCState *env)
>   {
> -    return env->spr[SPR_TFMR];
> +    tb_state_machine_step(env);
> +
> +    return env->spr[SPR_TFMR] | TFMR_TB_ECLIPZ;
>   }
>   
>   void helper_store_tfmr(CPUPPCState *env, target_ulong val)
>   {
> -    env->spr[SPR_TFMR] = val;
> +    uint64_t tfmr = env->spr[SPR_TFMR];
> +    unsigned int tbst = tfmr_get_tb_state(tfmr);
> +
> +    if (!(val & TFMR_TB_ECLIPZ)) {
> +        qemu_log_mask(LOG_UNIMP, "TFMR non-ECLIPZ mode not implemented\n");
> +        tfmr &= ~TFMR_TBST_ENCODED;
> +        tfmr &= ~TFMR_TBST_LAST;
> +        goto out;
> +    }
> +
> +    /* Update control bits */
> +    tfmr = (tfmr & ~TFMR_CONTROL_MASK) | (val & TFMR_CONTROL_MASK);
> +
> +    /* mtspr always clears this */
> +    tfmr &= ~TFMR_TB_SYNC_OCCURED;
> +    env->tb_sync_pulse_timer = 1;
> +
> +    /*
> +     * We don't implement any of the error status bits that can be
> +     * cleared by writing 1 to them. TB error injection / simulation
> +     * would have to implement some.
> +     *
> +     * Also don't implement mfTB failing when the TB state machine is
> +     * not running.
> +     */
> +
> +    if (((tfmr | val) & (TFMR_LOAD_TOD_MOD | TFMR_MOVE_CHIP_TOD_TO_TB)) ==
> +                        (TFMR_LOAD_TOD_MOD | TFMR_MOVE_CHIP_TOD_TO_TB)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "TFMR error: LOAD_TOD_MOD and "
> +                                       "MOVE_CHIP_TOD_TO_TB both set\n");
> +        tfmr = tfmr_new_tb_state(tfmr, TBST_TB_ERROR);
> +        env->tb_ready_for_tod = 0;
> +        goto out;
> +    }
> +
> +    if (tfmr & TFMR_CLEAR_TB_ERRORS) {
> +        tfmr = tfmr_new_tb_state(tfmr, TBST_RESET);
> +        tfmr &= ~TFMR_CLEAR_TB_ERRORS;
> +        tfmr &= ~TFMR_LOAD_TOD_MOD;
> +        tfmr &= ~TFMR_MOVE_CHIP_TOD_TO_TB;
> +        env->tb_ready_for_tod = 0;
> +        env->tod_sent_to_tb = 0;
> +        goto out;
> +    }
> +
> +    if (tbst == TBST_TB_ERROR) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "TFMR error: mtspr TFMR in TB_ERROR"
> +                                       " state\n");
> +        return;
> +    }
> +
> +    if (tfmr & TFMR_LOAD_TOD_MOD) {
> +        env->tb_state_timer = 3;
> +    } else if (tfmr & TFMR_MOVE_CHIP_TOD_TO_TB) {
> +        if (tbst == TBST_NOT_SET) {
> +            tfmr = tfmr_new_tb_state(tfmr, TBST_SYNC_WAIT);
> +            env->tb_ready_for_tod = 1;
> +            env->tb_state_timer = 3;
> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR, "TFMR error: MOVE_CHIP_TOD_TO_TB "
> +                                           "not in TB not set state 0x%x\n",
> +                                           tbst);
> +            tfmr = tfmr_new_tb_state(tfmr, TBST_TB_ERROR);
> +            env->tb_ready_for_tod = 0;
> +        }
> +    }
> +
> +out:
> +    env->spr[SPR_TFMR] = tfmr;
>   }
>   #endif
>   


