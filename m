Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FD87AB688
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 18:56:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjjRL-0003OW-2X; Fri, 22 Sep 2023 12:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjjRJ-0003OG-Hh
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 12:55:37 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjjRF-0000qm-U1
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 12:55:37 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4053d53a1bfso10875085e9.1
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 09:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695401731; x=1696006531; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BwtF5oYud9+b38UJO/4TUjmY3WPCod0A4nR2Ti+oLZc=;
 b=VrV4g0uHWsM6R71X0ECqghrRM98SpUJEEzNSsZpuKJjtMC5A3BCSeM6BPgyPbHM5U3
 E3T2K0jAk8O6t0H/Nrw/tUjxZ0Hhug7uhvWrheQTsHiOBtG9BIsiiqACiTZj0lN0zZR4
 fTVZG+OYsEm47ODu8LnBCutcDS/Bc0XM3BqL3vPQjq7oYOOa1I08Tt+wvEBOfPOTL1ob
 nE9K6AGjZG2R1+NDC8tm1GpHtyIOS5e6aNUQOCEpvSp6Eg/Xf4VCnaasu0uloNh6xeJU
 N6GJjf+m1tM7o2N5+f2e9lPmFtQfls6T5xnQrPd8msC8nnEZ6NjW2jfG1aZnWSIHCCbn
 +Cug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695401731; x=1696006531;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BwtF5oYud9+b38UJO/4TUjmY3WPCod0A4nR2Ti+oLZc=;
 b=snAjeg+JeFzGegMEfDORFGx3uB/hyqvCofb+0MbNLpfnhF8nn9UH/gIlb5dep5aXE4
 k1WpiKeL2ZF+fDQeZWyIuP3P4rhW1K9J2daBzZodDe2ahUTAtc5MHD+AWocNE/GEH0fu
 /t46zFx63BkvVqjRZ95KYDnOLg8w4/V4YxZC9/JcuVsBDe5SPFAXbyxmsSNyX8jOt+mV
 ks+ShIpJMWUjqjTSOA2CiHYuVnxd+pXb4n6mv5OxSz7uqV7wR8/vwKbUnw9nryZvsB+R
 vf6YnBahAMSLwMChFhZHXXbzAkxmBJTQhhHinzjiJnEaA0c31DWZMwAp5b2RJFSVb9iz
 2b7A==
X-Gm-Message-State: AOJu0YxKFeP3O+erJg2q29gaND23hN0sMMc8QyPsq+lmMADBo34+LNiZ
 hTyOmBZBpSb/47w1wED/0FgU8w==
X-Google-Smtp-Source: AGHT+IHzeBkrJJTIcJnUrZ3VScxJAcXfZ5Sg35xrIXf89SMaB/40cRrZrDp6UBUOfh4yTboKILfh/A==
X-Received: by 2002:a5d:4e91:0:b0:31a:d6cb:7f9d with SMTP id
 e17-20020a5d4e91000000b0031ad6cb7f9dmr252474wru.24.1695401731326; 
 Fri, 22 Sep 2023 09:55:31 -0700 (PDT)
Received: from [192.168.200.175] (93.red-88-28-0.dynamicip.rima-tde.net.
 [88.28.0.93]) by smtp.gmail.com with ESMTPSA id
 y2-20020adffa42000000b0031423a8f4f7sm4932646wrr.56.2023.09.22.09.55.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Sep 2023 09:55:30 -0700 (PDT)
Message-ID: <4535dfe6-a8cd-65e5-3079-498d04233750@linaro.org>
Date: Fri, 22 Sep 2023 18:55:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v6] hw/i386/pc: improve physical address space bound check
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
References: <20230922160413.165702-1-anisinha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230922160413.165702-1-anisinha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 22/9/23 18:04, Ani Sinha wrote:
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
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>   hw/i386/pc.c                   | 32 +++++++++++++++++++++++++++++---
>   hw/i386/pc_piix.c              |  4 ++++
>   hw/i386/pc_q35.c               |  2 ++
>   include/hw/i386/pc.h           |  6 ++++++
>   tests/qtest/bios-tables-test.c | 26 ++++++++++++++++++--------
>   tests/qtest/numa-test.c        |  7 ++++++-
>   6 files changed, 65 insertions(+), 12 deletions(-)
> 
> changelog:
> v6: more code messaging. incorporated another of phil's suggestions.

Thank you Ani, appreciated!

> v5: addressed phil's suggestions in code reorg to make it cleaner.
> v4: address comments from v3. Fix a bug where compat knob was absent
> from q35 machines. Commit message adjustment.
> v3: still accounting for additional memory device region above 4G.
> unit tests fixed (not running for 32-bit where mem hotplug is used).
> v2: removed memory hotplug region from max_gpa. added compat knobs.


