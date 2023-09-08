Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F189E7985DF
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 12:29:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeYil-0006mO-0G; Fri, 08 Sep 2023 06:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qeYii-0006jU-Oo
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 06:28:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qeYif-00073T-Qu
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 06:28:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694168888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xyoWQreR1Sroz0nVsQqwR92Zs5H9tRVcLLF+CAtRfGU=;
 b=SB4gSTqy7/eKvgtyt0hhy8DsC3UsDP+j6P6enHYvKbY7JxmdkQA/KvEr/ubymzjcbxWhrG
 N4oAzLdm8Tzg3+lab2kQuiE0s/SHxKq8u1ABg4XIrE5IqbbC/hmMo48GFz5PPl/oqrd2Iu
 oz7pRK7q0Mym09kQaiMiixw3TUegWbY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-jFOerAyvN3STN1iXgFa2KA-1; Fri, 08 Sep 2023 06:28:07 -0400
X-MC-Unique: jFOerAyvN3STN1iXgFa2KA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-401db25510fso14218125e9.1
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 03:28:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694168886; x=1694773686;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xyoWQreR1Sroz0nVsQqwR92Zs5H9tRVcLLF+CAtRfGU=;
 b=k9ekrDUtO7sdtB4x6t9BrUmWBuvVoxkciqkKG6+N7TjCeZj2tJLqp6KR6Zp7BZsjLl
 mFzQtCBMrPw+CCJXgLF08vm+77b+Go3qt7MhYtOp2mRXgMIQAIsqp7TS3Piy2l2YOqQ2
 F/81bybff+cBG/kXIIhsbQ8F2QyC4JjNmTdKxyPhhDYuGL8DIKwFQvFbmH/m4CwdWO2w
 Xx7UhBXyXdGmi8erplS6dJgm+qTlhsP1zfChG4i8e2cPizJBhfWux/52iK61OrDN0pb0
 LxHHMhtnSHPk5z+moysQQ19BeTLUKePiyztTzi9GbgVSGJIkSZHolkYaEvsON86XYlhW
 ydFQ==
X-Gm-Message-State: AOJu0YyXNqUSKPPLxcv21nikIFRbkhKvA1MzIO6qszHaZUpJHj05j8Ac
 eXTbsTgVHmX3eQYAtKrcNxZSs373mDfkYnCBDbmjVxLKLRGwL95L6bJcY6kaXbigobhtZBJgToc
 j9P0mA0p6Cz3E+cM=
X-Received: by 2002:a7b:c4d1:0:b0:401:4542:5edd with SMTP id
 g17-20020a7bc4d1000000b0040145425eddmr1732280wmk.34.1694168886059; 
 Fri, 08 Sep 2023 03:28:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtoChNoguK18h7beYZVj7FkanEgZV0TynxIdsU5SUoZS74wKNeBtNjJPgjJSdxstUGAgRc8w==
X-Received: by 2002:a7b:c4d1:0:b0:401:4542:5edd with SMTP id
 g17-20020a7bc4d1000000b0040145425eddmr1732268wmk.34.1694168885595; 
 Fri, 08 Sep 2023 03:28:05 -0700 (PDT)
Received: from ?IPV6:2003:cb:c720:d00:61ea:eace:637c:3f0f?
 (p200300cbc7200d0061eaeace637c3f0f.dip0.t-ipconnect.de.
 [2003:cb:c720:d00:61ea:eace:637c:3f0f])
 by smtp.gmail.com with ESMTPSA id
 f7-20020a7bcd07000000b00401c595fcc7sm4847089wmj.11.2023.09.08.03.28.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Sep 2023 03:28:05 -0700 (PDT)
Message-ID: <77284898-c540-31ac-d438-ebff52f6d75d@redhat.com>
Date: Fri, 8 Sep 2023 12:28:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Cc: qemu-devel@nongnu.org
References: <20230908095024.270946-1-anisinha@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mem/x86: add processor address space check for VM memory
In-Reply-To: <20230908095024.270946-1-anisinha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
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

On 08.09.23 11:50, Ani Sinha wrote:
> Depending on the number of available address bits of the current processor, a
> VM can only use a certain maximum amount of memory and no more. This change
> makes sure that a VM is not configured to have more memory than what it can use
> with the current processor settings when started. Additionally, the change adds
> checks during memory hotplug to ensure that the VM does not end up getting more
> memory than what it can actually use after hotplug.
> Currently, both the above checks are only for pc (x86) platform.
> 
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1235403
> CC: imammedo@redhat.com
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>   hw/i386/pc.c           | 45 ++++++++++++++++++++++++++++++++++++++++++
>   hw/mem/memory-device.c |  6 ++++++
>   include/hw/boards.h    |  9 +++++++++
>   3 files changed, 60 insertions(+)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 54838c0c41..f84e4c4916 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -31,6 +31,7 @@
>   #include "hw/i386/topology.h"
>   #include "hw/i386/fw_cfg.h"
>   #include "hw/i386/vmport.h"
> +#include "hw/mem/memory-device.h"
>   #include "sysemu/cpus.h"
>   #include "hw/block/fdc.h"
>   #include "hw/ide/internal.h"
> @@ -1006,6 +1007,17 @@ void pc_memory_init(PCMachineState *pcms,
>           exit(EXIT_FAILURE);
>       }
>   
> +    /*
> +     * check if the VM started with more ram configured than max physical
> +     * address available with the current processor.
> +     */
> +    if (machine->ram_size > maxphysaddr + 1) {
> +        error_report("Address space limit 0x%"PRIx64" < 0x%"PRIx64
> +                     " (max configured memory), phys-bits too low (%u)",
> +                     maxphysaddr, machine->ram_size, cpu->phys_bits);
> +        exit(EXIT_FAILURE);
> +    }

