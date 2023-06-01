Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D907195CE
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 10:41:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4dqi-0003kM-An; Thu, 01 Jun 2023 04:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=vOrz=BV=kaod.org=clg@ozlabs.org>)
 id 1q4dqg-0003fr-Jq; Thu, 01 Jun 2023 04:39:58 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=vOrz=BV=kaod.org=clg@ozlabs.org>)
 id 1q4dqe-000461-G6; Thu, 01 Jun 2023 04:39:58 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QX01k19kJz4x4T;
 Thu,  1 Jun 2023 18:39:54 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QX01h1bnGz4x4Y;
 Thu,  1 Jun 2023 18:39:51 +1000 (AEST)
Message-ID: <bd9b6f7d-a837-0086-3c77-e1c88dca7de8@kaod.org>
Date: Thu, 1 Jun 2023 10:39:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 6/7] target/ppc: Change ppcemb_tlb_check() to return bool
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Daniel Henrique Barboza <danielhb413@gmail.com>
References: <cover.1685448535.git.balaton@eik.bme.hu>
 <bacd1bcbe99c07930c29a9815915da9ac75f6920.1685448535.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <bacd1bcbe99c07930c29a9815915da9ac75f6920.1685448535.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=vOrz=BV=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 5/30/23 15:28, BALATON Zoltan wrote:
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   target/ppc/mmu_common.c | 26 +++++++++++++-------------
>   1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index ff7f987546..bd7d7d5257 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -489,15 +489,15 @@ static int get_segment_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
>   }
>   
>   /* Generic TLB check function for embedded PowerPC implementations */
> -static int ppcemb_tlb_check(CPUPPCState *env, ppcemb_tlb_t *tlb,
> -                            hwaddr *raddrp,
> -                            target_ulong address, uint32_t pid, int i)
> +static bool ppcemb_tlb_check(CPUPPCState *env, ppcemb_tlb_t *tlb,
> +                             hwaddr *raddrp,
> +                             target_ulong address, uint32_t pid, int i)
>   {
>       target_ulong mask;
>   
>       /* Check valid flag */
>       if (!(tlb->prot & PAGE_VALID)) {
> -        return -1;
> +        return false;
>       }
>       mask = ~(tlb->size - 1);
>       qemu_log_mask(CPU_LOG_MMU, "%s: TLB %d address " TARGET_FMT_lx
> @@ -506,14 +506,14 @@ static int ppcemb_tlb_check(CPUPPCState *env, ppcemb_tlb_t *tlb,
>                     mask, (uint32_t)tlb->PID, tlb->prot);
>       /* Check PID */
>       if (tlb->PID != 0 && tlb->PID != pid) {
> -        return -1;
> +        return false;
>       }
>       /* Check effective address */
>       if ((address & mask) != tlb->EPN) {
> -        return -1;
> +        return false;
>       }
>       *raddrp = (tlb->RPN & mask) | (address & ~mask);
> -    return 0;
> +    return true;
>   }
>   
>   /* Generic TLB search function for PowerPC embedded implementations */
> @@ -525,7 +525,7 @@ int ppcemb_tlb_search(CPUPPCState *env, target_ulong address, uint32_t pid)
>   
>       for (i = 0; i < env->nb_tlb; i++) {
>           tlb = &env->tlb.tlbe[i];
> -        if (ppcemb_tlb_check(env, tlb, &raddr, address, pid, i) == 0) {
> +        if (ppcemb_tlb_check(env, tlb, &raddr, address, pid, i)) {
>               return i;
>           }
>       }
> @@ -545,8 +545,8 @@ static int mmu40x_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
>       pr = FIELD_EX64(env->msr, MSR, PR);
>       for (i = 0; i < env->nb_tlb; i++) {
>           tlb = &env->tlb.tlbe[i];
> -        if (ppcemb_tlb_check(env, tlb, &raddr, address,
> -                             env->spr[SPR_40x_PID], i) < 0) {
> +        if (!ppcemb_tlb_check(env, tlb, &raddr, address,
> +                              env->spr[SPR_40x_PID], i)) {
>               continue;
>           }
>           zsel = (tlb->attr >> 4) & 0xF;
> @@ -608,7 +608,7 @@ static int mmubooke_check_tlb(CPUPPCState *env, ppcemb_tlb_t *tlb,
>       int prot2;
>   
>       if (ppcemb_tlb_check(env, tlb, raddr, address,
> -                         env->spr[SPR_BOOKE_PID], i) >= 0) {
> +                         env->spr[SPR_BOOKE_PID], i)) {
>           if (!env->nb_pids) {
>               /* Extend the physical address to 36 bits */
>               *raddr |= (uint64_t)(tlb->RPN & 0xF) << 32;
> @@ -618,13 +618,13 @@ static int mmubooke_check_tlb(CPUPPCState *env, ppcemb_tlb_t *tlb,
>   
>       if (env->spr[SPR_BOOKE_PID1] &&
>           ppcemb_tlb_check(env, tlb, raddr, address,
> -                         env->spr[SPR_BOOKE_PID1], i) >= 0) {
> +                         env->spr[SPR_BOOKE_PID1], i)) {
>           goto found_tlb;
>       }
>   
>       if (env->spr[SPR_BOOKE_PID2] &&
>           ppcemb_tlb_check(env, tlb, raddr, address,
> -                         env->spr[SPR_BOOKE_PID2], i) >= 0) {
> +                         env->spr[SPR_BOOKE_PID2], i)) {
>           goto found_tlb;
>       }
>   


