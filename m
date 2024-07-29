Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF17B93ED0C
	for <lists+qemu-devel@lfdr.de>; Mon, 29 Jul 2024 07:48:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYJEQ-0001VB-V1; Mon, 29 Jul 2024 01:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sYJEO-0001Sx-CI; Mon, 29 Jul 2024 01:47:36 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sYJEK-0005bh-Lh; Mon, 29 Jul 2024 01:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1722232040; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=F+BxR8V1XeFCJYQKWNkx1Gjf10cXeYK5MhUfnNYKpq0=;
 b=NFQHcgprgngZiQzvwSAAO6vsc4zw0In7jG/rvKjro9IaHEAoR3xyXL3j3Rc2VKyozCBoecVfFY+7ZgOqdpLaEq7lKc/NoBLwquDa3MDI5rkvkY1KkcW1BX7owDwmnol0bXW2FRY5iIG9QXL6X5ze6bs7eQOKNfPX/gOdtg+FXFM=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R511e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045046011;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0WBUe5IW_1722232039; 
Received: from 30.166.64.206(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WBUe5IW_1722232039) by smtp.aliyun-inc.com;
 Mon, 29 Jul 2024 13:47:19 +0800
Message-ID: <0b70d915-2662-479c-bfc4-61f39d57b7bf@linux.alibaba.com>
Date: Mon, 29 Jul 2024 13:47:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RISC-V: Remove riscv_cpu_claim_interrupts()
To: Alvin Chang <alvinga@andestech.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com
References: <20240727042758.2341031-1-alvinga@andestech.com>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240727042758.2341031-1-alvinga@andestech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.130;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-130.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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


