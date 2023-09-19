Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 292817A6348
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 14:42:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qia1w-0002it-4u; Tue, 19 Sep 2023 08:40:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qia1s-0002fY-Tc
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 08:40:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qia1q-0001pX-UK
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 08:40:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695127233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hy4mBJ1MGdinrCn6lHAllAQw41evnDlw5yzDZtBuZe0=;
 b=Oqvlo3ny5O4KCC/Pc8CJuBByoSkZGDLKkyr+hgoBqkp8QFjc4CmwskPqLqOFWoyodBfyOJ
 BIFq1CIizHsheYAlWY69z9NyCDeMyWDDG2PzkXRDptOq2CoVI2AmP8tVmJE3uPBpeqNd0v
 7kPb2t/9F/l2iWhJuXne/oZgTim6iOY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-FGlQmK4zN8Cv1tKUyDnZNw-1; Tue, 19 Sep 2023 08:40:32 -0400
X-MC-Unique: FGlQmK4zN8Cv1tKUyDnZNw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4011f56165eso28192015e9.0
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 05:40:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695127231; x=1695732031;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hy4mBJ1MGdinrCn6lHAllAQw41evnDlw5yzDZtBuZe0=;
 b=MD5iTieTUGm3d2Owyz513BVwipKG3Hgwr2BNC+BszEu2I3CSTRxjYERzFmP6HR4o3v
 fTqEw6cNoUPBxHuT3XoYFeBwbIvSb+udxGrr6+5/LfETZXop+yBFVCSFV2hLMah+k0dW
 oI3oxxaFwbCi1GFukjPp7vsiP8XnCE8j5Kbycu6W/Ff4RqUSwV/33zjq8cCWGT23u4ig
 gx/3l3gepUn2Vmjvgx/PqOsyshpAqs5KeKcaENWCqRug02E6WiGf7zvirbywOJfRRmvo
 qN7nIoy3XeINuGpj3K+4wFkLoovJG6I+bjvmQPIuDN6enMl4uK82oWWDQrQqyhs8UvVW
 eFXg==
X-Gm-Message-State: AOJu0YzXgqOklJQLuZ6V6eCcdqAiCelDVwyEnh84CBkPxOq+it6UiDBq
 YwXM1O6M1dxSSBHHsfynCe7VZ7+GNndSifByv0RWd1zpFXubwr/uUNLBMLKPkZLADf0Lt2iQIBj
 KiXUwRvYKSWpY7k0=
X-Received: by 2002:a05:600c:1c07:b0:405:1c2f:3a97 with SMTP id
 j7-20020a05600c1c0700b004051c2f3a97mr803913wms.5.1695127231292; 
 Tue, 19 Sep 2023 05:40:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGX4aO2dCU20nlIwpIiMZaEVXKd7UP9GbRg5Cv1QptMEIfh7gHtcczAFrNBOdZxq0XzIf09uw==
X-Received: by 2002:a05:600c:1c07:b0:405:1c2f:3a97 with SMTP id
 j7-20020a05600c1c0700b004051c2f3a97mr803895wms.5.1695127230918; 
 Tue, 19 Sep 2023 05:40:30 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:1300:c409:8b33:c793:108e?
 (p200300cbc7021300c4098b33c793108e.dip0.t-ipconnect.de.
 [2003:cb:c702:1300:c409:8b33:c793:108e])
 by smtp.gmail.com with ESMTPSA id
 t9-20020a7bc3c9000000b003fe23b10fdfsm18025166wmj.36.2023.09.19.05.40.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Sep 2023 05:40:30 -0700 (PDT)
Message-ID: <ba34ed0a-96a1-2563-425c-1642b031459f@redhat.com>
Date: Tue, 19 Sep 2023 14:40:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] hw/i386/pc: improve physical address space bound check
 for 32-bit systems
Content-Language: en-US
To: Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: philmd@linaro.org, qemu-devel@nongnu.org
References: <20230919103838.249317-1-anisinha@redhat.com>
 <CAK3XEhPqRTjSCuvsUHkdfH+1Yi=5TPREB3VWA0Chr+c_jdTiKQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAK3XEhPqRTjSCuvsUHkdfH+1Yi=5TPREB3VWA0Chr+c_jdTiKQ@mail.gmail.com>
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

On 19.09.23 13:52, Ani Sinha wrote:
> On Tue, Sep 19, 2023 at 4:08 PM Ani Sinha <anisinha@redhat.com> wrote:
>>
>> 32-bit systems do not have a reserved memory for hole64 and memory hotplug is
>> not supported on those systems. Therefore, the maximum limit of the guest
>> physical address coincides with the end of "above 4G memory space" region.
>> Make sure that the end of "above 4G memory" is still addressible by the
>> guest processor with its available address bits. For example, previously this
>> was allowed:
>>
>> $ ./qemu-system-x86_64 -cpu pentium -m size=10G
>>
>> Now it is no longer allowed:
>>
>> $ ./qemu-system-x86_64 -cpu pentium -m size=10G
>> qemu-system-x86_64: Address space limit 0xffffffff < 0x2bfffffff phys-bits too low (32)
>>
>> After calling CPUID with EAX=0x80000001, all AMD64 compliant processors
>> have the longmode-capable-bit turned on in the extended feature flags (bit 29)
>> in EDX. The absence of CPUID longmode can be used to differentiate between
>> 32-bit and 64-bit processors and is the recommended approach. QEMU takes this
>> approach elsewhere (for example, please see x86_cpu_realizefn()) and with
>> this change, pc_max_used_gpa() also takes the same approach to detect 32-bit
>> processors.
>>
>> Finally, a new compatibility flag is introduced to retain the old behavior
>> for pc_max_used_gpa() for macines 8.1 and older.
> typo - will fix in v3                   ^^^^^^^^
> 
> btw, does this patch break it for processors < 32-bit? For them clearly
> 
> x86ms->above_4g_mem_start = 4 * GiB;
> 
> does not work.
> 
> 
>>
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> ---
>>   hw/i386/pc.c         | 17 ++++++++++++++---
>>   hw/i386/pc_piix.c    |  4 ++++
>>   include/hw/i386/pc.h |  3 +++
>>   3 files changed, 21 insertions(+), 3 deletions(-)
>>
>> changelog:
>> v2: removed memory hotplug region from max_gpa. added compat knobs.
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 54838c0c41..fea97ee258 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -907,10 +907,20 @@ static uint64_t pc_get_cxl_range_end(PCMachineState *pcms)
>>   static hwaddr pc_max_used_gpa(PCMachineState *pcms, uint64_t pci_hole64_size)
>>   {
>>       X86CPU *cpu = X86_CPU(first_cpu);
>> +    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
>>
>> -    /* 32-bit systems don't have hole64 thus return max CPU address */
>> -    if (cpu->phys_bits <= 32) {
>> -        return ((hwaddr)1 << cpu->phys_bits) - 1;
>> +    /*
>> +     * 32-bit systems don't have hole64 and does not support
>> +     * memory hotplug.
>> +     */
>> +    if (pcmc->fixed_32bit_mem_addr_check) {
>> +        if (!(cpu->env.features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM)) {
>> +            return pc_above_4g_end(pcms) - 1;
>> +        }

I think you should use the logic from v1.

My comment regarding memory hotplug was primarily about (Linux) guest 
support.

We should not optimize for 32bit processors (e.g., try placing the 
device memory region below 4g), but you can still consider the region 
and properly account it.

-- 
Cheers,

David / dhildenb


