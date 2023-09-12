Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BC179CE96
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 12:42:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg0pu-0006kn-T2; Tue, 12 Sep 2023 06:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qg0pj-0006jG-20
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 06:41:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qg0pf-0001X8-6c
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 06:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694515280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nl1THcDIrz8XVX9vGhmfLSicsTyW2p2CCaLXNFNsbpQ=;
 b=QaKYEwzdnv15pAMo9Y6+ei2ZF/IkmP80m7iDFCZMyN4lLO9YrAXxTTCg8NoiOaCPcpYOGd
 rpn+96rvRoH0M4sv+9dojeK3pYyYZA0WaY2OrbMr7ZwF96TcTd7M3EQ1+uMq1zHlPG/oxo
 bQmdqUnm7j0vcJjEAeKAWspudfT10K4=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-iTJqdOsxMGS5T8tvT0tc8Q-1; Tue, 12 Sep 2023 06:41:18 -0400
X-MC-Unique: iTJqdOsxMGS5T8tvT0tc8Q-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1c3ae44bbceso26914795ad.2
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 03:41:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694515276; x=1695120076;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nl1THcDIrz8XVX9vGhmfLSicsTyW2p2CCaLXNFNsbpQ=;
 b=CgHTZqUIgQHPlQ3z0tB5JVSQtLF7CW7KLEGQn3GZsItGDqCOoKdyv7UuQow+Mjdjn2
 Frg15A43+UeKj1MNmXGxKEe03nVCE3axCbtIJ3tKYI4qi6N1PC/p8BrYs5zKL1MwGLto
 Jb+xRgT+MNkzC1huSbBZ4WPaGsyTtSGOe5SIUxYTCxpptaEglvHcV7ewmebtKHHEN/js
 nXk9Hh3sx0kBum2gtlRfu2FmbFhj9lvvXk8TYbtCYtz8Ee9DQ1zap1yFPY7lnSCF/IQN
 fYa7AhrT+ptIcTMeuK7VzDtRrRqTNuS0VGRhycWSGF6m7ePfBqWlJBl2PRH6iGyNRJ3h
 6g3g==
X-Gm-Message-State: AOJu0YyWwpZAXDmfqKID1lMibeBEkN/Avc3EpTW1GsL2yRz+0vETaBBh
 OOSkNOqyDglbc5b4s0HK7gSmjDjhNepGFSLmYYNjeskGjEFfpPqGvh/nnUVjxjXjHn0L9WXfCML
 ls64qL4HZ1zSTMe4=
X-Received: by 2002:a17:902:9a4b:b0:1c3:8976:e821 with SMTP id
 x11-20020a1709029a4b00b001c38976e821mr8641364plv.15.1694515276412; 
 Tue, 12 Sep 2023 03:41:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFICft9/BpZ+dtboozSd8kxd8YQIvuMn8KZkODkJO1LCE85Y2MnAFpHcSLcYtnkhM+uNGTBow==
X-Received: by 2002:a17:902:9a4b:b0:1c3:8976:e821 with SMTP id
 x11-20020a1709029a4b00b001c38976e821mr8641351plv.15.1694515276066; 
 Tue, 12 Sep 2023 03:41:16 -0700 (PDT)
Received: from smtpclient.apple ([115.96.158.157])
 by smtp.gmail.com with ESMTPSA id
 h6-20020a170902680600b001bb988ac243sm8252380plk.297.2023.09.12.03.41.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Sep 2023 03:41:15 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PATCH] mem/x86: add processor address space check for VM memory
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <6cbca7b9-381b-6268-27f0-d7ea1c5ed1bd@redhat.com>
Date: Tue, 12 Sep 2023 16:11:09 +0530
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3A287C52-F547-4494-B803-8CFC50CBA175@redhat.com>
References: <20230908095024.270946-1-anisinha@redhat.com>
 <77284898-c540-31ac-d438-ebff52f6d75d@redhat.com>
 <1911B17C-24F2-406B-9ED4-DCF98E794A09@redhat.com>
 <730648ed-55ac-aa2c-58d2-d79224aeb586@redhat.com>
 <1574DF3A-7E1F-4C4F-9087-6E8DEE456906@redhat.com>
 <6cbca7b9-381b-6268-27f0-d7ea1c5ed1bd@redhat.com>
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



