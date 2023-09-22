Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D882B7AB091
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 13:26:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjeIo-0002Os-JF; Fri, 22 Sep 2023 07:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjeIj-0002Kz-EU
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 07:26:25 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjeIg-0004kQ-2a
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 07:26:25 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3214d4ecd39so1832242f8f.1
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 04:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695381976; x=1695986776; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3f5AAQuDUNgIGq7Ya7PBZKORmhvNYQsT/kGNPGLNH/w=;
 b=wVMy9INyt5YKSHxs0hfMW+tvuK6t7/Fitm3yzCqeUId0Q6rnlWoGNRWfeeRv8TDEGm
 9tc7DJZDvhojfBxMxApKaHldzute42k7KGQ/qauyhPqm1tMeGbRd0yf49dg8mU4rKqpd
 gFtbiiRHqek2L+Hu4DnR/ms/b7z9vPcPevhm7xVYq2Win+gb9scTBhVmMSiCjEsLye3m
 0JBnun6dRzgbAkKHzTRx8cJV5x2EYdd/CsQ4GNO/lW7sYO2cwmPetynkmkw2M6Fw+Fhi
 FY2bPfq5HSF9mq0Ac98a3EmAwHtZL3A0VbIOwC2DPbjG4x5orp02tzMEeGngCUyPawKS
 1CPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695381976; x=1695986776;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3f5AAQuDUNgIGq7Ya7PBZKORmhvNYQsT/kGNPGLNH/w=;
 b=LzogQRX3MEMOe5uXehINLip62OjPifL/35VY7Pnd3ak38+YJc5pbj0BQDa18ZHpYxA
 Ycgn/c2NhkdthOGzbgYLkPYhgWhirgw2qbiaOuhMbCHCeJ3s269etn7zWsvyooT+LhIO
 NXz3Ufu4vpO8kmAFWk3nptKrZAdp1p+lmWRHVYzUdot1aGo0+ny+pTfInnupk9IJsA1N
 284eV2bZ85+Wt+8DHDTeBii1PJqs2Fmrv3i/qyx8QSZqkjWOpHorOjtQ/vxOMbwZZHdD
 t8RMDv1My/kAndr5lKC7wZSaU2L0TfJiq5dfwo+GwdHhdUa4fDc9qATkBp/GiRoLPMEB
 S2ew==
X-Gm-Message-State: AOJu0YxzX/zyfm1DB8y2aLVi+pw/yzSDUhjznA9obSbuJaevhINFsyAL
 n34qrmtlK6SQsNQSGIibc96WPQ==
X-Google-Smtp-Source: AGHT+IGZbXtPh5Wm+QgX1Yt4yG/hCYymc/BVPdTyl+1Qo5JwLQS2E1wvPtEYSp/NanHMJ7Pu0ywU0w==
X-Received: by 2002:a5d:45c4:0:b0:31f:f99c:6009 with SMTP id
 b4-20020a5d45c4000000b0031ff99c6009mr7147654wrs.22.1695381976390; 
 Fri, 22 Sep 2023 04:26:16 -0700 (PDT)
Received: from [192.168.5.175] ([79.95.86.254])
 by smtp.gmail.com with ESMTPSA id
 o7-20020a1c7507000000b004051f8d6207sm4440904wmc.6.2023.09.22.04.26.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Sep 2023 04:26:16 -0700 (PDT)
Message-ID: <60f44bdf-36cc-8402-bfbb-c6a964fe74db@linaro.org>
Date: Fri, 22 Sep 2023 12:42:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v4] hw/i386/pc: improve physical address space bound check
 for 32-bit x86 systems
