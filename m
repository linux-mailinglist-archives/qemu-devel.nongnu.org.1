Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 944AB7BDB9C
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 14:22:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qppFq-00039j-Sy; Mon, 09 Oct 2023 08:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qppFo-00039G-BT
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 08:20:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qppFl-00024m-He
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 08:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696854052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XV3UtU1e17ThaCU8FwkJff/Ub39aiHlBD69v7s4+WPg=;
 b=NsoV2GT0SW+Co3OornyefLRN2IRB2+aaefCmIVYx3kQbr+I764U1yeZMakMCBdzc13SbMI
 41ns108nQnIdipgOJhMcI1GhkgWOv+ErjWdKWKHJUcNPAhzdqTwFCu5D9/L+Hv0jp3LzzI
 jAiLax6QXIz/tZpnFP949n8gxoEQApQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-M4GAjJzEMw-o3NZGBiR7DQ-1; Mon, 09 Oct 2023 08:20:51 -0400
X-MC-Unique: M4GAjJzEMw-o3NZGBiR7DQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-405917470e8so33946595e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 05:20:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696854050; x=1697458850;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XV3UtU1e17ThaCU8FwkJff/Ub39aiHlBD69v7s4+WPg=;
 b=SxMe4DN0NdXJNBy21nA8wvzWgZoimnv1vEekIIBzM66QnOszMiJudIb7xDZMru7cJJ
 h+s3Sdj1Cwm7whkUaHU8PtnJSDaJBViE6zapCHUbxlQhfMLQUkTtjqWfx7V24oPza0l2
 Yxy2ovLSh28s6H6kHTNnoO0W/YoSyLVGLHdx7GMnD217wpOs5AA/f/SuIGk+vSSFHK3v
 Dd5a9Wzl2IKbF+lf9h/i5mXLV0LEeYm3O+SGcaiij6KKqeVeIHKs2pX+uvYWJaq45BeM
 p2ewBnPKqxQVUMmM+2BeBMz/ILO6C2j61gl52C6raJ+kK0RtSZ1p4bvEcztmJaWhDXaw
 lUEw==
X-Gm-Message-State: AOJu0YxLKXSMczrA7bd2tPc8FqeECGGBMPZg7X6U7S2+jtjUER+EWAMN
 AuZ9rUHBOVIcN27MQudZ/SvZ+Oz0XZC0z9Dq27V1rdC+Y8X9tKrSCFCEn1ZwOmngjwty1Tkx9H0
 s5kZPGFnks9gWtsw=
X-Received: by 2002:a5d:4ac6:0:b0:324:885f:f806 with SMTP id
 y6-20020a5d4ac6000000b00324885ff806mr12939644wrs.56.1696854049942; 
 Mon, 09 Oct 2023 05:20:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3M+Ii3ZG18MotgSjhd6mgEaRg3qzQUp7AtQUOc26lxDb8R/iB7lAymk7PafH8O+GcyEMwqQ==
X-Received: by 2002:a5d:4ac6:0:b0:324:885f:f806 with SMTP id
 y6-20020a5d4ac6000000b00324885ff806mr12939624wrs.56.1696854049495; 
 Mon, 09 Oct 2023 05:20:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c733:6400:ae10:4bb7:9712:8548?
 (p200300cbc7336400ae104bb797128548.dip0.t-ipconnect.de.
 [2003:cb:c733:6400:ae10:4bb7:9712:8548])
 by smtp.gmail.com with ESMTPSA id
 19-20020a05600c025300b00401d8181f8bsm13295153wmj.25.2023.10.09.05.20.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 05:20:49 -0700 (PDT)
Message-ID: <a02eae26-6018-6f5c-1b82-e6061544022b@redhat.com>
Date: Mon, 9 Oct 2023 14:20:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 philmd@linaro.org, eric.auger@redhat.com, oliver.upton@linux.dev,
 pbonzini@redhat.com, mst@redhat.com, will@kernel.org, gshan@redhat.com,
 rafael@kernel.org, alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, linuxarm@huawei.com
References: <20231009112812.10612-1-salil.mehta@huawei.com>
 <20231009112812.10612-2-salil.mehta@huawei.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH V3 01/10] accel/kvm: Extract common KVM vCPU
 {creation,parking} code
In-Reply-To: <20231009112812.10612-2-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

On 09.10.23 13:28, Salil Mehta wrote:
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

[...]

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

Unrelated change.

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
> index 399aaeb0ec..08e2dc253f 100644
> --- a/accel/kvm/trace-events
> +++ b/accel/kvm/trace-events
> @@ -9,6 +9,10 @@ kvm_device_ioctl(int fd, int type, void *arg) "dev fd %d, type 0x%x, arg %p"
>   kvm_failed_reg_get(uint64_t id, const char *msg) "Warning: Unable to retrieve ONEREG %" PRIu64 " from KVM: %s"
>   kvm_failed_reg_set(uint64_t id, const char *msg) "Warning: Unable to set ONEREG %" PRIu64 " to KVM: %s"
>   kvm_init_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d id: %lu"
> +kvm_create_vcpu(int cpu_index, unsigned long arch_cpu_id) "creating KVM cpu: cpu_index: %d arch vcpu-id: %lu"
> +kvm_get_vcpu(unsigned long arch_cpu_id) "unparking KVM vcpu: arch vcpu-id: %lu"
> +kvm_destroy_vcpu(int cpu_index, unsigned long arch_cpu_id) "destroy vcpu: cpu_index: %d arch vcpu-id: %lu"
> +kvm_park_vcpu(int cpu_index, unsigned long arch_cpu_id) "parking KVM vcpu: cpu_index: %d arch vcpu-id: %lu"

It's a bit confusing that there is now

1) create (create new or return parked)
2) destroy (cleanup + park)
3) park (park only)

Why would one use 2) instead of 3) or the other way around? But I 
suspect that kvm_destroy_vcpu() is only supposed to be a KVM-internal 
helper ...

>   kvm_irqchip_commit_routes(void) ""
>   kvm_irqchip_add_msi_route(char *name, int vector, int virq) "dev %s vector %d virq %d"
>   kvm_irqchip_update_msi_route(int virq) "Updating MSI route virq=%d"
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index ee9025f8e9..57bd8f8fd6 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -464,6 +464,20 @@ void kvm_set_sigmask_len(KVMState *s, unsigned int sigmask_len);
>   
>   int kvm_physical_memory_addr_from_host(KVMState *s, void *ram_addr,
>                                          hwaddr *phys_addr);
> +/**
> + * kvm_create_vcpu - Gets a parked KVM vCPU or creates a KVM vCPU
> + * @cpu: QOM CPUState object for which KVM vCPU has to be fetched/created.
> + *
> + * @returns: 0 when success, errno (<0) when failed.
> + */
> +int kvm_create_vcpu(CPUState *cpu);
> +/**
> + * kvm_park_vcpu - Gets a parked KVM vCPU if it exists


^ I suspect that description is wrong.

-- 
Cheers,

David / dhildenb


