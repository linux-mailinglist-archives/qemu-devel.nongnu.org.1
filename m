Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD9882EF85
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 14:11:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPjCX-0006gp-Lr; Tue, 16 Jan 2024 08:09:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rPjCU-0006bK-H4; Tue, 16 Jan 2024 08:09:54 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rPjCR-00089R-IY; Tue, 16 Jan 2024 08:09:54 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TDq6s41zWz6H6tG;
 Tue, 16 Jan 2024 21:07:33 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 5CE03140A36;
 Tue, 16 Jan 2024 21:09:42 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 16 Jan
 2024 13:09:41 +0000
Date: Tue, 16 Jan 2024 13:09:40 +0000
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 27/35] target/arm: Report VNCR_EL2 based faults correctly
Message-ID: <20240116130940.00002523@Huawei.com>
In-Reply-To: <20231218113305.2511480-28-peter.maydell@linaro.org>
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
 <20231218113305.2511480-28-peter.maydell@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, 18 Dec 2023 11:32:57 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> If FEAT_NV2 redirects a system register access to a memory offset
> from VNCR_EL2, that access might fault.  In this case we need to
> report the correct syndrome information:
>  * Data Abort, from same-EL
>  * no ISS information
>  * the VNCR bit (bit 13) is set
> 
> and the exception must be taken to EL2.
> 
> Save an appropriate syndrome template when generating code; we can
> then use that to:
>  * select the right target EL
>  * reconstitute a correct final syndrome for the data abort
>  * report the right syndrome if we take a FEAT_RME granule protection
>    fault on the VNCR-based write
> 
> Note that because VNCR is bit 13, we must start keeping bit 13 in
> template syndromes, by adjusting ARM_INSN_START_WORD2_SHIFT.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Hi Peter,

I'm getting an unhelpful crash on calling init in a guest
running on top of an a76 emulated host with virtualization turned on.

Run /sbin/init as init process
Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000007
CPU: 1 PID: 1 Comm: init Not tainted 6.7.0+ #1119
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0xa0/0x128
 show_stack+0x20/0x38
 dump_stack_lvl+0x48/0x60
 dump_stack+0x18/0x28
 panic+0x380/0x3c0
 do_exit+0x89c/0x9a0
 do_group_exit+0x3c/0xa0
 get_signal+0x968/0x970
 do_notify_resume+0x21c/0x1460
 el0_ia+0xa0/0xb0
 el0t_64_sync_handler+0xd0/0x130
 el0t_64_sync+0x190/0x198
SMP: stopping secondary CPUs
Kernel Offset: 0x2a8c93a00000 from 0xffff800080000000
PHYS_OFFSET: 0xffff82f980000000
CPU features: 0x0,00000001,7002014a,2101720b
Memory Limit: none
---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000007 ]---

Upstream kernel as of yesterday.  Nothing particular 'exciting' in the
configurations. Not attempting to use Nested virt.
-M virt,gic-version=3,virtualization=true
-cpu cortex-a76 (happens with max as well but switched to a76 for testing
to reduce possible sources of problems).

Doesn't happen if single cpu in the guest, or if using gic v2 in both.

Bisection points at this patch - so far no idea why but I've only
just started digging into this.
Having one of those weeks where I'm juggling several issues so
might not make progress on this for a while.