On 2024/7/27 12:27, Alvin Chang wrote:
> The function of riscv_cpu_claim_interrupts() was introduced in commit
> e3e7039 ("RISC-V: Allow interrupt controllers to claim interrupts") to
> enforce hardware controlled of SEIP signal when there is an attached
> external interrupt controller.
>
> In later RISC-V privileged specification version 1.10, SEIP became
> software-writable, even if there is an attached external interrupt
> controller. Thus, the commit 33fe584 ("target/riscv: Allow software
> access to MIP SEIP") was introduced to remove that limitation, and it
> also removed the usage of "miclaim" mask.
>
> It seems the function of riscv_cpu_claim_interrupts() is no longer used.
> Therefore, we remove it in this commit.
As MTIP/MSIP/MEIP in mip are still read-only fields in mip. I think we 
should not remove it.
Perhaps we should  add an assert for read-only fields for this function.

Thanks,
Zhiwei

>
> Signed-off-by: Alvin Chang <alvinga@andestech.com>
> ---
>   hw/intc/riscv_aclint.c    | 20 --------------------
>   hw/intc/riscv_aplic.c     | 11 -----------
>   hw/intc/riscv_imsic.c     |  8 --------
>   hw/intc/sifive_plic.c     | 15 ---------------
>   target/riscv/cpu.c        |  1 -
>   target/riscv/cpu.h        |  3 ---
>   target/riscv/cpu_helper.c | 11 -----------
>   target/riscv/machine.c    |  1 -
>   8 files changed, 70 deletions(-)
>
> diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
> index e9f0536b1c..54cf69dada 100644
> --- a/hw/intc/riscv_aclint.c
> +++ b/hw/intc/riscv_aclint.c
> @@ -280,7 +280,6 @@ static Property riscv_aclint_mtimer_properties[] = {
>   static void riscv_aclint_mtimer_realize(DeviceState *dev, Error **errp)
>   {
>       RISCVAclintMTimerState *s = RISCV_ACLINT_MTIMER(dev);
> -    int i;
>   
>       memory_region_init_io(&s->mmio, OBJECT(dev), &riscv_aclint_mtimer_ops,
>                             s, TYPE_RISCV_ACLINT_MTIMER, s->aperture_size);
> @@ -291,14 +290,6 @@ static void riscv_aclint_mtimer_realize(DeviceState *dev, Error **errp)
>   
>       s->timers = g_new0(QEMUTimer *, s->num_harts);
>       s->timecmp = g_new0(uint64_t, s->num_harts);
> -    /* Claim timer interrupt bits */
> -    for (i = 0; i < s->num_harts; i++) {
> -        RISCVCPU *cpu = RISCV_CPU(cpu_by_arch_id(s->hartid_base + i));
> -        if (riscv_cpu_claim_interrupts(cpu, MIP_MTIP) < 0) {
> -            error_report("MTIP already claimed");
> -            exit(1);
> -        }
> -    }
>   }
>   
>   static void riscv_aclint_mtimer_reset_enter(Object *obj, ResetType type)
> @@ -472,7 +463,6 @@ static Property riscv_aclint_swi_properties[] = {
>   static void riscv_aclint_swi_realize(DeviceState *dev, Error **errp)
>   {
>       RISCVAclintSwiState *swi = RISCV_ACLINT_SWI(dev);
> -    int i;
>   
>       memory_region_init_io(&swi->mmio, OBJECT(dev), &riscv_aclint_swi_ops, swi,
>                             TYPE_RISCV_ACLINT_SWI, RISCV_ACLINT_SWI_SIZE);
> @@ -480,16 +470,6 @@ static void riscv_aclint_swi_realize(DeviceState *dev, Error **errp)
>   
>       swi->soft_irqs = g_new(qemu_irq, swi->num_harts);
>       qdev_init_gpio_out(dev, swi->soft_irqs, swi->num_harts);
> -
> -    /* Claim software interrupt bits */
> -    for (i = 0; i < swi->num_harts; i++) {
> -        RISCVCPU *cpu = RISCV_CPU(qemu_get_cpu(swi->hartid_base + i));
> -        /* We don't claim mip.SSIP because it is writable by software */
> -        if (riscv_cpu_claim_interrupts(cpu, swi->sswi ? 0 : MIP_MSIP) < 0) {
> -            error_report("MSIP already claimed");
> -            exit(1);
> -        }
> -    }
>   }
>   
>   static void riscv_aclint_swi_reset_enter(Object *obj, ResetType type)
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index 32edd6d07b..cde8337542 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -873,17 +873,6 @@ static void riscv_aplic_realize(DeviceState *dev, Error **errp)
>       if (!aplic->msimode) {
>           aplic->external_irqs = g_malloc(sizeof(qemu_irq) * aplic->num_harts);
>           qdev_init_gpio_out(dev, aplic->external_irqs, aplic->num_harts);
> -
> -        /* Claim the CPU interrupt to be triggered by this APLIC */
> -        for (i = 0; i < aplic->num_harts; i++) {
> -            RISCVCPU *cpu = RISCV_CPU(cpu_by_arch_id(aplic->hartid_base + i));
> -            if (riscv_cpu_claim_interrupts(cpu,
> -                (aplic->mmode) ? MIP_MEIP : MIP_SEIP) < 0) {
> -                error_report("%s already claimed",
> -                             (aplic->mmode) ? "MEIP" : "SEIP");
> -                exit(1);
> -            }
> -        }
>       }
>   
>       msi_nonbroken = true;
> diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
> index b90f0d731d..8c61a5f28b 100644
> --- a/hw/intc/riscv_imsic.c
> +++ b/hw/intc/riscv_imsic.c
> @@ -347,14 +347,6 @@ static void riscv_imsic_realize(DeviceState *dev, Error **errp)
>                             IMSIC_MMIO_SIZE(imsic->num_pages));
>       sysbus_init_mmio(SYS_BUS_DEVICE(dev), &imsic->mmio);
>   
> -    /* Claim the CPU interrupt to be triggered by this IMSIC */
> -    if (riscv_cpu_claim_interrupts(rcpu,
> -            (imsic->mmode) ? MIP_MEIP : MIP_SEIP) < 0) {
> -        error_setg(errp, "%s already claimed",
> -                   (imsic->mmode) ? "MEIP" : "SEIP");
> -        return;
> -    }
> -
>       /* Create output IRQ lines */
>       imsic->external_irqs = g_malloc(sizeof(qemu_irq) * imsic->num_pages);
>       qdev_init_gpio_out(dev, imsic->external_irqs, imsic->num_pages);
> diff --git a/hw/intc/sifive_plic.c b/hw/intc/sifive_plic.c
> index e559f11805..f0f3dcce1f 100644
> --- a/hw/intc/sifive_plic.c
> +++ b/hw/intc/sifive_plic.c
> @@ -356,7 +356,6 @@ static void sifive_plic_irq_request(void *opaque, int irq, int level)
>   static void sifive_plic_realize(DeviceState *dev, Error **errp)
>   {
>       SiFivePLICState *s = SIFIVE_PLIC(dev);
> -    int i;
>   
>       memory_region_init_io(&s->mmio, OBJECT(dev), &sifive_plic_ops, s,
>                             TYPE_SIFIVE_PLIC, s->aperture_size);
> @@ -385,20 +384,6 @@ static void sifive_plic_realize(DeviceState *dev, Error **errp)
>       s->m_external_irqs = g_malloc(sizeof(qemu_irq) * s->num_harts);
>       qdev_init_gpio_out(dev, s->m_external_irqs, s->num_harts);
>   
> -    /*
> -     * We can't allow the supervisor to control SEIP as this would allow the
> -     * supervisor to clear a pending external interrupt which will result in
> -     * lost a interrupt in the case a PLIC is attached. The SEIP bit must be
> -     * hardware controlled when a PLIC is attached.
> -     */
> -    for (i = 0; i < s->num_harts; i++) {
> -        RISCVCPU *cpu = RISCV_CPU(qemu_get_cpu(s->hartid_base + i));
> -        if (riscv_cpu_claim_interrupts(cpu, MIP_SEIP) < 0) {
> -            error_setg(errp, "SEIP already claimed");
> -            return;
> -        }
> -    }
> -
>       msi_nonbroken = true;
>   }
>   
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index a90808a3ba..19feb032d6 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -967,7 +967,6 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>           }
>       }
>       env->mcause = 0;
> -    env->miclaim = MIP_SGEIP;
>       env->pc = env->resetvec;
>       env->bins = 0;
>       env->two_stage_lookup = false;
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 1619c3acb6..6277979afd 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -258,8 +258,6 @@ struct CPUArchState {
>       bool external_seip;
>       bool software_seip;
>   
> -    uint64_t miclaim;
> -
>       uint64_t mie;
>       uint64_t mideleg;
>   
> @@ -565,7 +563,6 @@ void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
>   hwaddr riscv_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>   bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request);
>   void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env);
> -int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts);
>   uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask,
>                                 uint64_t value);
>   void riscv_cpu_interrupt(CPURISCVState *env);
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 395a1d9140..bcafa55acd 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -619,17 +619,6 @@ void riscv_cpu_set_geilen(CPURISCVState *env, target_ulong geilen)
>       env->geilen = geilen;
>   }
>   
> -int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts)
> -{
> -    CPURISCVState *env = &cpu->env;
> -    if (env->miclaim & interrupts) {
> -        return -1;
> -    } else {
> -        env->miclaim |= interrupts;
> -        return 0;
> -    }
> -}
> -
>   void riscv_cpu_interrupt(CPURISCVState *env)
>   {
>       uint64_t gein, vsgein = 0, vstip = 0, irqf = 0;
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 492c2c6d9d..0eabb6c076 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -378,7 +378,6 @@ const VMStateDescription vmstate_riscv_cpu = {
>           VMSTATE_UINTTL(env.mhartid, RISCVCPU),
>           VMSTATE_UINT64(env.mstatus, RISCVCPU),
>           VMSTATE_UINT64(env.mip, RISCVCPU),
> -        VMSTATE_UINT64(env.miclaim, RISCVCPU),
>           VMSTATE_UINT64(env.mie, RISCVCPU),
>           VMSTATE_UINT64(env.mvien, RISCVCPU),
>           VMSTATE_UINT64(env.mvip, RISCVCPU),

