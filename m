Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3FD7AFB64
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 08:52:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlOP1-0002nY-DM; Wed, 27 Sep 2023 02:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qlOOz-0002mi-Ih
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 02:52:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qlOOx-0001s2-Su
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 02:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695797522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4RvOR5dZ+C1ZUQ+lqDGx3+8W6rngWTvNmzfImuxkWSU=;
 b=UmqOaN6GmQOVF1W2Fq6mLCjxuUUTOYjkO3LnAm9Kp7+HzQogf8gzLyjvM22M1N9Geccicw
 xYhhUCW1sAXAPRRvgtAkGkKTcQ5+jNYgPZYcjHFcIu6U4gemCeFpAowkYyOwMSoNkI/Fhq
 KzVn+rHgu5j7Lsb892hJF6yusbgydDc=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-bs-cHP28O9WtYryRnjVvLg-1; Wed, 27 Sep 2023 02:52:01 -0400
X-MC-Unique: bs-cHP28O9WtYryRnjVvLg-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-563ab574cb5so10597473a12.1
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 23:52:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695797520; x=1696402320;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4RvOR5dZ+C1ZUQ+lqDGx3+8W6rngWTvNmzfImuxkWSU=;
 b=eh7Z9JmAlybgHwzQkJNQhq4aCDOYzBJ7X9O17YaONRkPiCyBrLAv4vXt7/uN94t4WS
 fE0b3bptX808UcF4bux18LGAs+1NTOA1ZYAqSteQQrgdWFS2jGNubcF9rwJjd+Lr1mD5
 2TQe0cV2LMlbyTsj6wHeIEjzjxgz0EwSnpO8Yx5eX745YDRzeUcvwEZcW6mSeuTbnec3
 Ca8Pal0nnRShojefi/Vtox59eB3tZotOWQeORjqtWe54X5TYWNDBckEMbVf/vis+RYjR
 7GUkF+sU/IFGfcAsI5HN2/ghVolLYQnCvdyvO2MDchyLtKW2llP6EaJNBlk1X6FTTRTj
 vquw==
X-Gm-Message-State: AOJu0YxAaChs6pTU5tgS5ODzW1dJT0Nvb4R4ZC5cjSRdq+b0cKTYXmGN
 XQ8wxixmCStsLFb1pAfOVTJ+/tai0nHpqixVYfN5ALjORGoke805xrqUL3yR364LxS7KeaJFCVD
 ydpvi2aRan/subeM=
X-Received: by 2002:a05:6a21:9983:b0:161:2df0:eadf with SMTP id
 ve3-20020a056a21998300b001612df0eadfmr1266846pzb.24.1695797520173; 
 Tue, 26 Sep 2023 23:52:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCyKf8AkajXiA1awgjrmsMnr+ttAyf7PSYg9UYuiZjta/aDWiRws8VSgLdR6HXhzWNezekpw==
X-Received: by 2002:a05:6a21:9983:b0:161:2df0:eadf with SMTP id
 ve3-20020a056a21998300b001612df0eadfmr1266828pzb.24.1695797519837; 
 Tue, 26 Sep 2023 23:51:59 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 n1-20020a17090a160100b00277560ecd5dsm5617078pja.46.2023.09.26.23.51.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Sep 2023 23:51:59 -0700 (PDT)
Message-ID: <d58c51d2-53e4-3873-7c87-c6ccc3025ed9@redhat.com>
Date: Wed, 27 Sep 2023 16:51:45 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC V2 05/37] accel/kvm: Extract common KVM vCPU
 {creation,parking} code
Content-Language: en-US
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com, will@kernel.org,
 ardb@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 mst@redhat.com, rafael@kernel.org, borntraeger@linux.ibm.com,
 alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com,
 maobibo@loongson.cn, lixianglai@loongson.cn
References: <20230926100436.28284-1-salil.mehta@huawei.com>
 <20230926100436.28284-6-salil.mehta@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230926100436.28284-6-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

Hi Salil,