The VMM in the guest is also recent QEMU (yesterday's upstream I think)
so I suppose this might just be exposing a problem that will bisect
to a different patch in there.

Jonathan

> ---
>  target/arm/cpu.h               |  4 ++--
>  target/arm/syndrome.h          | 20 ++++++++++++++++----
>  target/arm/tcg/tlb_helper.c    | 27 +++++++++++++++++++++++++--
>  target/arm/tcg/translate-a64.c |  4 ++++
>  4 files changed, 47 insertions(+), 8 deletions(-)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index bc4fa95ea35..da640949518 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -120,12 +120,12 @@ enum {
>  #define TARGET_INSN_START_EXTRA_WORDS 2
>  
>  /* The 2nd extra word holding syndrome info for data aborts does not use
> - * the upper 6 bits nor the lower 14 bits. We mask and shift it down to
> + * the upper 6 bits nor the lower 13 bits. We mask and shift it down to
>   * help the sleb128 encoder do a better job.
>   * When restoring the CPU state, we shift it back up.
>   */
>  #define ARM_INSN_START_WORD2_MASK ((1 << 26) - 1)
> -#define ARM_INSN_START_WORD2_SHIFT 14
> +#define ARM_INSN_START_WORD2_SHIFT 13
>  
>  /* We currently assume float and double are IEEE single and double
>     precision respectively.
> diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
> index 95454b5b3bb..1a49767479f 100644
> --- a/target/arm/syndrome.h
> +++ b/target/arm/syndrome.h
> @@ -86,6 +86,9 @@ typedef enum {
>  #define ARM_EL_IL (1 << ARM_EL_IL_SHIFT)
>  #define ARM_EL_ISV (1 << ARM_EL_ISV_SHIFT)
>  
> +/* In the Data Abort syndrome */
> +#define ARM_EL_VNCR (1 << 13)
> +
>  static inline uint32_t syn_get_ec(uint32_t syn)
>  {
>      return syn >> ARM_EL_EC_SHIFT;
> @@ -256,13 +259,12 @@ static inline uint32_t syn_bxjtrap(int cv, int cond, int rm)
>          (cv << 24) | (cond << 20) | rm;
>  }
>  
> -static inline uint32_t syn_gpc(int s2ptw, int ind, int gpcsc,
> +static inline uint32_t syn_gpc(int s2ptw, int ind, int gpcsc, int vncr,
>                                 int cm, int s1ptw, int wnr, int fsc)
>  {
> -    /* TODO: FEAT_NV2 adds VNCR */
>      return (EC_GPC << ARM_EL_EC_SHIFT) | ARM_EL_IL | (s2ptw << 21)
> -            | (ind << 20) | (gpcsc << 14) | (cm << 8) | (s1ptw << 7)
> -            | (wnr << 6) | fsc;
> +        | (ind << 20) | (gpcsc << 14) | (vncr << 13) | (cm << 8)
> +        | (s1ptw << 7) | (wnr << 6) | fsc;
>  }
>  
>  static inline uint32_t syn_insn_abort(int same_el, int ea, int s1ptw, int fsc)
> @@ -295,6 +297,16 @@ static inline uint32_t syn_data_abort_with_iss(int same_el,
>             | (ea << 9) | (cm << 8) | (s1ptw << 7) | (wnr << 6) | fsc;
>  }
>  
> +/*
> + * Faults due to FEAT_NV2 VNCR_EL2-based accesses report as same-EL
> + * Data Aborts with the VNCR bit set.
> + */
> +static inline uint32_t syn_data_abort_vncr(int ea, int wnr, int fsc)
> +{
> +    return (EC_DATAABORT << ARM_EL_EC_SHIFT) | (1 << ARM_EL_EC_SHIFT)
> +        | ARM_EL_IL | ARM_EL_VNCR | (wnr << 6) | fsc;
> +}
> +
>  static inline uint32_t syn_swstep(int same_el, int isv, int ex)
>  {
>      return (EC_SOFTWARESTEP << ARM_EL_EC_SHIFT) | (same_el << ARM_EL_EC_SHIFT)
> diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
> index 4fdd85359e1..dd5de74ffb7 100644
> --- a/target/arm/tcg/tlb_helper.c
> +++ b/target/arm/tcg/tlb_helper.c
> @@ -50,7 +50,15 @@ static inline uint32_t merge_syn_data_abort(uint32_t template_syn,
>       * ST64BV, or ST64BV0 insns report syndrome info even for stage-1
>       * faults and regardless of the target EL.
>       */
> -    if (!(template_syn & ARM_EL_ISV) || target_el != 2
> +    if (template_syn & ARM_EL_VNCR) {
> +        /*
> +         * FEAT_NV2 faults on accesses via VNCR_EL2 are a special case:
> +         * they are always reported as "same EL", even though we are going
> +         * from EL1 to EL2.
> +         */
> +        assert(!fi->stage2);
> +        syn = syn_data_abort_vncr(fi->ea, is_write, fsc);
> +    } else if (!(template_syn & ARM_EL_ISV) || target_el != 2
>          || fi->s1ptw || !fi->stage2) {
>          syn = syn_data_abort_no_iss(same_el, 0,
>                                      fi->ea, 0, fi->s1ptw, is_write, fsc);
> @@ -169,6 +177,20 @@ void arm_deliver_fault(ARMCPU *cpu, vaddr addr,
>      int current_el = arm_current_el(env);
>      bool same_el;
>      uint32_t syn, exc, fsr, fsc;
> +    /*
> +     * We know this must be a data or insn abort, and that
> +     * env->exception.syndrome contains the template syndrome set
> +     * up at translate time. So we can check only the VNCR bit
> +     * (and indeed syndrome does not have the EC field in it,
> +     * because we masked that out in disas_set_insn_syndrome())
> +     */
> +    bool is_vncr = (mmu_idx != MMU_INST_FETCH) &&
> +        (env->exception.syndrome & ARM_EL_VNCR);
> +
> +    if (is_vncr) {
> +        /* FEAT_NV2 faults on accesses via VNCR_EL2 go to EL2 */
> +        target_el = 2;
> +    }
>  
>      if (report_as_gpc_exception(cpu, current_el, fi)) {
>          target_el = 3;
> @@ -177,7 +199,8 @@ void arm_deliver_fault(ARMCPU *cpu, vaddr addr,
>  
>          syn = syn_gpc(fi->stage2 && fi->type == ARMFault_GPCFOnWalk,
>                        access_type == MMU_INST_FETCH,
> -                      encode_gpcsc(fi), 0, fi->s1ptw,
> +                      encode_gpcsc(fi), is_vncr,
> +                      0, fi->s1ptw,
>                        access_type == MMU_DATA_STORE, fsc);
>  
>          env->cp15.mfar_el3 = fi->paddr;
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
> index 128bff4b445..8f905ed9645 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -2293,6 +2293,7 @@ static void handle_sys(DisasContext *s, bool isread,
>          MemOp mop = MO_64 | MO_ALIGN | MO_ATOM_IFALIGN;
>          ARMMMUIdx armmemidx = s->nv2_mem_e20 ? ARMMMUIdx_E20_2 : ARMMMUIdx_E2;
>          int memidx = arm_to_core_mmu_idx(armmemidx);
> +        uint32_t syn;
>  
>          if (s->nv2_mem_be) {
>              mop |= MO_BE;
> @@ -2302,6 +2303,9 @@ static void handle_sys(DisasContext *s, bool isread,
>          tcg_gen_addi_i64(ptr, ptr,
>                           (ri->nv2_redirect_offset & ~NV2_REDIR_FLAG_MASK));
>          tcg_rt = cpu_reg(s, rt);
> +
> +        syn = syn_data_abort_vncr(0, !isread, 0);
> +        disas_set_insn_syndrome(s, syn);
>          if (isread) {
>              tcg_gen_qemu_ld_i64(tcg_rt, ptr, memidx, mop);
>          } else {


