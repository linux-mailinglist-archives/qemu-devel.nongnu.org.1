Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD6C7AB199
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 14:02:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjeq3-0006bk-7H; Fri, 22 Sep 2023 08:00:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qjeq1-0006Zj-1T
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 08:00:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qjepy-0003Km-WE
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 08:00:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695384046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F8TaEiqQpLPCJRxQTGdoDtkGxRtZlp4gpOwJvjbQkXw=;
 b=VearFW1Fe34xs7zbP2pfCEuSuUqPVbwyBo+QvpUH06v15nJ6v4jyj+FH7fBFwt1dH6siY4
 e8NlQbEn0z3ZApFyLAruOk6b9eft8O5A3zMP+HyngpDV1GoFKv5GOY4C3cTeZukAYsEzlg
 3YwBEV+tdhiyhWMzwURfL2H7KeMMaYs=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-FgQAYGBAPDWc8tgRj8StPA-1; Fri, 22 Sep 2023 08:00:44 -0400
X-MC-Unique: FgQAYGBAPDWc8tgRj8StPA-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1c41392a0a2so16474815ad.0
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 05:00:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695384043; x=1695988843;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F8TaEiqQpLPCJRxQTGdoDtkGxRtZlp4gpOwJvjbQkXw=;
 b=V9SyKOyJnWRIbRmkVDjGOKr+8A/INFYjQLj/bofWeIWn3h/964KYKk5mt0RvnZBLfw
 KGUwY5luRF1K4s1BEp3i3yT/+O4O77oejVpoYJN4Kryy0kEiUIDDK4D18iKygew5dRs2
 CTBjFkMv6yoS0EgmhNMvSNSeY6McGKsLBDCwtRkpde3CFxHDZ12sHtlB8nfj7388ahLf
 gPQ8Zq3ojfugi43KiVkJXC1DCB+htgQNoBKIJyk0XSffAaJy7ZyO/bfjGX3AnkmnHEpM
 vaAp25pxVHH2DRs1hEUGNRG/NUNcPCpiGSHU8k+xkfaylBna9VaPDQd1E4SdRtDboImV
 OCig==
X-Gm-Message-State: AOJu0YwbHM+7wO8JxEcEwqstChpyHo7xAnFvzun/NaEBs2hfKbYXG15B
 +cC/uXSQNQy3MibtpfN3Xii55ddx4VCp6nGUl7PdtuTuI/kCkSI53PvDbv5gQ2iXbueTwjpZ00w
 BM88dqJexxRykwJU=
X-Received: by 2002:a17:903:1252:b0:1bc:6861:d746 with SMTP id
 u18-20020a170903125200b001bc6861d746mr8612784plh.58.1695384043429; 
 Fri, 22 Sep 2023 05:00:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHv5UzQHWd9LfEr1HLio+15IGjmtPOPdrB9PBiw/GKXHR+HiZfLGaoP+CVBniLZ+Ui30y8oNg==
X-Received: by 2002:a17:903:1252:b0:1bc:6861:d746 with SMTP id
 u18-20020a170903125200b001bc6861d746mr8612741plh.58.1695384042897; 
 Fri, 22 Sep 2023 05:00:42 -0700 (PDT)
Received: from smtpclient.apple ([116.73.132.49])
 by smtp.gmail.com with ESMTPSA id
 w12-20020a170902e88c00b001c55e13bf39sm3266175plg.275.2023.09.22.05.00.38
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Sep 2023 05:00:42 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PATCH v4] hw/i386/pc: improve physical address space bound check
 for 32-bit x86 systems
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <60f44bdf-36cc-8402-bfbb-c6a964fe74db@linaro.org>
Date: Fri, 22 Sep 2023 17:30:37 +0530
Cc: David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7A557569-58A2-4288-A7DE-803E9EA88797@redhat.com>
References: <20230922041619.3909-1-anisinha@redhat.com>
 <60f44bdf-36cc-8402-bfbb-c6a964fe74db@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 22-Sep-2023, at 4:12 PM, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> On 22/9/23 06:16, Ani Sinha wrote:
