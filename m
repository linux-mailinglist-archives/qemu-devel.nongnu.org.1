Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C03B59F790D
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Dec 2024 10:58:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tODIX-0001I2-4L; Thu, 19 Dec 2024 04:58:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tODIT-0001Ho-8C
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 04:58:21 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tODIP-0006V2-Da
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 04:58:20 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8BxuuAw7mNnbYJYAA--.43779S3;
 Thu, 19 Dec 2024 17:58:09 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMCx3sUt7mNncUQCAA--.5110S3;
 Thu, 19 Dec 2024 17:58:06 +0800 (CST)
Subject: Re: [PATCH] feat: add loongarch page table walker support for
 debugger memory access
To: Miao Hao <haomiao23s@ict.ac.cn>, gaosong@loongson.cn
Cc: qemu-devel@nongnu.org, "lixianglai@loongson.cn" <lixianglai@loongson.cn>
References: <20241219032455.28608-1-haomiao23s@ict.ac.cn>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <b041dacf-df2f-f25f-33c5-a53ad9cc2059@loongson.cn>
Date: Thu, 19 Dec 2024 17:57:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20241219032455.28608-1-haomiao23s@ict.ac.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCx3sUt7mNncUQCAA--.5110S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3GrWxXr15Zw17WFW7tFW7ZFc_yoWxKry5pF
 WxCFWayF48KrZrAas3X34YvFn8Zr43Kw4aga1fKF9YkwsxXryfZFWvg3sxJF48Jw4kWw4I
 gan8AF45Ca4UXFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL
 05UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.107,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Miao,

Thanks for doing this. It is useful to debug VM.