On 9/26/23 20:04, Salil Mehta wrote:
> KVM vCPU creation is done once during the initialization of the VM when Qemu
> threads are spawned. This is common to all the architectures. If the architecture
> supports vCPU hot-{un}plug then this KVM vCPU creation could be deferred to
> later point as well. Some architectures might in any case create KVM vCPUs for
> the yet-to-be plugged vCPUs (i.e. QoM Object & thread does not exists) during VM
> init time and park them.
> 
> Hot-unplug of vCPU results in destruction of the vCPU objects in QOM but
> the KVM vCPU objects in the Host KVM are not destroyed and their representative
> KVM vCPU objects in Qemu are parked.
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   accel/kvm/kvm-all.c  | 61 ++++++++++++++++++++++++++++++++++----------
>   include/sysemu/kvm.h |  2 ++
>   2 files changed, 49 insertions(+), 14 deletions(-)
> 

The most important point seems missed in the commit log: The KVM vCPU objects,
including those hotpluggable objects, need to be in place before in-host GICv3
is initialized. So we need expose kvm_create_vcpu() to make those KVM vCPU
objects in place, even for those non-present vCPUs.

> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 7b3da8dc3a..86e9c9ea60 100644
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
> @@ -320,11 +321,51 @@ err:
>       return ret;
>   }
>   
> +void kvm_park_vcpu(CPUState *cpu)
> +{
> +    unsigned long vcpu_id = cpu->cpu_index;
> +    struct KVMParkedVcpu *vcpu;
> +
> +    vcpu = g_malloc0(sizeof(*vcpu));
> +    vcpu->vcpu_id = vcpu_id;

        vcpu->vcpu_id = cpu->cpu_index;

@vcpu_id can be dropped.

> +    vcpu->kvm_fd = cpu->kvm_fd;
> +    QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu, node);
> +}
> +
> +int kvm_create_vcpu(CPUState *cpu)
> +{
> +    unsigned long vcpu_id = cpu->cpu_index;
> +    KVMState *s = kvm_state;
> +    int ret;
> +
> +    DPRINTF("kvm_create_vcpu\n");
> +
> +    /* check if the KVM vCPU already exist but is parked */
> +    ret = kvm_get_vcpu(s, kvm_arch_vcpu_id(cpu));
> +    if (ret > 0) {
> +        goto found;
> +    }
> +
> +    /* create a new KVM vcpu */
> +    ret = kvm_vm_ioctl(s, KVM_CREATE_VCPU, (void *)vcpu_id);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +found:
> +    cpu->vcpu_dirty = true;
> +    cpu->kvm_fd = ret;
> +    cpu->kvm_state = s;
> +    cpu->dirty_pages = 0;
> +    cpu->throttle_us_per_full = 0;
> +
> +    return 0;
> +}
> +

The found tag can be dropped. @cpu can be initialized if vCPU fd is found
and then bail early.

        /* The KVM vCPU may have been existing */
        ret = kvm_get_vcpu(s, kvm_arch_vcpu_id(cpu));
        if (ret > 0) {
            cpu->vcpu_dirty = true;
             :
             :
            return 0;
        }

        /* Create a new KVM vCPU */

>   static int do_kvm_destroy_vcpu(CPUState *cpu)
>   {
>       KVMState *s = kvm_state;
>       long mmap_size;
> -    struct KVMParkedVcpu *vcpu = NULL;
>       int ret = 0;
>   
>       DPRINTF("kvm_destroy_vcpu\n");
> @@ -353,10 +394,7 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
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
> @@ -384,7 +422,7 @@ static int kvm_get_vcpu(KVMState *s, unsigned long vcpu_id)
>           }
>       }
>   
> -    return kvm_vm_ioctl(s, KVM_CREATE_VCPU, (void *)vcpu_id);
> +    return -1;
>   }
>   
>   int kvm_init_vcpu(CPUState *cpu, Error **errp)
> @@ -395,19 +433,14 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
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
> index 115f0cca79..2c34889b01 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -473,6 +473,8 @@ void kvm_set_sigmask_len(KVMState *s, unsigned int sigmask_len);
>   
>   int kvm_physical_memory_addr_from_host(KVMState *s, void *ram_addr,
>                                          hwaddr *phys_addr);
> +int kvm_create_vcpu(CPUState *cpu);
> +void kvm_park_vcpu(CPUState *cpu);
>   
>   #endif /* NEED_CPU_H */
>   

Thanks,
Gavin


