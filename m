Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AFD743852
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 11:28:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFAOn-0002BR-P2; Fri, 30 Jun 2023 05:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qFAOl-0002AX-Jv
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 05:26:39 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qFAOi-0007vo-65
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 05:26:39 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-1b0156a1c4bso1226999fac.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 02:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1688117193; x=1690709193;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9C8g9yiNIl4oSyuj7PiH9aaGWGri1dqxEp9NUAOwI3M=;
 b=BWbMWmhbmj1K1LF0RZ+ENyTGL/gNJwrP0QENOycU2N0zOdYCJjQcnoKTZu/vWGU1dF
 cKx3HdXva+evVYtPkxOn+YgQXfpeejiLm+uQ1roQjRbT5Rr1nWgzWK2KUqPA9xzmKWCX
 gI1RAqgVSGL1Jo1HGlZp2aD3XppZp0IOULyqieVKz5+P5lHq1KNpb+jNp8/KmY28g5gv
 RiegSz1JC4haD2Wqyn3Hb8Un0x9VLU6KmEzpo+6uWfAUBHP5qT9SrAdV/33Wz74HvSnL
 V2TfOKhxQ0K1XSTmrN/cmbt1rf351YpkUJdGMAt9npzHCyjlUaaSj56K9ra/FZRQ4qB9
 ySgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688117193; x=1690709193;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9C8g9yiNIl4oSyuj7PiH9aaGWGri1dqxEp9NUAOwI3M=;
 b=RY/Ge1UnwxsijNT6sH8/Hl4Tq3nxH8XL2Tvc+QVDoqeStH3ThhIxRMdWUKkpBcNapP
 GPFJk7EOAU8PPl4vfPGR0u6EDQ/QBHScn8fjEkfUI3BbP5PCtTPAhWaXtKnEEhyK4w+f
 NuO+HevTUCbdxHNCswH3TxFPnmDEL2P6/HithTrBvp8q9wm+o8Ya/3sjZsxhYzphMEDv
 HNuJExVSr3GcL3f8qtVzRZWIcB1oEAist1e/ad3bkms+sVocpqBdjtHxtWA5RLCpTfyu
 WiaJ1MKyKMPR/QqTNuEdwQ/KCssqGii/fsrcRwKB+VG79P5kXRKx+4/J+aUYqo1cmnbM
 vR+Q==
X-Gm-Message-State: AC+VfDxA94ig2x/Xy9S9953tBFVKZnGajBCpuNu7D170sBtZNn7oIGjR
 oiykiYYSDiCMyQniBYuC4RvHLw==
X-Google-Smtp-Source: APBJJlE9K2vejRUdG0P4imjvtxD4nDmYv7PcDXl/yLedzA291opXjUqsMbAqX7K4xK4z9e4OimmaDw==
X-Received: by 2002:a05:6870:96a0:b0:1ad:548b:3bef with SMTP id
 o32-20020a05687096a000b001ad548b3befmr2867570oaq.14.1688117193387; 
 Fri, 30 Jun 2023 02:26:33 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-110.dial-up.telesp.net.br.
 [201.69.66.110]) by smtp.gmail.com with ESMTPSA id
 y21-20020a4ae7d5000000b0056591172bedsm246519oov.37.2023.06.30.02.26.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 02:26:32 -0700 (PDT)
Message-ID: <4d6fb10b-f622-4417-7504-3a6affcf7025@ventanamicro.com>
Date: Fri, 30 Jun 2023 06:26:27 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 5/6] target/riscv: Add M-mode virtual interrupt and IRQ
 filtering support.
Content-Language: en-US
To: Rajnesh Kanwal <rkanwal@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com,
 apatel@ventanamicro.com
References: <20230526162308.22892-1-rkanwal@rivosinc.com>
 <20230526162308.22892-6-rkanwal@rivosinc.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230526162308.22892-6-rkanwal@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x33.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

(sorry for the delayed review)

