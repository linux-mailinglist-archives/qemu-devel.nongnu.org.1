Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 703EC753759
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 12:02:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKFbv-00015x-Fp; Fri, 14 Jul 2023 06:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qKFbt-00015p-6d
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 06:01:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qKFbr-0000OA-Bb
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 06:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689328869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ByDDVD7NvmFd68eU5Z++57AQqEgF+MqIckZ78qu/j2w=;
 b=MZDPnydm2vlDix/QDCp92NlL1TpWyYibZxS4nJ7OXXbConkcX1mLUsitpoPqGn02WLpT4n
 HU1QZEvhJq8fEuAVoZrTGyERfdZV7xriKSwGLHHYc3aTNehGVcrax00ZKitXliplbh2AJE
 340I2W3RU+z/I4LGKKyZPg4zvL8XmO4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-tdh9iwCNMD-gvy_BbjGcUA-1; Fri, 14 Jul 2023 06:01:07 -0400
X-MC-Unique: tdh9iwCNMD-gvy_BbjGcUA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fbe4cecd66so9271045e9.1
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 03:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689328866; x=1691920866;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ByDDVD7NvmFd68eU5Z++57AQqEgF+MqIckZ78qu/j2w=;
 b=i8XpqwLyM69PLkc2ccZrZhnk5IxOsS/8eWC/1XmjE7tEkszOJnyaaF5yzNCkX2xZKA
 a/lZutZbsW6Y0zp5LnuLcIxwYcQXSZSR3UfXx8pBumWCjoJ1bQKAezBkDvmjqINFCa+9
 w12PA1+ctdBi+JgoXSeMbbYrKSaV51lvN5s7N+157ZvtlFuvBdj11TVUeScH6uayRWKE
 dhXeFfj/dna0tH+bdYGb5flEBYZFZWt3Mim9Sp6oJVtjeshBuohKNEAfDW+vU5uTUKe5
 F9B+8YU9KFPvS+TmqMv3JQp4x+tu3OdiyX2Go8VYLrt+uk8/jpUgT8wx8flbPUfDeU3I
 xWuA==
X-Gm-Message-State: ABy/qLZ1mMYCUNFZQhCe/DC4Us6D2NvkzsXohAzeMiv7ukHLHiakxL6m
 jVnfs6td0AwY5faEldl4G9/gaUcb3WkB3lDWmFpl6VUhXGfnIQb6EJvGV/TqaI7T5ECggWc1Rj4
 M3QeU5I7ZBfWCyBg=
X-Received: by 2002:a7b:c4d6:0:b0:3fb:ffef:d058 with SMTP id
 g22-20020a7bc4d6000000b003fbffefd058mr3305830wmk.0.1689328866470; 
 Fri, 14 Jul 2023 03:01:06 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHXE8cK5NLzeNgnPR7I5WnnP+S9CriZyncawrgO53haG2186lf7f4Na9CvD0LOX1aylIcQTxQ==
X-Received: by 2002:a7b:c4d6:0:b0:3fb:ffef:d058 with SMTP id
 g22-20020a7bc4d6000000b003fbffefd058mr3305792wmk.0.1689328866005; 
 Fri, 14 Jul 2023 03:01:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:4500:8a9e:a24a:133d:86bb?
 (p200300cbc70a45008a9ea24a133d86bb.dip0.t-ipconnect.de.
 [2003:cb:c70a:4500:8a9e:a24a:133d:86bb])
 by smtp.gmail.com with ESMTPSA id
 f17-20020a7bcd11000000b003fc02218d6csm1037545wmj.25.2023.07.14.03.01.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Jul 2023 03:01:05 -0700 (PDT)
Message-ID: <34f749c1-db52-f435-f887-f8a9852150d1@redhat.com>
Date: Fri, 14 Jul 2023 12:01:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 13/15] virtio-mem: Expose device memory via multiple
 memslots if enabled
Content-Language: en-US
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Michal Privoznik <mprivozn@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Gavin Shan <gshan@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 kvm@vger.kernel.org
References: <20230616092654.175518-1-david@redhat.com>
 <20230616092654.175518-14-david@redhat.com>
 <3bd720ec-8f61-d3e9-c998-4873e0c4f778@maciej.szmigiero.name>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <3bd720ec-8f61-d3e9-c998-4873e0c4f778@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.096, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 13.07.23 21:58, Maciej S. Szmigiero wrote:
