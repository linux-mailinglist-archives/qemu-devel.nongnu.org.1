Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD99878C295
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 12:51:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qawJb-000424-Kk; Tue, 29 Aug 2023 06:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qawJZ-00041p-EV
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 06:51:17 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qawJO-0005uO-VN
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 06:51:16 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RZkcP2RMWz6K6K4;
 Tue, 29 Aug 2023 18:46:13 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 29 Aug
 2023 11:50:57 +0100
Date: Tue, 29 Aug 2023 11:50:56 +0100
To: Richard Henderson <richard.henderson@linaro.org>
CC: <qemu-devel@nongnu.org>, <peter.maydell@linaro.org>,
 <pbonzini@redhat.com>, <alex.bennee@linaro.org>
Subject: Re: [PATCH 2/3] softmmu: Use async_run_on_cpu in tcg_commit
Message-ID: <20230829115056.000068f6@Huawei.com>
In-Reply-To: <20230826232415.80233-3-richard.henderson@linaro.org>
References: <20230826232415.80233-1-richard.henderson@linaro.org>
 <20230826232415.80233-3-richard.henderson@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Sat, 26 Aug 2023 16:24:14 -0700
Richard Henderson <richard.henderson@linaro.org> wrote:

> After system startup, run the update to memory_dispatch
> and the tlb_flush on the cpu.  This eliminates a race,
> wherein a running cpu sees the memory_dispatch change
> but has not yet seen the tlb_flush.
> 
> Since the update now happens on the cpu, we need not use
> qatomic_rcu_read to protect the read of memory_dispatch.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1826
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1834
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1846
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I'm not pretending I've understood the change though, just that
it makes the crashes I saw go away.

Jonathan

> ---
>  softmmu/physmem.c | 40 +++++++++++++++++++++++++++++-----------
>  1 file changed, 29 insertions(+), 11 deletions(-)
> 
> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
> index 7597dc1c39..18277ddd67 100644
> --- a/softmmu/physmem.c
> +++ b/softmmu/physmem.c
> @@ -680,8 +680,7 @@ address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr orig_addr,
>      IOMMUTLBEntry iotlb;
>      int iommu_idx;
>      hwaddr addr = orig_addr;
> -    AddressSpaceDispatch *d =
> -        qatomic_rcu_read(&cpu->cpu_ases[asidx].memory_dispatch);
> +    AddressSpaceDispatch *d = cpu->cpu_ases[asidx].memory_dispatch;
>  
>      for (;;) {
>          section = address_space_translate_internal(d, addr, &addr, plen, false);
> @@ -2412,7 +2411,7 @@ MemoryRegionSection *iotlb_to_section(CPUState *cpu,
>  {
>      int asidx = cpu_asidx_from_attrs(cpu, attrs);
>      CPUAddressSpace *cpuas = &cpu->cpu_ases[asidx];
> -    AddressSpaceDispatch *d = qatomic_rcu_read(&cpuas->memory_dispatch);
> +    AddressSpaceDispatch *d = cpuas->memory_dispatch;
>      int section_index = index & ~TARGET_PAGE_MASK;
>      MemoryRegionSection *ret;
>  
> @@ -2487,23 +2486,42 @@ static void tcg_log_global_after_sync(MemoryListener *listener)
>      }
>  }
>  
> +static void tcg_commit_cpu(CPUState *cpu, run_on_cpu_data data)
> +{
> +    CPUAddressSpace *cpuas = data.host_ptr;
> +
> +    cpuas->memory_dispatch = address_space_to_dispatch(cpuas->as);
> +    tlb_flush(cpu);
> +}
> +
>  static void tcg_commit(MemoryListener *listener)
>  {
>      CPUAddressSpace *cpuas;
> -    AddressSpaceDispatch *d;
> +    CPUState *cpu;
>  
>      assert(tcg_enabled());
>      /* since each CPU stores ram addresses in its TLB cache, we must
>         reset the modified entries */
>      cpuas = container_of(listener, CPUAddressSpace, tcg_as_listener);
> -    cpu_reloading_memory_map();
> -    /* The CPU and TLB are protected by the iothread lock.
> -     * We reload the dispatch pointer now because cpu_reloading_memory_map()
> -     * may have split the RCU critical section.
> +    cpu = cpuas->cpu;
> +
> +    /*
> +     * Defer changes to as->memory_dispatch until the cpu is quiescent.
> +     * Otherwise we race between (1) other cpu threads and (2) ongoing
> +     * i/o for the current cpu thread, with data cached by mmu_lookup().
> +     *
> +     * In addition, queueing the work function will kick the cpu back to
> +     * the main loop, which will end the RCU critical section and reclaim
> +     * the memory data structures.
> +     *
> +     * That said, the listener is also called during realize, before
> +     * all of the tcg machinery for run-on is initialized: thus halt_cond.
>       */
> -    d = address_space_to_dispatch(cpuas->as);
> -    qatomic_rcu_set(&cpuas->memory_dispatch, d);
> -    tlb_flush(cpuas->cpu);
> +    if (cpu->halt_cond) {
> +        async_run_on_cpu(cpu, tcg_commit_cpu, RUN_ON_CPU_HOST_PTR(cpuas));
> +    } else {
> +        tcg_commit_cpu(cpu, RUN_ON_CPU_HOST_PTR(cpuas));
> +    }
>  }
>  
>  static void memory_map_init(void)


