Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1702B7A0275
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 13:22:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgkPc-00024L-D4; Thu, 14 Sep 2023 07:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qgkPZ-00024B-MC
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 07:21:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qgkPX-0001wx-D8
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 07:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694690486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8FQduCFgvngkjW4STc+U6nRQwz3H/5nPI2nYB1ytu5c=;
 b=ZcFTnqQlA3NteGyQ+cMEwwe/aveTgDlttkOFXt/T82tYsW9L/YoVFmqcMnyZKNOEU4bWO+
 X+qJ3vLPqfwUU3VUKJ1BOcUn4Jf/5qVaKSROAOlWWNekrpzTdf1h6guLmbBftSxBay6Kth
 xYqSayRMgEcx9AObnvHWuG42niykMU0=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-njKDpY4xOGy2HtvcZ4e4YA-1; Thu, 14 Sep 2023 07:21:24 -0400
X-MC-Unique: njKDpY4xOGy2HtvcZ4e4YA-1
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-34ca50554d5so5747665ab.2
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 04:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694690484; x=1695295284;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8FQduCFgvngkjW4STc+U6nRQwz3H/5nPI2nYB1ytu5c=;
 b=LIU0Pr8AFlDTyilOIIflEbo3XLY3EkelGS8BxnTRtk3e0VRmKbleQOUv9yiAuwhoNJ
 B3uJ7Xn62U4NxdLb7hcj5CxeObfXMABwU0hWvNi+8YLqH6PSo3V87pDutZnmJobxL/cv
 x5A+vQ2Qb/SUQYcfRDLR4ki5UVpoiU13OryvKXV8MWA69fiPkXA6So4lJbvpuzQdVSWK
 zur88JkRyh80MB1RKeqVOkuMrlNS/gl9EjaQlI7elhCuo6/60tSlqtOClkSiH+7fK6uD
 bqja2ssXGTvqTioJQJy36x78awVs2iV+7ZHu6Jg0pUO4uWFo2MPJ0W3JV1wV5gL+MIIQ
 fDnw==
X-Gm-Message-State: AOJu0YxSljvk5x1G6oBRFCPze9E/KYmwgXNxUtJGuzb1JPr5h1QVE+2v
 aLNeoY7SE7eWu3ZZqTKsnC6VcJXHadj/gzFZ5P5OZXD0FqmCaO4azBDrDOLcqhvxiYPeG851+o6
 9nF6mDDwRuSFGJS8=
X-Received: by 2002:a05:6e02:1907:b0:349:7663:566c with SMTP id
 w7-20020a056e02190700b003497663566cmr6346194ilu.30.1694690483912; 
 Thu, 14 Sep 2023 04:21:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEgiM5pBg/ck/UPt2GDwSevLOymK6nKeNcXf4Bgeoznt46vvyL5AGyBf3Nj2CSuIDwpLyTUQ==
X-Received: by 2002:a05:6e02:1907:b0:349:7663:566c with SMTP id
 w7-20020a056e02190700b003497663566cmr6346179ilu.30.1694690483586; 
 Thu, 14 Sep 2023 04:21:23 -0700 (PDT)
Received: from smtpclient.apple ([115.96.132.85])
 by smtp.gmail.com with ESMTPSA id
 fk7-20020a056a003a8700b00682868714fdsm1171587pfb.95.2023.09.14.04.21.19
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Sep 2023 04:21:23 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PATCH] mem/x86: add processor address space check for VM memory
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <34403090-b4b3-990f-7723-1d56d8053bd5@redhat.com>
Date: Thu, 14 Sep 2023 16:51:16 +0530
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <08530A80-90F3-4E33-9B1A-E71A66726123@redhat.com>
References: <20230908095024.270946-1-anisinha@redhat.com>
 <77284898-c540-31ac-d438-ebff52f6d75d@redhat.com>
 <1911B17C-24F2-406B-9ED4-DCF98E794A09@redhat.com>
 <730648ed-55ac-aa2c-58d2-d79224aeb586@redhat.com>
 <1574DF3A-7E1F-4C4F-9087-6E8DEE456906@redhat.com>
 <6cbca7b9-381b-6268-27f0-d7ea1c5ed1bd@redhat.com>
 <3A287C52-F547-4494-B803-8CFC50CBA175@redhat.com>
 <30f0ddfb-6eb7-84a5-04a0-e11905451733@redhat.com>
 <A354B36D-A86E-48D9-B8B6-DC35D8976410@redhat.com>
 <34403090-b4b3-990f-7723-1d56d8053bd5@redhat.com>
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



