Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E207A9286
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 10:16:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjEqH-0006Ww-On; Thu, 21 Sep 2023 04:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qjEqF-0006V8-Gt
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 04:15:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qjEqD-0005Vx-Hl
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 04:15:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695284116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c2RXEpSMKENERLYuduK/r7BXLhInEHY4ZhbCrBNd8Ss=;
 b=Wi3RUjn4HuxdTLdBnC3SmipWYY1CTX49+lH1kl2rRlcz9rsv3K5UIxs1a8OV6n2gw2cxK7
 IoiKNziz+MjtOWcxErLeuTp4eEtsCC4SgstoZ3Ue4aFQhj4CWF4qWUdPMu4f4d3U4K8g+d
 9sIyMDcncMIwnyT+viBmI7xmD6Hvmpk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-F34CBSIfObiShP_MTZuZ1A-1; Thu, 21 Sep 2023 04:15:14 -0400
X-MC-Unique: F34CBSIfObiShP_MTZuZ1A-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-401c19fc097so5414225e9.1
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 01:15:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695284113; x=1695888913;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c2RXEpSMKENERLYuduK/r7BXLhInEHY4ZhbCrBNd8Ss=;
 b=RrUjS791oeLQIDgE7EC0wxnvpNyKXN95AKE/pTdL5kFlaWjcBuAkc08jiXcoIzjrxP
 0CirTUr0L02MOVYS7otBWM43jDUF5FIVcYnGZ7z8JuOcF2w/o4IJSZlzf6oi9qRpl8J4
 vgjbmPwqipIZop3sWzbzSKPGwIIn/ytSGE+826Hk4Y7cd1DpR7iTsB1K3qrVNdoEvhIw
 RkkqeEgZARImynXEfoWfF4EZTnucUEXyJGx1sOFkT46Oo4m9qAlQJOuavJ1Xt6YenPeQ
 Hk+bA54NwLLCTy41xtxk6A1C4Xk8gFAvoFguCzQltp7ah+npUYgsk048gB7JHbe97YgR
 hjiw==
X-Gm-Message-State: AOJu0YyyWfbS+kOkvUxOIJulKUx/lUz2u6W35NljQRMq0OjPE7B3JzlB
 ZaKDtWdihK9wYUNzD94Q3wBSz8qMox8apUxFYxB5GZlQpkmW8GysQF7HixP/U4rIZRVFTB5MZfp
 0eGNZleyiZBAALbc=
X-Received: by 2002:a05:600c:2110:b0:401:bcb4:f133 with SMTP id
 u16-20020a05600c211000b00401bcb4f133mr4585851wml.22.1695284113552; 
 Thu, 21 Sep 2023 01:15:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHx77cQ8y16IC94tMHBeMuob8H59SbOkQgEezQ7xSu6GVAiDdz7Fx9wOazTxCJM1w1S6nSXZA==
X-Received: by 2002:a05:600c:2110:b0:401:bcb4:f133 with SMTP id
 u16-20020a05600c211000b00401bcb4f133mr4585824wml.22.1695284113023; 
 Thu, 21 Sep 2023 01:15:13 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:3c00:9eab:fce5:e6f3:e626?
 (p200300cbc70d3c009eabfce5e6f3e626.dip0.t-ipconnect.de.
 [2003:cb:c70d:3c00:9eab:fce5:e6f3:e626])
 by smtp.gmail.com with ESMTPSA id
 12-20020a05600c240c00b003fc02e8ea68sm4073996wmp.13.2023.09.21.01.15.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Sep 2023 01:15:12 -0700 (PDT)
Message-ID: <9b9e4ee5-7ab3-3c61-8e50-3d3a9533b15b@redhat.com>
Date: Thu, 21 Sep 2023 10:15:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Cc: philmd@linaro.org, qemu-devel@nongnu.org
References: <20230921071755.61081-1-anisinha@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3] hw/i386/pc: improve physical address space bound check
 for 32-bit systems
In-Reply-To: <20230921071755.61081-1-anisinha@redhat.com>
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

