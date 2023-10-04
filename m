Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F87E7B8406
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 17:47:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo44a-0006v6-IG; Wed, 04 Oct 2023 11:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qo449-0006th-Nv
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 11:45:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qo446-0006gX-Rp
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 11:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696434333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uJUNzdBek5iAkE+Amwy37DT7is27Ngfm/KdaavN9yvM=;
 b=g+GXQO9U3q339/RZ24zv2z8y72PcVwWKvv+pTS4KVxqIfgFfBaRJleRioPcS+5GhtaTsrM
 4Bh1Q7wnfqKq73f0GT8nrMNySAk1O5fJTqiLAV0k/YtYR5q8kk2qovMNzSYHnAlgpyV4Vk
 mNDJYBrppQ2Sh1DbZr8g93Dz51W20UM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-490-0EiwqF5LO8Wblrg5WQnFMg-1; Wed, 04 Oct 2023 11:45:28 -0400
X-MC-Unique: 0EiwqF5LO8Wblrg5WQnFMg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 92638101B04C;
 Wed,  4 Oct 2023 15:45:27 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.192.172])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A859840C6EA8;
 Wed,  4 Oct 2023 15:45:23 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 zhenzhong.duan@intel.com, alex.williamson@redhat.com, clg@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, joao.m.martins@oracle.com,
 peterx@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, mjrosato@linux.ibm.com,
 aik@ozlabs.ru
Subject: [PATCH v4 00/15] Prerequisite changes for IOMMUFD support
Date: Wed,  4 Oct 2023 17:43:47 +0200
Message-ID: <20231004154518.334760-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

Hi All,

With the agreement of Zhenzhong, here is a v3 respin of the IOMMUFD
prerequisite series. This applies on top of vfio-next:
https://github.com/legoater/qemu/, branch vfio-next.

Per Cédric's suggestion, the IOMMUFD patchset v1[1] is now split
into two series, this prerequisite series and the new IOMMUFD backend
introduction support series. Hopefully this will ease the review.

The main purpose of this series is to make "common.c" group agnostic:
all group related code are moved into container.c. Then we are prepared
for next series, abstract base container, adding new backend, etc.

This series can be found at 
https://github.com/eauger/qemu/tree/prereq_v4

Test done:
- PCI device were tested
- device hotplug test
- with or without vIOMMU
- VFIO migration with a E800 net card(no dirty sync support) passthrough
- platform and ccw were only compile-tested due to environment limit

Zhenzhong, Yi, Eric

[1] https://lore.kernel.org/all/20230830103754.36461-1-zhenzhong.duan@intel.com/t/#u

Changelog:

v4:
- include qemu/error-report.h in helpers.c
- in ap.c, fix the wrongly added
  vfio_detach_device(vbasedev) and g_free(vbasedev->name);
  also added error_prepend
- simplified vbasedev setting in ccw.c
- vfio_detach_device: dropped check on
  !vbasedev->container
- container.c: restore dropped comment

v3:
- rebased on vfio-next as suggested by Cedric
- added vfio/common: Propagate KVM_SET_DEVICE_ATTR error if any
- collected Cedric's R-b
- Fix some error paths in vfio/cpi which now properly detach the device
  and also free the vbasedev->name
- Fix vfio/ccw migration (hopefully) [Matthew inputs]
- Split [PATCH v2 11/12] vfio/common: Introduce two kinds of VFIO device lists
  into 3 patches

v2:
- Refine patch description per Eric
- return errno and errp in vfio_kvm_device_[add/del]_fd per Eric
- make memory listener register/deregister in seperate patch per Eric
- Include the .h file first per Cédric
- Add trace event in vfio_attach_device per Cédric
- drop the change to vfio_viommu_preset by refactor per Cédric
- Introduce global VFIO device list and per container list per Alex

Note changelog below are from full IOMMUFD series:

v1:
- Alloc hwpt instead of using auto hwpt
- elaborate iommufd code per Nicolin
- consolidate two patches and drop as.c
- typo error fix and function rename

rfcv4:
- rebase on top of v8.0.3
- Add one patch from Yi which is about vfio device add in kvm
- Remove IOAS_COPY optimization and focus on functions in this patchset
- Fix wrong name issue reported and fix suggested by Matthew
- Fix compilation issue reported and fix sugggsted by Nicolin
- Use query_dirty_bitmap callback to replace get_dirty_bitmap for better
granularity
- Add dev_iter_next() callback to avoid adding so many callback
  at container scope, add VFIODevice.hwpt to support that
- Restore all functions back to common from container whenever possible,
  mainly migration and reset related functions
- Add --enable/disable-iommufd config option, enabled by default in linux
- Remove VFIODevice.hwpt_next as it's redundant with VFIODevice.next
- Adapt new VFIO_DEVICE_PCI_HOT_RESET uAPI for IOMMUFD backed device
- vfio_kvm_device_add/del_group call vfio_kvm_device_add/del_fd to remove
redundant code
- Add FD passing support for vfio device backed by IOMMUFD
- Fix hot unplug resource leak issue in vfio_legacy_detach_device()
- Fix FD leak in vfio_get_devicefd()

rfcv3:
- rebase on top of v7.2.0
- Fix the compilation with CONFIG_IOMMUFD unset by using true classes for
  VFIO backends
- Fix use after free in error path, reported by Alister
- Split common.c in several steps to ease the review

rfcv2:
- remove the first three patches of rfcv1
- add open cdev helper suggested by Jason
- remove the QOMification of the VFIOContainer and simply use standard ops
(David)
- add "-object iommufd" suggested by Alex

Thanks
Zhenzhong


Eric Auger (7):
  scripts/update-linux-headers: Add iommufd.h
  vfio/common: Propagate KVM_SET_DEVICE_ATTR error if any
  vfio/common: Introduce vfio_container_add|del_section_window()
  vfio/pci: Introduce vfio_[attach/detach]_device
  vfio/platform: Use vfio_[attach/detach]_device
  vfio/ap: Use vfio_[attach/detach]_device
  vfio/ccw: Use vfio_[attach/detach]_device

Yi Liu (2):
  vfio/common: Move IOMMU agnostic helpers to a separate file
  vfio/common: Move legacy VFIO backend code into separate container.c

Zhenzhong Duan (6):
  linux-headers: Add iommufd.h
  vfio/common: Extract out vfio_kvm_device_[add/del]_fd
  vfio/common: Move VFIO reset handler registration to a group agnostic
    function
  vfio/common: Introduce a per container device list
  vfio/common: Store the parent container in VFIODevice
  vfio/common: Introduce a global VFIODevice list

 include/hw/vfio/vfio-common.h   |   60 +-
 linux-headers/linux/iommufd.h   |  444 ++++++++
 hw/vfio/ap.c                    |   69 +-
 hw/vfio/ccw.c                   |  122 +-
 hw/vfio/common.c                | 1851 ++-----------------------------
 hw/vfio/container.c             | 1157 +++++++++++++++++++
 hw/vfio/helpers.c               |  612 ++++++++++
 hw/vfio/pci.c                   |   67 +-
 hw/vfio/platform.c              |   43 +-
 hw/vfio/meson.build             |    2 +
 hw/vfio/trace-events            |    4 +-
 scripts/update-linux-headers.sh |    3 +-
 12 files changed, 2458 insertions(+), 1976 deletions(-)
 create mode 100644 linux-headers/linux/iommufd.h
 create mode 100644 hw/vfio/container.c
 create mode 100644 hw/vfio/helpers.c

-- 
2.41.0


