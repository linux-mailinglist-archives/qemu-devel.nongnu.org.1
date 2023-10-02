Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 882547B56F1
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 17:53:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnLEv-0006cx-8l; Mon, 02 Oct 2023 11:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qnLEh-00068I-Bj; Mon, 02 Oct 2023 11:53:31 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qnLEe-0006Bt-DE; Mon, 02 Oct 2023 11:53:31 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rzlm61kfJz6HJZM;
 Mon,  2 Oct 2023 23:50:46 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 2 Oct
 2023 16:53:23 +0100
Date: Mon, 2 Oct 2023 16:53:22 +0100
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
Subject: Re: [PATCH V2 01/10] accel/kvm: Extract common KVM vCPU
 {creation,parking} code
Message-ID: <20231002165322.00003a2e@Huawei.com>
In-Reply-To: <20230930001933.2660-2-salil.mehta@huawei.com>
References: <20230930001933.2660-1-salil.mehta@huawei.com>
 <20230930001933.2660-2-salil.mehta@huawei.com>
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

On Sat, 30 Sep 2023 01:19:24 +0100
Salil Mehta <salil.mehta@huawei.com> wrote:

> KVM vCPU creation is done once during the initialization of the VM when Qemu
> threads are spawned. This is common to all the architectures.
> 
> Hot-unplug of vCPU results in destruction of the vCPU objects in QOM but
> the KVM vCPU objects in the Host KVM are not destroyed and their representative
> KVM vCPU objects/context in Qemu are parked.
> 
> Refactor common logic so that some APIs could be reused by vCPU Hotplug code.
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>

Hi Salil,

A few trivial things inline, plus a question about why 
cpu->cpu_index can now be used but kvm_arch_vcpu_id(cpu);
was previously needed.

Thanks,

Jonathan

> ---
>  accel/kvm/kvm-all.c  | 63 +++++++++++++++++++++++++++++++++-----------
>  include/sysemu/kvm.h | 14 ++++++++++
>  2 files changed, 61 insertions(+), 16 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index ff1578bb32..b8c36ba50a 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -80,7 +80,7 @@
>  #endif
>  
>  struct KVMParkedVcpu {
> -    unsigned long vcpu_id;
> +    int vcpu_id;
>      int kvm_fd;
>      QLIST_ENTRY(KVMParkedVcpu) node;
>  };
> @@ -137,6 +137,7 @@ static QemuMutex kml_slots_lock;
>  #define kvm_slots_unlock()  qemu_mutex_unlock(&kml_slots_lock)
>  
>  static void kvm_slot_init_dirty_bitmap(KVMSlot *mem);
> +static int kvm_get_vcpu(KVMState *s, int vcpu_id);
>  
>  static inline void kvm_resample_fd_remove(int gsi)
>  {
> @@ -320,11 +321,49 @@ err:
>      return ret;
>  }
>  
> +void kvm_park_vcpu(CPUState *cpu)
> +{
> +    int vcpu_id = cpu->cpu_index;
> +    struct KVMParkedVcpu *vcpu;
> +
> +    vcpu = g_malloc0(sizeof(*vcpu));
> +    vcpu->vcpu_id = vcpu_id;

As vcpu_id is only used here why have the local variable?
Maybe that changes in later patches, in which case ignore this.

    vcpu->vcpu_id = cpu->cpu_index;

Why is kvm_arch_vcpu_id() not necessary here any more but was
before?

> +    vcpu->kvm_fd = cpu->kvm_fd;
> +    QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu, node);
> +}
> +
> +int kvm_create_vcpu(CPUState *cpu)
> +{
> +    int vcpu_id = cpu->cpu_index;

See below. I'm not sure why it's safe not to use kvm_arch_vcpu_id()
Seems a few architectures have less than trivial implementations of
that function currently.


> +    KVMState *s = kvm_state;
> +    int kvm_fd;
> +
> +    DPRINTF("kvm_create_vcpu\n");
> +
> +    /* check if the KVM vCPU already exist but is parked */
> +    kvm_fd = kvm_get_vcpu(s, vcpu_id);
> +    if (kvm_fd < 0) {
> +        /* vCPU not parked: create a new KVM vCPU */
> +        kvm_fd = kvm_vm_ioctl(s, KVM_CREATE_VCPU, vcpu_id);
> +        if (kvm_fd < 0) {
> +            error_report("KVM_CREATE_VCPU IOCTL failed for vCPU %d", vcpu_id);
> +            return kvm_fd;
> +        }
> +    }
> +
> +    cpu->vcpu_dirty = true;
> +    cpu->kvm_fd = kvm_fd;
> +    cpu->kvm_state = s;
> +    cpu->dirty_pages = 0;
> +    cpu->throttle_us_per_full = 0;

Trivial but I would have maintained the order wrt to the code removed
below just to avoid a reviewer having to check the two bits of code
do the same thing after the reorder.

> +
> +    return 0;
> +}
> +
>  static int do_kvm_destroy_vcpu(CPUState *cpu)
>  {
>      KVMState *s = kvm_state;
>      long mmap_size;
> -    struct KVMParkedVcpu *vcpu = NULL;
>      int ret = 0;
>  
>      DPRINTF("kvm_destroy_vcpu\n");
> @@ -353,10 +392,7 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
>          }
>      }
>  
> -    vcpu = g_malloc0(sizeof(*vcpu));
> -    vcpu->vcpu_id = kvm_arch_vcpu_id(cpu);
> -    vcpu->kvm_fd = cpu->kvm_fd;
> -    QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu, node);
> +    kvm_park_vcpu(cpu);
>  err:
>      return ret;
>  }
> @@ -369,7 +405,7 @@ void kvm_destroy_vcpu(CPUState *cpu)
>      }
>  }
>  
> -static int kvm_get_vcpu(KVMState *s, unsigned long vcpu_id)
> +static int kvm_get_vcpu(KVMState *s, int vcpu_id)
>  {
>      struct KVMParkedVcpu *cpu;
>  
> @@ -384,7 +420,7 @@ static int kvm_get_vcpu(KVMState *s, unsigned long vcpu_id)
>          }
>      }
>  
> -    return kvm_vm_ioctl(s, KVM_CREATE_VCPU, (void *)vcpu_id);
> +    return -1;
>  }
>  
>  int kvm_init_vcpu(CPUState *cpu, Error **errp)
> @@ -395,19 +431,14 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
>  
>      trace_kvm_init_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
>  
> -    ret = kvm_get_vcpu(s, kvm_arch_vcpu_id(cpu));
> +    ret = kvm_create_vcpu(cpu);

