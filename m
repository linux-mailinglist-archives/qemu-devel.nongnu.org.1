Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FEB9979AD
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Oct 2024 02:35:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syh96-0007Jp-UB; Wed, 09 Oct 2024 20:35:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1syh95-0007JQ-DV
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 20:35:11 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1syh92-0005mz-Vw
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 20:35:11 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20c7ee8fe6bso2406875ad.2
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 17:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728520507; x=1729125307; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f0OWHYAvcOGvRIHQOPNPJFd7Aum5VbObcTnyW00Ggz8=;
 b=ysn3ZkCwZJPg8I8Xex6yJ+D1RMOIQYGJoIrcfYi8uQikdkRp/0ogzLpcw/3osHTqmB
 bJB4zBD8LrVVpvJ1YfFHFNl2ynhSklOrQsaZEI92RQEq5Cs9rU/b5Bc5XYF8tjTJlLRw
 1MTKYEA6aad+/xp9MjtdvNucKDjBWOYPStPuWKm2CIlwg30UCRnjqW6qlemlSAmVXGKU
 9XCRX0e9mYV346qASY9QDl/hBiusdA4ZOackCxswGRhonWx3RsRgzsi0LVhHyYcQBhGi
 hFHj3r997UMOoG+s/6SGrrN5KI0w5DsRRUcEmb9jkKDqlzHU6Cb3bGht6v/sPMpGXcX2
 9EcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728520507; x=1729125307;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f0OWHYAvcOGvRIHQOPNPJFd7Aum5VbObcTnyW00Ggz8=;
 b=WDA04/aXOJvOACXr0eZZSe0DXZBOMPnuWohpUR8BMxocKd09PCAUMkzQkYZSjAtjcM
 3GbATU6bWc+BLXrKXJ5gTIV9VEgltKVZWsF/TWz9b4DwHnKbFIvPktXDzHTJVPGsyADB
 cwD1O3lrfi9fkZPTYC2jT5xbezlXS2O8085QHyyFqjpBGMqxlISmU8YWcbCAqlPQ4ifo
 uMBBc2zpC8bcD2ndm96+19DQs2S3DppafXLJsLQ1nvYNzOhE9tBcqtYz1HBixVIw1J3h
 4tpXXTGXZmL0QL36gpwGcCIrN7R2SdsFfNGIzg1JHQ/QrS4rsPDd3toRqD+RETtAWwZk
 T5eA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsTwHXo5boA5z+IlvBJJc1N8XOq6C/+kH1ZDxJhMAzLYhPF2z1KmuNoPOFApRcwhI4XGaUmmLl7hGS@nongnu.org
X-Gm-Message-State: AOJu0YzwFfjh8kskQzek82LEZsQTxDrkUvgHlB0XZOboMCVUENyuAhML
 bDt2rXPuNPjZtZL9cdlmWJ/rFWuJFLxmz32RcORuz7AWG5271b1z6+8T5IrA/ZA=
X-Google-Smtp-Source: AGHT+IFtj6v5bIAzdgb9yCm8FL54MCWDc/3j7yWRTEU0FTvL0ePU5roum/9V6xPSR8J3M6io2rRJZQ==
X-Received: by 2002:a17:903:1d0:b0:20b:bad4:5b6e with SMTP id
 d9443c01a7336-20c637f754bmr73451555ad.38.1728520506932; 
 Wed, 09 Oct 2024 17:35:06 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8bc1b9f3sm192205ad.76.2024.10.09.17.35.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2024 17:35:06 -0700 (PDT)
Message-ID: <c81af2ad-fe0d-4f9f-8bc2-23bcd49354ea@linaro.org>
Date: Wed, 9 Oct 2024 17:35:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/23] accel/tcg: Always use IntervalTree for code lookups
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241009150855.804605-1-richard.henderson@linaro.org>
 <20241009150855.804605-20-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241009150855.804605-20-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/9/24 08:08, Richard Henderson wrote:
