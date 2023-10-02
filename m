Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2ECD7B57DD
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 18:21:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnLfB-00044M-CS; Mon, 02 Oct 2023 12:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qnLet-00043U-OS; Mon, 02 Oct 2023 12:20:36 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qnLen-0002ab-Pw; Mon, 02 Oct 2023 12:20:34 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RzmMJ1HPtz6HJZN;
 Tue,  3 Oct 2023 00:17:48 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 2 Oct
 2023 17:20:25 +0100
Date: Mon, 2 Oct 2023 17:20:24 +0100
To: Salil Mehta <salil.mehta@huawei.com>
CC: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <maz@kernel.org>,
 <jean-philippe@linaro.org>, <lpieralisi@kernel.org>,
 <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <imammedo@redhat.com>, <andrew.jones@linux.dev>, <david@redhat.com>,
 <philmd@linaro.org>, <eric.auger@redhat.com>, <oliver.upton@linux.dev>,
 <pbonzini@redhat.com>, <mst@redhat.com>, <will@kernel.org>,
 <gshan@redhat.com>, <rafael@kernel.org>, <alex.bennee@linaro.org>,
 <linux@armlinux.org.uk>, <darren@os.amperecomputing.com>,
 <ilkka@os.amperecomputing.com>, <vishnu@os.amperecomputing.com>,
 <karl.heubaum@oracle.com>, <miguel.luis@oracle.com>,
 <salil.mehta@opnsrc.net>, <zhukeqian1@huawei.com>,
 <wangxiongfeng2@huawei.com>, <wangyanan55@huawei.com>,
 <jiakernel2@gmail.com>, <maobibo@loongson.cn>, <lixianglai@loongson.cn>,
 <linuxarm@huawei.com>
Subject: Re: [PATCH V2 08/10] physmem: Add helper function to destroy CPU
 AddressSpace
Message-ID: <20231002172024.000042aa@Huawei.com>
In-Reply-To: <20230930001933.2660-9-salil.mehta@huawei.com>
References: <20230930001933.2660-1-salil.mehta@huawei.com>
 <20230930001933.2660-9-salil.mehta@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Sat, 30 Sep 2023 01:19:31 +0100
Salil Mehta <salil.mehta@huawei.com> wrote:

> Virtual CPU Hot-unplug leads to unrealization of a CPU object. This also
> involves destruction of the CPU AddressSpace. Add common function to help
> destroy the CPU AddressSpace.
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>

I'm not that familiar with this bit of the code, so no tag, but
as far as I can tell from a fairly superficial look, this is good.

> ---
>  include/exec/cpu-common.h |  8 ++++++++
>  include/hw/core/cpu.h     |  1 +
>  softmmu/physmem.c         | 25 +++++++++++++++++++++++++
>  3 files changed, 34 insertions(+)
> 
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 41788c0bdd..eb56a228a2 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -120,6 +120,14 @@ size_t qemu_ram_pagesize_largest(void);
>   */
>  void cpu_address_space_init(CPUState *cpu, int asidx,
>                              const char *prefix, MemoryRegion *mr);
> +/**
> + * cpu_address_space_destroy:
> + * @cpu: CPU for which address space needs to be destroyed
> + * @asidx: integer index of this address space
> + *
> + * Note that with KVM only one address space is supported.
> + */
> +void cpu_address_space_destroy(CPUState *cpu, int asidx);
>  
>  void cpu_physical_memory_rw(hwaddr addr, void *buf,
>                              hwaddr len, bool is_write);
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 648b5b3586..65d2ae4581 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -355,6 +355,7 @@ struct CPUState {
>      QSIMPLEQ_HEAD(, qemu_work_item) work_list;
>  
>      CPUAddressSpace *cpu_ases;
> +    int cpu_ases_count;
>      int num_ases;
>      AddressSpace *as;
>      MemoryRegion *memory;
> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
> index 4f6ca653b3..4dfa0ca66f 100644
> --- a/softmmu/physmem.c
> +++ b/softmmu/physmem.c
> @@ -761,6 +761,7 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
>  
>      if (!cpu->cpu_ases) {
>          cpu->cpu_ases = g_new0(CPUAddressSpace, cpu->num_ases);
> +        cpu->cpu_ases_count = cpu->num_ases;
>      }
>  
>      newas = &cpu->cpu_ases[asidx];
> @@ -774,6 +775,30 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
>      }
>  }
>  
> +void cpu_address_space_destroy(CPUState *cpu, int asidx)
> +{
> +    CPUAddressSpace *cpuas;
> +
> +    assert(asidx < cpu->num_ases);
> +    assert(asidx == 0 || !kvm_enabled());
> +    assert(cpu->cpu_ases);
> +
> +    cpuas = &cpu->cpu_ases[asidx];
> +    if (tcg_enabled()) {
> +        memory_listener_unregister(&cpuas->tcg_as_listener);
> +    }
> +
> +    address_space_destroy(cpuas->as);
> +    g_free_rcu(cpuas->as, rcu);
> +
> +    if (cpu->cpu_ases_count == 1) {
> +        g_free(cpu->cpu_ases);
> +        cpu->cpu_ases = NULL;
> +    }
> +
> +    cpu->cpu_ases_count--;
> +}
> +
>  AddressSpace *cpu_get_address_space(CPUState *cpu, int asidx)
>  {
>      /* Return the AddressSpace corresponding to the specified index */


