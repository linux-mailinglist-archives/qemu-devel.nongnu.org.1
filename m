Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0777CFB91
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:48:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtTMf-00018C-Px; Thu, 19 Oct 2023 09:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qtTMe-00017w-7q
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:47:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qtTMc-0002Sc-1J
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697723220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CMFWaJZjOECyVSpmfQbeH28DH9GydIaSi+W1r190Npg=;
 b=J5Otqy1HSPSZisLT2SlL628IPmvlXJosqzXrnny9O7c95pT99WjWmUIScmj8md5xDIc4kb
 +jBAVvCx//zN1wWks0nIV0I7/8rQqpf88y5AzUZ+YydBYHOTOgFcQ8npf/ZFimWJslDYie
 2adIHe1Kmt5sWiry381T3MsoFEykFBA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-487-dpj1o0YPPWi7Itk0p3cp1w-1; Thu, 19 Oct 2023 09:46:56 -0400
X-MC-Unique: dpj1o0YPPWi7Itk0p3cp1w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2770E82DFB8;
 Thu, 19 Oct 2023 13:46:56 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.195.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5726A492BFA;
 Thu, 19 Oct 2023 13:46:53 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, alex.williamson@redhat.com, clg@redhat.com,
 jean-philippe@linaro.org, mst@redhat.com, pbonzini@redhat.com
Cc: peter.maydell@linaro.org, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org, zhenzhong.duan@intel.com, yi.l.liu@intel.com,
 yanghliu@redhat.com
Subject: [PATCH v4 00/12] VIRTIO-IOMMU/VFIO: Don't assume 64b IOVA space
Date: Thu, 19 Oct 2023 15:45:06 +0200
Message-ID: <20231019134651.842175-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On x86, when assigning VFIO-PCI devices protected with virtio-iommu 
we encounter the case where the guest tries to map IOVAs beyond 48b
whereas the physical VTD IOMMU only supports 48b. This ends up with
VFIO_MAP_DMA failures at qemu level because at kernel level,
vfio_iommu_iova_dma_valid() check returns false on vfio_map_do_map().

This is due to the fact the virtio-iommu currently unconditionally
exposes an IOVA range of 64b through its config input range fields.

This series removes this assumption by retrieving the usable IOVA
regions through the VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE UAPI when
a VFIO device is attached. This info is communicated to the
virtio-iommu memory region, transformed into the inversed info, ie.
the host reserved IOVA regions. Then those latter are combined with the
reserved IOVA regions set though the virtio-iommu reserved-regions
property. That way, the guest virtio-iommu driver, unchanged, is 
able to probe the whole set of reserved regions and prevent any IOVA
belonging to those ranges from beeing used, achieving the original goal.

Best Regards

Eric

This series can be found at:
https://github.com/eauger/qemu/tree/iommu_geometry-v4

History:
v3 -> v4:
- removed nr_iovas (Alex) and droppped last patch (Alex)
- Collected Michael's R-b, Peter's R-b and Yanghang's T-b

v2 -> v3:
- rebase on top of vfio-next (including iommufd prereq)
- take into account IOVA range info capability may not be offered by
  old kernel and use nr_iovas = -1 to encode that [Alex]
- use GList * everywhere instead of arrays (in the range_inverse_array)
  with the benefice it sorts ranges retrieved from the kernel which are
  not garanteed to be sorted. Rework the tests accordingly [Alex]
- Make sure resv_regions GList is build before the probe() [Jean]
  per device list is first populated with prop resv regions on
  IOMMUDevice creation and then rebuilt on set_iova()
- Add a warning if set_iova builds a valid list after probe was
  called [Jean]
- Build host windows on top of IOVA valid ranges if this info can
  be retrieved from the kernel. As many windows are created as
  valid ranges
v1 -> v2:
- Remove "[PATCH 12/13] virtio-iommu: Resize memory region according
  to the max iova info" which causes way too much trouble: trigger
  a coredump in vhost, causes duplication of IOMMU notifiers causing
  EEXIST vfio_dma_map errors, ... This looks like a bad usage of the
  memory API so I prefer removing this from this series. So I was
  also obliged to remove the vfio_find_hostwin() check in the case
  of an IOMMU.
- Let range_inverse_array() take low/high args instead of hardcoding
  0, UINT64_MAX which both complexifies the algo and the tests.
- Move range function description in header.
- Check that if set_iova_ranges is called several times, new resv
  regions are included in previous ones


Eric Auger (12):
  memory: Let ReservedRegion use Range
  memory: Introduce memory_region_iommu_set_iova_ranges
  vfio: Collect container iova range info
  virtio-iommu: Rename reserved_regions into prop_resv_regions
  range: Make range_compare() public
  util/reserved-region: Add new ReservedRegion helpers
  virtio-iommu: Introduce per IOMMUDevice reserved regions
  range: Introduce range_inverse_array()
  virtio-iommu: Record whether a probe request has been issued
  virtio-iommu: Implement set_iova_ranges() callback
  virtio-iommu: Consolidate host reserved regions and property set ones
  test: Add some tests for range and resv-mem helpers

 include/exec/memory.h            |  34 +++-
 include/hw/vfio/vfio-common.h    |   1 +
 include/hw/virtio/virtio-iommu.h |   7 +-
 include/qemu/range.h             |  14 ++
 include/qemu/reserved-region.h   |  32 ++++
 hw/core/qdev-properties-system.c |   9 +-
 hw/vfio/common.c                 |   9 +
 hw/vfio/container.c              |  42 +++-
 hw/virtio/virtio-iommu-pci.c     |   8 +-
 hw/virtio/virtio-iommu.c         | 155 +++++++++++++--
 system/memory.c                  |  13 ++
 tests/unit/test-resv-mem.c       | 318 +++++++++++++++++++++++++++++++
 util/range.c                     |  61 +++++-
 util/reserved-region.c           |  91 +++++++++
 hw/virtio/trace-events           |   1 +
 tests/unit/meson.build           |   1 +
 util/meson.build                 |   1 +
 17 files changed, 764 insertions(+), 33 deletions(-)
 create mode 100644 include/qemu/reserved-region.h
 create mode 100644 tests/unit/test-resv-mem.c
 create mode 100644 util/reserved-region.c

-- 
2.41.0


