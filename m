Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 683E47C9D83
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 04:48:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsDe9-00089X-TM; Sun, 15 Oct 2023 22:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1qsDe8-00089P-26
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 22:47:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1qsDe2-0004tH-Hc
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 22:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697424469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KvgM+lb+IVkMv1rxg3BMId2hK7dnFtUElvsMmvRTX6c=;
 b=CXncydKy5bRVxTcMFBnztL+vnY7y67RO4qx0F6L+w9m/U/RRcdwD6yJGYghBC+r7TAyi4u
 e8JMMrk+lirwTO18VDIHLEdOKlVYAo8+sXOUgMCOq5+5Wuo+XYtt8Grhe6wMFO083SYwWp
 dw2ciKlgxPWT3+bz+7d7mn7scqyOs1I=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-24v4ymmzOgaE9SwWcarcag-1; Sun, 15 Oct 2023 22:47:48 -0400
X-MC-Unique: 24v4ymmzOgaE9SwWcarcag-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-6bde07512bfso140769b3a.0
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 19:47:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697424467; x=1698029267;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KvgM+lb+IVkMv1rxg3BMId2hK7dnFtUElvsMmvRTX6c=;
 b=wJjKCMK1ypHUbTf0gruadjQlmcdT+mEilElkqD1wB/PBrjRrL+O5wXqYXgJf6n5Wcb
 3e/lMH6Nnc+7LrvCos0W8zprS16/7uxr+a/FWnFOERWSgGpnJQ6JbTYoqXJYT2+RyU/8
 9LYl6lM8n/cacdcM7yLBHAqGoVb/zGh2q14ozPQheceuIvK2+yQ1HFZ5F1/f8dXsS659
 q00NyDtilK25daaw2wM/cwT8pKgJRQQrm0JJjdUMPw2zmwI/46lYQnDD6ail9JloLzVS
 nrrmWOHCmP+u7owFiS10R2NZGe4u1zfEZGiiLYIaw2IOXZ5QGdpMvGTa86BbaX9lXgc4
 uMCg==
X-Gm-Message-State: AOJu0YxYJnNi7pUNYw02H6pvwzZHdStNCZfLJabUITqZPRkspiARb6Xd
 CGl4QS58uQWtQ6Jp9H+MsgP1tc2qiQVbQ5GUc+d7DoD2N61DE11c+XjSxno9SQEH9IHGtK7+c+u
 CKwW6jGoOFuEMh6o=
X-Received: by 2002:a05:6a20:8f01:b0:163:d382:ba99 with SMTP id
 b1-20020a056a208f0100b00163d382ba99mr40565828pzk.5.1697424466962; 
 Sun, 15 Oct 2023 19:47:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFe5Grf+kAoZ3gsL9QEzJpLu4bj0FSX5wdasJC83RpFobLzURpVmvk6cPIei07GWG7NkUfAkA==
X-Received: by 2002:a05:6a20:8f01:b0:163:d382:ba99 with SMTP id
 b1-20020a056a208f0100b00163d382ba99mr40565781pzk.5.1697424466533; 
 Sun, 15 Oct 2023 19:47:46 -0700 (PDT)
Received: from [10.66.61.39] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 mf13-20020a17090b184d00b0026f919ff9a1sm3585170pjb.10.2023.10.15.19.47.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 19:47:46 -0700 (PDT)
Message-ID: <f33c6f0e-2d44-0023-39cf-49b74ff523d5@redhat.com>
Date: Mon, 16 Oct 2023 10:47:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V5 1/9] accel/kvm: Extract common KVM vCPU {creation,
 parking} code
Content-Language: en-US
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com,
 oliver.upton@linux.dev, pbonzini@redhat.com, mst@redhat.com,
 will@kernel.org, gshan@redhat.com, rafael@kernel.org,
 alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, linuxarm@huawei.com
