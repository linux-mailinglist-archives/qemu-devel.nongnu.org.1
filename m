Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D84737AB275
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 14:58:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjfiX-0001uz-6x; Fri, 22 Sep 2023 08:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjfiU-0001t9-Gx
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 08:57:06 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjfiS-0008KZ-8S
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 08:57:06 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-401da71b83cso21556915e9.2
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 05:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695387422; x=1695992222; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aaRZ4gWxBxEv/zOtSxsznP9lnRBoDGlWEcki4Tf8R5o=;
 b=PTWKILxVdapehXcYSgsW3jNjUtRhfM6jyZZECl1kH4bs63hHHzpKw0hiWk8gIr565D
 B9gWEinrKLGFnnDzUrZU269OTn+CzBV60jw6PDMPxZeA2krdmWj6gRlAh72T8UF6xPhz
 EFMLZxoDvejCntDH+CaklfzpXEJ7ZKpjsi/HshAKslmvqWSOW88bvwVOu3k6MDZZh+sR
 cZE3xzgRUJnCPZ325JGQZi2Jiqu3H4vdSDyeRS0lXICeehComeu8D3s0AuUHogwnGBhg
 SodCgHzNF7HANzFmBwWqxU1RWGJyHkpl0Ct0xbhhB+k9cPrtrvJOOTKxHgXHtVlxl9dO
 aP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695387422; x=1695992222;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aaRZ4gWxBxEv/zOtSxsznP9lnRBoDGlWEcki4Tf8R5o=;
 b=Tj2BZLGpH4IXOFlXeCc4x4iTksyS4suvXghPBD+N2EU/lNLh61+M2nU4Ink0epgS7x
 E7lmOzZmck/xDxVaz6zBeadDnIdKf0NTtDcS1lQ/ka+c41+42fceRyCg1p0ZTaKINJnt
 78LnKprCKFlNeA+JPML9OCU+JTHTQmFjffVofXIOr9CQMrkXB/ivdY97n1CS98O/EHVE
 ZouK7jEqM7ySxEI1jrVwUIG5ci/LnHwsNaYRpWO+38v21IVAM4yNcMA8jWaDXNWA0W14
 rmTaJIl7ewOpP9l8C9oTVwkKtJ4y6EzNmcM188UmhVRXDvJLu6cyxFWy2sQbpVlkdS5E
 NJyg==
X-Gm-Message-State: AOJu0YzJ4Rvjn5U6x+HcEOuy0Y08B61V+ZGZIGHIWAqRnZ46RM3vLInl
 z3eL6V3TQZoXpq1edt8wBWAVoA==
X-Google-Smtp-Source: AGHT+IFg7enIIe/scXIhiEMMVIHBKuGBCQXtsut8p97gCdOcXioE0ESUItL5W8bU6U7aJe6pa9t5iQ==
X-Received: by 2002:a05:600c:1da0:b0:405:3e92:76db with SMTP id
 p32-20020a05600c1da000b004053e9276dbmr1474884wms.5.1695387421580; 
 Fri, 22 Sep 2023 05:57:01 -0700 (PDT)
Received: from [192.168.19.175] ([77.205.117.247])
 by smtp.gmail.com with ESMTPSA id
 m20-20020a05600c281400b003fe1630a8f0sm7445121wmb.24.2023.09.22.05.57.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Sep 2023 05:57:01 -0700 (PDT)
Message-ID: <0c6ec4bc-eba5-1f9b-1173-f06867a4fff5@linaro.org>
Date: Fri, 22 Sep 2023 14:56:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v4] hw/i386/pc: improve physical address space bound check
 for 32-bit x86 systems
Content-Language: en-US
To: Ani Sinha <anisinha@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org
References: <20230922041619.3909-1-anisinha@redhat.com>
 <60f44bdf-36cc-8402-bfbb-c6a964fe74db@linaro.org>
 <7A557569-58A2-4288-A7DE-803E9EA88797@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <7A557569-58A2-4288-A7DE-803E9EA88797@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 22/9/23 14:00, Ani Sinha wrote:
