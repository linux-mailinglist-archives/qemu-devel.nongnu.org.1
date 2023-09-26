Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DB17AE39B
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 04:15:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkxai-0004di-Eu; Mon, 25 Sep 2023 22:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qkxag-0004dY-9L
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 22:14:22 -0400
Received: from mgamail.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qkxad-0002dW-7p
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 22:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695694459; x=1727230459;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=r/I6s+UocvNhx/65ZzmGKd25yAc9e9MLAZSZB5AmxoE=;
 b=XWW45xOIMg2SBfl9tOHIOYbqfJSsEW8QBpbH2gPNeEd0SOdYXST8m9J8
 GKxSFsVx5zgSJIBmp45p9PaU9Lo18/ApW9WQkm8Mj1atiJhKA0NZY0Ph6
 M2QjVv4fHtVZEkOieeyYFuTICrt4+W0G8ufjPgEugFEwCS98mfI1Dy4G5
 zW4F+69zIlbK2eeqqvE6GEWL77WzEkS8v44//Ff2EAttTR+H0p3U4wVur
 pe0TaFwE1CcZ3xQWpARWw/yaKmwKLAOnB9X9PXblP22uzj3acWtwN+zKd
 RiDuV1m69wKpuIDNxYi1XQYpl53RvJVlGB6L1V/ZSgAaGpS/zgAxrEnqi g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="412380118"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; d="scan'208";a="412380118"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2023 19:14:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="698283001"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; d="scan'208";a="698283001"
Received: from vmmteam.bj.intel.com ([10.240.193.84])
 by orsmga003.jf.intel.com with ESMTP; 25 Sep 2023 19:14:11 -0700
From: Jing Liu <jing2.liu@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, pbonzini@redhat.com,
 kevin.tian@intel.com, reinette.chatre@intel.com, jing2.liu@intel.com,
 jing2.liu@linux.intel.com
Subject: [PATCH v3 0/4] Support dynamic MSI-X allocation
Date: Mon, 25 Sep 2023 22:14:03 -0400
Message-Id: <20230926021407.580305-1-jing2.liu@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.88; envelope-from=jing2.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Changes since v2:
- v2: https://www.mail-archive.com/qemu-devel@nongnu.org/msg989852.html
- Use a bool type to test (vdev->nr_vectors < nr + 1). (Alex)
- Revise comments. (Alex)
- Apply Cédric's and Alex's Reviewed-by.

Changes since v1:
- v1: https://www.mail-archive.com/qemu-devel@nongnu.org/msg982842.html
- Revise Qemu to QEMU. (Cédric)
- Add g_free when failure of getting MSI-X irq info. (Cédric)
- Apply Cédric's Reviewed-by. (Cédric)
- Use g_autofree to automatically release. (Cédric)
- Remove the failure message in vfio_enable_msix_no_vec(). (Cédric)

Changes since RFC v1:
- RFC v1: https://www.mail-archive.com/qemu-devel@nongnu.org/msg978637.html
- Revise the comments. (Alex)
- Report error of getting irq info and remove the trace of failure
  case. (Alex, Cédric)
- Only store dynamic allocation flag as a bool type and test
  accordingly. (Alex)
- Move dynamic allocation detection to vfio_msix_early_setup(). (Alex)
- Change the condition logic in vfio_msix_vector_do_use() that moving
  the defer_kvm_irq_routing test out and create a common place to update
  nr_vectors. (Alex)
- Consolidate the way of MSI-X enabling during device initialization and
  interrupt restoring that uses fd = -1 trick. Create a function doing
  that. (Alex)

Before kernel v6.5, dynamic allocation of MSI-X interrupts was not
supported. QEMU therefore when allocating a new interrupt, should first
release all previously allocated interrupts (including disable of MSI-X)
and re-allocate all interrupts that includes the new one.

The kernel series [1] adds the support of dynamic MSI-X allocation to
vfio-pci and uses the existing flag VFIO_IRQ_INFO_NORESIZE to guide user
space, that when dynamic MSI-X is supported the flag is cleared.

This series makes the behavior for VFIO PCI devices when dynamic MSI-X
allocation is supported. When guest unmasks an interrupt, QEMU can
directly allocate an interrupt on host for this and has nothing to do
with the previously allocated ones. Therefore, host only allocates
interrupts for those unmasked (enabled) interrupts inside guest when
dynamic MSI-X allocation is supported by device.

When guests enable MSI-X with all of the vectors masked, QEMU need match
the state to enable MSI-X with no vector enabled. During migration
restore, QEMU also need enable MSI-X first in dynamic allocation mode,
to avoid the guest unused vectors being allocated on host. To
consolidate them, we use vector 0 with an invalid fd to get MSI-X
enabled and create a common function for this. This is cleaner than
setting userspace triggering and immediately release.

Any feedback is appreciated.

Jing

[1] https://lwn.net/Articles/931679/

Jing Liu (4):
  vfio/pci: detect the support of dynamic MSI-X allocation
  vfio/pci: enable vector on dynamic MSI-X allocation
  vfio/pci: use an invalid fd to enable MSI-X
  vfio/pci: enable MSI-X in interrupt restoring on dynamic allocation

 hw/vfio/pci.c        | 123 +++++++++++++++++++++++++++++++++----------
 hw/vfio/pci.h        |   1 +
 hw/vfio/trace-events |   2 +-
 3 files changed, 97 insertions(+), 29 deletions(-)

-- 
2.27.0


