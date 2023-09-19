Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F627A5BFC
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 10:09:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiVmw-0006tN-GV; Tue, 19 Sep 2023 04:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qiVmu-0006t0-7l
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 04:08:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qiVmh-0005HL-G7
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 04:08:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695110917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BveVHYYbO9DMBCSLkgW/QuwL2eKkh2hmhggCOlIxrUs=;
 b=eITbfNFhmWFMxltzFvOS/lewy3Gx6s7OAwy9rM5bMKtmMT3d3C+QF2kh3EZJBb8qeg2zv3
 Q/Xw5NCQaz3j4iUEq5055VPAjFN+vBr79oER70JEjPoJMXp+7AprzXgXvPjZT0AIxQyeb6
 Jv27/kOqkl1ej7gcfsjDEXiVCQCW/Fc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-gaWJ58vtOOiSWwedLejCeQ-1; Tue, 19 Sep 2023 04:08:35 -0400
X-MC-Unique: gaWJ58vtOOiSWwedLejCeQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31fe49c6bb1so3268401f8f.0
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 01:08:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695110914; x=1695715714;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BveVHYYbO9DMBCSLkgW/QuwL2eKkh2hmhggCOlIxrUs=;
 b=Qdw1NyUEV0APDiV3AGDQS9K/7qMyKw7gV0QFrzz0cu2mRCRH1Cp6dnohl20SbcuzWc
 +rcNk0DsgG6uFUqBCQMgouetL3q1Q4rXpGQhdYo+97nMxVOiJtj73UauiizILkqa0vI+
 OsJJ1+1Qsgox48jtSB+5WL1Ut/4R5eGqNV7SkZusWAwyPjOTUHvnHwRwD4RSuwlj8pKK
 k+9Bc+cWlWDgQXXj3cfo9FgJ1266CLUinSf2zt9NP8VO3QMygL3NKNTN/akMfyJdcCVT
 /ttChatiruILL/GSrmMYmidneQgyjiC1VN9pvUua6NEAJWDrZkFNbDfYwb9UEuMsjZTM
 d9+g==
X-Gm-Message-State: AOJu0Yw0Qbh7bdhEUMfTuXWBlZbwgy2CQHHyDnwbJJtoRqwO/890RbCm
 pld7imjtfxsVCPmdKXpkrAlAkTpFgKdOsyV54JzHOQhhpN88sByxyPvyGd7m0EnlAdQjbYj5uNL
 kTLDe/La69qMmE2o=
X-Received: by 2002:a5d:6485:0:b0:320:9e7:d525 with SMTP id
 o5-20020a5d6485000000b0032009e7d525mr8214185wri.46.1695110914490; 
 Tue, 19 Sep 2023 01:08:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjoEewH4/J/mLuuTmhBrNBs5PW3xkGMnD88BecOO/HJMuXnEDilXTe1ru1ao2gMAWWe5aq6w==
X-Received: by 2002:a5d:6485:0:b0:320:9e7:d525 with SMTP id
 o5-20020a5d6485000000b0032009e7d525mr8214154wri.46.1695110914048; 
 Tue, 19 Sep 2023 01:08:34 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:1300:c409:8b33:c793:108e?
 (p200300cbc7021300c4098b33c793108e.dip0.t-ipconnect.de.
 [2003:cb:c702:1300:c409:8b33:c793:108e])
 by smtp.gmail.com with ESMTPSA id
 h18-20020a5d5052000000b0031ad5470f89sm10076490wrt.18.2023.09.19.01.08.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Sep 2023 01:08:33 -0700 (PDT)
Message-ID: <0ad650b9-2420-8715-bddf-1e5cf1f05797@redhat.com>
Date: Tue, 19 Sep 2023 10:08:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 14/16] virtio-mem: Expose device memory via multiple
 memslots if enabled
Content-Language: en-US
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Michal Privoznik <mprivozn@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Gavin Shan <gshan@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
References: <20230908142136.403541-1-david@redhat.com>
 <20230908142136.403541-15-david@redhat.com>
 <e9cdf797-1497-ae65-9ac9-da0effb303d6@maciej.szmigiero.name>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <e9cdf797-1497-ae65-9ac9-da0effb303d6@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, SPF_HELO_NONE=0.001,
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

On 17.09.23 13:47, Maciej S. Szmigiero wrote:
> On 8.09.2023 16:21, David Hildenbrand wrote:
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
>> We'll auto-detect the number of memslots to use based on the memslot limit
>> provided by the core. We'll use at most 1 memslot per gigabyte. Note that
>> our global limit of memslots accross all memory devices is currently set to
>> 256: even with multiple large virtio-mem devices, we'd still have a sane
>> limit on the number of memslots used.
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
> 
> Reviewed-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> 
> Hope this patch was well-tested, especially on corner cases, since
> it's very easy to make an off-by-one somewhere (like v1 had) and
> much harder to spot it when doing a static code review.

I did test this series reasonably well indeed. Especially, also 
exercising the corner case of the last memslot having a different size.

Thanks for all the review!

-- 
Cheers,

David / dhildenb


