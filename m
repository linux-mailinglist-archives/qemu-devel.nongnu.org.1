Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE7877043F
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 17:20:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRwak-0001lp-Ki; Fri, 04 Aug 2023 11:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qRwaj-0001lH-2l; Fri, 04 Aug 2023 11:19:49 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qRwah-0000gj-F2; Fri, 04 Aug 2023 11:19:48 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6b9a2416b1cso1879339a34.2; 
 Fri, 04 Aug 2023 08:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691162386; x=1691767186;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1t2a6sgIHWW8hupP+O18og/A7bCSfliCH63ZE7ZE2dk=;
 b=g/y3aRr3gmzO0OLL2WC6krqAk2zs/xeVFUIvqTS9/ZmXssiRtnAOXk61CI9dzdDaZY
 pNJ58EMmdVW3PolRDbSFGJ+AdmwPXdrppaloca71+DiA1FfyEgjCXEWynZq+PR3fvX8j
 hIKVpYHP2GwfCpuhYHfdlIFOuV+RyswxXEJpVAksdVULDryqjJr6JKM0tljREjYeg4yA
 Oa8xSszsjGySPK4Xl56OzsBtgxlYAMn1MqMwp91qSdNmRkDn2m2MKC0ESZgge56hzbk1
 n101gVvADfH6Xr/KsYBODYBqW5cauCFKUKPm29YZIjRv0rdnyB9LpCyMwF63FhnFJAgU
 GdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691162386; x=1691767186;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1t2a6sgIHWW8hupP+O18og/A7bCSfliCH63ZE7ZE2dk=;
 b=Pjc5woe4VT/dm4a9Bp9rZDROofmnlEVyoxTH/KqONb7+doQAuHk5WQ4LwbXn3FVlIM
 FVPuuFZxqFIiGNgm6CP35JepZq+cbDTt4yMb9cINBgogBqPQY2odbZbTGbJlZ5h5Zqsk
 dKrvpMKsZLoA2Dl6Uk0j0m/V5SNn0d8cFP3YLLUgacwQAcGoalcfGIb6ZcHYLblIpg6Z
 MEx3+T4m2TF6H3M9HwBvpw5ecJlLwU5JTKfYSfqyhXvdGrXwyIDKQHWf85k1VB/E9Kv5
 66i5BBMtLiH4Bxs7Zk0WqN8dpV6K943HaLC7KRudiAYo5/YnHEAAWmo4CvtwFU0EAWtv
 UF9g==
X-Gm-Message-State: AOJu0YwCyG9iELbaRKUNK+8iKYyQlzGwbjRaLeDeuyRSLoXor/UrI4Zj
 1T7lGo5+QQUjtpGFNdz36xY=
X-Google-Smtp-Source: AGHT+IElSjuFR53syKZNzbFpcxAOpr6B9HhAp/HpK2rU2ahb4QwSizsN0Jzg9RlB3EUd4fW0Xhqx0A==
X-Received: by 2002:a05:6830:1d98:b0:6b9:465c:d22c with SMTP id
 y24-20020a0568301d9800b006b9465cd22cmr1909036oti.8.1691162385702; 
 Fri, 04 Aug 2023 08:19:45 -0700 (PDT)
Received: from [192.168.68.108] ([177.197.108.190])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a9d7c8c000000b006b466ed0484sm1206195otn.67.2023.08.04.08.19.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Aug 2023 08:19:45 -0700 (PDT)
Message-ID: <2490fea8-b9aa-82fd-6595-322da867b326@gmail.com>
Date: Fri, 4 Aug 2023 12:19:42 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] target/ppc: Fix VRMA page size for ISA v3.0
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>
Cc: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20230730111842.39292-1-npiggin@gmail.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230730111842.39292-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x32f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.093,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Queued in gitlab.com/danielhb/qemu/tree/ppc-next. Thanks,


Daniel

On 7/30/23 08:18, Nicholas Piggin wrote:
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

