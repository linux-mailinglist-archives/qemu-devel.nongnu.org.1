Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD2D9C0BD6
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Nov 2024 17:39:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t95Wp-0002Nd-50; Thu, 07 Nov 2024 11:38:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1t95Wm-0002NP-NL
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 11:38:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1t95Wk-0005HI-8G
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 11:38:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730997512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MgEr04ZzObBev1LR5h745g3uC+nEnce1viMRCu6X6/w=;
 b=KUj8Q2li3lcuO7DswN0e8IeYV2KGOx/vPPAMLO3SYbdV9zun/46quiXP0EzL1kcAnnXXGk
 tOtfomBhW0tl6TwaNEfBAegN5kxCdGbbGGGqHfMcD7vOhREnzcrsbfnwISZyZQWO8fxtAM
 SSqFfFjm0uCJpYJKBwikiJL331YA+qQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-2CpT6F6YNj6qveIgYdz5GQ-1; Thu, 07 Nov 2024 11:38:30 -0500
X-MC-Unique: 2CpT6F6YNj6qveIgYdz5GQ-1
X-Mimecast-MFC-AGG-ID: 2CpT6F6YNj6qveIgYdz5GQ
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-539e4b7c8f4so820027e87.1
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 08:38:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730997508; x=1731602308;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=MgEr04ZzObBev1LR5h745g3uC+nEnce1viMRCu6X6/w=;
 b=IIDkoAOTp/1BM8h5zOedGkianEzDmHnUEpDdZ5dgErZQqJmbomHP1WC0LMsbaR1u8l
 jofWSatDM3DNL6jj0Gs85zVCWUKSzFnRtTCVGsz48rj49PfvsmmVU/SFw6ckpnf4/6nF
 6Vu/CvGVBT0VznYQ98ZW91YhqhFfe9+6s/Wr9I7mRtIVAYO5gZaLogmqZlSM3Tx8KUkL
 4rtBHI6LxqOTM6we7jum4Gm6ZAces3wcCTEhpbWOuvian9cFtMQoY26DFg9Qs7hoLMwC
 nZqvgGGZ94rKoTKTQ3AtclStfWzpgK09oug//sd00vaSTQJiBLhtWRMokoMLmReHE7OU
 WjPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkVquSi/oyX/fo+WgfV+Zw6nhJWEoLgYeG2diKAdGrCT3eSOiVqdwF8UWAM7bj8yiISYjUpPcRyvu0@nongnu.org
X-Gm-Message-State: AOJu0YzWBpu2s6FIDS3IW2U4Y6xogjbfIdcOdv5m2/vdvv8FrKI+w9g6
 rwWTRVYUrbz8KPFATTCNVsa8ugw+gDPf6/UW6k8DdydNiH+DHVEgLNAn7ppVRiO9oB0K1F+AXMF
 nMvfxU42cGFJDeXOybxvmTAEh+W7aq+AIWjJqy8x7iSyNNuNyQJxJ
X-Received: by 2002:a05:6512:3d26:b0:539:f4a6:ef4b with SMTP id
 2adb3069b0e04-53b34c8db59mr23437562e87.55.1730997508383; 
 Thu, 07 Nov 2024 08:38:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWRF0+b1gMRsFW1OAOJkk2RPeC5kqAuPq1MMdv4i2Imh52cJMcClAdq7n8w1ks8+ey1r+oyA==
