Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9440F7195C6
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 10:39:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4dqG-0002ju-2B; Thu, 01 Jun 2023 04:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=vOrz=BV=kaod.org=clg@ozlabs.org>)
 id 1q4dqE-0002gB-Gu; Thu, 01 Jun 2023 04:39:30 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=vOrz=BV=kaod.org=clg@ozlabs.org>)
 id 1q4dqC-00042E-1M; Thu, 01 Jun 2023 04:39:30 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QX0173Wytz4x4H;
 Thu,  1 Jun 2023 18:39:23 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QX0153jJ3z4x3g;
 Thu,  1 Jun 2023 18:39:21 +1000 (AEST)
Message-ID: <25afce0a-dbbf-7f77-7c94-8718bf969b6d@kaod.org>
Date: Thu, 1 Jun 2023 10:39:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/7] target/ppc: Remove "ext" parameter of
 ppcemb_tlb_check()
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Daniel Henrique Barboza <danielhb413@gmail.com>
References: <cover.1685448535.git.balaton@eik.bme.hu>
 <b21f11ae20e8a8c2e8b5d943f2bff12b5356005a.1685448535.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <b21f11ae20e8a8c2e8b5d943f2bff12b5356005a.1685448535.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=vOrz=BV=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.091, SPF_HELO_PASS=-0.001,
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

On 5/30/23 15:28, BALATON Zoltan wrote:
> This is only used by one caller so simplify function by removing this
> parameter and move the operation to the single place where it's used.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   target/ppc/cpu.h        |  3 +--
>   target/ppc/mmu_common.c | 21 +++++++++------------
>   target/ppc/mmu_helper.c |  2 +-
>   3 files changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 0f9f2e1a0c..5cd1b442b4 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1430,8 +1430,7 @@ int ppcmas_tlb_check(CPUPPCState *env, ppcmas_tlb_t *tlb,
>                               uint32_t pid);
>   int ppcemb_tlb_check(CPUPPCState *env, ppcemb_tlb_t *tlb,
>                               hwaddr *raddrp,
> -                            target_ulong address, uint32_t pid, int ext,
> -                            int i);
> +                            target_ulong address, uint32_t pid, int i);
>   hwaddr booke206_tlb_to_page_size(CPUPPCState *env,
>                                           ppcmas_tlb_t *tlb);
>   #endif
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 7235a4befe..21a353c51a 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -491,8 +491,7 @@ static int get_segment_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
>   /* Generic TLB check function for embedded PowerPC implementations */
>   int ppcemb_tlb_check(CPUPPCState *env, ppcemb_tlb_t *tlb,
>                               hwaddr *raddrp,
> -                            target_ulong address, uint32_t pid, int ext,
> -                            int i)
> +                            target_ulong address, uint32_t pid, int i)
>   {
>       target_ulong mask;
>   
> @@ -514,11 +513,6 @@ int ppcemb_tlb_check(CPUPPCState *env, ppcemb_tlb_t *tlb,
>           return -1;
>       }
>       *raddrp = (tlb->RPN & mask) | (address & ~mask);
> -    if (ext) {
> -        /* Extend the physical address to 36 bits */
> -        *raddrp |= (uint64_t)(tlb->RPN & 0xF) << 32;
> -    }
> -
>       return 0;
>   }
>   
> @@ -536,7 +530,7 @@ static int mmu40x_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
>       for (i = 0; i < env->nb_tlb; i++) {
>           tlb = &env->tlb.tlbe[i];
>           if (ppcemb_tlb_check(env, tlb, &raddr, address,
> -                             env->spr[SPR_40x_PID], 0, i) < 0) {
> +                             env->spr[SPR_40x_PID], i) < 0) {
>               continue;
>           }
>           zsel = (tlb->attr >> 4) & 0xF;
> @@ -598,20 +592,23 @@ static int mmubooke_check_tlb(CPUPPCState *env, ppcemb_tlb_t *tlb,
>       int prot2;
>   
>       if (ppcemb_tlb_check(env, tlb, raddr, address,
> -                         env->spr[SPR_BOOKE_PID],
> -                         !env->nb_pids, i) >= 0) {
> +                         env->spr[SPR_BOOKE_PID], i) >= 0) {
> +        if (!env->nb_pids) {
> +            /* Extend the physical address to 36 bits */
> +            *raddr |= (uint64_t)(tlb->RPN & 0xF) << 32;
> +        }
>           goto found_tlb;
>       }
>   
>       if (env->spr[SPR_BOOKE_PID1] &&
>           ppcemb_tlb_check(env, tlb, raddr, address,
> -                         env->spr[SPR_BOOKE_PID1], 0, i) >= 0) {
> +                         env->spr[SPR_BOOKE_PID1], i) >= 0) {
>           goto found_tlb;
>       }
>   
>       if (env->spr[SPR_BOOKE_PID2] &&
>           ppcemb_tlb_check(env, tlb, raddr, address,
> -                         env->spr[SPR_BOOKE_PID2], 0, i) >= 0) {
> +                         env->spr[SPR_BOOKE_PID2], i) >= 0) {
>           goto found_tlb;
>       }
>   
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index c0c71a68ff..e7275eaec1 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -124,7 +124,7 @@ static int ppcemb_tlb_search(CPUPPCState *env, target_ulong address,
>       ret = -1;
>       for (i = 0; i < env->nb_tlb; i++) {
>           tlb = &env->tlb.tlbe[i];
> -        if (ppcemb_tlb_check(env, tlb, &raddr, address, pid, 0, i) == 0) {
> +        if (ppcemb_tlb_check(env, tlb, &raddr, address, pid, i) == 0) {
>               ret = i;
>               break;
>           }