On 5/26/23 13:23, Rajnesh Kanwal wrote:
> This change adds support for inserting virtual interrupts from M-mode
> into S-mode using mvien and mvip csrs. IRQ filtering is a use case of
> this change, i-e M-mode can stop delegating an interrupt to S-mode and
> instead enable it in MIE and receive those interrupts in M-mode and then
> selectively inject the interrupt using mvien and mvip.
> 
> Also, the spec doesn't mandate the interrupt to be actually supported
> in hardware. Which allows M-mode to assert virtual interrupts to S-mode
> that have no connection to any real interrupt events.
> 
> This is defined as part of the AIA specification [0], "5.3 Interrupt
> filtering and virtual interrupts for supervisor level".
> 
> [0]: https://github.com/riscv/riscv-aia/releases/download/1.0-RC4/riscv-interrupts-1.0-RC4.pdf
> 
> Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> ---

I didn't find anything wrong following the spec but there's a lot being done
here. Let's see how it goes in the field.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>



>   target/riscv/cpu.c        |   3 +-
>   target/riscv/cpu.h        |   8 ++
>   target/riscv/cpu_bits.h   |   6 +
>   target/riscv/cpu_helper.c |  26 +++-
>   target/riscv/csr.c        | 279 ++++++++++++++++++++++++++++++++++----
>   target/riscv/machine.c    |   3 +
>   6 files changed, 289 insertions(+), 36 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 269a094f42..7c4999431a 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -712,7 +712,8 @@ static bool riscv_cpu_has_work(CPUState *cs)
>        * Definition of the WFI instruction requires it to ignore the privilege
>        * mode and delegation registers, but respect individual enables
>        */
> -    return riscv_cpu_all_pending(env) != 0;
> +    return riscv_cpu_all_pending(env) != 0 ||
> +        riscv_cpu_sirq_pending(env) != RISCV_EXCP_NONE;
>   #else
>       return true;
>   #endif
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index de55bfb775..07cf656471 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -190,6 +190,12 @@ struct CPUArchState {
>       uint64_t mie;
>       uint64_t mideleg;
>   
> +    /*
> +     * When mideleg[i]=0 and mvien[i]=1, sie[i] is no more
> +     * alias of mie[i] and needs to be maintained separatly.
> +     */
> +    uint64_t sie;
> +
>       target_ulong satp;   /* since: priv-1.10.0 */
>       target_ulong stval;
>       target_ulong medeleg;
> @@ -210,6 +216,8 @@ struct CPUArchState {
>       /* AIA CSRs */
>       target_ulong miselect;
>       target_ulong siselect;
> +    uint64_t mvien;
> +    uint64_t mvip;
>   
>       /* Hypervisor CSRs */
>       target_ulong hstatus;
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 59f0ffd9e1..0d32d2a5a7 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -735,6 +735,12 @@ typedef enum RISCVException {
>   #define MIE_SSIE                           (1 << IRQ_S_SOFT)
>   #define MIE_USIE                           (1 << IRQ_U_SOFT)
>   
> +/* Machine constants */
> +#define M_MODE_INTERRUPTS  ((uint64_t)(MIP_MSIP | MIP_MTIP | MIP_MEIP))
> +#define S_MODE_INTERRUPTS  ((uint64_t)(MIP_SSIP | MIP_STIP | MIP_SEIP))
> +#define VS_MODE_INTERRUPTS ((uint64_t)(MIP_VSSIP | MIP_VSTIP | MIP_VSEIP))
> +#define HS_MODE_INTERRUPTS ((uint64_t)(MIP_SGEIP | VS_MODE_INTERRUPTS))
> +
>   /* General PointerMasking CSR bits */
>   #define PM_ENABLE       0x00000001ULL
>   #define PM_CURRENT      0x00000002ULL
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index c79ec4db76..6567ddef7b 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -365,6 +365,10 @@ static int riscv_cpu_pending_to_irq(CPURISCVState *env,
>       return best_irq;
>   }
>   
> +/*
> + * Doesn't report interrupts inserted using mvip from M-mode firmware. Those
> + * are returned in riscv_cpu_sirq_pending().
> + */
>   uint64_t riscv_cpu_all_pending(CPURISCVState *env)
>   {
>       uint32_t gein = get_field(env->hstatus, HSTATUS_VGEIN);
> @@ -387,9 +391,10 @@ int riscv_cpu_sirq_pending(CPURISCVState *env)
>   {
>       uint64_t irqs = riscv_cpu_all_pending(env) & env->mideleg &
>                       ~(MIP_VSSIP | MIP_VSTIP | MIP_VSEIP);
> +    uint64_t irqs_f = env->mvip & env->mvien & ~env->mideleg & env->sie;
>   
>       return riscv_cpu_pending_to_irq(env, IRQ_S_EXT, IPRIO_DEFAULT_S,
> -                                    irqs, env->siprio);
> +                                    irqs | irqs_f, env->siprio);
>   }
>   
>   int riscv_cpu_vsirq_pending(CPURISCVState *env)
> @@ -403,8 +408,8 @@ int riscv_cpu_vsirq_pending(CPURISCVState *env)
>   
>   static int riscv_cpu_local_irq_pending(CPURISCVState *env)
>   {
> +    uint64_t irqs, pending, mie, hsie, vsie, irqs_f;
>       int virq;
> -    uint64_t irqs, pending, mie, hsie, vsie;
>   
>       /* Determine interrupt enable state of all privilege modes */
>       if (env->virt_enabled) {
> @@ -430,8 +435,11 @@ static int riscv_cpu_local_irq_pending(CPURISCVState *env)
>                                           irqs, env->miprio);
>       }
>   
> +    /* Check for virtual S-mode interrupts. */
> +    irqs_f = env->mvip & (env->mvien & ~env->mideleg) & env->sie;
> +
>       /* Check HS-mode interrupts */
> -    irqs = pending & env->mideleg & ~env->hideleg & -hsie;
> +    irqs =  ((pending & env->mideleg & ~env->hideleg) | irqs_f) & -hsie;
>       if (irqs) {
>           return riscv_cpu_pending_to_irq(env, IRQ_S_EXT, IPRIO_DEFAULT_S,
>                                           irqs, env->siprio);
> @@ -611,7 +619,7 @@ int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts)
>   
>   void riscv_cpu_interrupt(CPURISCVState *env)
>   {
> -    uint64_t gein, vsgein = 0, vstip = 0;
> +    uint64_t gein, vsgein = 0, vstip = 0, irqf = 0;
>       CPUState *cs = env_cpu(env);
>   
>       QEMU_IOTHREAD_LOCK_GUARD();
> @@ -619,11 +627,13 @@ void riscv_cpu_interrupt(CPURISCVState *env)
>       if (env->virt_enabled) {
>           gein = get_field(env->hstatus, HSTATUS_VGEIN);
>           vsgein = (env->hgeip & (1ULL << gein)) ? MIP_VSEIP : 0;
> +    } else {
> +        irqf = env->mvien & env->mvip & env->sie;
>       }
>   
>       vstip = env->vstime_irq ? MIP_VSTIP : 0;
>   
> -    if (env->mip | vsgein | vstip) {
> +    if (env->mip | vsgein | vstip | irqf) {
>           cpu_interrupt(cs, CPU_INTERRUPT_HARD);
>       } else {
>           cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
> @@ -1608,6 +1618,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>       bool async = !!(cs->exception_index & RISCV_EXCP_INT_FLAG);
>       target_ulong cause = cs->exception_index & RISCV_EXCP_INT_MASK;
>       uint64_t deleg = async ? env->mideleg : env->medeleg;
> +    bool s_injected = env->mvip & (1 << cause) & env->mvien &&
> +        !(env->mip & (1 << cause));
>       target_ulong tval = 0;
>       target_ulong tinst = 0;
>       target_ulong htval = 0;
> @@ -1696,8 +1708,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>                     __func__, env->mhartid, async, cause, env->pc, tval,
>                     riscv_cpu_get_trap_name(cause, async));
>   
> -    if (env->priv <= PRV_S &&
> -            cause < TARGET_LONG_BITS && ((deleg >> cause) & 1)) {
> +    if (env->priv <= PRV_S && cause < 64 &&
> +        (((deleg >> cause) & 1) || s_injected)) {
>           /* handle the trap in S-mode */
>           if (riscv_has_ext(env, RVH)) {
>               uint64_t hdeleg = async ? env->hideleg : env->hedeleg;
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 041f0b3e2e..c1ca065a81 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -1113,21 +1113,16 @@ static RISCVException write_stimecmph(CPURISCVState *env, int csrno,
>       return RISCV_EXCP_NONE;
>   }
>   
> -/* Machine constants */
> -
> -#define M_MODE_INTERRUPTS  ((uint64_t)(MIP_MSIP | MIP_MTIP | MIP_MEIP))
> -#define S_MODE_INTERRUPTS  ((uint64_t)(MIP_SSIP | MIP_STIP | MIP_SEIP | \
> -                                      MIP_LCOFIP))
> -#define VS_MODE_INTERRUPTS ((uint64_t)(MIP_VSSIP | MIP_VSTIP | MIP_VSEIP))
> -#define HS_MODE_INTERRUPTS ((uint64_t)(MIP_SGEIP | VS_MODE_INTERRUPTS))
> -
>   #define VSTOPI_NUM_SRCS 5
>   
> -static const uint64_t delegable_ints = S_MODE_INTERRUPTS |
> -                                           VS_MODE_INTERRUPTS;
> -static const uint64_t vs_delegable_ints = VS_MODE_INTERRUPTS;
> +#define LOCAL_INTERRUPTS (~0x1FFF)
> +
> +static const uint64_t delegable_ints =
> +    S_MODE_INTERRUPTS | VS_MODE_INTERRUPTS | MIP_LCOFIP;
> +static const uint64_t vs_delegable_ints =
> +    (VS_MODE_INTERRUPTS | LOCAL_INTERRUPTS) & ~MIP_LCOFIP;
>   static const uint64_t all_ints = M_MODE_INTERRUPTS | S_MODE_INTERRUPTS |
> -                                     HS_MODE_INTERRUPTS;
> +                                     HS_MODE_INTERRUPTS | LOCAL_INTERRUPTS;
>   #define DELEGABLE_EXCPS ((1ULL << (RISCV_EXCP_INST_ADDR_MIS)) | \
>                            (1ULL << (RISCV_EXCP_INST_ACCESS_FAULT)) | \
>                            (1ULL << (RISCV_EXCP_ILLEGAL_INST)) | \
> @@ -1158,12 +1153,30 @@ static const target_ulong vs_delegable_excps = DELEGABLE_EXCPS &
>   static const target_ulong sstatus_v1_10_mask = SSTATUS_SIE | SSTATUS_SPIE |
>       SSTATUS_UIE | SSTATUS_UPIE | SSTATUS_SPP | SSTATUS_FS | SSTATUS_XS |
>       SSTATUS_SUM | SSTATUS_MXR | SSTATUS_VS;
> -static const target_ulong sip_writable_mask = SIP_SSIP | MIP_USIP | MIP_UEIP |
> -                                              SIP_LCOFIP;
> +
> +/*
> + * Spec allows for bits 13:63 to be either read-only or writable.
> + * So far we have interrupt LCOFIP in that region which is writable.
> + *
> + * Also, spec allows to inject virtual interrupts in this region even
> + * without any hardware interrupts for that interrupt number.
> + *
> + * For now interrupt in 13:63 region are all kept writable. 13 being
> + * LCOFIP and 14:63 being virtual only. Change this in future if we
> + * introduce more interrupts that are not writable.
> + */
> +
> +/* Bit STIP can be an alias of mip.STIP that's why it's writable in mvip. */
> +static const target_ulong mvip_writable_mask = MIP_SSIP | MIP_STIP | MIP_SEIP |
> +                                    LOCAL_INTERRUPTS;
> +static const target_ulong mvien_writable_mask = MIP_SSIP | MIP_SEIP |
> +                                    LOCAL_INTERRUPTS;
> +
> +static const target_ulong sip_writable_mask = SIP_SSIP | LOCAL_INTERRUPTS;
>   static const target_ulong hip_writable_mask = MIP_VSSIP;
>   static const target_ulong hvip_writable_mask = MIP_VSSIP | MIP_VSTIP |
> -                                               MIP_VSEIP;
> -static const target_ulong vsip_writable_mask = MIP_VSSIP;
> +                                    MIP_VSEIP | LOCAL_INTERRUPTS;
> +static const target_ulong vsip_writable_mask = MIP_VSSIP | LOCAL_INTERRUPTS;
>   
>   const bool valid_vm_1_10_32[16] = {
>       [VM_1_10_MBARE] = true,
> @@ -1559,6 +1572,52 @@ static RISCVException rmw_mieh(CPURISCVState *env, int csrno,
>       return ret;
>   }
>   
> +static RISCVException rmw_mvien64(CPURISCVState *env, int csrno,
> +                                uint64_t *ret_val,
> +                                uint64_t new_val, uint64_t wr_mask)
> +{
> +    uint64_t mask = wr_mask & mvien_writable_mask;
> +
> +    if (ret_val) {
> +        *ret_val = env->mvien;
> +    }
> +
> +    env->mvien = (env->mvien & ~mask) | (new_val & mask);
> +
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException rmw_mvien(CPURISCVState *env, int csrno,
> +                              target_ulong *ret_val,
> +                              target_ulong new_val, target_ulong wr_mask)
> +{
> +    uint64_t rval;
> +    RISCVException ret;
> +
> +    ret = rmw_mvien64(env, csrno, &rval, new_val, wr_mask);
> +    if (ret_val) {
> +        *ret_val = rval;
> +    }
> +
> +    return ret;
> +}
> +
> +static RISCVException rmw_mvienh(CPURISCVState *env, int csrno,
> +                                target_ulong *ret_val,
> +                                target_ulong new_val, target_ulong wr_mask)
> +{
> +    uint64_t rval;
> +    RISCVException ret;
> +
> +    ret = rmw_mvien64(env, csrno, &rval,
> +        ((uint64_t)new_val) << 32, ((uint64_t)wr_mask) << 32);
> +    if (ret_val) {
> +        *ret_val = rval >> 32;
> +    }
> +
> +    return ret;
> +}
> +
>   static int read_mtopi(CPURISCVState *env, int csrno, target_ulong *val)
>   {
>       int irq;
> @@ -1699,6 +1758,11 @@ static int rmw_xireg(CPURISCVState *env, int csrno, target_ulong *val,
>           priv = PRV_M;
>           break;
>       case CSR_SIREG:
> +        if (env->priv == PRV_S && env->mvien & MIP_SEIP &&
> +            env->siselect >= ISELECT_IMSIC_EIDELIVERY &&
> +            env->siselect <= ISELECT_IMSIC_EIE63) {
> +            goto done;
> +        }
>           iprio = env->siprio;
>           isel = env->siselect;
>           priv = PRV_S;
> @@ -1763,6 +1827,9 @@ static int rmw_xtopei(CPURISCVState *env, int csrno, target_ulong *val,
>           priv = PRV_M;
>           break;
>       case CSR_STOPEI:
> +        if (env->mvien & MIP_SEIP && env->priv == PRV_S) {
> +            goto done;
> +        }
>           priv = PRV_S;
>           break;
>       case CSR_VSTOPEI:
> @@ -2336,6 +2403,143 @@ static RISCVException rmw_miph(CPURISCVState *env, int csrno,
>       return ret;
>   }
>   
> +/*
> + * The function is written for two use-cases:
> + * 1- To access mvip csr as is for m-mode access.
> + * 2- To access sip as a combination of mip and mvip for s-mode.
> + *
> + * Both report bits 1, 5, 9 and 13:63 but with the exception of
> + * STIP being read-only zero in case of mvip when sstc extension
> + * is present.
> + * Also, sip needs to be read-only zero when both mideleg[i] and
> + * mvien[i] are zero but mvip needs to be an alias of mip.
> + */
> +static RISCVException rmw_mvip64(CPURISCVState *env, int csrno,
> +                                uint64_t *ret_val,
> +                                uint64_t new_val, uint64_t wr_mask)
> +{
> +    RISCVCPU *cpu = env_archcpu(env);
> +    target_ulong ret_mip = 0;
> +    RISCVException ret;
> +    uint64_t old_mvip;
> +
> +    /*
> +     * mideleg[i]  mvien[i]
> +     *   0           0      No delegation. mvip[i] is alias of mip[i].
> +     *   0           1      mvip[i] becomes source of interrupt, mip bypassed.
> +     *   1           X      mip[i] is source of interrupt and mvip[i] aliases
> +     *                      mip[i].
> +     *
> +     *   So alias condition would be for bits:
> +     *      ((S_MODE_INTERRUPTS | LOCAL_INTERRUPTS) & (mideleg | ~mvien)) |
> +     *          (!sstc & MIP_STIP)
> +     *
> +     *   Non-alias condition will be for bits:
> +     *      (S_MODE_INTERRUPTS | LOCAL_INTERRUPTS) & (~mideleg & mvien)
> +     *
> +     *  alias_mask denotes the bits that come from mip nalias_mask denotes bits
> +     *  that come from hvip.
> +     */
> +    uint64_t alias_mask = ((S_MODE_INTERRUPTS | LOCAL_INTERRUPTS) &
> +        (env->mideleg | ~env->mvien)) | MIP_STIP;
> +    uint64_t nalias_mask = (S_MODE_INTERRUPTS | LOCAL_INTERRUPTS) &
> +        (~env->mideleg & env->mvien);
> +    uint64_t wr_mask_mvip;
> +    uint64_t wr_mask_mip;
> +
> +    /*
> +     * mideleg[i]  mvien[i]
> +     *   0           0      sip[i] read-only zero.
> +     *   0           1      sip[i] alias of mvip[i].
> +     *   1           X      sip[i] alias of mip[i].
> +     *
> +     *  Both alias and non-alias mask remain same for sip except for bits
> +     *  which are zero in both mideleg and mvien.
> +     */
> +    if (csrno == CSR_SIP) {
> +        /* Remove bits that are zero in both mideleg and mvien. */
> +        alias_mask &= (env->mideleg | env->mvien);
> +        nalias_mask &= (env->mideleg | env->mvien);
> +    }
> +
> +    /*
> +     * If sstc is present, mvip.STIP is not an alias of mip.STIP so clear
> +     * that our in mip returned value.
> +     */
> +    if (cpu->cfg.ext_sstc && (env->priv == PRV_M) &&
> +        get_field(env->menvcfg, MENVCFG_STCE)) {
> +        alias_mask &= ~MIP_STIP;
> +    }
> +
> +    wr_mask_mip = wr_mask & alias_mask & mvip_writable_mask;
> +    wr_mask_mvip = wr_mask & nalias_mask & mvip_writable_mask;
> +
> +    /*
> +     * For bits set in alias_mask, mvip needs to be alias of mip, so forward
> +     * this to rmw_mip.
> +     */
> +    ret = rmw_mip(env, CSR_MIP, &ret_mip, new_val, wr_mask_mip);
> +    if (ret != RISCV_EXCP_NONE) {
> +        return ret;
> +    }
> +
> +    old_mvip = env->mvip;
> +
> +    /*
> +     * Write to mvip. Update only non-alias bits. Alias bits were updated
> +     * in mip in rmw_mip above.
> +     */
> +    if (wr_mask_mvip) {
> +        env->mvip = (env->mvip & ~wr_mask_mvip) | (new_val & wr_mask_mvip);
> +
> +        /*
> +         * Given mvip is separate source from mip, we need to trigger interrupt
> +         * from here separately. Normally this happen from riscv_cpu_update_mip.
> +         */
> +        riscv_cpu_interrupt(env);
> +    }
> +
> +    if (ret_val) {
> +        ret_mip &= alias_mask;
> +        old_mvip &= nalias_mask;
> +
> +        *ret_val = old_mvip | ret_mip;
> +    }
> +
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException rmw_mvip(CPURISCVState *env, int csrno,
> +                              target_ulong *ret_val,
> +                              target_ulong new_val, target_ulong wr_mask)
> +{
> +    uint64_t rval;
> +    RISCVException ret;
> +
> +    ret = rmw_mvip64(env, csrno, &rval, new_val, wr_mask);
> +    if (ret_val) {
> +        *ret_val = rval;
> +    }
> +
> +    return ret;
> +}
> +
> +static RISCVException rmw_mviph(CPURISCVState *env, int csrno,
> +                               target_ulong *ret_val,
> +                               target_ulong new_val, target_ulong wr_mask)
> +{
> +    uint64_t rval;
> +    RISCVException ret;
> +
> +    ret = rmw_mvip64(env, csrno, &rval,
> +        ((uint64_t)new_val) << 32, ((uint64_t)wr_mask) << 32);
> +    if (ret_val) {
> +        *ret_val = rval >> 32;
> +    }
> +
> +    return ret;
> +}
> +
>   /* Supervisor Trap Setup */
>   static RISCVException read_sstatus_i128(CPURISCVState *env, int csrno,
>                                           Int128 *val)
> @@ -2430,20 +2634,37 @@ static RISCVException rmw_sie64(CPURISCVState *env, int csrno,
>                                   uint64_t *ret_val,
>                                   uint64_t new_val, uint64_t wr_mask)
>   {
> +    uint64_t nalias_mask = (S_MODE_INTERRUPTS | LOCAL_INTERRUPTS) &
> +        (~env->mideleg & env->mvien);
> +    uint64_t alias_mask = (S_MODE_INTERRUPTS | LOCAL_INTERRUPTS) & env->mideleg;
> +    uint64_t sie_mask = wr_mask & nalias_mask;
>       RISCVException ret;
> -    uint64_t mask = env->mideleg & S_MODE_INTERRUPTS;
>   
> +    /*
> +     * mideleg[i]  mvien[i]
> +     *   0           0      sie[i] read-only zero.
> +     *   0           1      sie[i] is a separate writable bit.
> +     *   1           X      sie[i] alias of mie[i].
> +     *
> +     *  Both alias and non-alias mask remain same for sip except for bits
> +     *  which are zero in both mideleg and mvien.
> +     */
>       if (env->virt_enabled) {
>           if (env->hvictl & HVICTL_VTI) {
>               return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
>           }
>           ret = rmw_vsie64(env, CSR_VSIE, ret_val, new_val, wr_mask);
> +        if (ret_val) {
> +            *ret_val &= alias_mask;
> +        }
>       } else {
> -        ret = rmw_mie64(env, csrno, ret_val, new_val, wr_mask & mask);
> -    }
> +        ret = rmw_mie64(env, csrno, ret_val, new_val, wr_mask & alias_mask);
> +        if (ret_val) {
> +            *ret_val &= alias_mask;
> +            *ret_val |= env->sie & nalias_mask;
> +        }
>   
> -    if (ret_val) {
> -        *ret_val &= mask;
> +        env->sie = (env->sie & ~sie_mask) | (new_val & sie_mask);
>       }
>   
>       return ret;
> @@ -2641,7 +2862,7 @@ static RISCVException rmw_sip64(CPURISCVState *env, int csrno,
>                                   uint64_t new_val, uint64_t wr_mask)
>   {
>       RISCVException ret;
> -    uint64_t mask = env->mideleg & sip_writable_mask;
> +    uint64_t mask = (env->mideleg | env->mvien) & sip_writable_mask;
>   
>       if (env->virt_enabled) {
>           if (env->hvictl & HVICTL_VTI) {
> @@ -2649,11 +2870,12 @@ static RISCVException rmw_sip64(CPURISCVState *env, int csrno,
>           }
>           ret = rmw_vsip64(env, CSR_VSIP, ret_val, new_val, wr_mask);
>       } else {
> -        ret = rmw_mip64(env, csrno, ret_val, new_val, wr_mask & mask);
> +        ret = rmw_mvip64(env, csrno, ret_val, new_val, wr_mask & mask);
>       }
>   
>       if (ret_val) {
> -        *ret_val &= env->mideleg & S_MODE_INTERRUPTS;
> +        *ret_val &= (env->mideleg | env->mvien) &
> +            (S_MODE_INTERRUPTS | LOCAL_INTERRUPTS);
>       }
>   
>       return ret;
> @@ -2818,6 +3040,7 @@ static int read_vstopi(CPURISCVState *env, int csrno, target_ulong *val)
>   
>       *val = (iid & TOPI_IID_MASK) << TOPI_IID_SHIFT;
>       *val |= iprio;
> +
>       return RISCV_EXCP_NONE;
>   }
>   
> @@ -4123,14 +4346,14 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>       [CSR_MTOPI]    = { "mtopi",    aia_any, read_mtopi },
>   
>       /* Virtual Interrupts for Supervisor Level (AIA) */
> -    [CSR_MVIEN]    = { "mvien",    aia_any, read_zero, write_ignore },
> -    [CSR_MVIP]     = { "mvip",     aia_any, read_zero, write_ignore },
> +    [CSR_MVIEN]    = { "mvien",    aia_any, NULL, NULL, rmw_mvien   },
> +    [CSR_MVIP]     = { "mvip",     aia_any, NULL, NULL, rmw_mvip    },
>   
>       /* Machine-Level High-Half CSRs (AIA) */
>       [CSR_MIDELEGH] = { "midelegh", aia_any32, NULL, NULL, rmw_midelegh },
>       [CSR_MIEH]     = { "mieh",     aia_any32, NULL, NULL, rmw_mieh     },
> -    [CSR_MVIENH]   = { "mvienh",   aia_any32, read_zero,  write_ignore },
> -    [CSR_MVIPH]    = { "mviph",    aia_any32, read_zero,  write_ignore },
> +    [CSR_MVIENH]   = { "mvienh",   aia_any32, NULL, NULL, rmw_mvienh   },
> +    [CSR_MVIPH]    = { "mviph",    aia_any32, NULL, NULL, rmw_mviph    },
>       [CSR_MIPH]     = { "miph",     aia_any32, NULL, NULL, rmw_miph     },
>   
>       /* Execution environment configuration */
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 3ce2970785..dd7bdbb691 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -377,6 +377,9 @@ const VMStateDescription vmstate_riscv_cpu = {
>           VMSTATE_UINT64(env.mip, RISCVCPU),
>           VMSTATE_UINT64(env.miclaim, RISCVCPU),
>           VMSTATE_UINT64(env.mie, RISCVCPU),
> +        VMSTATE_UINT64(env.mvien, RISCVCPU),
> +        VMSTATE_UINT64(env.mvip, RISCVCPU),
> +        VMSTATE_UINT64(env.sie, RISCVCPU),
>           VMSTATE_UINT64(env.mideleg, RISCVCPU),
>           VMSTATE_UINTTL(env.satp, RISCVCPU),
>           VMSTATE_UINTTL(env.stval, RISCVCPU),