X-Received: by 2002:a05:6512:3d26:b0:539:f4a6:ef4b with SMTP id
 2adb3069b0e04-53b34c8db59mr23437544e87.55.1730997507847; 
 Thu, 07 Nov 2024 08:38:27 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:7900:b88e:c72a:abbd:d3d9?
 (p200300cbc7087900b88ec72aabbdd3d9.dip0.t-ipconnect.de.
 [2003:cb:c708:7900:b88e:c72a:abbd:d3d9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6bee9asm69671895e9.19.2024.11.07.08.38.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Nov 2024 08:38:27 -0800 (PST)
Message-ID: <db8fe7a8-9592-42b4-a7e2-df9575408c71@redhat.com>
Date: Thu, 7 Nov 2024 17:38:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 01/16] machine: anon-alloc option
To: Peter Xu <peterx@redhat.com>, Steven Sistare <steven.sistare@oracle.com>
Cc: Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
References: <45ea8a8a-928d-4703-b698-d5f910e6a224@oracle.com>
 <1f1a2742-0429-47d5-958f-b37575c1e4ba@redhat.com>
 <c2ca740b-0178-463b-8262-b149841b8def@redhat.com>
 <bcc4cd7e-3532-475a-8989-211e80bf3eab@oracle.com>
 <09701693-436c-4e1a-8206-03eb26cacab5@redhat.com>
 <66c05a06-dbb7-49ec-b58e-ccd917d098ea@oracle.com> <ZyvUg3CP30f3DZYY@x1n>
 <d78a806f-4c15-4a1c-a9a4-8fb9f215a2a6@oracle.com>
 <7fb32744-0512-46e2-b58d-2990f742b897@redhat.com>
 <bb324f6d-8c8b-4f92-9c0f-12278e3c926c@oracle.com> <ZyzrqnqoK81QfT_c@x1n>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZyzrqnqoK81QfT_c@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 07.11.24 17:32, Peter Xu wrote:
> On Thu, Nov 07, 2024 at 09:04:02AM -0500, Steven Sistare wrote:
>> On 11/7/2024 8:05 AM, David Hildenbrand wrote:
>>> On 06.11.24 21:59, Steven Sistare wrote:
>>>> On 11/6/2024 3:41 PM, Peter Xu wrote:
>>>>> On Wed, Nov 06, 2024 at 03:12:20PM -0500, Steven Sistare wrote:
>>>>>> On 11/4/2024 4:36 PM, David Hildenbrand wrote:
>>>>>>> On 04.11.24 21:56, Steven Sistare wrote:
>>>>>>>> On 11/4/2024 3:15 PM, David Hildenbrand wrote:
>>>>>>>>> On 04.11.24 20:51, David Hildenbrand wrote:
>>>>>>>>>> On 04.11.24 18:38, Steven Sistare wrote:
>>>>>>>>>>> On 11/4/2024 5:39 AM, David Hildenbrand wrote:
>>>>>>>>>>>> On 01.11.24 14:47, Steve Sistare wrote:
>>>>>>>>>>>>> Allocate anonymous memory using mmap MAP_ANON or memfd_create depending
>>>>>>>>>>>>> on the value of the anon-alloc machine property.  This option applies to
>>>>>>>>>>>>> memory allocated as a side effect of creating various devices. It does
>>>>>>>>>>>>> not apply to memory-backend-objects, whether explicitly specified on
>>>>>>>>>>>>> the command line, or implicitly created by the -m command line option.
>>>>>>>>>>>>>
>>>>>>>>>>>>> The memfd option is intended to support new migration modes, in which the
>>>>>>>>>>>>> memory region can be transferred in place to a new QEMU process, by sending
>>>>>>>>>>>>> the memfd file descriptor to the process.  Memory contents are preserved,
>>>>>>>>>>>>> and if the mode also transfers device descriptors, then pages that are
>>>>>>>>>>>>> locked in memory for DMA remain locked.  This behavior is a pre-requisite
>>>>>>>>>>>>> for supporting vfio, vdpa, and iommufd devices with the new modes.
>>>>>>>>>>>>
>>>>>>>>>>>> A more portable, non-Linux specific variant of this will be using shm,
>>>>>>>>>>>> similar to backends/hostmem-shm.c.
>>>>>>>>>>>>
>>>>>>>>>>>> Likely we should be using that instead of memfd, or try hiding the
>>>>>>>>>>>> details. See below.
>>>>>>>>>>>
>>>>>>>>>>> For this series I would prefer to use memfd and hide the details.  It's a
>>>>>>>>>>> concise (and well tested) solution albeit linux only.  The code you supply
>>>>>>>>>>> for posix shm would be a good follow on patch to support other unices.
>>>>>>>>>>
>>>>>>>>>> Unless there is reason to use memfd we should start with the more
>>>>>>>>>> generic POSIX variant that is available even on systems without memfd.
>>>>>>>>>> Factoring stuff out as I drafted does look quite compelling.
>>>>>>>>>>
>>>>>>>>>> I can help with the rework, and send it out separately, so you can focus
>>>>>>>>>> on the "machine toggle" as part of this series.
>>>>>>>>>>
>>>>>>>>>> Of course, if we find out we need the memfd internally instead under
>>>>>>>>>> Linux for whatever reason later, we can use that instead.
>>>>>>>>>>
>>>>>>>>>> But IIUC, the main selling point for memfd are additional features
>>>>>>>>>> (hugetlb, memory sealing) that you aren't even using.
>>>>>>>>>
>>>>>>>>> FWIW, I'm looking into some details, and one difference is that shmem_open() under Linux (glibc) seems to go to /dev/shmem and memfd/SYSV go to the internal tmpfs mount. There is not a big difference, but there can be some difference (e.g., sizing of the /dev/shm mount).
>>>>>>>>
>>>>>>>> Sizing is a non-trivial difference.  One can by default allocate all memory using memfd_create.
>>>>>>>> To do so using shm_open requires configuration on the mount.  One step harder to use.
>>>>>>>
>>>>>>> Yes.
>>>>>>>
>>>>>>>>
>>>>>>>> This is a real issue for memory-backend-ram, and becomes an issue for the internal RAM
>>>>>>>> if memory-backend-ram has hogged all the memory.
>>>>>>>>
>>>>>>>>> Regarding memory-backend-ram,share=on, I assume we can use memfd if available, but then fallback to shm_open().
>>>>>>>>
>>>>>>>> Yes, and if that is a good idea, then the same should be done for internal RAM
>>>>>>>> -- memfd if available and fallback to shm_open.
>>>>>>>
>>>>>>> Yes.
>>>>>>>
>>>>>>>>
>>>>>>>>> I'm hoping we can find a way where it just all is rather intuitive, like
>>>>>>>>>
>>>>>>>>> "default-ram-share=on": behave for internal RAM just like "memory-backend-ram,share=on"
>>>>>>>>>
>>>>>>>>> "memory-backend-ram,share=on": use whatever mechanism we have to give us "anonymous" memory that can be shared using an fd with another process.
>>>>>>>>>
>>>>>>>>> Thoughts?
>>>>>>>>
>>>>>>>> Agreed, though I thought I had already landed at the intuitive specification in my patch.
>>>>>>>> The user must explicitly configure memory-backend-* to be usable with CPR, and anon-alloc
>>>>>>>> controls everything else.  Now we're just riffing on the details: memfd vs shm_open, spelling
>>>>>>>> of options and words to describe them.
>>>>>>>
>>>>>>> Well, yes, and making it all a bit more consistent and the "machine option" behave just like "memory-backend-ram,share=on".
>>>>>>
>>>>>> Hi David and Peter,
>>>>>>
>>>>>> I have implemented and tested the following, for both qemu_memfd_create
>>>>>> and qemu_shm_alloc.  This is pseudo-code, with error conditions omitted
>>>>>> for simplicity.
>>>>>
>>>>> I'm ok with either shm or memfd, as this feature only applies to Linux
>>>>> anyway.  I'll leave that part to you and David to decide.
>>>>>
>>>>>>
>>>>>> Any comments before I submit a complete patch?
>>>>>>
>>>>>> ----
>>>>>> qemu-options.hx:
>>>>>>        ``aux-ram-share=on|off``
>>>>>>            Allocate auxiliary guest RAM as an anonymous file that is
>>>>>>            shareable with an external process.  This option applies to
>>>>>>            memory allocated as a side effect of creating various devices.
>>>>>>            It does not apply to memory-backend-objects, whether explicitly
>>>>>>            specified on the command line, or implicitly created by the -m
>>>>>>            command line option.
>>>>>>
>>>>>>            Some migration modes require aux-ram-share=on.
>>>>>>
>>>>>> qapi/migration.json:
>>>>>>        @cpr-transfer:
>>>>>>             ...
>>>>>>             Memory-backend objects must have the share=on attribute, but
>>>>>>             memory-backend-epc is not supported.  The VM must be started
>>>>>>             with the '-machine aux-ram-share=on' option.
>>>>>>
>>>>>> Define RAM_PRIVATE
>>>>>>
>>>>>> Define qemu_shm_alloc(), from David's tmp patch
>>>>>>
>>>>>> ram_backend_memory_alloc()
>>>>>>        ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
>>>>>>        memory_region_init_ram_flags_nomigrate(ram_flags)
>>>>>
>>>>> Looks all good until here.
>>>>>
>>>>>>
>>>>>> qemu_ram_alloc_internal()
>>>>>>        ...
>>>>>>        if (!host && !(ram_flags & RAM_PRIVATE) && current_machine->aux_ram_share)
>>>>>
>>>>> Nitpick: could rely on flags-only, rather than testing "!host", AFAICT
>>>>> that's equal to RAM_PREALLOC.
>>>>
>>>> IMO testing host is clearer and more future proof, regardless of how flags
>>>> are currently used.  If the caller passes host, then we should not allocate
>>>> memory here, full stop.
>>>>
>>>>> Meanwhile I slightly prefer we don't touch
>>>>> anything if SHARED|PRIVATE is set.
>>>>
>>>> OK, if SHARED is already set I will not set it again.
>>>
>>> We only have to make sure that stuff like qemu_ram_is_shared() will continue working as expected.
>>>
>>> What I think we should do:
>>>
>>> We should probably assert that nobody passes in SHARED|PRIVATE. And we can use PRIVATE only as a parameter to the function, but never actually set it on the ramblock.
>>>
>>> If someone passes in PRIVATE, we don't include it in block->flags. (RMA_SHARED remains cleared)
>>>
>>> If someone passes in SHARED, we do set it in block->flags.
>>> If someone passes PRIVATE|SHARED, we assert.
>>>
>>> If someone passes in nothing: we set block->flags to SHARED with aux_ram_share=on. Otherwise, we do nothing (RAM_SHARED remains cleared)
>>>
>>> If that's also what you had in mind, great.
>>
>> Yes, my patch does that, but it also sets RAM_PRIVATE on the ramblock.
>> I will undo the latter.
> 
> David: why do we need to drop PRIVATE in ramblock flags?  I thought it was
> pretty harmless.  I suppose things like qemu_ram_is_shared() will even keep
> working as before?
> 
> It looks ok to remove it too, but it adds logics that doesn't seem
> necessary to me, so just to double check if I missed something..

A finished ramblock is only boolean "shared" vs. "not shared/private". A 
single flag (RAM_SHARED) can express that clearly.

Consequently there is less to get wrong when using RAM_PRIVATE only as a 
flag to the creation function (and documenting that!).

To make RAM_PRIVATE consistent we might have to tweak all other RAMBlock 
creation functions to set RAM_PRIVATE in the !RAM_SHARED case, and I 
don't think that is wroth the trouble.

-- 
Cheers,

David / dhildenb


