Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CE97921AA
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 11:50:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdShT-00075M-2g; Tue, 05 Sep 2023 05:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qdShQ-000755-Jo
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 05:50:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qdShN-0003Fs-OY
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 05:50:20 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-S62RRQ0gMD2weKfNa7x_gQ-1; Tue, 05 Sep 2023 05:50:15 -0400
X-MC-Unique: S62RRQ0gMD2weKfNa7x_gQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-31dc8f0733dso1162327f8f.3
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 02:50:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693907414; x=1694512214;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IIyPiU3SGizoQEzrYTb1AqPw/vH1eVycuDo31fRpA9Y=;
 b=AQIn8UOr4Tkdp3ifIko99mMIck1B6APp0ZQGYKsB1hK2nHP1HqPLdhOr5XGUIWFudS
 n0ichl4e0xINO5v3+qinChl/ZLhGkKbar5wse13GqzbdRnl0fPAtm/Z1rKNH3m1SXgfo
 hOVi3rhjqcEWNjfabjGDToyQBjmdq48qqZNayciRrg0lN7ncm6OYKmfjF4YAs3DWOQJP
 yMXyI3YZv3P2s8zzN7W/8jANaFhoUKJVIcQYT2ZAWnvUgATKCuVzbmG4EsmKg6F5kNoY
 B9Tzc5liiJCcvmXGlxA1VUCaI8dYDGI/VqRY8I0BRTreZWncLeV9ixvxs3hw7OyFcq69
 6eaQ==
X-Gm-Message-State: AOJu0YynyzM3yBWJpneaLLmIWYLw/Na76n86l4UvEW6/A0Uy1EDTPMLf
 R6hMKkxViS3W7n2A3h0O7S+K9gA2nHXBo1p1rued39crYvwq43bLUs6sQqbzaQLA5PxpNn7VOCW
 fcMUCQ8OBvdR/DU4=
X-Received: by 2002:a5d:6690:0:b0:317:3deb:a899 with SMTP id
 l16-20020a5d6690000000b003173deba899mr9179639wru.1.1693907414201; 
 Tue, 05 Sep 2023 02:50:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0VR70RIxx+42qFvbQ2IpIg3vI14rtvxIx5mx88VWidO7S+RXVoia5RGX+25Rkjgaz/RJkfw==
X-Received: by 2002:a5d:6690:0:b0:317:3deb:a899 with SMTP id
 l16-20020a5d6690000000b003173deba899mr9179622wru.1.1693907413886; 
 Tue, 05 Sep 2023 02:50:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d9-20020a5d4f89000000b0031c5b380291sm17027815wru.110.2023.09.05.02.50.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 02:50:12 -0700 (PDT)
Message-ID: <5757bc33-fd76-345d-ca28-1aa382472b84@redhat.com>
Date: Tue, 5 Sep 2023 11:50:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 00/13] VIRTIO-IOMMU/VFIO: Don't assume 64b IOVA space
Content-Language: en-US
To: YangHang Liu <yanghliu@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 alex.williamson@redhat.com, clg@redhat.com, jean-philippe@linaro.org,
 mst@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org
References: <20230904080451.424731-1-eric.auger@redhat.com>
 <CAGYh1E9+odNLWuuPQdb4RqcSh-uDHW0DiVCKVJH=oA56BqqPtw@mail.gmail.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CAGYh1E9+odNLWuuPQdb4RqcSh-uDHW0DiVCKVJH=oA56BqqPtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi,

On 9/5/23 10:22, YangHang Liu wrote:
> I have runned the following two tests, but both tests failed:
> [1] start a VM with virtio-iommu + 2 ice PFs only via qemu-kvm 8.1.5
> Test result : the qemu-kvm keeps throwing the error:  VFIO_MAP_DMA
> failed: File exists. vfio_dma_map(0x56443d20fbe0, 0xffffe000, 0x1000,
> 0x7fb545709000) = -17 (File exists)
> [2] start a VM with virtio-iommu + 2 ice PFs via libvirt-9.5 + qemu-kvm 8.1.5
> Test result: the qemu-kvm core dump with
> ERROR:../qom/object.c:1198:object_unref: assertion failed: (obj->ref >
> 0). Bail out! ERROR:../qom/object.c:1198:object_unref: assertion
> failed: (obj->ref > 0)
This latter issue is introduced by patch
[PATCH 12/13] virtio-iommu: Resize memory region according to the max
iova info
and especially the call to

