Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CAD79E175
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 10:06:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgKrY-0000pB-AC; Wed, 13 Sep 2023 04:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qgKrW-0000oK-2g
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 04:04:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qgKrS-0004gA-8k
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 04:04:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694592273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PPVRIvAgkA5YR8E3rFX/1jrGZAYS59cVb1MApJrU1Gs=;
 b=TQan/RhXkRgYYQ5ezTr2kUzo5Rnw4dKk9cNfEfGD+Pz6U7PFuvQfEO63CIT6xpd1FN1OMA
 NqRxCkDr1L7bcYHhSoN2LIRcIzByXbpw/X02xDe18p1avixuOAsYjS86K/U4xFyznNPScy
 RbxArT2GB+k+iQJMDqRn+xOvxS4QIdc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-496--REtdB83M3ymPXBpAG1Hkw-1; Wed, 13 Sep 2023 04:04:30 -0400
X-MC-Unique: -REtdB83M3ymPXBpAG1Hkw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE2F8816521;
 Wed, 13 Sep 2023 08:04:29 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.192.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7EEA12026D4B;
 Wed, 13 Sep 2023 08:04:27 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, alex.williamson@redhat.com, clg@redhat.com,
 jean-philippe@linaro.org, mst@redhat.com, pbonzini@redhat.com
Cc: peter.maydell@linaro.org, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org
Subject: [PATCH v2 00/12] VIRTIO-IOMMU/VFIO: Don't assume 64b IOVA space
Date: Wed, 13 Sep 2023 10:01:35 +0200
Message-ID: <20230913080423.523953-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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
https://github.com/eauger/qemu/tree/virtio-iommu_geometry_v2

History:
v1 -> v2:
- Remove "[PATCH 12/13] virtio-iommu: Resize memory region according
  to the max iova info" which causes way too much trouble: trigger
  a coredump in vhost, causes duplication of IOMMU notifiers causing
  EEXIST vfio_dma_map errors, ... This looks like a bad usage of the
  memory API so I prefer removing this from this series. So I was
  also obliged to remove the vfio_find_hostwin() check in the case
  of an IOMMU MR.
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
  virtio-iommu: Introduce per IOMMUDevice reserved regions
  range: Introduce range_inverse_array()
  virtio-iommu: Implement set_iova_ranges() callback
  range: Make range_compare() public
  util/reserved-region: Add new ReservedRegion helpers
  virtio-iommu: Consolidate host reserved regions and property set ones
  test: Add some tests for range and resv-mem helpers
  vfio: Remove 64-bit IOVA address space assumption

 include/exec/memory.h            |  30 +++-
 include/hw/vfio/vfio-common.h    |   2 +
 include/hw/virtio/virtio-iommu.h |   7 +-
 include/qemu/range.h             |  14 ++
 include/qemu/reserved-region.h   |  32 ++++
 hw/core/qdev-properties-system.c |   9 +-
 hw/vfio/common.c                 |  70 +++++++--
 hw/virtio/virtio-iommu-pci.c     |   8 +-
 hw/virtio/virtio-iommu.c         | 110 ++++++++++++--
 softmmu/memory.c                 |  15 ++
 tests/unit/test-resv-mem.c       | 251 +++++++++++++++++++++++++++++++
 util/range.c                     |  51 ++++++-
 util/reserved-region.c           |  94 ++++++++++++
 hw/virtio/trace-events           |   1 +
 tests/unit/meson.build           |   1 +
 util/meson.build                 |   1 +
 16 files changed, 655 insertions(+), 41 deletions(-)
 create mode 100644 include/qemu/reserved-region.h
 create mode 100644 tests/unit/test-resv-mem.c
 create mode 100644 util/reserved-region.c

-- 
2.41.0


