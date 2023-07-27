Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A6F7654CA
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 15:19:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP0i4-0002Q7-T5; Thu, 27 Jul 2023 09:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=csIm=DN=kaod.org=clg@ozlabs.org>)
 id 1qP0i0-0002Pv-Si; Thu, 27 Jul 2023 09:07:12 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=csIm=DN=kaod.org=clg@ozlabs.org>)
 id 1qP0hy-0004yf-Cp; Thu, 27 Jul 2023 09:07:12 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RBWJ86NQCz4wxn;
 Thu, 27 Jul 2023 23:07:04 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RBWJ64Rsdz4wbP;
 Thu, 27 Jul 2023 23:07:02 +1000 (AEST)
Message-ID: <b0ff2811-ef70-d018-4952-df8b2b6d8413@kaod.org>
Date: Thu, 27 Jul 2023 15:07:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/6] target/ppc: Fix VRMA page size for ISA v3.0
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20230726182230.433945-1-npiggin@gmail.com>
 <20230726182230.433945-3-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230726182230.433945-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=csIm=DN=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

On 7/26/23 20:22, Nicholas Piggin wrote:
> Until v2.07s, the VRMA page size (L||LP) was encoded in LPCR[VRMASD].
> In v3.0 that moved to the partition table PS field.
> 
> The powernv machine can now run KVM HPT guests on POWER9/10 CPUs with
> this fix and the patch to add ASDR.
> 
> Fixes: 3367c62f522b ("target/ppc: Support for POWER9 native hash")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   target/ppc/mmu-hash64.c | 41 +++++++++++++++++++++++++++++++++++------
>   1 file changed, 35 insertions(+), 6 deletions(-)
> 
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index a0c90df3ce..7f8bbbbdb0 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -874,12 +874,41 @@ static target_ulong rmls_limit(PowerPCCPU *cpu)
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
> +        uint64_t ps;
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
> +        ps = pate.dw0 >> (63 - 58);
> +        llp = ((ps & 0x4) << (63 - 55 - 2)) | ((ps & 0x3) << (63 - 59));

Please add bitfield definitions for these numbers :)

> +
> +    } else {
> +        uint64_t lpcr = env->spr[SPR_LPCR];
> +        target_ulong vrmasd = (lpcr & LPCR_VRMASD) >> LPCR_VRMASD_SHIFT;
> +
> +        llp = (vrmasd << 4) & SLB_VSID_LLP_MASK;
> +    }
> +
> +    return llp;
> +}
> +
> +static int build_vrma_slbe(PowerPCCPU *cpu, ppc_slb_t *slb)
> +{
> +    target_ulong vsid = SLB_VSID_VRMA | get_vrma_llp(cpu);

May be you could introduce a 'uint64_t llp' variable instead and use it
directly in error_report and in the slb encoding test. This is minor.

Thanks,

C.

>       int i;
>   
>       for (i = 0; i < PPC_PAGE_SIZES_MAX_SZ; i++) {
> @@ -897,8 +926,8 @@ static int build_vrma_slbe(PowerPCCPU *cpu, ppc_slb_t *slb)
>           }
>       }
>   
> -    error_report("Bad page size encoding in LPCR[VRMASD]; LPCR=0x"
> -                 TARGET_FMT_lx, lpcr);
> +    error_report("Bad VRMA page size encoding 0x" TARGET_FMT_lx,
> +                 get_vrma_llp(cpu));
>   
>       return -1;
>   }


