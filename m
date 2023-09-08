Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0419579885A
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 16:14:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qecEN-0003HP-Uy; Fri, 08 Sep 2023 10:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qecEG-0003GV-07
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:13:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qecEB-0007tq-LZ
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694182374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZTfDBDfZbNO8j17VBtL4XFCBaM1LSjgEEJ8tAEmIMcY=;
 b=Uw8EEtAs+kBdYs2H12AG3io/nXOVUbOyn6OjlnFV2dsiAHt/yK6XImCjQhcOT6CQIp2B87
 SUwUXGiwl3dkf1KsOu/+7O9TUd40eYMj/9NPcaQSgtSTcN0Lo3h6OOsIDemQ7qSYsRN2w2
 AhrxB8ZOd3qLtJh40m+mbPZr8SNn9IM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-G8PEjdt_Nf-bUdwCJn9wuA-1; Fri, 08 Sep 2023 10:12:53 -0400
X-MC-Unique: G8PEjdt_Nf-bUdwCJn9wuA-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-26d5970cbdbso3001150a91.0
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 07:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694182372; x=1694787172;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZTfDBDfZbNO8j17VBtL4XFCBaM1LSjgEEJ8tAEmIMcY=;
 b=YkhI3parRnW7MKejAar50IC+i93ezZwZPS7Yt6do6p92OJAVt0UJjyErywwQG/Ztgg
 kOrCNOjX/Gexp4g0PKkwnn5qgN+NomIftiDt/nsBAIMNNMLc2FlVmNgBqxKNpREb1wsQ
 s4MMCr4ekJqVds0ilmBzUw+bKoTHYobbi3o3nlrh9AMfeBWviEScJoAYtndllFvrsea+
 tC+lwACWL7G3LjB53fpNrN8f0GiUx2AUCJ43zkTpkTycY00Hk4XRQ01HQpyyIIIz3ghq
 GDe+RjbnrVnsKoXQ2ZQFkN6XMCFgrI7a8R/aIvc+UJdBf21UDlHi3cnluXbHrwsux9dc
 SRbQ==
X-Gm-Message-State: AOJu0YyueJFXbCbgLUBrpkU+nBPbV5GX7kzqO7R0wSu88msLaJCMV1xq
 EFDe0ROQJhbgV7h4F5sJpxiew306fEXTgcSloF0b65KSArLWCSoyOaBvE7umNBmZvq/c9PxXUVe
 FEOCombXa53KwXWM=
X-Received: by 2002:a17:90a:c38d:b0:26f:4685:5b53 with SMTP id
 h13-20020a17090ac38d00b0026f46855b53mr2983550pjt.28.1694182371996; 
 Fri, 08 Sep 2023 07:12:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGgqIADsorc5bIO/tA0D59APSyW6q/+BOPSliNOLimE3LUH8Vf4zNrJdyXpjA9HV2tNSWCmg==
X-Received: by 2002:a17:90a:c38d:b0:26f:4685:5b53 with SMTP id
 h13-20020a17090ac38d00b0026f46855b53mr2983523pjt.28.1694182371627; 
 Fri, 08 Sep 2023 07:12:51 -0700 (PDT)
Received: from smtpclient.apple ([115.96.141.163])
 by smtp.gmail.com with ESMTPSA id
 d4-20020a17090ad98400b002694da8a9cdsm1378610pjv.48.2023.09.08.07.12.47
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 08 Sep 2023 07:12:51 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PATCH] mem/x86: add processor address space check for VM memory
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <77284898-c540-31ac-d438-ebff52f6d75d@redhat.com>
Date: Fri, 8 Sep 2023 19:42:44 +0530
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1911B17C-24F2-406B-9ED4-DCF98E794A09@redhat.com>
References: <20230908095024.270946-1-anisinha@redhat.com>
 <77284898-c540-31ac-d438-ebff52f6d75d@redhat.com>
