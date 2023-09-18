Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C8B7A464D
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 11:46:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiAoy-0005pq-2e; Mon, 18 Sep 2023 05:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qiAou-0005pe-H7
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 05:45:32 -0400
Received: from mgamail.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qiAoe-0000xd-AS
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 05:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695030316; x=1726566316;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=UVp0CJUm5LMb+MNWX99N/OHn1q0qDkXvZqlrb6wgIL4=;
 b=R2D/2F0JPInTt4JT+NGoXDflk3BvUVwoeA8YjbL/VkThTPR3DcRZrTck
 pSbTKmQ6Kn0oR9y8v+MxY6RKWsQdLB26O+vLUtjmfn9qp7rfBO9r/oNKK
 x5Cbz9VbfHajA4r6jcBcdynk9xNol5JKF7U8Wl9muY9J+YUEOGxiS1ILk
 U9YbBCh/nYAgz9LZFJDxQYzC5l7EbfDpmvs2UJ5cLq3NXo+0gewhurbAz
 7kqqiND+zlkRB9d+TvIWsPUBgGGBqP/IciEqlF2knEYqsuNi30af4rHmW
 dtZlftVGZlN0tSsS6/qlhgwo6YgrR2o//MbH6WcQ2KryDuThqPVcqLIVh Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="446072265"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; d="scan'208";a="446072265"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2023 02:45:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="835955924"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; d="scan'208";a="835955924"
Received: from vmmteam.bj.intel.com ([10.240.193.84])
 by FMSMGA003.fm.intel.com with ESMTP; 18 Sep 2023 02:45:08 -0700
From: Jing Liu <jing2.liu@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, pbonzini@redhat.com,
 kevin.tian@intel.com, reinette.chatre@intel.com, jing2.liu@intel.com,
 jing2.liu@linux.intel.com
Subject: [PATCH v2 0/4] Support dynamic MSI-X allocation
Date: Mon, 18 Sep 2023 05:45:03 -0400
Message-Id: <20230918094507.409050-1-jing2.liu@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.100; envelope-from=jing2.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

 hw/vfio/pci.c        | 121 +++++++++++++++++++++++++++++++++----------
 hw/vfio/pci.h        |   1 +
 hw/vfio/trace-events |   2 +-
 3 files changed, 96 insertions(+), 28 deletions(-)

-- 
2.27.0


