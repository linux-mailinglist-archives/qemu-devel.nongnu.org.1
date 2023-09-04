Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7797912EB
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 10:07:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd4bE-0000vK-Lh; Mon, 04 Sep 2023 04:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qd4b7-0000uF-TH
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 04:06:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qd4b1-00066m-Sm
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 04:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693814766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Zd/6v3BsL0KyyFR68OoyvGRfd8uUwyY2DGLwqKdIYqY=;
 b=JlUZ3Fb/+sJEbve2sXi+r689/sCWNKwXqAijzbCI9RlF1Rfu5UTx7OiFzH1Y9lcCazggzt
 n13huNJlL1wa2SyKbLcgjbEeKBvzCadCsCCwIaNJxP95pZBeTdCE0uAbXd0C1EJVKEQOsW
 JSV1iFBv5R3hGny9VRRxwr9eGdWDCcw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-94-ZPDVc1K3Peu9O1cz0RKkPQ-1; Mon, 04 Sep 2023 04:04:57 -0400
X-MC-Unique: ZPDVc1K3Peu9O1cz0RKkPQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B67591817903;
 Mon,  4 Sep 2023 08:04:56 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.192.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 45ED340C6CCC;
 Mon,  4 Sep 2023 08:04:54 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, alex.williamson@redhat.com, clg@redhat.com,
 jean-philippe@linaro.org, mst@redhat.com, pbonzini@redhat.com
Cc: peter.maydell@linaro.org, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org
Subject: [PATCH 00/13] VIRTIO-IOMMU/VFIO: Don't assume 64b IOVA space
Date: Mon,  4 Sep 2023 10:03:43 +0200
Message-ID: <20230904080451.424731-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
https://github.com/eauger/qemu/tree/virtio-iommu_geometry_v1

Eric Auger (13):
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
  virtio-iommu: Resize memory region according to the max iova info
  vfio: Remove 64-bit IOVA address space assumption

 include/exec/memory.h            |  30 ++++-
 include/hw/vfio/vfio-common.h    |   2 +
 include/hw/virtio/virtio-iommu.h |   7 +-
 include/qemu/range.h             |   9 ++
 include/qemu/reserved-region.h   |  32 +++++
 hw/core/qdev-properties-system.c |   9 +-
 hw/vfio/common.c                 |  70 ++++++++---
 hw/virtio/virtio-iommu-pci.c     |   8 +-
 hw/virtio/virtio-iommu.c         |  85 +++++++++++--
 softmmu/memory.c                 |  15 +++
 tests/unit/test-resv-mem.c       | 198 +++++++++++++++++++++++++++++++
 util/range.c                     |  41 ++++++-
 util/reserved-region.c           |  94 +++++++++++++++
 hw/virtio/trace-events           |   1 +
 tests/unit/meson.build           |   1 +
 util/meson.build                 |   1 +
 16 files changed, 562 insertions(+), 41 deletions(-)
 create mode 100644 include/qemu/reserved-region.h
 create mode 100644 tests/unit/test-resv-mem.c
 create mode 100644 util/reserved-region.c

-- 
2.41.0