References: <20231011194355.15628-1-salil.mehta@huawei.com>
 <20231011194355.15628-2-salil.mehta@huawei.com>
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <20231011194355.15628-2-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=shahuang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 10/12/23 03:43, Salil Mehta via wrote:
> KVM vCPU creation is done once during the initialization of the VM when Qemu
> thread is spawned. This is common to all the architectures.
> 
> Hot-unplug of vCPU results in destruction of the vCPU object in QOM but the
> corresponding KVM vCPU object in the Host KVM is not destroyed and its
> representative KVM vCPU object/context in Qemu is parked.
> 
> Refactor common logic so that some APIs could be reused by vCPU Hotplug code.
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> ---
>   accel/kvm/kvm-all.c    | 64 ++++++++++++++++++++++++++++++++----------
>   accel/kvm/trace-events |  4 +++
>   include/sysemu/kvm.h   | 16 +++++++++++
>   3 files changed, 69 insertions(+), 15 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index ff1578bb32..0dcaa15276 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -137,6 +137,7 @@ static QemuMutex kml_slots_lock;
>   #define kvm_slots_unlock()  qemu_mutex_unlock(&kml_slots_lock)
>   
>   static void kvm_slot_init_dirty_bitmap(KVMSlot *mem);
> +static int kvm_get_vcpu(KVMState *s, unsigned long vcpu_id);
>   
>   static inline void kvm_resample_fd_remove(int gsi)
>   {
> @@ -320,14 +321,53 @@ err:
>       return ret;
>   }
>   
> +void kvm_park_vcpu(CPUState *cpu)
> +{
> +    struct KVMParkedVcpu *vcpu;
> +
> +    trace_kvm_park_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
> +
> +    vcpu = g_malloc0(sizeof(*vcpu));
> +    vcpu->vcpu_id = kvm_arch_vcpu_id(cpu);
> +    vcpu->kvm_fd = cpu->kvm_fd;
> +    QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu, node);
> +}
> +
> +int kvm_create_vcpu(CPUState *cpu)
> +{
> +    unsigned long vcpu_id = kvm_arch_vcpu_id(cpu);
> +    KVMState *s = kvm_state;
> +    int kvm_fd;
> +
> +    trace_kvm_create_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
> +
> +    /* check if the KVM vCPU already exist but is parked */
> +    kvm_fd = kvm_get_vcpu(s, vcpu_id);
> +    if (kvm_fd < 0) {
> +        /* vCPU not parked: create a new KVM vCPU */
> +        kvm_fd = kvm_vm_ioctl(s, KVM_CREATE_VCPU, vcpu_id);
> +        if (kvm_fd < 0) {
> +            error_report("KVM_CREATE_VCPU IOCTL failed for vCPU %lu", vcpu_id);
> +            return kvm_fd;
> +        }
> +    }
> +
> +    cpu->kvm_fd = kvm_fd;
> +    cpu->kvm_state = s;
> +    cpu->vcpu_dirty = true;
> +    cpu->dirty_pages = 0;
> +    cpu->throttle_us_per_full = 0;
> +
> +    return 0;
> +}
> +
>   static int do_kvm_destroy_vcpu(CPUState *cpu)
>   {
>       KVMState *s = kvm_state;
>       long mmap_size;
> -    struct KVMParkedVcpu *vcpu = NULL;
>       int ret = 0;
>   
> -    DPRINTF("kvm_destroy_vcpu\n");
> +    trace_kvm_destroy_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
>   
>       ret = kvm_arch_destroy_vcpu(cpu);
>       if (ret < 0) {
> @@ -353,10 +393,7 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
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
> @@ -377,6 +414,8 @@ static int kvm_get_vcpu(KVMState *s, unsigned long vcpu_id)
>           if (cpu->vcpu_id == vcpu_id) {
>               int kvm_fd;
>   
> +            trace_kvm_get_vcpu(vcpu_id);
> +
>               QLIST_REMOVE(cpu, node);
>               kvm_fd = cpu->kvm_fd;
>               g_free(cpu);
> @@ -384,7 +423,7 @@ static int kvm_get_vcpu(KVMState *s, unsigned long vcpu_id)
>           }
>       }
>   
> -    return kvm_vm_ioctl(s, KVM_CREATE_VCPU, (void *)vcpu_id);
> +    return -ENOENT;
>   }
>   
>   int kvm_init_vcpu(CPUState *cpu, Error **errp)
> @@ -395,19 +434,14 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
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
> diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
> index 399aaeb0ec..cdd0c95c09 100644
> --- a/accel/kvm/trace-events
> +++ b/accel/kvm/trace-events
> @@ -9,6 +9,10 @@ kvm_device_ioctl(int fd, int type, void *arg) "dev fd %d, type 0x%x, arg %p"
>   kvm_failed_reg_get(uint64_t id, const char *msg) "Warning: Unable to retrieve ONEREG %" PRIu64 " from KVM: %s"
>   kvm_failed_reg_set(uint64_t id, const char *msg) "Warning: Unable to set ONEREG %" PRIu64 " to KVM: %s"
>   kvm_init_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d id: %lu"
> +kvm_create_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d id: %lu"
> +kvm_get_vcpu(unsigned long arch_cpu_id) "id: %lu"
> +kvm_destroy_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d id: %lu"
> +kvm_park_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d id: %lu"
>   kvm_irqchip_commit_routes(void) ""
>   kvm_irqchip_add_msi_route(char *name, int vector, int virq) "dev %s vector %d virq %d"
>   kvm_irqchip_update_msi_route(int virq) "Updating MSI route virq=%d"
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index ee9025f8e9..740686ab60 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -465,6 +465,22 @@ void kvm_set_sigmask_len(KVMState *s, unsigned int sigmask_len);
>   int kvm_physical_memory_addr_from_host(KVMState *s, void *ram_addr,
>                                          hwaddr *phys_addr);
>   
> +/**
> + * kvm_create_vcpu - Gets a parked KVM vCPU or creates a KVM vCPU
> + * @cpu: QOM CPUState object for which KVM vCPU has to be fetched/created.
> + *
> + * @returns: 0 when success, errno (<0) when failed.
> + */
> +int kvm_create_vcpu(CPUState *cpu);
> +
> +/**
> + * kvm_park_vcpu - Park Qemu KVM vCPU context
> + * @cpu: QOM CPUState object for which Qemu KVM vCPU context has to be parked.
> + *
> + * @returns: none
> + */
> +void kvm_park_vcpu(CPUState *cpu);
> +
>   #endif /* NEED_CPU_H */
>   
>   void kvm_cpu_synchronize_state(CPUState *cpu);

-- 
Shaoqin


