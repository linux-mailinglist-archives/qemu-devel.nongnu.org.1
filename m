Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6F2716BC2
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 20:00:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q43dh-00086e-V6; Tue, 30 May 2023 14:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q43de-00082L-6L
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:00:06 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q43db-00029v-2v
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:00:05 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34UE4uZS016936; Tue, 30 May 2023 17:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=kzTOzYuyZLfETfZowPYRoozY6FIt5l3czx3/6DU3ZPM=;
 b=clHjapKBA4k3qigAKzp8n8lRJY121THxz1qMTss+AE+63mNN6mLunGy6IO43GIPMx6xA
 ngCt0qTlfXcgzVla/I7TU0QHVDhYxKVUZUBuXMiGdzSAigO/W9tx6yHcgGAFDBTri8aM
 TWRzx7Bt2HP/2VGNhlZIDq7sKCKolu1is/ctPoI9miQcwIEXO9aU3DSjH02aa2NDAQXQ
 wTlyeT7LNJ4zcl+VJT8YqGcFWYtuiTGNdYAzYji8e2o60Q3rNd3aaX48WwAT+N6ZnAfd
 OU+0QPp4u+uaXrTfPT3p+VL0SDnnH6gMkIndga7eCiiQXIFFfDe7+XolWm+zh1WL3hp5 uQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhjkketj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 May 2023 17:59:55 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34UHHZnF014645; Tue, 30 May 2023 17:59:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3qu8a48sx0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 May 2023 17:59:54 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34UHxspB011459;
 Tue, 30 May 2023 17:59:54 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-191-61.vpn.oracle.com
 [10.175.191.61])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3qu8a48srr-1; Tue, 30 May 2023 17:59:54 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Avihai Horon <avihaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v3 00/15] vfio: VFIO migration support with vIOMMU
Date: Tue, 30 May 2023 18:59:22 +0100
Message-Id: <20230530175937.24202-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_13,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305300144
X-Proofpoint-ORIG-GUID: vEl2Yjg6OmG4znrMSqP3xLWFDbMhrB4C
X-Proofpoint-GUID: vEl2Yjg6OmG4znrMSqP3xLWFDbMhrB4C
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 URI_TRY_3LD=1.517 autolearn=no autolearn_force=no
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

Hey folks,

This series introduces support for vIOMMU with VFIO device migration,
particurlarly related to how we do the dirty page tracking. This is a v3
follow-up containing the vIOMMU subset of v2[0], but with some new changes,
some simplifications and finer grained scope.

Today vIOMMUs serve two purposes: 1) enable interrupt remaping 2)
provide dma translation services for guests to provide some form of
guest kernel managed DMA e.g. for nested virt based usage; (1) is specially
required for big VMs with VFs with more than 255 vcpus. We tackle both
and remove the migration blocker when vIOMMU is present provided the
conditions are met. I have both use-cases here in one series, but I am happy
to tackle them in separate series.

As I found out we don't necessarily need to expose the whole vIOMMU
functionality in order to just support interrupt remapping. x86 IOMMUs
on Windows Server 2018[2] and Linux >=5.10, with qemu 7.1+ (or really
Linux guests with commit c40aaaac10 and since qemu commit 8646d9c773d8)
can instantiate a IOMMU just for interrupt remapping without needing to
be advertised/support DMA translation. AMD IOMMU in theory can provide
the same, but Linux doesn't quite support the IR-only part there yet,
only intel-iommu.

The series is organized as following:

Patches 1-5: Today we can't gather vIOMMU details before the guest
establishes their first DMA mapping via the vIOMMU. So these first four
patches add a way for vIOMMUs to be asked of their properties.
Essentially by being able to return IOMMU MR to upper layers. The last
patch of this uses the new pci_setup_iommu_info() in intel-iommu, which
then lets VFIO fetch the IOMMU MR and use it to gather the necessary
properties that are added in follow-up patches. I choose the least churn
possible way for now (as opposed to a treewide conversion) and allow easy
conversion a posteriori.

Patches 6-8: Handle configs with vIOMMU interrupt remapping but without
DMA translation allowed. Today the 'dma-translation' attribute is
x86-iommu only, but the way this series is structured nothing stops from
other vIOMMUs supporting it too as long as they use
pci_setup_iommu_info() and the necessary IOMMU MR get_attr attributes
are handled. The blocker is thus relaxed when vIOMMUs are able to toggle
the toggle/report DMA_TRANSLATION attribute. With the patches up to this set,
we've then tackled item (1) of the second paragraph.

