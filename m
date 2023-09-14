Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 106D579FE93
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 10:38:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qghrG-00081O-Fl; Thu, 14 Sep 2023 04:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qghrB-00081D-Kt
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 04:37:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qghr9-0005Jv-EW
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 04:37:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694680666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G+otnmZp2gLKXSUMdSO4g+qnu7nKOs0lNDa7t5xSwqE=;
 b=dZK7GiNIN2j8FM9XY3Tdu6Zn2ba6OJOI23qGP7ua2Vr+2uz7DGZ0OIEDbgXZD2O6Qjb9vL
 APx0AuhbZHkf4jtPseQtqjbs4POgXwkmjFr2UlNshwKxasKjz3JORygpqnvuUGytRfyU24
 6jgA3sko6LZDw7OF2BeD0UQ0rKCcW2E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-fuYMLGU7PrmS3GpJS9tLww-1; Thu, 14 Sep 2023 04:37:44 -0400
X-MC-Unique: fuYMLGU7PrmS3GpJS9tLww-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-401e1c55ddcso5644105e9.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 01:37:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694680663; x=1695285463;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :content-language:references:cc:to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G+otnmZp2gLKXSUMdSO4g+qnu7nKOs0lNDa7t5xSwqE=;
 b=KKm5jBeSj2mUNhTMJrMtux+aCyTKm4+60qpvW3YPFq+YM4+M3zWH8tWXpVsu7vUT2y
 +JCNox4osiY5mYzSjomwI1YP29Hi1q+R/owzVJlxKyHaomY+tcwwiGLAhnLyZqx08srO
 vQc68AsYF6QSFw8fvVos+TyziW9I7QdgS/zQU2IQalEtrUb8rUpAR9ymKwfKz0g+xgwx
 TbgejPigYFBQGA8IxEuX8M8uCcvJ3cMi4U/sMacjpRpbo/+inI/PShdrRFpmqWtySKb7
 vZnEJFsi4g45aOQet4VXqVWYzjsd1LyP4IZAlKTYwjnIwB2FioLFzN1cJH3FLR4MgG2E
 Km0A==
X-Gm-Message-State: AOJu0YyUDQfUvUwp9sr8Hz7YfQ2ASybWKKDhd7b3GTdWEaN1YRIlcPWa
 wXVHiBYtiEMSU0JIC3JFDXemBfasyC/xo4MmJnJTlprd+I7bBlU5zXIhqiF+7Iv17dQkAUkxbAl
 /28snL7/ilPy+N3Q=
X-Received: by 2002:a7b:ce0d:0:b0:401:daf2:2737 with SMTP id
 m13-20020a7bce0d000000b00401daf22737mr4547158wmc.30.1694680663121; 
 Thu, 14 Sep 2023 01:37:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPPFg3EihE2GKu60wRd/5QCQkSA2p0IP97lJAwH0tVqEKdwBeBbMu2tV/2mWnfP9XlZa48Ag==
X-Received: by 2002:a7b:ce0d:0:b0:401:daf2:2737 with SMTP id
 m13-20020a7bce0d000000b00401daf22737mr4547123wmc.30.1694680662515; 
 Thu, 14 Sep 2023 01:37:42 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7?
 ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
 by smtp.gmail.com with ESMTPSA id
 p20-20020a7bcc94000000b003feea62440bsm1307804wma.43.2023.09.14.01.37.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 01:37:41 -0700 (PDT)
Message-ID: <34403090-b4b3-990f-7723-1d56d8053bd5@redhat.com>
Date: Thu, 14 Sep 2023 10:37:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To: Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-devel <qemu-devel@nongnu.org>
References: <20230908095024.270946-1-anisinha@redhat.com>
 <77284898-c540-31ac-d438-ebff52f6d75d@redhat.com>
 <1911B17C-24F2-406B-9ED4-DCF98E794A09@redhat.com>
 <730648ed-55ac-aa2c-58d2-d79224aeb586@redhat.com>
 <1574DF3A-7E1F-4C4F-9087-6E8DEE456906@redhat.com>
 <6cbca7b9-381b-6268-27f0-d7ea1c5ed1bd@redhat.com>
 <3A287C52-F547-4494-B803-8CFC50CBA175@redhat.com>
 <30f0ddfb-6eb7-84a5-04a0-e11905451733@redhat.com>
 <A354B36D-A86E-48D9-B8B6-DC35D8976410@redhat.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mem/x86: add processor address space check for VM memory