To: David Hildenbrand <david@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 08-Sep-2023, at 3:58 PM, David Hildenbrand <david@redhat.com> =
wrote:
>=20
> On 08.09.23 11:50, Ani Sinha wrote:
>> Depending on the number of available address bits of the current =
processor, a
>> VM can only use a certain maximum amount of memory and no more. This =
change
>> makes sure that a VM is not configured to have more memory than what =
it can use
>> with the current processor settings when started. Additionally, the =
change adds
>> checks during memory hotplug to ensure that the VM does not end up =
getting more
>> memory than what it can actually use after hotplug.
>> Currently, both the above checks are only for pc (x86) platform.
>> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1235403
>> CC: imammedo@redhat.com
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> ---
>>  hw/i386/pc.c           | 45 =
++++++++++++++++++++++++++++++++++++++++++
>>  hw/mem/memory-device.c |  6 ++++++
>>  include/hw/boards.h    |  9 +++++++++
>>  3 files changed, 60 insertions(+)
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 54838c0c41..f84e4c4916 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -31,6 +31,7 @@
>>  #include "hw/i386/topology.h"
>>  #include "hw/i386/fw_cfg.h"
>>  #include "hw/i386/vmport.h"
>> +#include "hw/mem/memory-device.h"
>>  #include "sysemu/cpus.h"
>>  #include "hw/block/fdc.h"
>>  #include "hw/ide/internal.h"
>> @@ -1006,6 +1007,17 @@ void pc_memory_init(PCMachineState *pcms,
>>          exit(EXIT_FAILURE);
>>      }
>>  +    /*
>> +     * check if the VM started with more ram configured than max =
physical
>> +     * address available with the current processor.
>> +     */
>> +    if (machine->ram_size > maxphysaddr + 1) {
>> +        error_report("Address space limit 0x%"PRIx64" < 0x%"PRIx64
>> +                     " (max configured memory), phys-bits too low =
(%u)",
>> +                     maxphysaddr, machine->ram_size, =
cpu->phys_bits);
>> +        exit(EXIT_FAILURE);
>> +    }
>=20
> ... I know that this used to be a problem in the past, but nowadays we =
already do have similar checks in place?
>=20
> $ ./build/qemu-system-x86_64 -m 4T -machine q35,memory-backend=3Dmem0 =
-object memory-backend-ram,id=3Dmem0,size=3D4T,reserve=3Doff
> qemu-system-x86_64: Address space limit 0xffffffffff < 0x5077fffffff =
phys-bits too low (40)

So you are saying that this is OK and should be allowed? On a 32 bit =
processor that can access only 4G memory, I am spinning up a 10G VM.

$ ./qemu-system-x86_64 -cpu pentium -m size=3D10G, -monitor stdio -qmp =
tcp:0:5555,server,nowait
QEMU 8.1.50 monitor - type 'help' for more information
VNC server running on ::1:5900
(qemu)=20



