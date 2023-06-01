Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 354307195C9
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 10:40:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4dqL-0002mO-J2; Thu, 01 Jun 2023 04:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=vOrz=BV=kaod.org=clg@ozlabs.org>)
 id 1q4dqK-0002m3-97; Thu, 01 Jun 2023 04:39:36 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=vOrz=BV=kaod.org=clg@ozlabs.org>)
 id 1q4dqI-00042s-7s; Thu, 01 Jun 2023 04:39:36 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QX01H6Tp2z4x4L;
 Thu,  1 Jun 2023 18:39:31 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QX01F6JFKz4x3g;
 Thu,  1 Jun 2023 18:39:29 +1000 (AEST)
Message-ID: <2cacf6ae-6a05-d885-2d28-bab96ab32bf6@kaod.org>
Date: Thu, 1 Jun 2023 10:39:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/7] target/ppc: Move ppcemb_tlb_search() to mmu_common.c
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Daniel Henrique Barboza <danielhb413@gmail.com>
References: <cover.1685448535.git.balaton@eik.bme.hu>
 <b64fd712a773558dea9b84945c57785546c0ae2e.1685448535.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <b64fd712a773558dea9b84945c57785546c0ae2e.1685448535.git.balaton@eik.bme.hu>
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
> This function is the only reason why ppcemb_tlb_check() is not static
> to mmu_common.c but it also better fits in mmu_common.c so move it
> there.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>   target/ppc/cpu.h        |  4 +---
>   target/ppc/mmu_common.c | 22 +++++++++++++++++++++-
>   target/ppc/mmu_helper.c | 21 ---------------------
>   3 files changed, 22 insertions(+), 25 deletions(-)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 5cd1b442b4..77eb5edea2 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1428,9 +1428,7 @@ void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp);
>   int ppcmas_tlb_check(CPUPPCState *env, ppcmas_tlb_t *tlb,
>                               hwaddr *raddrp, target_ulong address,
>                               uint32_t pid);
> -int ppcemb_tlb_check(CPUPPCState *env, ppcemb_tlb_t *tlb,
> -                            hwaddr *raddrp,
> -                            target_ulong address, uint32_t pid, int i);
> +int ppcemb_tlb_search(CPUPPCState *env, target_ulong address, uint32_t pid);
>   hwaddr booke206_tlb_to_page_size(CPUPPCState *env,
>                                           ppcmas_tlb_t *tlb);
>   #endif
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 21a353c51a..845eee4c6f 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -489,7 +489,7 @@ static int get_segment_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
>   }
>   
>   /* Generic TLB check function for embedded PowerPC implementations */
> -int ppcemb_tlb_check(CPUPPCState *env, ppcemb_tlb_t *tlb,
> +static int ppcemb_tlb_check(CPUPPCState *env, ppcemb_tlb_t *tlb,
>                               hwaddr *raddrp,
>                               target_ulong address, uint32_t pid, int i)
>   {
> @@ -516,6 +516,26 @@ int ppcemb_tlb_check(CPUPPCState *env, ppcemb_tlb_t *tlb,
>       return 0;
>   }
>   
> +/* Generic TLB search function for PowerPC embedded implementations */
> +int ppcemb_tlb_search(CPUPPCState *env, target_ulong address, uint32_t pid)
> +{
> +    ppcemb_tlb_t *tlb;
> +    hwaddr raddr;
> +    int i, ret;
> +
> +    /* Default return value is no match */
> +    ret = -1;
> +    for (i = 0; i < env->nb_tlb; i++) {
> +        tlb = &env->tlb.tlbe[i];
> +        if (ppcemb_tlb_check(env, tlb, &raddr, address, pid, i) == 0) {
> +            ret = i;
> +            break;
> +        }
> +    }
> +
> +    return ret;
> +}
> +
>   static int mmu40x_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
>                                          target_ulong address,
>                                          MMUAccessType access_type)
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index e7275eaec1..d3ea7588f9 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -112,27 +112,6 @@ static void ppc6xx_tlb_store(CPUPPCState *env, target_ulong EPN, int way,
>       env->last_way = way;
>   }
>   
> -/* Generic TLB search function for PowerPC embedded implementations */
> -static int ppcemb_tlb_search(CPUPPCState *env, target_ulong address,
> -                             uint32_t pid)
> -{
> -    ppcemb_tlb_t *tlb;
> -    hwaddr raddr;
> -    int i, ret;
> -
> -    /* Default return value is no match */
> -    ret = -1;
> -    for (i = 0; i < env->nb_tlb; i++) {
> -        tlb = &env->tlb.tlbe[i];
> -        if (ppcemb_tlb_check(env, tlb, &raddr, address, pid, i) == 0) {
> -            ret = i;
> -            break;
> -        }
> -    }
> -
> -    return ret;
> -}
> -
>   /* Helpers specific to PowerPC 40x implementations */
>   static inline void ppc4xx_tlb_invalidate_all(CPUPPCState *env)
>   {


