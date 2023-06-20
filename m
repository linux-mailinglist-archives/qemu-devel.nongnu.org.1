Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63130736EA5
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 16:27:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBcJl-0008HM-A1; Tue, 20 Jun 2023 10:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qBcJj-0008Gf-7J; Tue, 20 Jun 2023 10:26:47 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qBcJh-0003wy-AZ; Tue, 20 Jun 2023 10:26:46 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 3E53874638A;
 Tue, 20 Jun 2023 16:26:34 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7717E746377; Tue, 20 Jun 2023 16:26:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 75C11745720;
 Tue, 20 Jun 2023 16:26:33 +0200 (CEST)
Date: Tue, 20 Jun 2023 16:26:33 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>, 
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 1/4] target/ppc: Fix instruction loading endianness in
 alignment interrupt
In-Reply-To: <20230620131044.169110-2-npiggin@gmail.com>
Message-ID: <393305f2-e785-c3f6-523f-6826b3511cc4@eik.bme.hu>
References: <20230620131044.169110-1-npiggin@gmail.com>
 <20230620131044.169110-2-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Probability: 9%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, 20 Jun 2023, Nicholas Piggin wrote:
> powerpc ifetch endianness depends on MSR[LE] so it has to byteswap
> after cpu_ldl_code(). This corrects DSISR bits in alignment
> interrupts when running in little endian mode.
>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> target/ppc/excp_helper.c | 22 +++++++++++++++++++++-
> 1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 12d8a7257b..a2801f6e6b 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -133,6 +133,26 @@ static void dump_hcall(CPUPPCState *env)
>                   env->nip);
> }
>
> +#ifdef CONFIG_TCG
> +/* Return true iff byteswap is needed to load instruction */
> +static inline bool insn_need_byteswap(CPUArchState *env)
> +{
> +    /* SYSTEM builds TARGET_BIG_ENDIAN. Need to swap when MSR[LE] is set */
> +    return !!(env->msr & ((target_ulong)1 << MSR_LE));
> +}

Don't other places typically use FIELD_EX64 to test for msr bits now? If 
this really only tests for the LE bit and used only once do we need a new 
function for that? I don't quite like trivial one line functions unless it 
does something more complex Because if just makes code harder to read as I 
have to look up what these do when I could just see it right away where it 
used without these functions.

> +
> +static uint32_t ppc_ldl_code(CPUArchState *env, hwaddr addr)
> +{
> +    uint32_t insn = cpu_ldl_code(env, addr);
> +
> +    if (insn_need_byteswap(env)) {
> +        insn = bswap32(insn);
> +    }
> +
> +    return insn;
> +}
> +#endif

Along the same lines I'm not sure this wrapper is needed unless this is a 
recurring operation. Otherwise you could just add the if and the comment 
below at the single place where this is needed. If this will be needed at 
more places later then adding a function may make sense but otherwise I'd 
avoid making code tangled with single line functions defined away from 
where they are used as it's simpler to just have the if and swap at the 
single place where it's needed than adding two new functions that I'd had 
to look up and comprehend first to see what's happening. (It also would be 
just 3 lines instead of 20 that way.)

Regards,
BALATON Zoltan

> +
> static void ppc_excp_debug_sw_tlb(CPUPPCState *env, int excp)
> {
>     const char *es;
> @@ -3104,7 +3124,7 @@ void ppc_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
>
>     /* Restore state and reload the insn we executed, for filling in DSISR.  */
>     cpu_restore_state(cs, retaddr);
> -    insn = cpu_ldl_code(env, env->nip);
> +    insn = ppc_ldl_code(env, env->nip);
>
>     switch (env->mmu_model) {
>     case POWERPC_MMU_SOFT_4xx:
>