On 2024/12/19 上午11:24, Miao Hao wrote:
> Signed-off-by: Miao Hao <haomiao23s@ict.ac.cn>
> ---
>   target/loongarch/cpu_helper.c     | 104 ++++++++++++++++++++++++++++--
>   target/loongarch/internals.h      |   4 +-
>   target/loongarch/tcg/tlb_helper.c |   4 +-
>   3 files changed, 104 insertions(+), 8 deletions(-)
> 
> diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
> index 580362ac3e..c0828a813d 100644
> --- a/target/loongarch/cpu_helper.c
> +++ b/target/loongarch/cpu_helper.c
> @@ -141,9 +141,95 @@ bool loongarch_tlb_search(CPULoongArchState *env, target_ulong vaddr,
>       return false;
>   }
>   
> +static int loongarch_page_table_walker(CPULoongArchState *env, hwaddr *physical,
> +                                 int *prot, target_ulong address)
> +{
> +    CPUState *cs = env_cpu(env);
> +    target_ulong index, phys;
> +    int shift;
> +    uint64_t dir_base, dir_width;
> +    uint64_t base;
> +    int level;
> +
> +    /* 0:64bit, 1:128bit, 2:192bit, 3:256bit */
> +    shift = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTEWIDTH);
> +    shift = (shift + 1) * 3;
> +
> +    if ((address >> 63) & 0x1) {
> +        base = env->CSR_PGDH;
> +    } else {
> +        base = env->CSR_PGDL;
> +    }
> +    base &= TARGET_PHYS_MASK;
> +
> +    for (level = 4; level > 0; level--) {
> +        get_dir_base_width(env, &dir_base, &dir_width, level);
> +
> +        if (dir_width != 0) {
how about check whether it equeal to 0 firstly like this?
            if (dir_width == 0)
                continue;

> +            /* get next level page directory */
> +            index = (address >> dir_base) & ((1 << dir_width) - 1);
> +            phys = base | index << shift;
Here will only load first 64bit if shift is not 0, such as 1:128bit, 
2:192bit, 3:256bit

> +            base = ldq_phys(cs->as, phys) & TARGET_PHYS_MASK;
> +            if (!FIELD_EX64(base, TLBENTRY, HUGE)) {
> +                /* mask off page dir permission bits */
> +                base &= TARGET_PAGE_MASK;
> +            } else {
> +                /* base is a huge pte */
> +                break;
> +            }
> +
> +            if (base == 0) {
physical adddress 0 is valid and Valid bit will be checked in later. 
Can we remove this?
> +                return TLBRET_NOMATCH;
> +            }

> +        }
> +    }
> +
> +    /* pte */
> +    if (FIELD_EX64(base, TLBENTRY, HUGE)) {
> +        /* Huge Page. base is pte */
> +        base = FIELD_DP64(base, TLBENTRY, LEVEL, 0);
> +        base = FIELD_DP64(base, TLBENTRY, HUGE, 0);
> +        if (FIELD_EX64(base, TLBENTRY, HGLOBAL)) {
> +            base = FIELD_DP64(base, TLBENTRY, HGLOBAL, 0);
> +            base = FIELD_DP64(base, TLBENTRY, G, 1);
> +        }
> +    } else {
> +        /* Normal Page. base points to pte */
> +        get_dir_base_width(env, &dir_base, &dir_width, 0);
> +        index = (address >> dir_base) & ((1 << dir_width) - 1);
> +        phys = base | index << shift;
Ditto, shift may be wider than 64-bit.

Regards
Bibo Mao
> +        base = ldq_phys(cs->as, phys);
> +    }
> +
> +    /* TODO: check plv and other bits? */
> +
> +    /* base is pte, in normal pte format */
> +    if (!FIELD_EX64(base, TLBENTRY, V)) {
> +        return TLBRET_NOMATCH;
> +    }
> +
> +    if (!FIELD_EX64(base, TLBENTRY, D)) {
> +        *prot = PAGE_READ;
> +    } else {
> +        *prot = PAGE_READ | PAGE_WRITE;
> +    }
> +
> +    /* get TARGET_PAGE_SIZE aligned physical address */
> +    base += (address & TARGET_PHYS_MASK) & ((1 << dir_base) - 1);
> +    /* mask RPLV, NX, NR bits */
> +    base = FIELD_DP64(base, TLBENTRY_64, RPLV, 0);
> +    base = FIELD_DP64(base, TLBENTRY_64, NX, 0);
> +    base = FIELD_DP64(base, TLBENTRY_64, NR, 0);
> +    /* mask other attribute bits */
> +    *physical = base & TARGET_PAGE_MASK;
> +
> +    return 0;
> +}
> +
>   static int loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
>                                    int *prot, target_ulong address,
> -                                 MMUAccessType access_type, int mmu_idx)
> +                                 MMUAccessType access_type, int mmu_idx,
> +                                 int is_debug)
>   {
>       int index, match;
>   
> @@ -151,6 +237,13 @@ static int loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
>       if (match) {
>           return loongarch_map_tlb_entry(env, physical, prot,
>                                          address, access_type, index, mmu_idx);
> +    } else if (is_debug) {
> +        /*
> +         * For debugger memory access, we want to do the map when there is a
> +         * legal mapping, even if the mapping is not yet in TLB. return 0 if
> +         * there is a valid map, else none zero.
> +         */
> +        return loongarch_page_table_walker(env, physical, prot, address);
>       }
>   
>       return TLBRET_NOMATCH;
> @@ -158,7 +251,8 @@ static int loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
>   #else
>   static int loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
>                                    int *prot, target_ulong address,
> -                                 MMUAccessType access_type, int mmu_idx)
> +                                 MMUAccessType access_type, int mmu_idx,
> +                                 int is_debug)
>   {
>       return TLBRET_NOMATCH;
>   }
> @@ -178,7 +272,7 @@ static hwaddr dmw_va2pa(CPULoongArchState *env, target_ulong va,
>   
>   int get_physical_address(CPULoongArchState *env, hwaddr *physical,
>                            int *prot, target_ulong address,
> -                         MMUAccessType access_type, int mmu_idx)
> +                         MMUAccessType access_type, int mmu_idx, int is_debug)
>   {
>       int user_mode = mmu_idx == MMU_USER_IDX;
>       int kernel_mode = mmu_idx == MMU_KERNEL_IDX;
> @@ -222,7 +316,7 @@ int get_physical_address(CPULoongArchState *env, hwaddr *physical,
>   
>       /* Mapped address */
>       return loongarch_map_address(env, physical, prot, address,
> -                                 access_type, mmu_idx);
> +                                 access_type, mmu_idx, is_debug);
>   }
>   
>   hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
> @@ -232,7 +326,7 @@ hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
>       int prot;
>   
>       if (get_physical_address(env, &phys_addr, &prot, addr, MMU_DATA_LOAD,
> -                             cpu_mmu_index(cs, false)) != 0) {
> +                             cpu_mmu_index(cs, false), 1) != 0) {
>           return -1;
>       }
>       return phys_addr;
> diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
> index 1a02427627..bc2ca30746 100644
> --- a/target/loongarch/internals.h
> +++ b/target/loongarch/internals.h
> @@ -56,7 +56,9 @@ bool loongarch_tlb_search(CPULoongArchState *env, target_ulong vaddr,
>                             int *index);
>   int get_physical_address(CPULoongArchState *env, hwaddr *physical,
>                            int *prot, target_ulong address,
> -                         MMUAccessType access_type, int mmu_idx);
> +                         MMUAccessType access_type, int mmu_idx, int is_debug);
> +void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
> +                               uint64_t *dir_width, target_ulong level);
>   hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>   
>   #ifdef CONFIG_TCG
> diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
> index 97f38fc391..564f336df9 100644
> --- a/target/loongarch/tcg/tlb_helper.c
> +++ b/target/loongarch/tcg/tlb_helper.c
> @@ -18,7 +18,7 @@
>   #include "exec/log.h"
>   #include "cpu-csr.h"
>   
> -static void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
> +void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
>                                  uint64_t *dir_width, target_ulong level)
>   {
>       switch (level) {
> @@ -485,7 +485,7 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>   
>       /* Data access */
>       ret = get_physical_address(env, &physical, &prot, address,
> -                               access_type, mmu_idx);
> +                               access_type, mmu_idx, 0);
>   
>       if (ret == TLBRET_MATCH) {
>           tlb_set_page(cs, address & TARGET_PAGE_MASK,
> 


