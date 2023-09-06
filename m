Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27467793575
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 08:41:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdmDW-0003y3-1M; Wed, 06 Sep 2023 02:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qdmD9-0003xL-VD
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 02:40:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qdmD6-0001s6-Jc
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 02:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693982419;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VWp1WBgxxC0M2B0L2AakfIxxKdTjnUzirVKKkUNtu60=;
 b=aXKx+4Yy662GCEG9hU7TI77q2th0pscqmGuG4lEjy0T4TLK+HCmTUI5cIGufUJMpR5bDKh
 G/pF7rZ72PV9XGeCriEMHG9fd5MDGJmI83afGVVP/xcpCifjqUkLKLHz/qLz44vKVCFMfD
 L9AofkuilT3ndl7u5+TWuQ9tX8KuG9k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-88Fmw-Q5NOuujPkvoC2W2Q-1; Wed, 06 Sep 2023 02:40:17 -0400
X-MC-Unique: 88Fmw-Q5NOuujPkvoC2W2Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fef5403093so2682095e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 23:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693982417; x=1694587217;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VWp1WBgxxC0M2B0L2AakfIxxKdTjnUzirVKKkUNtu60=;
 b=EGxmNHp/0xfBOPfnwZ9rh3tbh+t90ZjyMTvB34fQhGGmlPZH2OCxCIzg3ZtPNt2520
 JQGQADeZXfL98ULG+38xnynWtHGhJ0zl73pprYn0ERPZJCC2x42f7jfH8EjiJngiQ3hU
 82HwBwf7F7K4ABvaqZ+JMEZBepY50/1Ho3hACMi1eVrbrYvK4W2gBwU5K11wUSwJAjg6
 GTjYHM/jhASz8EJNj4pcct+jS0kUwA0Wje6ROZr62qIZrWDeczTP1WQTtSYMWlUItDxl
 4Jhx1+MBKumSYN6Jro7xGWSI9Z4PJnmCK0AsEfhCnZXsOMlKulDXlphcYd+lakiSa3HE
 MHmg==
X-Gm-Message-State: AOJu0YypQd4ZMq/G0FDTMwrKs3ireKhW05WIjATVdhQUzGOv+3f1KwpO
 gf20ZK2c8k7s7UQBSTJbNPW/QSwez8alK06Z4hN/6vt/BxDtgw9Y+x/q/TJ8jYJ2WoUI2N3nKOn
 66miAXVgHtV+f4As=
X-Received: by 2002:a05:600c:4f91:b0:401:bd94:f45b with SMTP id
 n17-20020a05600c4f9100b00401bd94f45bmr1610161wmq.4.1693982416879; 
 Tue, 05 Sep 2023 23:40:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg1EOZ0E+Rmmhs4gdAcQ8F0iY7P1vUr7MOt9Oz/30gPEy5tFfZ5yyN8HKPOVwrlAyzygYe3Q==
X-Received: by 2002:a05:600c:4f91:b0:401:bd94:f45b with SMTP id
 n17-20020a05600c4f9100b00401bd94f45bmr1610148wmq.4.1693982416538; 
 Tue, 05 Sep 2023 23:40:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 m9-20020a7bcb89000000b003fe26244858sm22007296wmi.46.2023.09.05.23.40.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 23:40:15 -0700 (PDT)
Message-ID: <157e137d-d5a5-8091-412a-da13c0e7f7b0@redhat.com>
Date: Wed, 6 Sep 2023 08:40:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 00/13] VIRTIO-IOMMU/VFIO: Don't assume 64b IOVA space
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 clg@redhat.com, jean-philippe@linaro.org, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, peterx@redhat.com,
 david@redhat.com, philmd@linaro.org
References: <20230904080451.424731-1-eric.auger@redhat.com>
 <20230905115558.590ea2e5.alex.williamson@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230905115558.590ea2e5.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Alex,

On 9/5/23 19:55, Alex Williamson wrote:
> On Mon,  4 Sep 2023 10:03:43 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
>
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
> Hi Eric,
>
> I don't quite follow this relative to device hotplug.  Are we
> manipulating a per-device memory region which is created at device add
> time?  Is that memory region actually shared in some cases, for instance
> if we have a PCIe-to-PCI bridge aliasing devices on the conventional
> side?  Thanks,
I agree this deserves more attention and testing in the case of hotplug
and aliasing. Wrt PCIe to PCI bridge, virtio-iommu and smmu are known to
be broken with this latter due to lack of kernel support (issue with
group probing, but this might change in the future) so this is not a
currently supported feature, as opposed to virtual intel iommu. Here I
was mostly assuming one device per container and per IOMMU MR but maybe
I have to detect & forbid more complex scenari.

Thanks

Eric
> Alex
>
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