Content-Language: en-US
To: Ani Sinha <anisinha@redhat.com>, david@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20230922041619.3909-1-anisinha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230922041619.3909-1-anisinha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 22/9/23 06:16, Ani Sinha wrote:
> 32-bit x86 systems do not have a reserved memory for hole64. On those 32-bit
> systems without PSE36 or PAE CPU features, hotplugging memory devices are not
> supported by QEMU as QEMU always places hotplugged memory above 4 GiB boundary
> which is beyond the physical address space of the processor. Linux guests also
> does not support memory hotplug on those systems. Please see Linux
> kernel commit b59d02ed08690 ("mm/memory_hotplug: disable the functionality
> for 32b") for more details.
> 
> Therefore, the maximum limit of the guest physical address in the absence of
> additional memory devices effectively coincides with the end of
> "above 4G memory space" region for 32-bit x86 without PAE/PSE36. When users
> configure additional memory devices, after properly accounting for the
> additional device memory region to find the maximum value of the guest
> physical address, the address will be outside the range of the processor's
> physical address space.
> 
> This change adds improvements to take above into consideration.
> 
> For example, previously this was allowed:
> 
> $ ./qemu-system-x86_64 -cpu pentium -m size=10G
> 
> With this change now it is no longer allowed:
> 
> $ ./qemu-system-x86_64 -cpu pentium -m size=10G
> qemu-system-x86_64: Address space limit 0xffffffff < 0x2bfffffff phys-bits too low (32)
> 
> However, the following are allowed since on both cases physical address
> space of the processor is 36 bits:
> 
> $ ./qemu-system-x86_64 -cpu pentium2 -m size=10G
> $ ./qemu-system-x86_64 -cpu pentium,pse36=on -m size=10G
> 
> For 32-bit, without PAE/PSE36, hotplugging additional memory is no longer allowed.
> 
> $ ./qemu-system-i386 -m size=1G,maxmem=3G,slots=2
> qemu-system-i386: Address space limit 0xffffffff < 0x1ffffffff phys-bits too low (32)
> $ ./qemu-system-i386 -machine q35 -m size=1G,maxmem=3G,slots=2
> qemu-system-i386: Address space limit 0xffffffff < 0x1ffffffff phys-bits too low (32)
> 
> A new compatibility flag is introduced to make sure pc_max_used_gpa() keeps
> returning the old value for machines 8.1 and older.
> Therefore, the above is still allowed for older machine types in order to support
> compatibility. Hence, the following still works:
> 
> $ ./qemu-system-i386 -machine pc-i440fx-8.1 -m size=1G,maxmem=3G,slots=2
> $ ./qemu-system-i386 -machine pc-q35-8.1 -m size=1G,maxmem=3G,slots=2
> 
> Further, following is also allowed as with PSE36, the processor has 36-bit
> address space:
> 
> $ ./qemu-system-i386 -cpu 486,pse36=on -m size=1G,maxmem=3G,slots=2
> 
> After calling CPUID with EAX=0x80000001, all AMD64 compliant processors
> have the longmode-capable-bit turned on in the extended feature flags (bit 29)
> in EDX. The absence of CPUID longmode can be used to differentiate between
> 32-bit and 64-bit processors and is the recommended approach. QEMU takes this
> approach elsewhere (for example, please see x86_cpu_realizefn()), With
> this change, pc_max_used_gpa() also uses the same method to detect 32-bit
> processors.
> 
> Unit tests are modified to not run 32-bit x86 tests that use memory hotplug.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>   hw/i386/pc.c                   | 31 ++++++++++++++++++++++++++++---
>   hw/i386/pc_piix.c              |  4 ++++
>   hw/i386/pc_q35.c               |  2 ++
>   include/hw/i386/pc.h           |  6 ++++++
>   tests/qtest/bios-tables-test.c | 26 ++++++++++++++++++--------
>   tests/qtest/numa-test.c        |  7 ++++++-
>   6 files changed, 64 insertions(+), 12 deletions(-)


> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 54838c0c41..2a689cf0bd 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -907,12 +907,37 @@ static uint64_t pc_get_cxl_range_end(PCMachineState *pcms)
>   static hwaddr pc_max_used_gpa(PCMachineState *pcms, uint64_t pci_hole64_size)
>   {
>       X86CPU *cpu = X86_CPU(first_cpu);
> +    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
> +    MachineState *ms = MACHINE(pcms);
> +    uint64_t devmem_start = 0;
> +    ram_addr_t devmem_size = 0;
>   
> -    /* 32-bit systems don't have hole64 thus return max CPU address */
> -    if (cpu->phys_bits <= 32) {
> -        return ((hwaddr)1 << cpu->phys_bits) - 1;
> +    /*
> +     * 32-bit systems don't have hole64 but they might have a region for
> +     * memory devices. Even if additional hotplugged memory devices might
> +     * not be usable by most guest OSes, we need to still consider them for
> +     * calculating the highest possible GPA so that we can properly report
> +     * if someone configures them on a CPU that cannot possibly address them.
> +     */
> +    if (!(cpu->env.features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM)) {
> +        /* 32-bit systems */
> +        if (!pcmc->broken_32bit_mem_addr_check) {

Nitpicking, code is simplified if you invert this condition check.

> +            if (pcmc->has_reserved_memory &&
> +                (ms->ram_size < ms->maxram_size)) {
> +                pc_get_device_memory_range(pcms, &devmem_start,
> +                                           &devmem_size);
> +                devmem_start += devmem_size;
> +                return devmem_start - 1;
> +            } else {
> +                return pc_above_4g_end(pcms) - 1;
> +            }
> +        } else {
> +            /* old value for compatibility reasons */
> +            return ((hwaddr)1 << cpu->phys_bits) - 1;

Since you change this line, can we convert to
MAKE_64BIT_MASK(0, cpu->phys_bits) ?

> +        }
>       }
>   
> +    /* 64-bit systems */
>       return pc_pci_hole64_start() + pci_hole64_size - 1;
>   }