In-Reply-To: <A354B36D-A86E-48D9-B8B6-DC35D8976410@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

On 14.09.23 07:53, Ani Sinha wrote:
> 
> 
>> On 12-Sep-2023, at 9:04 PM, David Hildenbrand <david@redhat.com> wrote:
>>
>> [...]
>>
>>>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>>>> index 54838c0c41..d187890675 100644
>>>> --- a/hw/i386/pc.c
>>>> +++ b/hw/i386/pc.c
>>>> @@ -908,9 +908,12 @@ static hwaddr pc_max_used_gpa(PCMachineState *pcms, uint64_t pci_hole64_size)
>>>> {
>>>>      X86CPU *cpu = X86_CPU(first_cpu);
>>>>
>>>> -    /* 32-bit systems don't have hole64 thus return max CPU address */
>>>> -    if (cpu->phys_bits <= 32) {
>>>> -        return ((hwaddr)1 << cpu->phys_bits) - 1;
>>>> +    /*
>>>> +     * 32-bit systems don't have hole64, but we might have a region for
>>>> +     * memory hotplug.
>>>> +     */
>>>> +    if (!(cpu->env.features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM)) {
>>>> +        return pc_pci_hole64_start() - 1;
>>> Ok this is very confusing! I am looking at pc_pci_hole64_start() function. I have a few questions …
>>> (a) pc_get_device_memory_range() returns the size of the device memory as the difference between ram_size and maxram_size. But from what I understand, ram_size is the actual size of the ram present and maxram_size is the max size of ram *after* hot plugging additional memory. How can we assume that the additional available space is already occupied by hot plugged memory?
>>
>> Let's take a look at an example:
>>
>> $ ./build/qemu-system-x86_64 -m 8g,maxmem=16g,slots=1 \
>>   -object memory-backend-ram,id=mem0,size=1g \
>>   -device pc-dimm,memdev=mem0 \
>>   -nodefaults -nographic -S -monitor stdio
>>
>> (qemu) info mtree
>> ...
>> memory-region: system
>>   0000000000000000-ffffffffffffffff (prio 0, i/o): system
>>     0000000000000000-00000000bfffffff (prio 0, ram): alias ram-below-4g @pc.ram 0000000000000000-00000000bfffffff
>>     0000000000000000-ffffffffffffffff (prio -1, i/o): pci
>>       00000000000c0000-00000000000dffff (prio 1, rom): pc.rom
>>       00000000000e0000-00000000000fffff (prio 1, rom): alias isa-bios @pc.bios 0000000000020000-000000000003ffff
>>       00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios
>>     00000000000a0000-00000000000bffff (prio 1, i/o): alias smram-region @pci 00000000000a0000-00000000000bffff
>>     00000000000c0000-00000000000c3fff (prio 1, i/o): alias pam-pci @pci 00000000000c0000-00000000000c3fff
>>     00000000000c4000-00000000000c7fff (prio 1, i/o): alias pam-pci @pci 00000000000c4000-00000000000c7fff
>>     00000000000c8000-00000000000cbfff (prio 1, i/o): alias pam-pci @pci 00000000000c8000-00000000000cbfff
>>     00000000000cc000-00000000000cffff (prio 1, i/o): alias pam-pci @pci 00000000000cc000-00000000000cffff
>>     00000000000d0000-00000000000d3fff (prio 1, i/o): alias pam-pci @pci 00000000000d0000-00000000000d3fff
>>     00000000000d4000-00000000000d7fff (prio 1, i/o): alias pam-pci @pci 00000000000d4000-00000000000d7fff
>>     00000000000d8000-00000000000dbfff (prio 1, i/o): alias pam-pci @pci 00000000000d8000-00000000000dbfff
>>     00000000000dc000-00000000000dffff (prio 1, i/o): alias pam-pci @pci 00000000000dc000-00000000000dffff
>>     00000000000e0000-00000000000e3fff (prio 1, i/o): alias pam-pci @pci 00000000000e0000-00000000000e3fff
>>     00000000000e4000-00000000000e7fff (prio 1, i/o): alias pam-pci @pci 00000000000e4000-00000000000e7fff
>>     00000000000e8000-00000000000ebfff (prio 1, i/o): alias pam-pci @pci 00000000000e8000-00000000000ebfff
>>     00000000000ec000-00000000000effff (prio 1, i/o): alias pam-pci @pci 00000000000ec000-00000000000effff
>>     00000000000f0000-00000000000fffff (prio 1, i/o): alias pam-pci @pci 00000000000f0000-00000000000fffff
>>     00000000fec00000-00000000fec00fff (prio 0, i/o): ioapic
>>     00000000fed00000-00000000fed003ff (prio 0, i/o): hpet
>>     00000000fee00000-00000000feefffff (prio 4096, i/o): apic-msi
>>     0000000100000000-000000023fffffff (prio 0, ram): alias ram-above-4g @pc.ram 00000000c0000000-00000001ffffffff
>>     0000000240000000-000000047fffffff (prio 0, i/o): device-memory
>>       0000000240000000-000000027fffffff (prio 0, ram): mem0
>>
>>
>> We requested 8G of boot memory, which is split between "<4G" memory and ">=4G" memory.
>>
>> We only place exactly 3G (0x0->0xbfffffff) under 4G, starting at address 0.
> 
> I can’t reconcile this with this code for q35:
> 
>     if (machine->ram_size >= 0xb0000000) {
>          lowmem = 0x80000000; // max memory 0x8fffffff or 2.25 GiB
>      } else {
>          lowmem = 0xb0000000; // max memory 0xbfffffff or 3 GiB
>      }
> 
> You assigned 8 Gib to ram which is > 0xb0000000 (2.75 Gib)
> 

QEMU defaults to the "pc" machine. If you add "-M q35" you get:

address-space: memory
   0000000000000000-ffffffffffffffff (prio 0, i/o): system
     0000000000000000-000000007fffffff (prio 0, ram): alias ram-below-4g @pc.ram 0000000000000000-000000007fffffff
[...]
     0000000100000000-000000027fffffff (prio 0, ram): alias ram-above-4g @pc.ram 0000000080000000-00000001ffffffff
     0000000280000000-00000004bfffffff (prio 0, i/o): device-memory
       0000000280000000-00000002bfffffff (prio 0, ram): mem0


> 
>>
>> We leave the remainder (1G) of the <4G addresses available for I/O devices (32bit PCI hole).
>>
>> So we end up with 5G (0x100000000->0x23fffffff) of memory starting exactly at address 4G.
>>
>> "maxram_size - ram_size"=8G is the maximum amount of memory you can hotplug. We use it to size the
>> "device-memory" region:
>>
>> 0x47fffffff - 0x240000000+1 = 0x240000000
>> -> 9 GiB
>>
>> We requested a to hotplug a maximum of "8 GiB", and sized the area slightly larger to allow for some flexibility
>> when it comes to placing DIMMs in that "device-memory" area.
> 
> Right but here in this example you do not hot plug memory while the VM is running. We can hot plug 8G yes, but the memory may not physically exist yet (and may never exist). How can we use this math to provision device-memory when the memory may not exist physically?

We simply reserve a region in GPA space where we can coldplug and hotplug a
predefined maximum amount of memory we can hotplug.

What do you think is wrong with that?

> 
>>
>> We place that area for memory devices after the RAM. So it starts after the 5G of ">=4G" boot memory.
>>
>>
>> Long story short, based on the initial RAM size and the maximum RAM size, you
>> can construct the layout above and exactly know
>> a) How much memory is below 4G, starting at address 0 -> leaving 1G for the 32bit PCI hole
>> b) How much memory is above 4G, starting at address 4g.
>> c) Where the region for memory devices starts (aligned after b) ) and how big it is.
>> d) Where the 64bit PCI hole is (after c) )
>>
>>> (b) Another question is, in pc_pci_hole64_start(), why are we adding this size to the start address?
>>> } else if (pcmc->has_reserved_memory && (ms->ram_size < ms->maxram_size)) {
>>> 	pc_get_device_memory_range(pcms, &hole64_start, &size);
>>>          if (!pcmc->broken_reserved_end) {
>>>              hole64_start += size;
>>
>> The 64bit PCI hole starts after "device-memory" above.
>>
>> Apparently, we have to take care of some layout issues before QEMU 2.5. You can assume that nowadays,
>> "pcmc->broken_reserved_end" is never set. So the PCI64 hole is always after the device-memory region.
>>
>>> I think this is trying to put the hole after the device memory. But if the ram size is <=maxram_size then the hole is after the above_4G memory? Why?
>>
>> I didn't quit get what the concern is, can you elaborate?
> 
> Oh I meant the else part here and made a typo, the else implies ram size == maxram_size
> 
>    } else {
>          hole64_start = pc_above_4g_end(pcms);
>      }
> 
> So in this case, there is no device_memory region?!

Yes. In this case ms->ram_size == ms->maxram_size and you cannot cold/hotplug any memory devices.

See how pc_memory_init() doesn't call machine_memory_devices_init() in that case.

That's what the QEMU user asked for when *not* specifying maxmem (e.g., -m 4g).

In order to cold/hotplug any memory devices, you have to tell QEMU ahead of time how much memory
you are intending to provide using memory devices (DIMM, NVDIMM, virtio-pmem, virtio-mem).

So when specifying, say -m 4g,maxmem=20g, we can have memory devices of a total of 16g (20 - 4).
We use reserve a GPA space for device_memory that is at least 16g, into which we can either coldplug
(QEMU cmdline) or hotplug (qmp/hmp) memory later.

> Another thing I do not understand is, for 32 -bit,
> above_4g_mem_start is 4GiB  and above_4g_mem_size = ram_size - lowmem.
> So we are allocating “above-4G” ram above address space of the processor?!
> 
>>
>>> (c) in your above change, what does long mode have anything to do with all of this?
>>
>> According to my understanding, 32bit (i386) doesn't have a 64bit hole. And 32bit vs.
>> 64bit (i386 vs. x86_64) is decided based on LM, not on the address bits (as we learned, PSE36, and PAE).
>>
>> But really, I just did what x86_cpu_realizefn() does to decide 32bit vs. 64bit ;)
>>
>>     /* For 64bit systems think about the number of physical bits to present.
>>      * ideally this should be the same as the host; anything other than matching
>>      * the host can cause incorrect guest behaviour.
>>      * QEMU used to pick the magic value of 40 bits that corresponds to
>>      * consumer AMD devices but nothing else.
>>      *
>>      * Note that this code assumes features expansion has already been done
>>      * (as it checks for CPUID_EXT2_LM), and also assumes that potential
>>      * phys_bits adjustments to match the host have been already done in
>>      * accel-specific code in cpu_exec_realizefn.
>>      */
>>     if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
>>     ...
>>     } else {
>>         /* For 32 bit systems don't use the user set value, but keep
>>          * phys_bits consistent with what we tell the guest.
>>          */
> 
> Ah I see. I missed this. But I still can’t understand why for 32 bit, pc_pci_hole64_start() would be the right address for max gpa?

You want "end of device memory region" if there is one, or
"end of RAM" is there is none.

What pc_pci_hole64_start() does:

/*
  * The 64bit pci hole starts after "above 4G RAM" and
  * potentially the space reserved for memory hotplug.
  */

There is the
	ROUND_UP(hole64_start, 1 * GiB);
in there that is not really required for the !hole64 case. It
shouldn't matter much in practice I think (besides an aligned value
showing up in the error message).

We could factor out most of that calculation into a
separate function, skipping that alignment to make that
clearer.

-- 
Cheers,

David / dhildenb


