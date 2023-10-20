Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 378687D0F88
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 14:18:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtoRW-0005E8-To; Fri, 20 Oct 2023 08:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qtoRU-0005Db-2J
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 08:17:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qtoRR-0007B7-GH
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 08:17:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697804244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RTaZB4aPx6HNBLmLCAMu5ymRKKq6c9/CTZq1K5Zepho=;
 b=NqR99jvgefFw66y7hVkCCKKV4hxIrkWYeQaxOoLHRNWgVZQbaug1r24ZyhO2P6u5pOkRT9
 DzAhCrrQ4jr2GhJXPLK9npqUbjJIDpHegvNCqbyqdNa+QAxiyVlnf3ZAg4velhp/70Kdva
 W/cZTJ21LZPWJgiS9ZTChhEbq+Lyv04=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-h6VjgFINPKe9v-sf4l_evw-1; Fri, 20 Oct 2023 08:17:20 -0400
X-MC-Unique: h6VjgFINPKe9v-sf4l_evw-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-66d4aa946ceso12461206d6.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 05:17:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697804240; x=1698409040;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RTaZB4aPx6HNBLmLCAMu5ymRKKq6c9/CTZq1K5Zepho=;
 b=xQRBh43dNlcG9IsGDV27LcxfzsHiPEO5HhCG9SvNF0MOkUdXIv1R77TkztZu1dWss3
 kiZ5S7pbu58U/SvfMBWRFALqTwBtjWG62c4R6oycgxyMAyAZmA+1OemJOwGU/XvKJO0o
 2TF6xfIEytwJ8O9OUdxcFCNNMoEITaWQ7XwSivbKmy0puXddvdJhMTj+4/2bLuqFQcOG
 ILxrYWVvnFD57XX6OczAlNmmhaLUkQGIFQdzMeHHTFFL+jZH5fXGJ2nldeQvfAOfGSuF
 CbB56CHbPgrVjbPYkZ0qWXvZqsMRxT1q12QMIPMyuT5IfuOwhxq/d22B1V8AYgIt7CPi
 4C7A==
X-Gm-Message-State: AOJu0Yzcnij2z1L2KV8qES3u9o1A8bugBKfA0v9Gd9PlUvgN4CKZ8B+z
 TSdv2Vr2yMlsSHDJIOPxRAA65xFANeYD7XXbciJ4jGPCsJjLK8GY823V8Z9ziuLJIhp4vAFyGsm
 /sBs1iUr6mieMEfw=
X-Received: by 2002:ad4:4d43:0:b0:656:500e:7b64 with SMTP id
 m3-20020ad44d43000000b00656500e7b64mr6093823qvm.16.1697804240408; 
 Fri, 20 Oct 2023 05:17:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsrRhGMQtmiU3p7E3DP3ZeJCrutbBOJAq30Ll+La9i6J4McF/bssr2E5K8hOwKq5wH40CJ5w==
X-Received: by 2002:ad4:4d43:0:b0:656:500e:7b64 with SMTP id
 m3-20020ad44d43000000b00656500e7b64mr6093788qvm.16.1697804240081; 
 Fri, 20 Oct 2023 05:17:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 pm10-20020ad446ca000000b0066d1f118b7esm643053qvb.1.2023.10.20.05.17.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Oct 2023 05:17:18 -0700 (PDT)
Message-ID: <50ddc7e8-e28a-428f-a2be-0e5a1d2f7038@redhat.com>
Date: Fri, 20 Oct 2023 14:17:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/12] VIRTIO-IOMMU/VFIO: Don't assume 64b IOVA space
Content-Language: en-US
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, alex.williamson@redhat.com,
 jean-philippe@linaro.org, mst@redhat.com, pbonzini@redhat.com
Cc: peter.maydell@linaro.org, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org, zhenzhong.duan@intel.com, yi.l.liu@intel.com,
 yanghliu@redhat.com