>=20
> Why is that not sufficient or why can't that be extended?
>=20
>> +
>>      /*
>>       * Split single memory region and use aliases to address =
portions of it,
>>       * done for backwards compatibility with older qemus.
>> @@ -1845,6 +1857,38 @@ static bool pc_hotplug_allowed(MachineState =
*ms, DeviceState *dev, Error **errp)
>>      return true;
>>  }
>>  +static bool pc_mem_hotplug_allowed(MachineState *ms,
>> +                                   MemoryRegion *mr, Error **errp)
>> +{
>> +    hwaddr maxphysaddr;
>> +    uint64_t dimm_size, size, ram_size, total_mem_size;
>> +    X86CPU *cpu =3D X86_CPU(first_cpu);
>> +
>> +    if (!mr) {
>> +        return true;
>> +    }
>> +
>> +    dimm_size =3D ms->device_memory->dimm_size;
>> +    size =3D memory_region_size(mr);
>> +    ram_size =3D (uint64_t) ms->ram_size;
>> +    total_mem_size =3D ram_size + dimm_size + size;
>=20
> That's wrong. The sizes does not tell you where the devices are =
actually located in the address space.
>=20
>> +
>> +    maxphysaddr =3D ((hwaddr)1 << cpu->phys_bits) - 1;
>> +
>> +    /*
>> +     * total memory after hotplug will exceed the maximum physical
>> +     * address limit of the processor. So hotplug cannot be allowed.
>> +     */
>> +    if ((total_mem_size > (uint64_t)maxphysaddr + 1) &&
>> +        (total_mem_size > ram_size + dimm_size)) {
>> +        error_setg(errp, "Address space limit 0x%"PRIx64" < =
0x%"PRIx64
>> +                   " phys-bits too low (%u)",
>> +                   maxphysaddr, total_mem_size, cpu->phys_bits);
>> +        return false;
>> +    }
>> +    return true;
>> +}
>> +
>>  static void pc_machine_class_init(ObjectClass *oc, void *data)
>>  {
>>      MachineClass *mc =3D MACHINE_CLASS(oc);
>> @@ -1870,6 +1914,7 @@ static void pc_machine_class_init(ObjectClass =
*oc, void *data)
>>      assert(!mc->get_hotplug_handler);
>>      mc->get_hotplug_handler =3D pc_get_hotplug_handler;
>>      mc->hotplug_allowed =3D pc_hotplug_allowed;
>> +    mc->mem_hotplug_allowed =3D pc_mem_hotplug_allowed;
>>      mc->cpu_index_to_instance_props =3D x86_cpu_index_to_props;
>>      mc->get_default_cpu_node_id =3D x86_get_default_cpu_node_id;
>>      mc->possible_cpu_arch_ids =3D x86_possible_cpu_arch_ids;
>> diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
>> index 667d56bd29..825bc593ae 100644
>> --- a/hw/mem/memory-device.c
>> +++ b/hw/mem/memory-device.c
>> @@ -57,6 +57,7 @@ static void =
memory_device_check_addable(MachineState *ms, MemoryRegion *mr,
>>  {
>>      const uint64_t used_region_size =3D =
ms->device_memory->used_region_size;
>>      const uint64_t size =3D memory_region_size(mr);
>> +    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
>>        /* we will need a new memory slot for kvm and vhost */
>>      if (kvm_enabled() && !kvm_has_free_slot(ms)) {
>> @@ -68,6 +69,11 @@ static void =
memory_device_check_addable(MachineState *ms, MemoryRegion *mr,
>>          return;
>>      }
>>  +    if (mc->mem_hotplug_allowed &&
>> +        (!(mc->mem_hotplug_allowed(ms, mr, errp)))) {
>> +        return;
>> +    }
>> +
>>      /* will we exceed the total amount of memory specified */
>>      if (used_region_size + size < used_region_size ||
>>          used_region_size + size > ms->maxram_size - ms->ram_size) {
>> diff --git a/include/hw/boards.h b/include/hw/boards.h
>> index 3b541ffd24..84b199ee51 100644
>> --- a/include/hw/boards.h
>> +++ b/include/hw/boards.h
>> @@ -210,6 +210,13 @@ typedef struct {
>>   *    false is returned, an error must be set to show the reason of
>>   *    the rejection.  If the hook is not provided, all hotplug will =
be
>>   *    allowed.
>> + * @mem_hotplug_allowed:
>> + *    If the hook is provided, then it'll be called for each memory =
device
>> + *    hotplug to check whether the mem device hotplug is allowed.  =
Return
>> + *    true to grant allowance or false to reject the hotplug.  When
>> + *    false is returned, an error must be set to show the reason of
>> + *    the rejection.  If the hook is not provided, all mem hotplug =
will be
>> + *    allowed.
>=20
> That's nasty.
>=20
> 1) The machine hotplug handler already is in charge of plugging such =
devices. It could perform such checks there but,
>=20
> 2) Why even allow the device memory region to exceed maxphysaddr?
>=20
>=20
> Instead, we should probably fail creating the device managed region if =
it would end up exceeding maxphysaddr.
>=20
> pc_memory_init()-> ... -> machine_memory_devices_init()
>=20
> Can't we make sure in pc_memory_init() that we can never have memory =
devices being plugged into inaccessible regions? Or check back later =
once we know the limit (if not already known)?
>=20
> --=20
> Cheers,
>=20
> David / dhildenb


