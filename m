Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6BB830103
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 09:06:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ0uf-000298-Hy; Wed, 17 Jan 2024 03:04:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rQ0ub-00027E-ON
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 03:04:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rQ0uR-00032r-OF
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 03:04:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705478666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tRwUXM4uEOyRCpSPFh7F6GKgG/yzJq5yx0Ax39Yn5Pc=;
 b=VB7xaDja5MLnDCMlev973NrCFOOoKihxZyv/fktYtGH6TQ1F+Z0/CYNH2Lup+S4ErK2tcm
 kwPTScOjMIBmoxkat2LGM3Kpgz7Rw74hoBFkkouNAwSITglrbvjT6+WhzY4nqZXEvXqOWV
 306F4QPLBch1b54eemcqPMA0dGNR+5Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-198-pKFr1q1oOUKOEwDnv8PCBg-1; Wed,
 17 Jan 2024 03:04:24 -0500
X-MC-Unique: pKFr1q1oOUKOEwDnv8PCBg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 808373C0008C;
 Wed, 17 Jan 2024 08:04:24 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.192.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E733F1BDB0;
 Wed, 17 Jan 2024 08:04:21 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, jean-philippe@linaro.org, alex.williamson@redhat.com,
 peter.maydell@linaro.org, zhenzhong.duan@intel.com, peterx@redhat.com,
 yanghliu@redhat.com, pbonzini@redhat.com
Cc: mst@redhat.com,
	clg@redhat.com
Subject: [RFC 0/7] VIRTIO-IOMMU/VFIO: Fix host iommu geometry handling for
 hotplugged devices
Date: Wed, 17 Jan 2024 09:02:04 +0100
Message-ID: <20240117080414.316890-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

In [1] we attempted to fix a case where a VFIO-PCI device protected
with a virtio-iommu was assigned to an x86 guest. On x86 the physical
IOMMU may have an address width (gaw) of 39 or 48 bits whereas the
virtio-iommu used to expose a 64b address space by default.
Hence the guest was trying to use the full 64b space and we hit
DMA MAP failures. To work around this issue we managed to pass
usable IOVA regions (excluding the out of range space) from VFIO 
to the virtio-iommu device. This was made feasible by introducing
a new IOMMU Memory Region callback dubbed iommu_set_iova_regions().
This latter gets called when the IOMMU MR is enabled which
causes the vfio_listener_region_add() to be called.

However with VFIO-PCI hotplug, this technique fails due to the
race between the call to the callback in the add memory listener
and the virtio-iommu probe request. Indeed the probe request gets
called before the attach to the domain. So in that case the usable
regions are communicated after the probe request and fail to be
conveyed to the guest. To be honest the problem was hinted by
Jean-Philippe in [1] and I should have been more careful at
listening to him and testing with hotplug :-(

For coldplugged device the technique works because we make sure all
the IOMMU MR are enabled once on the machine init done: 94df5b2180
("virtio-iommu: Fix 64kB host page size VFIO device assignment")
for granule freeze. But I would be keen to get rid of this trick.

Using an IOMMU MR Ops is unpractical because this relies on the IOMMU
MR to have been enabled and the corresponding vfio_listener_region_add()
to be executed. Instead this series proposes to replace the usage of this
API by the recently introduced PCIIOMMUOps: ba7d12eb8c  ("hw/pci: modify
pci_setup_iommu() to set PCIIOMMUOps"). That way, the callback can be
called earlier, once the usable IOVA regions have been collected by
VFIO, without the need for the IOMMU MR to be enabled.

This looks cleaner. In the short term this may also be used for
passing the page size mask, which would allow to get rid of the
hacky transient IOMMU MR enablement mentionned above.

[1] [PATCH v4 00/12] VIRTIO-IOMMU/VFIO: Don't assume 64b IOVA space
    https://lore.kernel.org/all/20231019134651.842175-1-eric.auger@redhat.com/

[2] https://lore.kernel.org/all/20230929161547.GB2957297@myrica/

Extra Notes:
With that series, the reserved memory regions are communicated on time
so that the virtio-iommu probe request grabs them. However this is not
sufficient. In some cases (my case), I still see some DMA MAP failures
and the guest keeps on using IOVA ranges outside the geometry of the
physical IOMMU. This is due to the fact the VFIO-PCI device is in the
same iommu group as the pcie root port. Normally the kernel
iova_reserve_iommu_regions (dma-iommu.c) is supposed to call reserve_iova()
for each reserved IOVA, which carves them out of the allocator. When
iommu_dma_init_domain() gets called for the hotplugged vfio-pci device
the iova domain is already allocated and set and we don't call
iova_reserve_iommu_regions() again for the vfio-pci device. So its
corresponding reserved regions are not properly taken into account.

This is not trivial to fix because theoretically the 1st attached
devices could already have allocated IOVAs within the reserved regions
of the second device. Also we are somehow hijacking the reserved
memory regions to model the geometry of the physical IOMMU so not sure
any attempt to fix that upstream will be accepted. At the moment one
solution is to make sure assigned devices end up in singleton group.
Another solution is to work on a different approach where the gaw
can be passed as an option to the virtio-iommu device, similarly at
what is done with intel iommu.

This series can be found at:
https://github.com/eauger/qemu/tree/hotplug-resv-rfc


Eric Auger (7):
  hw/pci: Introduce PCIIOMMUOps::set_host_iova_regions
  hw/pci: Introduce pci_device_iommu_bus
  vfio/pci: Pass the usable IOVA ranges through PCIIOMMUOps
  virtio-iommu: Implement PCIIOMMUOps set_host_resv_regions
  virtio-iommu: Remove the implementation of iommu_set_iova_ranges
  hw/vfio: Remove memory_region_iommu_set_iova_ranges() call
  memory: Remove IOMMU MR iommu_set_iova_range API

 include/exec/memory.h    |  32 -------
 include/hw/pci/pci.h     |  16 ++++
 hw/pci/pci.c             |  16 ++++
 hw/vfio/common.c         |  10 --
 hw/vfio/pci.c            |  27 ++++++
 hw/virtio/virtio-iommu.c | 201 ++++++++++++++++++++-------------------
 system/memory.c          |  13 ---
 7 files changed, 160 insertions(+), 155 deletions(-)

-- 
2.41.0