... I know that this used to be a problem in the past, but nowadays we 
already do have similar checks in place?

$ ./build/qemu-system-x86_64 -m 4T -machine q35,memory-backend=mem0 
-object memory-backend-ram,id=mem0,size=4T,reserve=off
qemu-system-x86_64: Address space limit 0xffffffffff < 0x5077fffffff 
phys-bits too low (40)

Why is that not sufficient or why can't that be extended?

> +
>       /*
>        * Split single memory region and use aliases to address portions of it,
>        * done for backwards compatibility with older qemus.
> @@ -1845,6 +1857,38 @@ static bool pc_hotplug_allowed(MachineState *ms, DeviceState *dev, Error **errp)
>       return true;
>   }
>   
> +static bool pc_mem_hotplug_allowed(MachineState *ms,
> +                                   MemoryRegion *mr, Error **errp)
> +{
> +    hwaddr maxphysaddr;
> +    uint64_t dimm_size, size, ram_size, total_mem_size;
> +    X86CPU *cpu = X86_CPU(first_cpu);
> +
> +    if (!mr) {
> +        return true;
> +    }
> +
> +    dimm_size = ms->device_memory->dimm_size;
> +    size = memory_region_size(mr);
> +    ram_size = (uint64_t) ms->ram_size;
> +    total_mem_size = ram_size + dimm_size + size;

That's wrong. The sizes does not tell you where the devices are actually 
located in the address space.

> +
> +    maxphysaddr = ((hwaddr)1 << cpu->phys_bits) - 1;
> +
> +    /*
> +     * total memory after hotplug will exceed the maximum physical
> +     * address limit of the processor. So hotplug cannot be allowed.
> +     */
> +    if ((total_mem_size > (uint64_t)maxphysaddr + 1) &&
> +        (total_mem_size > ram_size + dimm_size)) {
> +        error_setg(errp, "Address space limit 0x%"PRIx64" < 0x%"PRIx64
> +                   " phys-bits too low (%u)",
> +                   maxphysaddr, total_mem_size, cpu->phys_bits);
> +        return false;
> +    }
> +    return true;
> +}
> +
>   static void pc_machine_class_init(ObjectClass *oc, void *data)
>   {
>       MachineClass *mc = MACHINE_CLASS(oc);
> @@ -1870,6 +1914,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
>       assert(!mc->get_hotplug_handler);
>       mc->get_hotplug_handler = pc_get_hotplug_handler;
>       mc->hotplug_allowed = pc_hotplug_allowed;
> +    mc->mem_hotplug_allowed = pc_mem_hotplug_allowed;
>       mc->cpu_index_to_instance_props = x86_cpu_index_to_props;
>       mc->get_default_cpu_node_id = x86_get_default_cpu_node_id;
>       mc->possible_cpu_arch_ids = x86_possible_cpu_arch_ids;
> diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
> index 667d56bd29..825bc593ae 100644
> --- a/hw/mem/memory-device.c
> +++ b/hw/mem/memory-device.c
> @@ -57,6 +57,7 @@ static void memory_device_check_addable(MachineState *ms, MemoryRegion *mr,
>   {
>       const uint64_t used_region_size = ms->device_memory->used_region_size;
>       const uint64_t size = memory_region_size(mr);
> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
>   
>       /* we will need a new memory slot for kvm and vhost */
>       if (kvm_enabled() && !kvm_has_free_slot(ms)) {
> @@ -68,6 +69,11 @@ static void memory_device_check_addable(MachineState *ms, MemoryRegion *mr,
>           return;
>       }
>   
> +    if (mc->mem_hotplug_allowed &&
> +        (!(mc->mem_hotplug_allowed(ms, mr, errp)))) {
> +        return;
> +    }
> +
>       /* will we exceed the total amount of memory specified */
>       if (used_region_size + size < used_region_size ||
>           used_region_size + size > ms->maxram_size - ms->ram_size) {
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 3b541ffd24..84b199ee51 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -210,6 +210,13 @@ typedef struct {
>    *    false is returned, an error must be set to show the reason of
>    *    the rejection.  If the hook is not provided, all hotplug will be
>    *    allowed.
> + * @mem_hotplug_allowed:
> + *    If the hook is provided, then it'll be called for each memory device
> + *    hotplug to check whether the mem device hotplug is allowed.  Return
> + *    true to grant allowance or false to reject the hotplug.  When
> + *    false is returned, an error must be set to show the reason of
> + *    the rejection.  If the hook is not provided, all mem hotplug will be
> + *    allowed.

That's nasty.

1) The machine hotplug handler already is in charge of plugging such 
devices. It could perform such checks there but,

2) Why even allow the device memory region to exceed maxphysaddr?


Instead, we should probably fail creating the device managed region if 
it would end up exceeding maxphysaddr.

pc_memory_init()-> ... -> machine_memory_devices_init()

Can't we make sure in pc_memory_init() that we can never have memory 
devices being plugged into inaccessible regions? Or check back later 
once we know the limit (if not already known)?

-- 
Cheers,

David / dhildenb


