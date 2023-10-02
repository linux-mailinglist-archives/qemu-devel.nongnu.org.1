Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E15C37B5DA6
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 01:19:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnSAt-0001nV-43; Mon, 02 Oct 2023 19:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qnSAr-0001n2-DS
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 19:18:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qnSAp-0007Np-Fm
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 19:18:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696288677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5NZ2x4L8jtCIGTeilWA3veW3agmb+Wl4Ve9U54jEwrg=;
 b=O64xrVpSqbVPR7mWw82pIjGOSuMxHI5/WYnf4MyCZhm8RRou0VKekmZV8duz8zyprOUuki
 KHHLVQku6+ksjTPFUHwuHqIII6sAkzPjzUa5e9gtSAy1QfEhlkMLT+eJDvXBBgkS5BPCBo
 lOgO9xoOjHHltVGAgco7MMn2z62By9M=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-a8AoGp7jPAyIuQmiqDJZlg-1; Mon, 02 Oct 2023 19:17:56 -0400
X-MC-Unique: a8AoGp7jPAyIuQmiqDJZlg-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1c73637061eso2686905ad.3
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 16:17:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696288675; x=1696893475;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5NZ2x4L8jtCIGTeilWA3veW3agmb+Wl4Ve9U54jEwrg=;
 b=C4tHmMhY0bQGXanGZZDoEgx2ttvHMEWZT38CcunNqF63MA3YRyt9xg+j+bd480uUnT
 AUa97Hd9boNcv6fltvXwitydxAYgyET8BLb/9g0Vg+wKC10e57RcwM/v9DA3zOEhzSuJ
 XaEPwXosizqVMuvLz83MYRuNL4ysj91uP6Lnnovnx6ZiDwNg68aTemYHDnb1ec/mDp91
 Lco8uVe1h0pj1X5evb2jQPF/8GX1NpGxbOkGjJ2IwJ9r6UJdz2bxgEFGTFOCKbUPqB7N
 n9O+iatdQYeRYzbVeXlmM+tCzHgYXVlkH5o412zOn2xers6KOln3/2wTvUiUw2jYkq6w
 X9UA==
X-Gm-Message-State: AOJu0YxO+dStYVAABAB/oSqsv+WCsTShRlaxRYDARGcl+gERCwqsYHR/
 6uYl8sbs5qrG/XyvRGeJFdlPaCWbeK3jFsNUTbm2Mugfld9utlWQo7ewQvpSWWQxWWFhvmxxZY4
 VGcdIknUl0e2NfwE=
X-Received: by 2002:a17:902:eec6:b0:1c6:d34:5279 with SMTP id
 h6-20020a170902eec600b001c60d345279mr11470433plb.13.1696288675158; 
 Mon, 02 Oct 2023 16:17:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7VhNOZdVUTZ/fHWFExdIS8B/4jzXHwgLuV063IaB3v4yLn2H3mfBG6ISLk9d+K7hDzLSQqQ==
X-Received: by 2002:a17:902:eec6:b0:1c6:d34:5279 with SMTP id
 h6-20020a170902eec600b001c60d345279mr11470421plb.13.1696288674782; 
 Mon, 02 Oct 2023 16:17:54 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 l5-20020a170902eb0500b001c619fbd5fbsm15971197plb.298.2023.10.02.16.17.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 16:17:54 -0700 (PDT)
Message-ID: <a8861b68-5e04-5127-5c0f-77816401741b@redhat.com>
Date: Tue, 3 Oct 2023 09:17:41 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V2 01/10] accel/kvm: Extract common KVM vCPU
 {creation,parking} code
Content-Language: en-US
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com,
 oliver.upton@linux.dev, pbonzini@redhat.com, mst@redhat.com,
 will@kernel.org, rafael@kernel.org, alex.bennee@linaro.org,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 karl.heubaum@oracle.com, miguel.luis@oracle.com, salil.mehta@opnsrc.net,
 zhukeqian1@huawei.com, wangxiongfeng2@huawei.com, wangyanan55@huawei.com,
 jiakernel2@gmail.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 linuxarm@huawei.com
References: <20230930001933.2660-1-salil.mehta@huawei.com>
 <20230930001933.2660-2-salil.mehta@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230930001933.2660-2-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.321, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 9/30/23 10:19, Salil Mehta wrote:
> KVM vCPU creation is done once during the initialization of the VM when Qemu
> threads are spawned. This is common to all the architectures.
   ^^^^^^^^^^^^^^^^^^^
   thread is spawned.

> 
> Hot-unplug of vCPU results in destruction of the vCPU objects in QOM but
> the KVM vCPU objects in the Host KVM are not destroyed and their representative
> KVM vCPU objects/context in Qemu are parked.
> 
> Refactor common logic so that some APIs could be reused by vCPU Hotplug code.
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   accel/kvm/kvm-all.c  | 63 +++++++++++++++++++++++++++++++++-----------
>   include/sysemu/kvm.h | 14 ++++++++++
>   2 files changed, 61 insertions(+), 16 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index ff1578bb32..b8c36ba50a 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -80,7 +80,7 @@
>   #endif
>   
>   struct KVMParkedVcpu {
> -    unsigned long vcpu_id;
> +    int vcpu_id;

@vcpu_id represents the vCPU index (CPUState::cpu_index) instead of the
architectural CPU ID any more. However, I don't understand how it works
for x86, and more comments regarding it can be seen below.

>       int kvm_fd;
>       QLIST_ENTRY(KVMParkedVcpu) node;
>   };
> @@ -137,6 +137,7 @@ static QemuMutex kml_slots_lock;
>   #define kvm_slots_unlock()  qemu_mutex_unlock(&kml_slots_lock)
>   
>   static void kvm_slot_init_dirty_bitmap(KVMSlot *mem);
> +static int kvm_get_vcpu(KVMState *s, int vcpu_id);
>   
>   static inline void kvm_resample_fd_remove(int gsi)
>   {
> @@ -320,11 +321,49 @@ err:
>       return ret;
>   }
>   
> +void kvm_park_vcpu(CPUState *cpu)
> +{
> +    int vcpu_id = cpu->cpu_index;
> +    struct KVMParkedVcpu *vcpu;
> +
> +    vcpu = g_malloc0(sizeof(*vcpu));
> +    vcpu->vcpu_id = vcpu_id;
> +    vcpu->kvm_fd = cpu->kvm_fd;
> +    QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu, node);
> +}
> +