memory_region_set_size(&mr->parent_obj, max_iova + 1);

I don't really get why at the moment but I will investigate ... Eric

>
> After removing the 2 PF from the VM, both tests passed.
>
> Tested-by: Yanghang Liu <yanghliu@redhat.com>
>
> Best Regards,
> YangHang Liu
>
>
> On Mon, Sep 4, 2023 at 4:08 PM Eric Auger <eric.auger@redhat.com> wrote:
>> On x86, when assigning VFIO-PCI devices protected with virtio-iommu
>> we encounter the case where the guest tries to map IOVAs beyond 48b
>> whereas the physical VTD IOMMU only supports 48b. This ends up with
>> VFIO_MAP_DMA failures at qemu level because at kernel level,
>> vfio_iommu_iova_dma_valid() check returns false on vfio_map_do_map().
>>
>> This is due to the fact the virtio-iommu currently unconditionally
>> exposes an IOVA range of 64b through its config input range fields.
>>
>> This series removes this assumption by retrieving the usable IOVA
>> regions through the VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE UAPI when
>> a VFIO device is attached. This info is communicated to the
>> virtio-iommu memory region, transformed into the inversed info, ie.
>> the host reserved IOVA regions. Then those latter are combined with the
>> reserved IOVA regions set though the virtio-iommu reserved-regions
>> property. That way, the guest virtio-iommu driver, unchanged, is
>> able to probe the whole set of reserved regions and prevent any IOVA
>> belonging to those ranges from beeing used, achieving the original goal.
>>
>> Best Regards
>>
>> Eric
>>
>> This series can be found at:
>> https://github.com/eauger/qemu/tree/virtio-iommu_geometry_v1
>>
>> Eric Auger (13):
>>   memory: Let ReservedRegion use Range
>>   memory: Introduce memory_region_iommu_set_iova_ranges
>>   vfio: Collect container iova range info
>>   virtio-iommu: Rename reserved_regions into prop_resv_regions
>>   virtio-iommu: Introduce per IOMMUDevice reserved regions
>>   range: Introduce range_inverse_array()
>>   virtio-iommu: Implement set_iova_ranges() callback
>>   range: Make range_compare() public
>>   util/reserved-region: Add new ReservedRegion helpers
>>   virtio-iommu: Consolidate host reserved regions and property set ones
>>   test: Add some tests for range and resv-mem helpers
>>   virtio-iommu: Resize memory region according to the max iova info
>>   vfio: Remove 64-bit IOVA address space assumption
>>
>>  include/exec/memory.h            |  30 ++++-
>>  include/hw/vfio/vfio-common.h    |   2 +
>>  include/hw/virtio/virtio-iommu.h |   7 +-
>>  include/qemu/range.h             |   9 ++
>>  include/qemu/reserved-region.h   |  32 +++++
>>  hw/core/qdev-properties-system.c |   9 +-
>>  hw/vfio/common.c                 |  70 ++++++++---
>>  hw/virtio/virtio-iommu-pci.c     |   8 +-
>>  hw/virtio/virtio-iommu.c         |  85 +++++++++++--
>>  softmmu/memory.c                 |  15 +++
>>  tests/unit/test-resv-mem.c       | 198 +++++++++++++++++++++++++++++++
>>  util/range.c                     |  41 ++++++-
>>  util/reserved-region.c           |  94 +++++++++++++++
>>  hw/virtio/trace-events           |   1 +
>>  tests/unit/meson.build           |   1 +
>>  util/meson.build                 |   1 +
>>  16 files changed, 562 insertions(+), 41 deletions(-)
>>  create mode 100644 include/qemu/reserved-region.h
>>  create mode 100644 tests/unit/test-resv-mem.c
>>  create mode 100644 util/reserved-region.c
>>
>> --
>> 2.41.0
>>
>>