> On 14-Sep-2023, at 2:07 PM, David Hildenbrand <david@redhat.com> =
wrote:
>=20
> On 14.09.23 07:53, Ani Sinha wrote:
>>> On 12-Sep-2023, at 9:04 PM, David Hildenbrand <david@redhat.com> =
wrote:
>>>=20
>>> [...]
>>>=20
>>>>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>>>>> index 54838c0c41..d187890675 100644
>>>>> --- a/hw/i386/pc.c
>>>>> +++ b/hw/i386/pc.c
>>>>> @@ -908,9 +908,12 @@ static hwaddr pc_max_used_gpa(PCMachineState =
*pcms, uint64_t pci_hole64_size)
>>>>> {
>>>>>     X86CPU *cpu =3D X86_CPU(first_cpu);
>>>>>=20
>>>>> -    /* 32-bit systems don't have hole64 thus return max CPU =
address */
>>>>> -    if (cpu->phys_bits <=3D 32) {
>>>>> -        return ((hwaddr)1 << cpu->phys_bits) - 1;
>>>>> +    /*
>>>>> +     * 32-bit systems don't have hole64, but we might have a =
region for
>>>>> +     * memory hotplug.
>>>>> +     */
>>>>> +    if (!(cpu->env.features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM)) =
{
>>>>> +        return pc_pci_hole64_start() - 1;
>>>> Ok this is very confusing! I am looking at pc_pci_hole64_start() =
function. I have a few questions =E2=80=A6
>>>> (a) pc_get_device_memory_range() returns the size of the device =
memory as the difference between ram_size and maxram_size. But from what =
I understand, ram_size is the actual size of the ram present and =
maxram_size is the max size of ram *after* hot plugging additional =
memory. How can we assume that the additional available space is already =
occupied by hot plugged memory?
>>>=20
>>> Let's take a look at an example:
>>>=20
>>> $ ./build/qemu-system-x86_64 -m 8g,maxmem=3D16g,slots=3D1 \
>>>  -object memory-backend-ram,id=3Dmem0,size=3D1g \
>>>  -device pc-dimm,memdev=3Dmem0 \
>>>  -nodefaults -nographic -S -monitor stdio
>>>=20
>>> (qemu) info mtree
>>> ...
>>> memory-region: system
>>>  0000000000000000-ffffffffffffffff (prio 0, i/o): system
>>>    0000000000000000-00000000bfffffff (prio 0, ram): alias =
ram-below-4g @pc.ram 0000000000000000-00000000bfffffff
>>>    0000000000000000-ffffffffffffffff (prio -1, i/o): pci
>>>      00000000000c0000-00000000000dffff (prio 1, rom): pc.rom
>>>      00000000000e0000-00000000000fffff (prio 1, rom): alias isa-bios =
@pc.bios 0000000000020000-000000000003ffff
>>>      00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios
>>>    00000000000a0000-00000000000bffff (prio 1, i/o): alias =
smram-region @pci 00000000000a0000-00000000000bffff
>>>    00000000000c0000-00000000000c3fff (prio 1, i/o): alias pam-pci =
@pci 00000000000c0000-00000000000c3fff
>>>    00000000000c4000-00000000000c7fff (prio 1, i/o): alias pam-pci =
@pci 00000000000c4000-00000000000c7fff
>>>    00000000000c8000-00000000000cbfff (prio 1, i/o): alias pam-pci =
@pci 00000000000c8000-00000000000cbfff
>>>    00000000000cc000-00000000000cffff (prio 1, i/o): alias pam-pci =
@pci 00000000000cc000-00000000000cffff
>>>    00000000000d0000-00000000000d3fff (prio 1, i/o): alias pam-pci =
@pci 00000000000d0000-00000000000d3fff
>>>    00000000000d4000-00000000000d7fff (prio 1, i/o): alias pam-pci =
@pci 00000000000d4000-00000000000d7fff
>>>    00000000000d8000-00000000000dbfff (prio 1, i/o): alias pam-pci =
@pci 00000000000d8000-00000000000dbfff
>>>    00000000000dc000-00000000000dffff (prio 1, i/o): alias pam-pci =
@pci 00000000000dc000-00000000000dffff
>>>    00000000000e0000-00000000000e3fff (prio 1, i/o): alias pam-pci =
@pci 00000000000e0000-00000000000e3fff
>>>    00000000000e4000-00000000000e7fff (prio 1, i/o): alias pam-pci =
@pci 00000000000e4000-00000000000e7fff
>>>    00000000000e8000-00000000000ebfff (prio 1, i/o): alias pam-pci =
@pci 00000000000e8000-00000000000ebfff
>>>    00000000000ec000-00000000000effff (prio 1, i/o): alias pam-pci =
@pci 00000000000ec000-00000000000effff
>>>    00000000000f0000-00000000000fffff (prio 1, i/o): alias pam-pci =
@pci 00000000000f0000-00000000000fffff
>>>    00000000fec00000-00000000fec00fff (prio 0, i/o): ioapic
>>>    00000000fed00000-00000000fed003ff (prio 0, i/o): hpet
>>>    00000000fee00000-00000000feefffff (prio 4096, i/o): apic-msi
>>>    0000000100000000-000000023fffffff (prio 0, ram): alias =
ram-above-4g @pc.ram 00000000c0000000-00000001ffffffff
>>>    0000000240000000-000000047fffffff (prio 0, i/o): device-memory
>>>      0000000240000000-000000027fffffff (prio 0, ram): mem0
>>>=20
>>>=20
>>> We requested 8G of boot memory, which is split between "<4G" memory =
and ">=3D4G" memory.
>>>=20
>>> We only place exactly 3G (0x0->0xbfffffff) under 4G, starting at =
address 0.
>> I can=E2=80=99t reconcile this with this code for q35:
>>    if (machine->ram_size >=3D 0xb0000000) {
>>         lowmem =3D 0x80000000; // max memory 0x8fffffff or 2.25 GiB
>>     } else {
>>         lowmem =3D 0xb0000000; // max memory 0xbfffffff or 3 GiB
>>     }
>> You assigned 8 Gib to ram which is > 0xb0000000 (2.75 Gib)
>=20
> QEMU defaults to the "pc" machine. If you add "-M q35" you get:
>=20
> address-space: memory
>  0000000000000000-ffffffffffffffff (prio 0, i/o): system
>    0000000000000000-000000007fffffff (prio 0, ram): alias ram-below-4g =
@pc.ram 0000000000000000-000000007fffffff
> [...]
>    0000000100000000-000000027fffffff (prio 0, ram): alias ram-above-4g =
@pc.ram 0000000080000000-00000001ffffffff
>    0000000280000000-00000004bfffffff (prio 0, i/o): device-memory
>      0000000280000000-00000002bfffffff (prio 0, ram): mem0
>=20
>=20
>>>=20
>>> We leave the remainder (1G) of the <4G addresses available for I/O =
devices (32bit PCI hole).
>>>=20
>>> So we end up with 5G (0x100000000->0x23fffffff) of memory starting =
exactly at address 4G.
>>>=20
>>> "maxram_size - ram_size"=3D8G is the maximum amount of memory you =
can hotplug. We use it to size the
>>> "device-memory" region:
>>>=20
>>> 0x47fffffff - 0x240000000+1 =3D 0x240000000
>>> -> 9 GiB
>>>=20
>>> We requested a to hotplug a maximum of "8 GiB", and sized the area =
slightly larger to allow for some flexibility
>>> when it comes to placing DIMMs in that "device-memory" area.
>> Right but here in this example you do not hot plug memory while the =
VM is running. We can hot plug 8G yes, but the memory may not physically =
exist yet (and may never exist). How can we use this math to provision =
device-memory when the memory may not exist physically?
>=20
> We simply reserve a region in GPA space where we can coldplug and =
hotplug a
> predefined maximum amount of memory we can hotplug.
>=20
> What do you think is wrong with that?

The only issue I have is that even though we are accounting for it, the =
memory actually might not be physically present.

>=20
>>>=20
>>> We place that area for memory devices after the RAM. So it starts =
after the 5G of ">=3D4G" boot memory.
>>>=20
>>>=20
>>> Long story short, based on the initial RAM size and the maximum RAM =
size, you
>>> can construct the layout above and exactly know
>>> a) How much memory is below 4G, starting at address 0 -> leaving 1G =
for the 32bit PCI hole
>>> b) How much memory is above 4G, starting at address 4g.
>>> c) Where the region for memory devices starts (aligned after b) ) =
and how big it is.
>>> d) Where the 64bit PCI hole is (after c) )
>>>=20
>>>> (b) Another question is, in pc_pci_hole64_start(), why are we =
adding this size to the start address?
>>>> } else if (pcmc->has_reserved_memory && (ms->ram_size < =
ms->maxram_size)) {
>>>> 	pc_get_device_memory_range(pcms, &hole64_start, &size);
>>>>         if (!pcmc->broken_reserved_end) {
>>>>             hole64_start +=3D size;
>>>=20
>>> The 64bit PCI hole starts after "device-memory" above.
>>>=20
>>> Apparently, we have to take care of some layout issues before QEMU =
2.5. You can assume that nowadays,
>>> "pcmc->broken_reserved_end" is never set. So the PCI64 hole is =
always after the device-memory region.
>>>=20
>>>> I think this is trying to put the hole after the device memory. But =
if the ram size is <=3Dmaxram_size then the hole is after the above_4G =
memory? Why?
>>>=20
>>> I didn't quit get what the concern is, can you elaborate?
>> Oh I meant the else part here and made a typo, the else implies ram =
size =3D=3D maxram_size
>>   } else {
>>         hole64_start =3D pc_above_4g_end(pcms);
>>     }
>> So in this case, there is no device_memory region?!
>=20
> Yes. In this case ms->ram_size =3D=3D ms->maxram_size and you cannot =
cold/hotplug any memory devices.
>=20
> See how pc_memory_init() doesn't call machine_memory_devices_init() in =
that case.
>=20
> That's what the QEMU user asked for when *not* specifying maxmem =
(e.g., -m 4g).
>=20
> In order to cold/hotplug any memory devices, you have to tell QEMU =
ahead of time how much memory
> you are intending to provide using memory devices (DIMM, NVDIMM, =
virtio-pmem, virtio-mem).

So that means that when we are actually hot plugging the memory, there =
is no need to actually perform additional checks. It can be done =
statically when -mem and -maxmem etc are provided in the command line.

>=20
> So when specifying, say -m 4g,maxmem=3D20g, we can have memory devices =
of a total of 16g (20 - 4).
> We use reserve a GPA space for device_memory that is at least 16g, =
into which we can either coldplug
> (QEMU cmdline) or hotplug (qmp/hmp) memory later.
>=20
>> Another thing I do not understand is, for 32 -bit,
>> above_4g_mem_start is 4GiB  and above_4g_mem_size =3D ram_size - =
lowmem.
>> So we are allocating =E2=80=9Cabove-4G=E2=80=9D ram above address =
space of the processor?!
>>>=20
>>>> (c) in your above change, what does long mode have anything to do =
with all of this?
>>>=20
>>> According to my understanding, 32bit (i386) doesn't have a 64bit =
hole. And 32bit vs.
>>> 64bit (i386 vs. x86_64) is decided based on LM, not on the address =
bits (as we learned, PSE36, and PAE).
>>>=20
>>> But really, I just did what x86_cpu_realizefn() does to decide 32bit =
vs. 64bit ;)
>>>=20
>>>    /* For 64bit systems think about the number of physical bits to =
present.
>>>     * ideally this should be the same as the host; anything other =
than matching
>>>     * the host can cause incorrect guest behaviour.
>>>     * QEMU used to pick the magic value of 40 bits that corresponds =
to
>>>     * consumer AMD devices but nothing else.
>>>     *
>>>     * Note that this code assumes features expansion has already =
been done
>>>     * (as it checks for CPUID_EXT2_LM), and also assumes that =
potential
>>>     * phys_bits adjustments to match the host have been already done =
in
>>>     * accel-specific code in cpu_exec_realizefn.
>>>     */
>>>    if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
>>>    ...
>>>    } else {
>>>        /* For 32 bit systems don't use the user set value, but keep
>>>         * phys_bits consistent with what we tell the guest.
>>>         */
>> Ah I see. I missed this. But I still can=E2=80=99t understand why for =
32 bit, pc_pci_hole64_start() would be the right address for max gpa?
>=20
> You want "end of device memory region" if there is one, or
> "end of RAM" is there is none.
>=20
> What pc_pci_hole64_start() does:
>=20
> /*
> * The 64bit pci hole starts after "above 4G RAM" and
> * potentially the space reserved for memory hotplug.
> */
>=20
> There is the
> 	ROUND_UP(hole64_start, 1 * GiB);
> in there that is not really required for the !hole64 case. It
> shouldn't matter much in practice I think (besides an aligned value
> showing up in the error message).
>=20
> We could factor out most of that calculation into a
> separate function, skipping that alignment to make that
> clearer.

Yeah this whole memory segmentation is quite complicated and might =
benefit from a qemu doc or a refactoring.=20=


