Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D087792157
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 11:16:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdSAB-0003Ue-Aa; Tue, 05 Sep 2023 05:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qdSA5-0003Tl-Mw
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 05:15:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qdSA3-0004bJ-2J
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 05:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693905348;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WQ0UxSlZiBSY1y9/4HeAknNre1JVBLbWoe1nygen67I=;
 b=felHu9J+syanEXKmU8Ffu4lHVl8/pNu0pWvw0g/ywua40i7YqEJCWRjUI/7hdVNu3bM3c6
 l9vMKik/nYMzcav/npem+2En0O7/hLFTGdZsSMnfypgUnbXBs/CnOJ1OR4Mu0s4BDVuQn3
 50SQtHI3TNOwLxs2nyboi3BP+SaENv0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-W713G7XOOUq6PVruYqKUtQ-1; Tue, 05 Sep 2023 05:15:47 -0400
X-MC-Unique: W713G7XOOUq6PVruYqKUtQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-401db2550e0so16346615e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 02:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693905346; x=1694510146;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WQ0UxSlZiBSY1y9/4HeAknNre1JVBLbWoe1nygen67I=;
 b=Y4aK0f0gWdu1eo/gWfG+0rSphnmOUWdUh6LMGRDxn/h2euqYxUH4wZ6HR48AuchbJs
 A9rqvur6s7hhhaqtrgyvDHw47yiYSKVOySvoucxAt+wFABMm1ltbdK7J1D9SMV2TKLPD
 zF6JNGSRtSdEYLgugKaRpQ5eozBESTfUWhgaG/8c/nwoizLeHiA1kKnQ9BP9xMG51K85
 Y3QKl7wF75uB7Lq48o0rQDyFjo5R5hr4hAz/ZvZHPVFQLzsedacJzX56teh+VMWpfIyI
 DqzuIOFmatFKOWPq8LDnhe6En7U7uJs23NKP9NOhVPCVxlle9JNDCb948t6rKLmmLqtp
 czQw==
X-Gm-Message-State: AOJu0YxMMH/OtOxrnyqZAEdXgBFSRyxTlngZr+bb1S9fqvFxB5McV2YF
 oq0S6Guj+2yz9Mmy/QzBQdgJShXQnzgBLUF3bNTV0uj7O2zBtt71/OSwOs6xTuEHXc7K1JpPrtR
 Q+uqWF8GcXBCqkpY=
X-Received: by 2002:a7b:cd0a:0:b0:3fe:795:712a with SMTP id
 f10-20020a7bcd0a000000b003fe0795712amr8876322wmj.27.1693905346521; 
 Tue, 05 Sep 2023 02:15:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKKpQ/Ysvnt3iNTCGAn77xZn7nQ5it320TwUra/CUmTYbNDXS3h60OgggUQLSqJCIAXb+5/w==
X-Received: by 2002:a7b:cd0a:0:b0:3fe:795:712a with SMTP id
 f10-20020a7bcd0a000000b003fe0795712amr8876303wmj.27.1693905346145; 
 Tue, 05 Sep 2023 02:15:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 x3-20020adff643000000b003188358e08esm16734090wrp.42.2023.09.05.02.15.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 02:15:45 -0700 (PDT)
Message-ID: <6ce3daf9-b2c8-bd6e-a502-0870f8b17913@redhat.com>
Date: Tue, 5 Sep 2023 11:15:43 +0200
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
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Yanghang,

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
>
> After removing the 2 PF from the VM, both tests passed.
> Tested-by: Yanghang Liu <yanghliu@redhat.com>

thank you for testing. If my understanding is correct you still
encountered some issues with/after the series. If this is correct you
shall not offer your Tested-by which means you tested the series and it
works fine for you/fixes your issue.

Coming back to the above mentionned issues:

1) the File Exists issue is known and is linked to the replay. This will
be handled separately, ie.I need to resume working on it as my first
approach was flawed: See
https://lore.kernel.org/all/20221207133646.635760-1-eric.auger@redhat.com/
This is unrelated to this series. Note this shouldn't prevent your
passthroughed device from working. Those should be just spurious
warnings that need to be removed.

2) the object_unref assertion most probaly is linked to that series and
I will to investigate asap.

Thank you again!

Eric
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