Patches 9-15: Simplified a lot from v2 (patch 9) to only track the complete
IOVA address space, leveraging the logic we use to compose the dirty ranges.
The blocker is once again relaxed for vIOMMUs that advertise their IOVA
addressing limits. This tackles item (2). So far I mainly use it with
intel-iommu, although I have a small set of patches for virtio-iommu per
Alex's suggestion in v2.

Comments, suggestions welcome. Thanks for the review!

Regards,
	Joao

Changes since v2[3]:
* New patches 1-9 to be able to handle vIOMMUs without DMA translation, and
introduce ways to know various IOMMU model attributes via the IOMMU MR. This
is partly meant to address a comment in previous versions where we can't
access the IOMMU MR prior to the DMA mapping happening. Before this series
vfio giommu_list is only tracking 'mapped GIOVA' and that controlled by the
guest. As well as better tackling of the IOMMU usage for interrupt-remapping
only purposes. 
* Dropped Peter Xu ack on patch 9 given that the code changed a bit.
* Adjust patch 14 to adjust for the VFIO bitmaps no longer being pointers.
* The patches that existed in v2 of vIOMMU dirty tracking, are mostly
* untouched, except patch 12 which was greatly simplified.

Changes since v1[4]:
- Rebased on latest master branch. As part of it, made some changes in
  pre-copy to adjust it to Juan's new patches:
  1. Added a new patch that passes threshold_size parameter to
     .state_pending_{estimate,exact}() handlers.
  2. Added a new patch that refactors vfio_save_block().
  3. Changed the pre-copy patch to cache and report pending pre-copy
     size in the .state_pending_estimate() handler.
- Removed unnecessary P2P code. This should be added later on when P2P
  support is added. (Alex)
- Moved the dirty sync to be after the DMA unmap in vfio_dma_unmap()
  (patch #11). (Alex)
- Stored vfio_devices_all_device_dirty_tracking()'s value in a local
  variable in vfio_get_dirty_bitmap() so it can be re-used (patch #11).
- Refactored the viommu device dirty tracking ranges creation code to
  make it clearer (patch #15).
- Changed overflow check in vfio_iommu_range_is_device_tracked() to
  emphasize that we specifically check for 2^64 wrap around (patch #15).
- Added R-bs / Acks.

[0] https://lore.kernel.org/qemu-devel/20230222174915.5647-1-avihaih@nvidia.com/
[1] https://lore.kernel.org/qemu-devel/c66d2d8e-f042-964a-a797-a3d07c260a3b@oracle.com/
[2] https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/oem-kernel-dma-protection
[3] https://lore.kernel.org/qemu-devel/20230222174915.5647-1-avihaih@nvidia.com/
[4] https://lore.kernel.org/qemu-devel/20230126184948.10478-1-avihaih@nvidia.com/

Avihai Horon (4):
  memory/iommu: Add IOMMU_ATTR_MAX_IOVA attribute
  intel-iommu: Implement IOMMU_ATTR_MAX_IOVA get_attr() attribute
  vfio/common: Extract vIOMMU code from vfio_sync_dirty_bitmap()
  vfio/common: Optimize device dirty page tracking with vIOMMU

Joao Martins (11):
  hw/pci: Refactor pci_device_iommu_address_space()
  hw/pci: Add a pci_setup_iommu_info() helper
  hw/pci: Add a pci_device_iommu_memory_region() helper
  intel-iommu: Switch to pci_setup_iommu_info()
  vfio/common: Track the IOMMU MR behind the device in addition to the AS
  memory/iommu: Add IOMMU_ATTR_DMA_TRANSLATION attribute
  intel-iommu: Implement get_attr() method
  vfio/common: Relax vIOMMU detection when DMA translation is off
  vfio/common: Move dirty tracking ranges update to helper
  vfio/common: Support device dirty page tracking with vIOMMU
  vfio/common: Block migration with vIOMMUs without address width limits

 hw/i386/intel_iommu.c         |  40 ++++-
 hw/pci/pci.c                  |  21 ++-
 hw/vfio/common.c              | 265 +++++++++++++++++++++++++++-------
 hw/vfio/pci.c                 |   4 +
 include/exec/memory.h         |   4 +-
 include/hw/pci/pci.h          |  38 ++++-
 include/hw/pci/pci_bus.h      |   1 +
 include/hw/vfio/vfio-common.h |   1 +
 8 files changed, 309 insertions(+), 65 deletions(-)

-- 
2.39.3


