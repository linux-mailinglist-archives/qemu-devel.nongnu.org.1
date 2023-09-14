Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA737A0511
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 15:10:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgm6a-0003wa-AR; Thu, 14 Sep 2023 09:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qgm6Z-0003wM-CQ
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 09:09:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qgm6X-0006zO-MG
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 09:09:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694696996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7ChIOmTfd7o/NKHWUFFWtkJ2XI7L7oPGwY6YJ68EaFI=;
 b=G6VIdx0rC0/8NalnkpsZPLbIIN19U0E+4bc5eRdiWjEmXwaq5PY2GAMWsZ2Ssd4sTibDhR
 kmFiOBw7KyKqTIyM2tvJmdwSBnrw3V1nUxXfbpomdzD7LUuU+M53iips0A0f8Rky+srXIp
 eMH+zh7uTWeL0T7sIhLh6EeqSVNsnIw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-azQL-VImOwqQ22vQdJtzEA-1; Thu, 14 Sep 2023 09:09:49 -0400
X-MC-Unique: azQL-VImOwqQ22vQdJtzEA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4011fa32e99so7208625e9.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 06:09:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694696988; x=1695301788;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7ChIOmTfd7o/NKHWUFFWtkJ2XI7L7oPGwY6YJ68EaFI=;
 b=jcrl3yBb+3Z0JofcLuKaZl6v4eOS7psi6cXXjB0Ul9FJQrLwKGDkUhWD9s0dRu5RUs
 qdHGeNAtVgz5mn81hy0ZzQe3ZBmCz0iVGWGt2bJFL2fE/dAEUeGvfruikv77GK6qPdtZ
 L9s0o/OgMXTCdBrkdNvl3CHGX06csAK8FE1hKtkqEXoJhDp2jn7HvS2iOKFkl0Cq3Ejf
 dzpamxgW0GDu96EAn6AZSGya0o4EdrCjS7TFsnMAQI4WA2WQQqbW25e8SnNH34tXaQEc
 s5OF+s+aeV8FMzxqpA+Eb1bndBjFeF5kMtukUPWhF00erFtTpaNjk7aRX9blFjCBP5te
 3bZA==
X-Gm-Message-State: AOJu0Yw50SgEoqkIak606PDzRy0mi9hH4fbRL5d9miO3QqwzRa9LZ43Z
 /8jJUWrGampQicz6WVkrYh9io5HK4oeXsEWVhDk1aOCcdBbwSliU9mkEy702fKYRkJhS2B05wPv
 i4UugZ9DmJddJ3kM=
X-Received: by 2002:a05:6000:1d83:b0:31f:e1b4:5846 with SMTP id
 bk3-20020a0560001d8300b0031fe1b45846mr1230564wrb.53.1694696988340; 
 Thu, 14 Sep 2023 06:09:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWujUSunuwo9Kqn3OnEp5AQVDiwQj77GqWQB/Z9xX2vzqdYchUWZp0OuKiR/MfisxVkzDOxw==
X-Received: by 2002:a05:6000:1d83:b0:31f:e1b4:5846 with SMTP id
 bk3-20020a0560001d8300b0031fe1b45846mr1230544wrb.53.1694696987868; 
 Thu, 14 Sep 2023 06:09:47 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7?
 ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
 by smtp.gmail.com with ESMTPSA id
 t3-20020a05600001c300b003143b14848dsm1713172wrx.102.2023.09.14.06.09.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 06:09:46 -0700 (PDT)
Message-ID: <fe9f3d19-df01-01e6-a253-f7fe5bdea41f@redhat.com>
Date: Thu, 14 Sep 2023 15:09:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Michael Roth <michael.roth@amd.com>, isaku.yamahata@gmail.com,
 Sean Christopherson <seanjc@google.com>, Claudio Fontana <cfontana@suse.de>
References: <20230914035117.3285885-1-xiaoyao.li@intel.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH v2 00/21] QEMU gmem implemention
In-Reply-To: <20230914035117.3285885-1-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 14.09.23 05:50, Xiaoyao Li wrote:
> It's the v2 RFC of enabling KVM gmem[1] as the backend for private
> memory.
> 
> For confidential-computing, KVM provides gmem/guest_mem interfaces for
> userspace, like QEMU, to allocate user-unaccesible private memory. This
> series aims to add gmem support in QEMU's RAMBlock so that each RAM can
> have both hva-based shared memory and gmem_fd based private memory. QEMU
> does the shared-private conversion on KVM_MEMORY_EXIT and discards the
> memory.
> 
> It chooses the design that adds "private" property to hostmeory backend.
> If "private" property is set, QEMU will allocate/create KVM gmem when
> initialize the RAMbloch of the memory backend.
> 
> This sereis also introduces the first user of kvm gmem,
> KVM_X86_SW_PROTECTED_VM. A KVM_X86_SW_PROTECTED_VM with private KVM gmem
> can be created with
> 
>    $qemu -object sw-protected-vm,id=sp-vm0 \
> 	-object memory-backend-ram,id=mem0,size=1G,private=on \
> 	-machine q35,kernel_irqchip=split,confidential-guest-support=sp-vm0,memory-backend=mem0 \
> 	...
> 
> Unfortunately this patch series fails the boot of OVMF at very early
> stage due to triple fault, because KVM doesn't support emulating string IO
> to private memory.

Is support being added? Or have we figured out what it would take to 
make it work?

How does this interact with other features (memory ballooning, virtiofs, 
vfio/mdev/...)?

> 
> This version still leave some opens to be discussed:
> 1. whether we need "private" propery to be user-settable?
> 
>     It seems unnecessary because vm-type is determined. If the VM is
>     confidential-guest, then the RAM of the guest must be able to be
>     mapped as private, i.e., have kvm gmem backend. So QEMU can
>     determine the value of "private" property automatiacally based on vm
>     type.
> 
>     This also aligns with the board internal MemoryRegion that needs to
>     have kvm gmem backend, e.g., TDX requires OVMF to act as private
>     memory so bios memory region needs to have kvm gmem fd associated.
>     QEMU no doubt will do it internally automatically.

Would it make sense to have some regions without "pivate" semantics? 
Like NVDIMMs?

> 
> 2. hugepage support.
> 
>     KVM gmem can be allocated from hugetlbfs. How does QEMU determine
>     when to allocate KVM gmem with KVM_GUEST_MEMFD_ALLOW_HUGEPAGE. The
>     easiest solution is create KVM gmem with KVM_GUEST_MEMFD_ALLOW_HUGEPAGE
>     only when memory backend is HostMemoryBackendFile of hugetlbfs.

Good question.

Probably "if the memory backend uses huge pages, also use huge pages for 
the private gmem" makes sense.

... but it becomes a mess with preallocation ... which is what people 
should actually be using with hugetlb. Andeventual double 
memory-consumption ... but maybe that's all been taken care of already?

Probably it's best to leave hugetlb support as future work and start 
with something minimal.

> 
> 3. What is KVM_X86_SW_PROTECTED_VM going to look like? and do we need it?
> 

Why implement it when you have to ask others for a motivation? ;)

Personally, I'm not sure if it is really useful, especially in this state.

>     This series implements KVM_X86_SW_PROTECTED_VM because it's introduced
>     with gmem together on KVM side and it's supposed to be the first user
>     who requires KVM gmem. However the implementation is incomplete and
>     there lacks the definition of how KVM_X86_SW_PROTECTED_VM works.

Then it should not be included in this series such that you can make 
progress with the gmem implementation for TDX guests instead?

-- 
Cheers,

David / dhildenb


