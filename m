Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B71AF76867D
	for <lists+qemu-devel@lfdr.de>; Sun, 30 Jul 2023 18:44:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQ9P1-0001Zj-6N; Sun, 30 Jul 2023 12:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=LlZL=DQ=kaod.org=clg@ozlabs.org>)
 id 1qQ9Oz-0001ZL-4C; Sun, 30 Jul 2023 12:36:17 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=LlZL=DQ=kaod.org=clg@ozlabs.org>)
 id 1qQ9Or-0002xs-GH; Sun, 30 Jul 2023 12:36:16 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RDRnt6JZtz4wyJ;
 Mon, 31 Jul 2023 02:36:02 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RDRnr2zQFz4wyD;
 Mon, 31 Jul 2023 02:36:00 +1000 (AEST)
Message-ID: <335bb32c-85ad-b02c-b8a9-dc030d13238f@kaod.org>
Date: Sun, 30 Jul 2023 18:35:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] target/ppc: Fix VRMA page size for ISA v3.0
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20230730111842.39292-1-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230730111842.39292-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=LlZL=DQ=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.101,
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

On 7/30/23 13:18, Nicholas Piggin wrote:
> Until v2.07s, the VRMA page size (L||LP) was encoded in LPCR[VRMASD].
> In v3.0 that moved to the partition table PS field.
> 
> The powernv machine can now run KVM HPT guests on POWER9/10 CPUs with
> this fix and the patch to add ASDR.
> 
> Fixes: 3367c62f522b ("target/ppc: Support for POWER9 native hash")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> Since v1:
> - Added llp variable to avoid calling get_vrma_llp twice [Cedric].
> - Added some bit defines for architected fields and values [Cedric].

Thanks,


Reviewed-by: Cédric Le Goater <clg@kaod.org>

C.


> 
> Patches 1,3 from the previously posted series, let's defer 4-6
> decrementer fixes until after 8.1, so this is the last remaining
> one from the series.
> 
> Thanks,
> Nick
> 
>   target/ppc/mmu-hash64.c | 45 +++++++++++++++++++++++++++++++++++------
>   target/ppc/mmu-hash64.h |  5 +++++
>   2 files changed, 44 insertions(+), 6 deletions(-)
> 
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index a0c90df3ce..d645c0bb94 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -874,12 +874,46 @@ static target_ulong rmls_limit(PowerPCCPU *cpu)
>       return rma_sizes[rmls];
>   }
>   
> -static int build_vrma_slbe(PowerPCCPU *cpu, ppc_slb_t *slb)
> +/* Return the LLP in SLB_VSID format */
> +static uint64_t get_vrma_llp(PowerPCCPU *cpu)
>   {
>       CPUPPCState *env = &cpu->env;
> -    target_ulong lpcr = env->spr[SPR_LPCR];
> -    uint32_t vrmasd = (lpcr & LPCR_VRMASD) >> LPCR_VRMASD_SHIFT;
> -    target_ulong vsid = SLB_VSID_VRMA | ((vrmasd << 4) & SLB_VSID_LLP_MASK);
> +    uint64_t llp;
> +
> +    if (env->mmu_model == POWERPC_MMU_3_00) {
> +        ppc_v3_pate_t pate;
> +        uint64_t ps, l, lp;
> +
> +        /*
> +         * ISA v3.0 removes the LPCR[VRMASD] field and puts the VRMA base
> +         * page size (L||LP equivalent) in the PS field in the HPT partition
> +         * table entry.
> +         */
> +        if (!ppc64_v3_get_pate(cpu, cpu->env.spr[SPR_LPIDR], &pate)) {
> +            error_report("Bad VRMA with no partition table entry");
> +            return 0;
> +        }
> +        ps = PATE0_GET_PS(pate.dw0);
> +        /* PS has L||LP in 3 consecutive bits, put them into SLB LLP format */
> +        l = (ps >> 2) & 0x1;
> +        lp = ps & 0x3;
> +        llp = (l << SLB_VSID_L_SHIFT) | (lp << SLB_VSID_LP_SHIFT);
> +
> +    } else {
> +        uint64_t lpcr = env->spr[SPR_LPCR];
> +        target_ulong vrmasd = (lpcr & LPCR_VRMASD) >> LPCR_VRMASD_SHIFT;
> +
> +        /* VRMASD LLP matches SLB format, just shift and mask it */
> +        llp = (vrmasd << SLB_VSID_LP_SHIFT) & SLB_VSID_LLP_MASK;
> +    }
> +
> +    return llp;
> +}
> +
> +static int build_vrma_slbe(PowerPCCPU *cpu, ppc_slb_t *slb)
> +{
> +    uint64_t llp = get_vrma_llp(cpu);
> +    target_ulong vsid = SLB_VSID_VRMA | llp;
>       int i;
>   
>       for (i = 0; i < PPC_PAGE_SIZES_MAX_SZ; i++) {
> @@ -897,8 +931,7 @@ static int build_vrma_slbe(PowerPCCPU *cpu, ppc_slb_t *slb)
>           }
>       }
>   
> -    error_report("Bad page size encoding in LPCR[VRMASD]; LPCR=0x"
> -                 TARGET_FMT_lx, lpcr);
> +    error_report("Bad VRMA page size encoding 0x" TARGET_FMT_lx, llp);
>   
>       return -1;
>   }
> diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
> index 1496955d38..de653fcae5 100644
> --- a/target/ppc/mmu-hash64.h
> +++ b/target/ppc/mmu-hash64.h
> @@ -41,8 +41,10 @@ void ppc_hash64_finalize(PowerPCCPU *cpu);
>   #define SLB_VSID_KP             0x0000000000000400ULL
>   #define SLB_VSID_N              0x0000000000000200ULL /* no-execute */
>   #define SLB_VSID_L              0x0000000000000100ULL
> +#define SLB_VSID_L_SHIFT        PPC_BIT_NR(55)
>   #define SLB_VSID_C              0x0000000000000080ULL /* class */
>   #define SLB_VSID_LP             0x0000000000000030ULL
> +#define SLB_VSID_LP_SHIFT       PPC_BIT_NR(59)
>   #define SLB_VSID_ATTR           0x0000000000000FFFULL
>   #define SLB_VSID_LLP_MASK       (SLB_VSID_L | SLB_VSID_LP)
>   #define SLB_VSID_4K             0x0000000000000000ULL
> @@ -58,6 +60,9 @@ void ppc_hash64_finalize(PowerPCCPU *cpu);
>   #define SDR_64_HTABSIZE        0x000000000000001FULL
>   
>   #define PATE0_HTABORG           0x0FFFFFFFFFFC0000ULL
> +#define PATE0_PS                PPC_BITMASK(56, 58)
> +#define PATE0_GET_PS(dw0)       (((dw0) & PATE0_PS) >> PPC_BIT_NR(58))
> +
>   #define HPTES_PER_GROUP         8
>   #define HASH_PTE_SIZE_64        16
>   #define HASH_PTEG_SIZE_64       (HASH_PTE_SIZE_64 * HPTES_PER_GROUP)