> On 16.06.2023 11:26, David Hildenbrand wrote:
>> Having large virtio-mem devices that only expose little memory to a VM
>> is currently a problem: we map the whole sparse memory region into the
>> guest using a single memslot, resulting in one gigantic memslot in KVM.
>> KVM allocates metadata for the whole memslot, which can result in quite
>> some memory waste.
>>
>> Assuming we have a 1 TiB virtio-mem device and only expose little (e.g.,
>> 1 GiB) memory, we would create a single 1 TiB memslot and KVM has to
>> allocate metadata for that 1 TiB memslot: on x86, this implies allocating
>> a significant amount of memory for metadata:
>>
>> (1) RMAP: 8 bytes per 4 KiB, 8 bytes per 2 MiB, 8 bytes per 1 GiB
>>       -> For 1 TiB: 2147483648 + 4194304 + 8192 = ~ 2 GiB (0.2 %)
>>
>>       With the TDP MMU (cat /sys/module/kvm/parameters/tdp_mmu) this gets
>>       allocated lazily when required for nested VMs
>> (2) gfn_track: 2 bytes per 4 KiB
>>       -> For 1 TiB: 536870912 = ~512 MiB (0.05 %)
>> (3) lpage_info: 4 bytes per 2 MiB, 4 bytes per 1 GiB
>>       -> For 1 TiB: 2097152 + 4096 = ~2 MiB (0.0002 %)
>> (4) 2x dirty bitmaps for tracking: 2x 1 bit per 4 KiB page
>>       -> For 1 TiB: 536870912 = 64 MiB (0.006 %)
>>
>> So we primarily care about (1) and (2). The bad thing is, that the
>> memory consumption *doubles* once SMM is enabled, because we create the
>> memslot once for !SMM and once for SMM.
>>
>> Having a 1 TiB memslot without the TDP MMU consumes around:
>> * With SMM: 5 GiB
>> * Without SMM: 2.5 GiB
>> Having a 1 TiB memslot with the TDP MMU consumes around:
>> * With SMM: 1 GiB
>> * Without SMM: 512 MiB
>>
>> ... and that's really something we want to optimize, to be able to just
>> start a VM with small boot memory (e.g., 4 GiB) and a virtio-mem device
>> that can grow very large (e.g., 1 TiB).
>>
>> Consequently, using multiple memslots and only mapping the memslots we
>> really need can significantly reduce memory waste and speed up
>> memslot-related operations. Let's expose the sparse RAM memory region using
>> multiple memslots, mapping only the memslots we currently need into our
>> device memory region container.
>>
>> * With VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE, we only map the memslots that
>>     actually have memory plugged, and dynamically (un)map when
>>     (un)plugging memory blocks.
>>
>> * Without VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE, we always map the memslots
>>     covered by the usable region, and dynamically (un)map when resizing the
>>     usable region.
>>
>> We'll auto-determine the number of memslots to use based on the suggested
>> memslot limit provided by the core. We'll use at most 1 memslot per
>> gigabyte. Note that our global limit of memslots accross all memory devices
>> is currently set to 256: even with multiple large virtio-mem devices, we'd
>> still have a sane limit on the number of memslots used.
>>
>> The default is a single memslot for now ("multiple-memslots=off"). The
>> optimization must be enabled manually using "multiple-memslots=on", because
>> some vhost setups (e.g., hotplug of vhost-user devices) might be
>> problematic until we support more memslots especially in vhost-user
>> backends.
>>
>> Note that "multiple-memslots=on" is just a hint that multiple memslots
>> *may* be used for internal optimizations, not that multiple memslots
>> *must* be used. The actual number of memslots that are used is an
>> internal detail: for example, once memslot metadata is no longer an
>> issue, we could simply stop optimizing for that. Migration source and
>> destination can differ on the setting of "multiple-memslots".
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>    hw/virtio/virtio-mem-pci.c     |  21 +++
>>    hw/virtio/virtio-mem.c         | 265 ++++++++++++++++++++++++++++++++-
>>    include/hw/virtio/virtio-mem.h |  23 ++-
>>    3 files changed, 304 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/virtio/virtio-mem-pci.c b/hw/virtio/virtio-mem-pci.c
>> index b85c12668d..8b403e7e78 100644
>> --- a/hw/virtio/virtio-mem-pci.c
>> +++ b/hw/virtio/virtio-mem-pci.c
> (...)
>> @@ -790,6 +921,43 @@ static void virtio_mem_system_reset(void *opaque)
>>        virtio_mem_unplug_all(vmem);
>>    }
>>    
>> +static void virtio_mem_prepare_mr(VirtIOMEM *vmem)
>> +{
>> +    const uint64_t region_size = memory_region_size(&vmem->memdev->mr);
>> +
>> +    g_assert(!vmem->mr);
>> +    vmem->mr = g_new0(MemoryRegion, 1);
>> +    memory_region_init(vmem->mr, OBJECT(vmem), "virtio-mem",
>> +                       region_size);
>> +    vmem->mr->align = memory_region_get_alignment(&vmem->memdev->mr);
>> +}
>> +
>> +static void virtio_mem_prepare_memslots(VirtIOMEM *vmem)
>> +{
>> +    const uint64_t region_size = memory_region_size(&vmem->memdev->mr);
>> +    unsigned int idx;
>> +
>> +    g_assert(!vmem->memslots && vmem->nb_memslots);
>> +    vmem->memslots = g_new0(MemoryRegion, vmem->nb_memslots);
>> +
>> +    /* Initialize our memslots, but don't map them yet. */
>> +    for (idx = 0; idx < vmem->nb_memslots; idx++) {
>> +        const uint64_t memslot_offset = idx * vmem->memslot_size;
>> +        uint64_t memslot_size = vmem->memslot_size;
>> +        char name[20];
>> +
>> +        /* The size of the last memslot might be smaller. */
>> +        if (idx == vmem->nb_memslots) {                       ^
> I guess this should be "vmem->nb_memslots - 1" since that's the last
> memslot index.

Indeed, thanks!

-- 
Cheers,

David / dhildenb