>> 32-bit x86 systems do not have a reserved memory for hole64. On those =
32-bit
>> systems without PSE36 or PAE CPU features, hotplugging memory devices =
are not
>> supported by QEMU as QEMU always places hotplugged memory above 4 GiB =
boundary
>> which is beyond the physical address space of the processor. Linux =
guests also
>> does not support memory hotplug on those systems. Please see Linux
>> kernel commit b59d02ed08690 ("mm/memory_hotplug: disable the =
functionality
>> for 32b") for more details.
>> Therefore, the maximum limit of the guest physical address in the =
absence of
>> additional memory devices effectively coincides with the end of
>> "above 4G memory space" region for 32-bit x86 without PAE/PSE36. When =
users
>> configure additional memory devices, after properly accounting for =
the
>> additional device memory region to find the maximum value of the =
guest
>> physical address, the address will be outside the range of the =
processor's
>> physical address space.
>> This change adds improvements to take above into consideration.
>> For example, previously this was allowed:
>> $ ./qemu-system-x86_64 -cpu pentium -m size=3D10G
>> With this change now it is no longer allowed:
>> $ ./qemu-system-x86_64 -cpu pentium -m size=3D10G
>> qemu-system-x86_64: Address space limit 0xffffffff < 0x2bfffffff =
phys-bits too low (32)
>> However, the following are allowed since on both cases physical =
address
>> space of the processor is 36 bits:
>> $ ./qemu-system-x86_64 -cpu pentium2 -m size=3D10G
>> $ ./qemu-system-x86_64 -cpu pentium,pse36=3Don -m size=3D10G
>> For 32-bit, without PAE/PSE36, hotplugging additional memory is no =
longer allowed.
>> $ ./qemu-system-i386 -m size=3D1G,maxmem=3D3G,slots=3D2
>> qemu-system-i386: Address space limit 0xffffffff < 0x1ffffffff =
phys-bits too low (32)
>> $ ./qemu-system-i386 -machine q35 -m size=3D1G,maxmem=3D3G,slots=3D2
>> qemu-system-i386: Address space limit 0xffffffff < 0x1ffffffff =
phys-bits too low (32)
>> A new compatibility flag is introduced to make sure pc_max_used_gpa() =
keeps
>> returning the old value for machines 8.1 and older.
>> Therefore, the above is still allowed for older machine types in =
order to support
>> compatibility. Hence, the following still works:
>> $ ./qemu-system-i386 -machine pc-i440fx-8.1 -m =
size=3D1G,maxmem=3D3G,slots=3D2
>> $ ./qemu-system-i386 -machine pc-q35-8.1 -m size=3D1G,maxmem=3D3G,slots=
=3D2
>> Further, following is also allowed as with PSE36, the processor has =
36-bit
>> address space:
>> $ ./qemu-system-i386 -cpu 486,pse36=3Don -m size=3D1G,maxmem=3D3G,slots=
=3D2
>> After calling CPUID with EAX=3D0x80000001, all AMD64 compliant =
processors
>> have the longmode-capable-bit turned on in the extended feature flags =
(bit 29)
>> in EDX. The absence of CPUID longmode can be used to differentiate =
between
>> 32-bit and 64-bit processors and is the recommended approach. QEMU =
takes this
>> approach elsewhere (for example, please see x86_cpu_realizefn()), =
With
>> this change, pc_max_used_gpa() also uses the same method to detect =
32-bit
>> processors.
>> Unit tests are modified to not run 32-bit x86 tests that use memory =
hotplug.
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> ---
>>  hw/i386/pc.c                   | 31 ++++++++++++++++++++++++++++---
>>  hw/i386/pc_piix.c              |  4 ++++
>>  hw/i386/pc_q35.c               |  2 ++
>>  include/hw/i386/pc.h           |  6 ++++++
>>  tests/qtest/bios-tables-test.c | 26 ++++++++++++++++++--------
>>  tests/qtest/numa-test.c        |  7 ++++++-
>>  6 files changed, 64 insertions(+), 12 deletions(-)
>=20
>=20
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 54838c0c41..2a689cf0bd 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -907,12 +907,37 @@ static uint64_t =
pc_get_cxl_range_end(PCMachineState *pcms)
>>  static hwaddr pc_max_used_gpa(PCMachineState *pcms, uint64_t =
pci_hole64_size)
>>  {
>>      X86CPU *cpu =3D X86_CPU(first_cpu);
>> +    PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
>> +    MachineState *ms =3D MACHINE(pcms);
>> +    uint64_t devmem_start =3D 0;
>> +    ram_addr_t devmem_size =3D 0;
>>  -    /* 32-bit systems don't have hole64 thus return max CPU address =
*/
>> -    if (cpu->phys_bits <=3D 32) {
>> -        return ((hwaddr)1 << cpu->phys_bits) - 1;
>> +    /*
>> +     * 32-bit systems don't have hole64 but they might have a region =
for
>> +     * memory devices. Even if additional hotplugged memory devices =
might
>> +     * not be usable by most guest OSes, we need to still consider =
them for
>> +     * calculating the highest possible GPA so that we can properly =
report
>> +     * if someone configures them on a CPU that cannot possibly =
address them.
>> +     */
>> +    if (!(cpu->env.features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM)) {
>> +        /* 32-bit systems */
>> +        if (!pcmc->broken_32bit_mem_addr_check) {
>=20
> Nitpicking, code is simplified if you invert this condition check.

Maybe it reads better, but simplified? .. I am not so sure.

>=20
>> +            if (pcmc->has_reserved_memory &&
>> +                (ms->ram_size < ms->maxram_size)) {
>> +                pc_get_device_memory_range(pcms, &devmem_start,
>> +                                           &devmem_size);
>> +                devmem_start +=3D devmem_size;
>> +                return devmem_start - 1;
>> +            } else {
>> +                return pc_above_4g_end(pcms) - 1;
>> +            }
>> +        } else {
>> +            /* old value for compatibility reasons */
>> +            return ((hwaddr)1 << cpu->phys_bits) - 1;
>=20
> Since you change this line, can we convert to
> MAKE_64BIT_MASK(0, cpu->phys_bits) ?

Doesn=E2=80=99t the existing code reads better? Assuming that the macro =
does exactly the same thing, one has to still look up the definition. =
And=20

 (((~0ULL) >> (64 - (length))) << (shift))

Is such a brain twister :-)=20

>=20
>> +        }
>>      }
>>  +    /* 64-bit systems */
>>      return pc_pci_hole64_start() + pci_hole64_size - 1;
>>  }