> On 08-Sep-2023, at 9:32 PM, David Hildenbrand <david@redhat.com> =
wrote:
>=20
> On 08.09.23 17:13, Ani Sinha wrote:
>>> On 08-Sep-2023, at 7:46 PM, David Hildenbrand <david@redhat.com> =
wrote:
>>>=20
>>> On 08.09.23 16:12, Ani Sinha wrote:
>>>>> On 08-Sep-2023, at 3:58 PM, David Hildenbrand <david@redhat.com> =
wrote:
>>>>>=20
>>>>> On 08.09.23 11:50, Ani Sinha wrote:
>>>>>> Depending on the number of available address bits of the current =
processor, a
>>>>>> VM can only use a certain maximum amount of memory and no more. =
This change
>>>>>> makes sure that a VM is not configured to have more memory than =
what it can use
>>>>>> with the current processor settings when started. Additionally, =
the change adds
>>>>>> checks during memory hotplug to ensure that the VM does not end =
up getting more
>>>>>> memory than what it can actually use after hotplug.
>>>>>> Currently, both the above checks are only for pc (x86) platform.
>>>>>> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1235403
>>>>>> CC: imammedo@redhat.com
>>>>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>>>>> ---
>>>>>>  hw/i386/pc.c           | 45 =
++++++++++++++++++++++++++++++++++++++++++
>>>>>>  hw/mem/memory-device.c |  6 ++++++
>>>>>>  include/hw/boards.h    |  9 +++++++++
>>>>>>  3 files changed, 60 insertions(+)
>>>>>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>>>>>> index 54838c0c41..f84e4c4916 100644
>>>>>> --- a/hw/i386/pc.c
>>>>>> +++ b/hw/i386/pc.c
>>>>>> @@ -31,6 +31,7 @@
>>>>>>  #include "hw/i386/topology.h"
>>>>>>  #include "hw/i386/fw_cfg.h"
>>>>>>  #include "hw/i386/vmport.h"
>>>>>> +#include "hw/mem/memory-device.h"
>>>>>>  #include "sysemu/cpus.h"
>>>>>>  #include "hw/block/fdc.h"
>>>>>>  #include "hw/ide/internal.h"
>>>>>> @@ -1006,6 +1007,17 @@ void pc_memory_init(PCMachineState *pcms,
>>>>>>          exit(EXIT_FAILURE);
>>>>>>      }
>>>>>>  +    /*
>>>>>> +     * check if the VM started with more ram configured than max =
physical
>>>>>> +     * address available with the current processor.
>>>>>> +     */
>>>>>> +    if (machine->ram_size > maxphysaddr + 1) {
>>>>>> +        error_report("Address space limit 0x%"PRIx64" < =
0x%"PRIx64
>>>>>> +                     " (max configured memory), phys-bits too =
low (%u)",
>>>>>> +                     maxphysaddr, machine->ram_size, =
cpu->phys_bits);
>>>>>> +        exit(EXIT_FAILURE);
>>>>>> +    }
>>>>>=20
>>>>> ... I know that this used to be a problem in the past, but =
nowadays we already do have similar checks in place?
>>>>>=20
>>>>> $ ./build/qemu-system-x86_64 -m 4T -machine =
q35,memory-backend=3Dmem0 -object =
memory-backend-ram,id=3Dmem0,size=3D4T,reserve=3Doff
>>>>> qemu-system-x86_64: Address space limit 0xffffffffff < =
0x5077fffffff phys-bits too low (40)
>>>> So you are saying that this is OK and should be allowed? On a 32 =
bit processor that can access only 4G memory, I am spinning up a 10G VM.
>>>=20
>>> Would that 32bit process have PAE (Physical Address Extension) and =
still be able to access that memory?
>> You are sidestepping my point. Sure, we can improve the condition =
check by checking for PAE CPUID etc but that is not the issue I am =
trying too point out. What if the processor did not have PAE? Would we =
allow a VM to have memory size which the processor can=E2=80=99t access? =
There is no such check today it would seem.
>=20
> Indeed, because the implementation for 32bit in pc_max_used_gpa() is =
wrong.
>=20
> Note that for 64bit it does the right thing, even with memory hotplug, =
because the PCI64 hole is placed above the memory device region.
>=20
> So I think we should tackle that via pc_max_used_gpa().
>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 54838c0c41..d187890675 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -908,9 +908,12 @@ static hwaddr pc_max_used_gpa(PCMachineState =
*pcms, uint64_t pci_hole64_size)
> {
>     X86CPU *cpu =3D X86_CPU(first_cpu);
>=20
> -    /* 32-bit systems don't have hole64 thus return max CPU address =
*/
> -    if (cpu->phys_bits <=3D 32) {
> -        return ((hwaddr)1 << cpu->phys_bits) - 1;
> +    /*
> +     * 32-bit systems don't have hole64, but we might have a region =
for
> +     * memory hotplug.
> +     */
> +    if (!(cpu->env.features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM)) {
> +        return pc_pci_hole64_start() - 1;

Ok this is very confusing! I am looking at pc_pci_hole64_start() =
function. I have a few questions =E2=80=A6
(a) pc_get_device_memory_range() returns the size of the device memory =
as the difference between ram_size and maxram_size. But from what I =
understand, ram_size is the actual size of the ram present and =
maxram_size is the max size of ram *after* hot plugging additional =
memory. How can we assume that the additional available space is already =
occupied by hot plugged memory?
(b) Another question is, in pc_pci_hole64_start(), why are we adding =
this size to the start address?

} else if (pcmc->has_reserved_memory && (ms->ram_size < =
ms->maxram_size)) {
	pc_get_device_memory_range(pcms, &hole64_start, &size);
        if (!pcmc->broken_reserved_end) {
            hole64_start +=3D size;

I think this is trying to put the hole after the device memory. But if =
the ram size is <=3Dmaxram_size then the hole is after the above_4G =
memory? Why?

(c) in your above change, what does long mode have anything to do with =
all of this?=20

>     }
>=20
>     return pc_pci_hole64_start() + pci_hole64_size - 1;
>=20
>=20
> That implies:
>=20
> ./build/qemu-system-x86_64 -cpu pentium -m size=3D4G -nodefaults =
-nographic
> qemu-system-x86_64: Address space limit 0xffffffff < 0x13fffffff =
phys-bits too low (32)
>=20
> As we have memory over 4G (due to PCI hole), that would now correctly =
fail.
>=20
> However, what works is:
>=20
> ./build/qemu-system-x86_64 -cpu pentium -m size=3D3G -nodefaults =
-nographic
>=20
>=20
> Weirdly enough, when setting cpu->phys_bits, we take care of PSE36 and =
allow for 36bits in the address space.

Hmm, I see this

 if (env->features[FEAT_1_EDX] & CPUID_PSE36) {
            cpu->phys_bits =3D 36;
        } else {
            cpu->phys_bits =3D 32;
        }

I will send a small patch to add PAE as well to this.=20

>=20
> So what works:
>=20
> ./build/qemu-system-x86_64 -cpu pentium,pse36=3Don -m size=3D32G =
-nodefaults -nographic
>=20
> And what doesn't:
>=20
> ./build/qemu-system-x86_64 -cpu pentium,pse36=3Don -m size=3D64G =
-nodefaults -nographic -S
> qemu-system-x86_64: Address space limit 0xfffffffff < 0x103fffffff =
phys-bits too low (36)
>=20
>=20
> However, we don't seem to have such handling in place for PAE (do we =
have to extend that handling in x86_cpu_realizefn()?). Maybe pae should =
always imply pse36, not sure ...
>=20
> --=20
> Cheers,
>=20
> David / dhildenb
>=20


