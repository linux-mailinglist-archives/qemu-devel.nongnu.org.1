Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1902E7AEBBD
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 13:47:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql6XO-0001w6-OF; Tue, 26 Sep 2023 07:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ql6XN-0001vh-3N
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 07:47:33 -0400
Received: from mgamail.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ql6XK-0002Cy-4u
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 07:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695728850; x=1727264850;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=BUFbJB4vnmfUt4gYX742xJViqWe4Ya72acz490IEYWw=;
 b=Xj/ojLRD3TxoTdLMMthinsQCVHg1+Fdhl97s7eYwPwPu2/Um6dkmMnah
 kQ6CwqDOE5Kcxqslld81uDBVgukZTy8we5dsOWN2SaVIE96QVnJlmXkYn
 mFRaiLjxDsXqMB7bYuMwrk2U7IJESPIhliU0qPzYkUxlPIz6XT97XkrbC
 rO6E4mg3HobV3I89JeirZe9yuBbfaE8oa/wb7W6wWpbkFTlYc1alIOZQu
 ZHSCeS/k5JAIgR/IItTn9Wjo5xQKZR+3MP7ESzZQmZaU6UeCIr372rx9n
 PnQkZl6s4+mfm+I5Un0thN4xEM1KDCIgg86gX38jHRmPhbNf4aE2XJSaI g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="378825385"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; d="scan'208";a="378825385"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2023 04:47:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="748789526"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; d="scan'208";a="748789526"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2023 04:47:20 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 00/12] Prerequisite change for IOMMUFD support
Date: Tue, 26 Sep 2023 19:32:43 +0800
Message-Id: <20230926113255.1177834-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.93;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi All,

Per Cédric's suggestion, the IOMMUFD patchset v1[1] will be splited
to two series, prerequisite patchset and pure IOMMUFD support patchset
to facilitate review. This is the prerequisite one.

The main purpose of this series is to make common.c group agnostic,
all group related code are moved into container.c. Then we are prepared
for next series, abstract base container, adding new backend, etc.

In case someone want to have a preview of the v2 of full IOMMUFD support,
please check github link [2]. For this series, just check
957791f547..609b7836ac in [2].

Test done:
- PCI device were tested
- device hotplug test
- with or without vIOMMU
- VFIO migration with a E800 net card(no dirty sync support) passthrough
- platform, ccw and ap were only compile-tested due to environment limit



[1] https://lore.kernel.org/all/20230830103754.36461-1-zhenzhong.duan@intel.com/t/#u
[2] https://github.com/yiliu1765/qemu/commits/iommufd_cdev_v1_rebased_devlist_split

Changelog:
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

Eric Auger (6):
  scripts/update-linux-headers: Add iommufd.h
  vfio/common: Introduce vfio_container_add|del_section_window()
  vfio/pci: Introduce vfio_[attach/detach]_device
  vfio/platform: Use vfio_[attach/detach]_device
  vfio/ap: Use vfio_[attach/detach]_device
  vfio/ccw: Use vfio_[attach/detach]_device

Yi Liu (2):
  vfio/common: Move IOMMU agnostic helpers to a separate file
  vfio/common: Move legacy VFIO backend code into separate container.c

Zhenzhong Duan (4):
  linux-headers: Add iommufd.h
  vfio/common: Extract out vfio_kvm_device_[add/del]_fd
  vfio/common: Move VFIO reset handler registration to a group agnostic
    function
  vfio/common: Introduce two kinds of VFIO device lists

 include/hw/vfio/vfio-common.h   |   60 +-
 linux-headers/linux/iommufd.h   |  444 ++++++++
 hw/vfio/ap.c                    |   68 +-
 hw/vfio/ccw.c                   |  115 +-
 hw/vfio/common.c                | 1885 +++----------------------------
 hw/vfio/container.c             | 1155 +++++++++++++++++++
 hw/vfio/helpers.c               |  611 ++++++++++
 hw/vfio/pci.c                   |   50 +-
 hw/vfio/platform.c              |   43 +-
 hw/vfio/meson.build             |    2 +
 hw/vfio/trace-events            |    3 +-
 scripts/update-linux-headers.sh |    3 +-
 12 files changed, 2452 insertions(+), 1987 deletions(-)
 create mode 100644 linux-headers/linux/iommufd.h
 create mode 100644 hw/vfio/container.c
 create mode 100644 hw/vfio/helpers.c

-- 
2.34.1