> Because translation is special, we don't need the speed
> of the direct-mapped softmmu tlb.  We cache a lookups in
> DisasContextBase within the translator loop anyway.
> 
> Drop the addr_code comparator from CPUTLBEntry.
> Go directly to the IntervalTree for MMU_INST_FETCH.
> Derive exec flags from read flags.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/cpu-all.h    |   3 +
>   include/exec/tlb-common.h |   5 +-
>   accel/tcg/cputlb.c        | 138 +++++++++++++++++++++++++++++---------
>   3 files changed, 110 insertions(+), 36 deletions(-)
> 
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index 6f09b86e7f..7f5a10962a 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -326,6 +326,9 @@ static inline int cpu_mmu_index(CPUState *cs, bool ifetch)
>       (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_MMIO \
>       | TLB_FORCE_SLOW | TLB_DISCARD_WRITE)
>   
> +/* Filter read flags to exec flags. */
> +#define TLB_EXEC_FLAGS_MASK  (TLB_MMIO)
> +
>   /*
>    * Flags stored in CPUTLBEntryFull.slow_flags[x].
>    * TLB_FORCE_SLOW must be set in CPUTLBEntry.addr_idx[x].
> diff --git a/include/exec/tlb-common.h b/include/exec/tlb-common.h
> index 300f9fae67..feaa471299 100644
> --- a/include/exec/tlb-common.h
> +++ b/include/exec/tlb-common.h
> @@ -26,7 +26,6 @@ typedef union CPUTLBEntry {
>       struct {
>           uint64_t addr_read;
>           uint64_t addr_write;
> -        uint64_t addr_code;
>           /*
>            * Addend to virtual address to get host address.  IO accesses
>            * use the corresponding iotlb value.
> @@ -35,7 +34,7 @@ typedef union CPUTLBEntry {
>       };
>       /*
>        * Padding to get a power of two size, as well as index
> -     * access to addr_{read,write,code}.
> +     * access to addr_{read,write}.
>        */
>       uint64_t addr_idx[(1 << CPU_TLB_ENTRY_BITS) / sizeof(uint64_t)];
>   } CPUTLBEntry;
> @@ -92,7 +91,7 @@ struct CPUTLBEntryFull {
>        * Additional tlb flags for use by the slow path. If non-zero,
>        * the corresponding CPUTLBEntry comparator must have TLB_FORCE_SLOW.
>        */
> -    uint8_t slow_flags[MMU_ACCESS_COUNT];
> +    uint8_t slow_flags[2];
>   
>       /*
>        * Allow target-specific additions to this structure.
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 61daa89e06..7c8308355d 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -114,8 +114,9 @@ static inline uint64_t tlb_read_idx(const CPUTLBEntry *entry,
>                         MMU_DATA_LOAD * sizeof(uint64_t));
>       QEMU_BUILD_BUG_ON(offsetof(CPUTLBEntry, addr_write) !=
>                         MMU_DATA_STORE * sizeof(uint64_t));
> -    QEMU_BUILD_BUG_ON(offsetof(CPUTLBEntry, addr_code) !=
> -                      MMU_INST_FETCH * sizeof(uint64_t));
> +
> +    tcg_debug_assert(access_type == MMU_DATA_LOAD ||
> +                     access_type == MMU_DATA_STORE);
>   
>   #if TARGET_LONG_BITS == 32
>       /* Use qatomic_read, in case of addr_write; only care about low bits. */
> @@ -490,8 +491,7 @@ static bool tlb_hit_page_mask_anyprot(CPUTLBEntry *tlb_entry,
>       mask &= TARGET_PAGE_MASK | TLB_INVALID_MASK;
>   
>       return (page == (tlb_entry->addr_read & mask) ||
> -            page == (tlb_addr_write(tlb_entry) & mask) ||
> -            page == (tlb_entry->addr_code & mask));
> +            page == (tlb_addr_write(tlb_entry) & mask));
>   }
>   
>   static inline bool tlb_hit_page_anyprot(CPUTLBEntry *tlb_entry, vaddr page)
> @@ -1061,15 +1061,13 @@ static inline void tlb_set_compare(CPUTLBEntryFull *full, CPUTLBEntry *ent,
>                                      vaddr address, int flags,
>                                      MMUAccessType access_type, bool enable)
>   {
> -    if (enable) {
> -        address |= flags & TLB_FLAGS_MASK;
> -        flags &= TLB_SLOW_FLAGS_MASK;
> -        if (flags) {
> -            address |= TLB_FORCE_SLOW;
> -        }
> -    } else {
> -        address = -1;
> -        flags = 0;
> +    if (!enable) {
> +	address = TLB_INVALID_MASK;
> +    }
> +    address |= flags & TLB_FLAGS_MASK;
> +    flags &= TLB_SLOW_FLAGS_MASK;
> +    if (flags) {
> +        address |= TLB_FORCE_SLOW;
>       }

I'm not sure to follow this change correctly.
After, the final address and flags value depend on flags in parameter, 
while before, it used to depend on flags & enable parameter.

>       ent->addr_idx[access_type] = address;
>       full->slow_flags[access_type] = flags;
> @@ -1215,9 +1213,6 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
>       /* Now calculate the new entry */
>       node->copy.addend = addend - addr_page;
>   
> -    tlb_set_compare(full, &node->copy, addr_page, read_flags,
> -                    MMU_INST_FETCH, prot & PAGE_EXEC);
> -
>       if (wp_flags & BP_MEM_READ) {
>           read_flags |= TLB_WATCHPOINT;
>       }
> @@ -1392,21 +1387,52 @@ static void notdirty_write(CPUState *cpu, vaddr mem_vaddr, unsigned size,
>       }
>   }
>   
> -static int probe_access_internal(CPUState *cpu, vaddr addr,
> -                                 int fault_size, MMUAccessType access_type,
> -                                 int mmu_idx, bool nonfault,
> -                                 void **phost, CPUTLBEntryFull **pfull,
> -                                 uintptr_t retaddr, bool check_mem_cbs)
> +static int probe_access_internal_code(CPUState *cpu, vaddr addr,
> +                                      int fault_size, int mmu_idx,
> +                                      bool nonfault,
> +                                      void **phost, CPUTLBEntryFull **pfull,
> +                                      uintptr_t retaddr)
> +{
> +    CPUTLBEntryTree *t = tlbtree_lookup_addr(&cpu->neg.tlb.d[mmu_idx], addr);
> +    int flags;
> +
> +    if (!t || !(t->full.prot & PAGE_EXEC)) {
> +        if (!tlb_fill_align(cpu, addr, MMU_INST_FETCH, mmu_idx,
> +                            0, fault_size, nonfault, retaddr)) {
> +            /* Non-faulting page table read failed.  */
> +            *phost = NULL;
> +            *pfull = NULL;
> +            return TLB_INVALID_MASK;
> +        }
> +        t = tlbtree_lookup_addr(&cpu->neg.tlb.d[mmu_idx], addr);
> +    }
> +    flags = t->copy.addr_read & TLB_EXEC_FLAGS_MASK;
> +    *pfull = &t->full;
> +
> +    if (flags) {
> +        *phost = NULL;
> +        return TLB_MMIO;
> +    }
> +
> +    /* Everything else is RAM. */
> +    *phost = (void *)((uintptr_t)addr + t->copy.addend);
> +    return flags;
> +}
> +
> +static int probe_access_internal_data(CPUState *cpu, vaddr addr,
> +                                      int fault_size, MMUAccessType access_type,
> +                                      int mmu_idx, bool nonfault,
> +                                      void **phost, CPUTLBEntryFull **pfull,
> +                                      uintptr_t retaddr, bool check_mem_cbs)
>   {
>       uintptr_t index = tlb_index(cpu, mmu_idx, addr);
>       CPUTLBEntry *entry = tlb_entry(cpu, mmu_idx, addr);
>       uint64_t tlb_addr = tlb_read_idx(entry, access_type);
> -    vaddr page_addr = addr & TARGET_PAGE_MASK;
>       int flags = TLB_FLAGS_MASK & ~TLB_FORCE_SLOW;
>       CPUTLBEntryFull *full;
>   
> -    if (!tlb_hit_page(tlb_addr, page_addr)) {
> -        if (!tlbtree_hit(cpu, mmu_idx, access_type, page_addr)) {
> +    if (!tlb_hit(tlb_addr, addr)) {
> +        if (!tlbtree_hit(cpu, mmu_idx, access_type, addr)) {
>               if (!tlb_fill_align(cpu, addr, access_type, mmu_idx,
>                                   0, fault_size, nonfault, retaddr)) {
>                   /* Non-faulting page table read failed.  */
> @@ -1450,6 +1476,21 @@ static int probe_access_internal(CPUState *cpu, vaddr addr,
>       return flags;
>   }
>   
> +static int probe_access_internal(CPUState *cpu, vaddr addr,
> +                                 int fault_size, MMUAccessType access_type,
> +                                 int mmu_idx, bool nonfault,
> +                                 void **phost, CPUTLBEntryFull **pfull,
> +                                 uintptr_t retaddr, bool check_mem_cbs)
> +{
> +    if (access_type == MMU_INST_FETCH) {
> +        return probe_access_internal_code(cpu, addr, fault_size, mmu_idx,
> +                                          nonfault, phost, pfull, retaddr);
> +    }
> +    return probe_access_internal_data(cpu, addr, fault_size, access_type,
> +                                      mmu_idx, nonfault, phost, pfull,
> +                                      retaddr, check_mem_cbs);
> +}
> +
>   int probe_access_full(CPUArchState *env, vaddr addr, int size,
>                         MMUAccessType access_type, int mmu_idx,
>                         bool nonfault, void **phost, CPUTLBEntryFull **pfull,
> @@ -1582,9 +1623,9 @@ tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
>       CPUTLBEntryFull *full;
>       void *p;
>   
> -    (void)probe_access_internal(env_cpu(env), addr, 1, MMU_INST_FETCH,
> -                                cpu_mmu_index(env_cpu(env), true), false,
> -                                &p, &full, 0, false);
> +    (void)probe_access_internal_code(env_cpu(env), addr, 1,
> +                                     cpu_mmu_index(env_cpu(env), true),
> +                                     false, &p, &full, 0);
>       if (p == NULL) {
>           return -1;
>       }
> @@ -1678,8 +1719,31 @@ typedef struct MMULookupLocals {
>    * tlb_fill_align will longjmp out.  Return true if the softmmu tlb for
>    * @mmu_idx may have resized.
>    */
> -static bool mmu_lookup1(CPUState *cpu, MMULookupPageData *data, MemOp memop,
> -                        int mmu_idx, MMUAccessType access_type, uintptr_t ra)
> +static bool mmu_lookup1_code(CPUState *cpu, MMULookupPageData *data,
> +                             MemOp memop, int mmu_idx, uintptr_t ra)
> +{
> +    vaddr addr = data->addr;
> +    CPUTLBEntryTree *t = tlbtree_lookup_addr(&cpu->neg.tlb.d[mmu_idx], addr);
> +    bool maybe_resized = true;
> +
> +    if (!t || !(t->full.prot & PAGE_EXEC)) {
> +        tlb_fill_align(cpu, addr, MMU_INST_FETCH, mmu_idx,
> +                       memop, data->size, false, ra);
> +        maybe_resized = true;
> +        t = tlbtree_lookup_addr(&cpu->neg.tlb.d[mmu_idx], addr);
> +    }
> +
> +    data->full = &t->full;
> +    data->flags = t->copy.addr_read & TLB_EXEC_FLAGS_MASK;
> +    /* Compute haddr speculatively; depending on flags it might be invalid. */
> +    data->haddr = (void *)((uintptr_t)addr + t->copy.addend);
> +
> +    return maybe_resized;
> +}
> +
> +static bool mmu_lookup1_data(CPUState *cpu, MMULookupPageData *data,
> +                             MemOp memop, int mmu_idx,
> +                             MMUAccessType access_type, uintptr_t ra)
>   {
>       vaddr addr = data->addr;
>       uintptr_t index = tlb_index(cpu, mmu_idx, addr);
> @@ -1738,6 +1802,15 @@ static bool mmu_lookup1(CPUState *cpu, MMULookupPageData *data, MemOp memop,
>       return maybe_resized;
>   }
>   
> +static bool mmu_lookup1(CPUState *cpu, MMULookupPageData *data, MemOp memop,
> +                        int mmu_idx, MMUAccessType access_type, uintptr_t ra)
> +{
> +    if (access_type == MMU_INST_FETCH) {
> +        return mmu_lookup1_code(cpu, data, memop, mmu_idx, ra);
> +    }
> +    return mmu_lookup1_data(cpu, data, memop, mmu_idx, access_type, ra);
> +}
> +
>   /**
>    * mmu_watch_or_dirty
>    * @cpu: generic cpu state
> @@ -1885,13 +1958,13 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
>           }
>       }
>   
> +    full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
> +
>       /*
>        * Let the guest notice RMW on a write-only page.
>        * We have just verified that the page is writable.
> -     * Subpage lookups may have left TLB_INVALID_MASK set,
> -     * but addr_read will only be -1 if PAGE_READ was unset.
>        */
> -    if (unlikely(tlbe->addr_read == -1)) {
> +    if (unlikely(!(full->prot & PAGE_READ))) {
>           tlb_fill_align(cpu, addr, MMU_DATA_LOAD, mmu_idx,
>                          0, size, false, retaddr);
>           /*
> @@ -1929,7 +2002,6 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
>       }
>   
>       hostaddr = (void *)((uintptr_t)addr + tlbe->addend);
> -    full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
>   
>       if (unlikely(flags & TLB_NOTDIRTY)) {
>           notdirty_write(cpu, addr, size, full, retaddr);

Sounds good to have a fast path for code fetch. Did you measure the 
benefit, or just implemented this thinking it's worth?