The switch from kvm_arch_vcpu_id(cpu) to using 
int vcpu_id = cpu->cpu_index;

Seems like a functional change on some arch.
>      if (ret < 0) {
> -        error_setg_errno(errp, -ret, "kvm_init_vcpu: kvm_get_vcpu failed (%lu)",
> +        error_setg_errno(errp, -ret,
> +                         "kvm_init_vcpu: kvm_create_vcpu failed (%lu)",

The rewrap of the lines above seems like an unrelated change.

>                           kvm_arch_vcpu_id(cpu));
>          goto err;
>      }
>  
> -    cpu->kvm_fd = ret;
> -    cpu->kvm_state = s;
> -    cpu->vcpu_dirty = true;
> -    cpu->dirty_pages = 0;
> -    cpu->throttle_us_per_full = 0;
> -
>      mmap_size = kvm_ioctl(s, KVM_GET_VCPU_MMAP_SIZE, 0);
>      if (mmap_size < 0) {
>          ret = mmap_size;
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index ee9025f8e9..785f3ed083 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -464,6 +464,20 @@ void kvm_set_sigmask_len(KVMState *s, unsigned int sigmask_len);
>  
>  int kvm_physical_memory_addr_from_host(KVMState *s, void *ram_addr,
>                                         hwaddr *phys_addr);
> +/**
> + * kvm_create_vcpu - Gets a parked KVM vCPU or creates a KVM vCPU
> + * @cpu:  QOM CPUState object for which KVM vCPU has to be created/fetched.

Extra space before QOM (same below)

> + *
> + * @returns: 0 when success, errno (<0) when failed.
> + */
> +int kvm_create_vcpu(CPUState *cpu);

Blank line here perhaps.

> +/**
> + * kvm_park_vcpu - Gets a parked KVM vCPU if it exists
> + * @cpu:  QOM CPUState object for which parked KVM vCPU has to be fetched.

We aren't returning anything, so why fetch?

> + *
> + * @returns: kvm_fd (>0) when success, -1 when failed.
> + */
> +void kvm_park_vcpu(CPUState *cpu);
>  
>  #endif /* NEED_CPU_H */
>  