@vcpu_id can be dropped as suggested previously.

        vcpu->vcpu_id = cpu->cpu_index;

> +int kvm_create_vcpu(CPUState *cpu)
> +{
> +    int vcpu_id = cpu->cpu_index;
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
> +
> +    return 0;
> +}
> +

The comments here can be dropped since the code is self-explaining.

@vcpu_id represents vCPU index, instead of the architecrual vCPU ID any more.
@vcpu_id is passed to host through ioctl(KVM_CREATE_VCPU), which is expected
as an architecrual vCPU ID instead of a vCPU index by host. It's indicated
by 'struct kvm_vcpu' as below.

struct kvm_vcpu {
	:
	int vcpu_id;  /* id given by userspace at creation */
         int vcpu_idx; /* index into kvm->vcpu_array */
};

Function kvm_arch_vcpu_id() converts the vCPU instance or vCPU index to
the architecrual vCPU ID. All architectures except x86 simply returns
vCPU index (CPUState::cpu_index) as the architecrural vCPU ID. x86 returns
the APIC ID. Treating them equally seems to break x86.

>   static int do_kvm_destroy_vcpu(CPUState *cpu)
>   {
>       KVMState *s = kvm_state;
>       long mmap_size;
> -    struct KVMParkedVcpu *vcpu = NULL;
>       int ret = 0;
>   
>       DPRINTF("kvm_destroy_vcpu\n");
> @@ -353,10 +392,7 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
>           }
>       }
>   
> -    vcpu = g_malloc0(sizeof(*vcpu));
> -    vcpu->vcpu_id = kvm_arch_vcpu_id(cpu);
> -    vcpu->kvm_fd = cpu->kvm_fd;
> -    QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu, node);
> +    kvm_park_vcpu(cpu);
>   err:
>       return ret;
>   }
> @@ -369,7 +405,7 @@ void kvm_destroy_vcpu(CPUState *cpu)
>       }
>   }
>   
> -static int kvm_get_vcpu(KVMState *s, unsigned long vcpu_id)
> +static int kvm_get_vcpu(KVMState *s, int vcpu_id)
>   {
>       struct KVMParkedVcpu *cpu;
>   
> @@ -384,7 +420,7 @@ static int kvm_get_vcpu(KVMState *s, unsigned long vcpu_id)
>           }
>       }
>   
> -    return kvm_vm_ioctl(s, KVM_CREATE_VCPU, (void *)vcpu_id);
> +    return -1;
>   }
>   

Why we have -1 here. -ENOENT seems more descriptive?

>   int kvm_init_vcpu(CPUState *cpu, Error **errp)
> @@ -395,19 +431,14 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
>   
>       trace_kvm_init_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
>   
> -    ret = kvm_get_vcpu(s, kvm_arch_vcpu_id(cpu));
> +    ret = kvm_create_vcpu(cpu);
>       if (ret < 0) {
> -        error_setg_errno(errp, -ret, "kvm_init_vcpu: kvm_get_vcpu failed (%lu)",
> +        error_setg_errno(errp, -ret,
> +                         "kvm_init_vcpu: kvm_create_vcpu failed (%lu)",
>                            kvm_arch_vcpu_id(cpu));
>           goto err;
>       }
>   
> -    cpu->kvm_fd = ret;
> -    cpu->kvm_state = s;
> -    cpu->vcpu_dirty = true;
> -    cpu->dirty_pages = 0;
> -    cpu->throttle_us_per_full = 0;
> -
>       mmap_size = kvm_ioctl(s, KVM_GET_VCPU_MMAP_SIZE, 0);
>       if (mmap_size < 0) {
>           ret = mmap_size;
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index ee9025f8e9..785f3ed083 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -464,6 +464,20 @@ void kvm_set_sigmask_len(KVMState *s, unsigned int sigmask_len);
>   
>   int kvm_physical_memory_addr_from_host(KVMState *s, void *ram_addr,
>                                          hwaddr *phys_addr);
> +/**
> + * kvm_create_vcpu - Gets a parked KVM vCPU or creates a KVM vCPU
> + * @cpu:  QOM CPUState object for which KVM vCPU has to be created/fetched.
> + *
> + * @returns: 0 when success, errno (<0) when failed.
> + */
> +int kvm_create_vcpu(CPUState *cpu);
> +/**
> + * kvm_park_vcpu - Gets a parked KVM vCPU if it exists
> + * @cpu:  QOM CPUState object for which parked KVM vCPU has to be fetched.
> + *
> + * @returns: kvm_fd (>0) when success, -1 when failed.
> + */
> +void kvm_park_vcpu(CPUState *cpu);
>   
>   #endif /* NEED_CPU_H */
>   

Thanks,
Gavin