> 
> 
>> On 22-Sep-2023, at 4:12 PM, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> On 22/9/23 06:16, Ani Sinha wrote:
>>> 32-bit x86 systems do not have a reserved memory for hole64. On those 32-bit
>>> systems without PSE36 or PAE CPU features, hotplugging memory devices are not
>>> supported by QEMU as QEMU always places hotplugged memory above 4 GiB boundary
>>> which is beyond the physical address space of the processor. Linux guests also
>>> does not support memory hotplug on those systems. Please see Linux
>>> kernel commit b59d02ed08690 ("mm/memory_hotplug: disable the functionality
>>> for 32b") for more details.
>>> Therefore, the maximum limit of the guest physical address in the absence of
>>> additional memory devices effectively coincides with the end of
>>> "above 4G memory space" region for 32-bit x86 without PAE/PSE36. When users
>>> configure additional memory devices, after properly accounting for the
>>> additional device memory region to find the maximum value of the guest
>>> physical address, the address will be outside the range of the processor's
>>> physical address space.
>>> This change adds improvements to take above into consideration.
>>> For example, previously this was allowed:
>>> $ ./qemu-system-x86_64 -cpu pentium -m size=10G
>>> With this change now it is no longer allowed:
>>> $ ./qemu-system-x86_64 -cpu pentium -m size=10G
>>> qemu-system-x86_64: Address space limit 0xffffffff < 0x2bfffffff phys-bits too low (32)
>>> However, the following are allowed since on both cases physical address
>>> space of the processor is 36 bits:
>>> $ ./qemu-system-x86_64 -cpu pentium2 -m size=10G
>>> $ ./qemu-system-x86_64 -cpu pentium,pse36=on -m size=10G
>>> For 32-bit, without PAE/PSE36, hotplugging additional memory is no longer allowed.
>>> $ ./qemu-system-i386 -m size=1G,maxmem=3G,slots=2
>>> qemu-system-i386: Address space limit 0xffffffff < 0x1ffffffff phys-bits too low (32)
>>> $ ./qemu-system-i386 -machine q35 -m size=1G,maxmem=3G,slots=2
>>> qemu-system-i386: Address space limit 0xffffffff < 0x1ffffffff phys-bits too low (32)
>>> A new compatibility flag is introduced to make sure pc_max_used_gpa() keeps
>>> returning the old value for machines 8.1 and older.
>>> Therefore, the above is still allowed for older machine types in order to support
>>> compatibility. Hence, the following still works:
>>> $ ./qemu-system-i386 -machine pc-i440fx-8.1 -m size=1G,maxmem=3G,slots=2
>>> $ ./qemu-system-i386 -machine pc-q35-8.1 -m size=1G,maxmem=3G,slots=2
>>> Further, following is also allowed as with PSE36, the processor has 36-bit
>>> address space:
>>> $ ./qemu-system-i386 -cpu 486,pse36=on -m size=1G,maxmem=3G,slots=2
>>> After calling CPUID with EAX=0x80000001, all AMD64 compliant processors
>>> have the longmode-capable-bit turned on in the extended feature flags (bit 29)
>>> in EDX. The absence of CPUID longmode can be used to differentiate between
>>> 32-bit and 64-bit processors and is the recommended approach. QEMU takes this
>>> approach elsewhere (for example, please see x86_cpu_realizefn()), With
>>> this change, pc_max_used_gpa() also uses the same method to detect 32-bit
>>> processors.
>>> Unit tests are modified to not run 32-bit x86 tests that use memory hotplug.
>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>> ---
>>>   hw/i386/pc.c                   | 31 ++++++++++++++++++++++++++++---
>>>   hw/i386/pc_piix.c              |  4 ++++
>>>   hw/i386/pc_q35.c               |  2 ++
>>>   include/hw/i386/pc.h           |  6 ++++++
>>>   tests/qtest/bios-tables-test.c | 26 ++++++++++++++++++--------
>>>   tests/qtest/numa-test.c        |  7 ++++++-
>>>   6 files changed, 64 insertions(+), 12 deletions(-)
>>
>>
>>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>>> index 54838c0c41..2a689cf0bd 100644
>>> --- a/hw/i386/pc.c
>>> +++ b/hw/i386/pc.c
>>> @@ -907,12 +907,37 @@ static uint64_t pc_get_cxl_range_end(PCMachineState *pcms)
>>>   static hwaddr pc_max_used_gpa(PCMachineState *pcms, uint64_t pci_hole64_size)
>>>   {
>>>       X86CPU *cpu = X86_CPU(first_cpu);
>>> +    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
>>> +    MachineState *ms = MACHINE(pcms);
>>> +    uint64_t devmem_start = 0;
>>> +    ram_addr_t devmem_size = 0;
>>>   -    /* 32-bit systems don't have hole64 thus return max CPU address */
>>> -    if (cpu->phys_bits <= 32) {
>>> -        return ((hwaddr)1 << cpu->phys_bits) - 1;
>>> +    /*
>>> +     * 32-bit systems don't have hole64 but they might have a region for
>>> +     * memory devices. Even if additional hotplugged memory devices might
>>> +     * not be usable by most guest OSes, we need to still consider them for
>>> +     * calculating the highest possible GPA so that we can properly report
>>> +     * if someone configures them on a CPU that cannot possibly address them.
>>> +     */
>>> +    if (!(cpu->env.features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM)) {
>>> +        /* 32-bit systems */
>>> +        if (!pcmc->broken_32bit_mem_addr_check) {
>>
>> Nitpicking, code is simplified if you invert this condition check.
> 
> Maybe it reads better, but simplified? .. I am not so sure.

As:

-- >8 --
@@ -907,12 +907,35 @@ static uint64_t 
pc_get_cxl_range_end(PCMachineState *pcms)
  static hwaddr pc_max_used_gpa(PCMachineState *pcms, uint64_t 
pci_hole64_size)
  {
      X86CPU *cpu = X86_CPU(first_cpu);
+    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    MachineState *ms = MACHINE(pcms);

-    /* 32-bit systems don't have hole64 thus return max CPU address */
-    if (cpu->phys_bits <= 32) {
-        return ((hwaddr)1 << cpu->phys_bits) - 1;
+    /*
+     * 32-bit systems don't have hole64 but they might have a region for
+     * memory devices. Even if additional hotplugged memory devices might
+     * not be usable by most guest OSes, we need to still consider them for
+     * calculating the highest possible GPA so that we can properly report
+     * if someone configures them on a CPU that cannot possibly address 
them.
+     */
+    if (!(cpu->env.features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM)) {
+        /* 32-bit systems */
+        if (pcmc->broken_32bit_mem_addr_check) {
+            /* old value for compatibility reasons */
+            return ((hwaddr)1 << cpu->phys_bits) - 1;
+        }
+        if (pcmc->has_reserved_memory && (ms->ram_size < 
ms->maxram_size)) {
+            uint64_t devmem_start = 0;
+            ram_addr_t devmem_size = 0;
+
+            pc_get_device_memory_range(pcms, &devmem_start, &devmem_size);
+            devmem_start += devmem_size;
+
+            return devmem_start - 1;
+        }
+        return pc_above_4g_end(pcms) - 1;
      }

+    /* 64-bit systems */
      return pc_pci_hole64_start() + pci_hole64_size - 1;
  }
---

But then even simpler (to review):

-- >8 --
@@ -907,13 +907,35 @@ static uint64_t 
pc_get_cxl_range_end(PCMachineState *pcms)
  static hwaddr pc_max_used_gpa(PCMachineState *pcms, uint64_t 
pci_hole64_size)
  {
      X86CPU *cpu = X86_CPU(first_cpu);
+    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    MachineState *ms = MACHINE(pcms);

-    /* 32-bit systems don't have hole64 thus return max CPU address */
-    if (cpu->phys_bits <= 32) {
-        return ((hwaddr)1 << cpu->phys_bits) - 1;
+    if (cpu->env.features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
+        /* 64-bit systems */
+        return pc_pci_hole64_start() + pci_hole64_size - 1;
      }

-    return pc_pci_hole64_start() + pci_hole64_size - 1;
+    /*
+     * 32-bit systems don't have hole64 but they might have a region for
+     * memory devices. Even if additional hotplugged memory devices might
+     * not be usable by most guest OSes, we need to still consider them for
+     * calculating the highest possible GPA so that we can properly report
+     * if someone configures them on a CPU that cannot possibly address 
them.
+     */
+    if (pcmc->broken_32bit_mem_addr_check) {
+        /* old value for compatibility reasons */
+        return ((hwaddr)1 << cpu->phys_bits) - 1;
+    }
+    if (pcmc->has_reserved_memory && (ms->ram_size < ms->maxram_size)) {
+        uint64_t devmem_start = 0;
+        ram_addr_t devmem_size = 0;
+
+        pc_get_device_memory_range(pcms, &devmem_start, &devmem_size);
+        devmem_start += devmem_size;
+
+        return devmem_start - 1;
+    }
+    return pc_above_4g_end(pcms) - 1;
  }
---

Personally I'd do it in 2 steps, first invert the if statement:

-- >8 --
@@ -908,12 +908,13 @@ static hwaddr pc_max_used_gpa(PCMachineState 
*pcms, uint64_t pci_hole64_size)
  {
      X86CPU *cpu = X86_CPU(first_cpu);

-    /* 32-bit systems don't have hole64 thus return max CPU address */
-    if (cpu->phys_bits <= 32) {
-        return ((hwaddr)1 << cpu->phys_bits) - 1;
+    if (cpu->phys_bits > 32) {
+        /* 64-bit systems */
+        return pc_pci_hole64_start() + pci_hole64_size - 1;
      }

-    return pc_pci_hole64_start() + pci_hole64_size - 1;
+    /* 32-bit systems don't have hole64 thus return max CPU address */
+    return ((hwaddr)1 << cpu->phys_bits) - 1;
  }
---

Then your patch as:

-- >8 --
@@ -907,14 +907,35 @@ static uint64_t 
pc_get_cxl_range_end(PCMachineState *pcms)
  static hwaddr pc_max_used_gpa(PCMachineState *pcms, uint64_t 
pci_hole64_size)
  {
      X86CPU *cpu = X86_CPU(first_cpu);
+    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    MachineState *ms = MACHINE(pcms);

-    if (cpu->phys_bits > 32) {
+    if (cpu->env.features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
          /* 64-bit systems */
          return pc_pci_hole64_start() + pci_hole64_size - 1;
      }

-    /* 32-bit systems don't have hole64 thus return max CPU address */
-    return ((hwaddr)1 << cpu->phys_bits) - 1;
+    /*
+     * 32-bit systems don't have hole64 but they might have a region for
+     * memory devices. Even if additional hotplugged memory devices might
+     * not be usable by most guest OSes, we need to still consider them for
+     * calculating the highest possible GPA so that we can properly report
+     * if someone configures them on a CPU that cannot possibly address 
them.
+     */
+    if (pcmc->broken_32bit_mem_addr_check) {
+        /* old value for compatibility reasons */
+        return ((hwaddr)1 << cpu->phys_bits) - 1;
+    }
+    if (pcmc->has_reserved_memory && (ms->ram_size < ms->maxram_size)) {
+        uint64_t devmem_start = 0;
+        ram_addr_t devmem_size = 0;
+
+        pc_get_device_memory_range(pcms, &devmem_start, &devmem_size);
+        devmem_start += devmem_size;
+
+        return devmem_start - 1;
+    }
+    return pc_above_4g_end(pcms) - 1;
  }
---

> 
>>
>>> +            if (pcmc->has_reserved_memory &&
>>> +                (ms->ram_size < ms->maxram_size)) {
>>> +                pc_get_device_memory_range(pcms, &devmem_start,
>>> +                                           &devmem_size);
>>> +                devmem_start += devmem_size;
>>> +                return devmem_start - 1;
>>> +            } else {
>>> +                return pc_above_4g_end(pcms) - 1;
>>> +            }
>>> +        } else {
>>> +            /* old value for compatibility reasons */
>>> +            return ((hwaddr)1 << cpu->phys_bits) - 1;

Left shifting by N and removing 1 makes a mask of N bits,
but I had to do the logical operation mentally to figure it out,

>>
>> Since you change this line, can we convert to
>> MAKE_64BIT_MASK(0, cpu->phys_bits) ?

while here this macro says "make a mask" without having to look
at the definition.

Anyhow as I said, "nitpicking...".

> 
> Doesn’t the existing code reads better? Assuming that the macro does exactly the same thing, one has to still look up the definition. And
> 
>   (((~0ULL) >> (64 - (length))) << (shift))
> 
> Is such a brain twister :-)
> 
>>
>>> +        }
>>>       }
>>>   +    /* 64-bit systems */
>>>       return pc_pci_hole64_start() + pci_hole64_size - 1;
>>>   }
> 