References: <20231019134651.842175-1-eric.auger@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231019134651.842175-1-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/19/23 15:45, Eric Auger wrote:
> On x86, when assigning VFIO-PCI devices protected with virtio-iommu
> we encounter the case where the guest tries to map IOVAs beyond 48b
> whereas the physical VTD IOMMU only supports 48b. This ends up with
> VFIO_MAP_DMA failures at qemu level because at kernel level,
> vfio_iommu_iova_dma_valid() check returns false on vfio_map_do_map().
> 
> This is due to the fact the virtio-iommu currently unconditionally
> exposes an IOVA range of 64b through its config input range fields.
> 
> This series removes this assumption by retrieving the usable IOVA
> regions through the VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE UAPI when
> a VFIO device is attached. This info is communicated to the
> virtio-iommu memory region, transformed into the inversed info, ie.
> the host reserved IOVA regions. Then those latter are combined with the
> reserved IOVA regions set though the virtio-iommu reserved-regions
> property. That way, the guest virtio-iommu driver, unchanged, is
> able to probe the whole set of reserved regions and prevent any IOVA
> belonging to those ranges from beeing used, achieving the original goal.
> 
> Best Regards
> 
> Eric
> 
> This series can be found at:
> https://github.com/eauger/qemu/tree/iommu_geometry-v4

Applied to vfio-next.

Thanks,

C.


> 
> History:
> v3 -> v4:
> - removed nr_iovas (Alex) and droppped last patch (Alex)
> - Collected Michael's R-b, Peter's R-b and Yanghang's T-b
> 
> v2 -> v3:
> - rebase on top of vfio-next (including iommufd prereq)
> - take into account IOVA range info capability may not be offered by
>    old kernel and use nr_iovas = -1 to encode that [Alex]
> - use GList * everywhere instead of arrays (in the range_inverse_array)
>    with the benefice it sorts ranges retrieved from the kernel which are
>    not garanteed to be sorted. Rework the tests accordingly [Alex]
> - Make sure resv_regions GList is build before the probe() [Jean]
>    per device list is first populated with prop resv regions on
>    IOMMUDevice creation and then rebuilt on set_iova()
> - Add a warning if set_iova builds a valid list after probe was
>    called [Jean]
> - Build host windows on top of IOVA valid ranges if this info can
>    be retrieved from the kernel. As many windows are created as
>    valid ranges
> v1 -> v2:
> - Remove "[PATCH 12/13] virtio-iommu: Resize memory region according
>    to the max iova info" which causes way too much trouble: trigger
>    a coredump in vhost, causes duplication of IOMMU notifiers causing
>    EEXIST vfio_dma_map errors, ... This looks like a bad usage of the
>    memory API so I prefer removing this from this series. So I was
>    also obliged to remove the vfio_find_hostwin() check in the case
>    of an IOMMU.
> - Let range_inverse_array() take low/high args instead of hardcoding
>    0, UINT64_MAX which both complexifies the algo and the tests.
> - Move range function description in header.
> - Check that if set_iova_ranges is called several times, new resv
>    regions are included in previous ones
> 
> 
> Eric Auger (12):
>    memory: Let ReservedRegion use Range
>    memory: Introduce memory_region_iommu_set_iova_ranges
>    vfio: Collect container iova range info
>    virtio-iommu: Rename reserved_regions into prop_resv_regions
>    range: Make range_compare() public
>    util/reserved-region: Add new ReservedRegion helpers
>    virtio-iommu: Introduce per IOMMUDevice reserved regions
>    range: Introduce range_inverse_array()
>    virtio-iommu: Record whether a probe request has been issued
>    virtio-iommu: Implement set_iova_ranges() callback
>    virtio-iommu: Consolidate host reserved regions and property set ones
>    test: Add some tests for range and resv-mem helpers
> 
>   include/exec/memory.h            |  34 +++-
>   include/hw/vfio/vfio-common.h    |   1 +
>   include/hw/virtio/virtio-iommu.h |   7 +-
>   include/qemu/range.h             |  14 ++
>   include/qemu/reserved-region.h   |  32 ++++
>   hw/core/qdev-properties-system.c |   9 +-
>   hw/vfio/common.c                 |   9 +
>   hw/vfio/container.c              |  42 +++-
>   hw/virtio/virtio-iommu-pci.c     |   8 +-
>   hw/virtio/virtio-iommu.c         | 155 +++++++++++++--
>   system/memory.c                  |  13 ++
>   tests/unit/test-resv-mem.c       | 318 +++++++++++++++++++++++++++++++
>   util/range.c                     |  61 +++++-
>   util/reserved-region.c           |  91 +++++++++
>   hw/virtio/trace-events           |   1 +
>   tests/unit/meson.build           |   1 +
>   util/meson.build                 |   1 +
>   17 files changed, 764 insertions(+), 33 deletions(-)
>   create mode 100644 include/qemu/reserved-region.h
>   create mode 100644 tests/unit/test-resv-mem.c
>   create mode 100644 util/reserved-region.c
> 