On 21.09.23 09:17, Ani Sinha wrote:
> 32-bit systems do not have a reserved memory for hole64 and hotplugging memory
> devices are not supported on those systems. Therefore, the maximum limit of the
> guest physical address in the absence of additional memory devices effectively
> coincides with the end of "above 4G memory space" region. When users configure
> additional memory devices, we need to properly account for the additional device
> memory region so as to find the maximum value of the guest physical address
> and enforce that it is within the physical address space of the processor. For
> 32-bit, this maximum PA will be outside the range of the processor's address
> space.
> 
> With this change, for example, previously this was allowed:
> 
> $ ./qemu-system-x86_64 -cpu pentium -m size=10G
> 
> Now it is no longer allowed:
> 
> $ ./qemu-system-x86_64 -cpu pentium -m size=10G
> qemu-system-x86_64: Address space limit 0xffffffff < 0x2bfffffff phys-bits too low (32)
> 
> For 32-bit, hotplugging additional memory is no longer allowed.

"32-bit without PAE/PSE36"

> 
> $ ./qemu-system-i386 -m size=1G,maxmem=3G,slots=2
> qemu-system-i386: Address space limit 0xffffffff < 0x1ffffffff phys-bits too low (32)
> 

We always place the device memory region above 4G. Without PAE/PSE36, 
you cannot ever possibly make use hotplugged memory, because it would 
reside > 4g.

So while the user could have started that QEMU instance, even with an OS 
that would support memory hotplug, a DIMM above 4G would not have been 
usable.

So we're now properly failing for a setup that doesn't make any sense. 
Good :)

... if someone ever cares about making that work, we would have to let 
the device memory region start below 4g (and obviously, not exceed 4g).


So while

./qemu-system-i386 -m size=1G,maxmem=3G,slots=2

fails (because pentium cannot access that memory), what should work is

./qemu-system-i386 -m size=1G,maxmem=3G,slots=2 -cpu pentium2

or

  ./qemu-system-i386 -m size=1G,maxmem=3G,slots=2 -cpu pentium,pse36=on

Because that CPU could actually address that memory somehow (PAE/PSE36).


So IMHO, we're now forbidding setups that are impossible.

> The above is still allowed for older machine types in order to support
> compatibility. Therefore, this still works:
> 
> $ ./qemu-system-i386 -machine pc-i440fx-8.1 -m size=1G,maxmem=3G,slots=2
> 

Makes sense. (probably nobody cares, but better safe than sorry)

> After calling CPUID with EAX=0x80000001, all AMD64 compliant processors
> have the longmode-capable-bit turned on in the extended feature flags (bit 29)
> in EDX. The absence of CPUID longmode can be used to differentiate between
> 32-bit and 64-bit processors and is the recommended approach. QEMU takes this
> approach elsewhere (for example, please see x86_cpu_realizefn()) and with
> this change, pc_max_used_gpa() also takes the same approach to detect 32-bit
> processors.
> 
> Unit tests are modified to not run those tests that use memory hotplug
> on 32-bit x86 architecture.

We could use a different CPU (pentium2) to still run these tests. 
"pentium2" should work I assume?
[...]

> @@ -907,12 +907,39 @@ static uint64_t pc_get_cxl_range_end(PCMachineState *pcms)
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
> +        if (pcmc->fixed_32bit_mem_addr_check) {
> +            if (pcmc->has_reserved_memory &&
> +                (ms->ram_size < ms->maxram_size)) {
> +                pc_get_device_memory_range(pcms, &devmem_start,
> +                                           &devmem_size);
> +                if (!pcmc->broken_reserved_end) {

I think you can remove that check. "pcmc->fixed_32bit_mem_addr_check && 
pcmc->broken_reserved_end" can never hold at the same time.

broken_reserved_end is only set for QEMU <= 2.4, to work around another 
broken check. pcmc->fixed_32bit_mem_addr_check is only set for 8.2+.

Maybe consider calling "fixed_32bit_mem_addr_check" 
"pcmc->broken_32bit_max_gpa_check" and reverse the logic (treating it 
like broken_reserved_end).


-- 
Cheers,

David / dhildenb


