Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B663A783AE7
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 09:30:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYLpw-0005aP-D5; Tue, 22 Aug 2023 03:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qYLpu-0005Zl-73
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:29:58 -0400
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qYLpq-0006Wr-1h
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:29:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692689394; x=1724225394;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=e58hLIHYkWdNqJIdJ3HCB3XmeGaT0A3zC7hvBwllKb4=;
 b=isrDHnQAeiqiKWK+SDHca3vOSyzRVAFZRIQHP4NgOGXx7Mf3o9/WDz37
 4LuIS9JN5zVECL44QqZR+punRZLkX4/EnllYEWNHJJZzy9pWz4BrgAe5Q
 ocf9AXjN/4XvtXh5UkpmBg8CVZpawU9TwzUtJxS8knPi+kURse3u6U/5s
 njRcd81JfHJ9lCZz7qiyHkLElYzggizYj2/mb7KnGRoVzMAHzeQlGDsrw
 CzeYNDcJRfQ7vr62rivzFtmCZR0lb3t/Jd+6MFxS0tcV468kmqzTFMiE4
 0z+UVFcfpxZTA4qSgbK0WOq4vzk2KCBFZIoJd8pEinv8nOpaHv6xqZgRg Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="437721767"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; d="scan'208";a="437721767"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Aug 2023 00:29:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="850501984"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; d="scan'208";a="850501984"
Received: from vmmteam.bj.intel.com ([10.240.192.110])
 by fmsmga002.fm.intel.com with ESMTP; 22 Aug 2023 00:29:35 -0700
From: Jing Liu <jing2.liu@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, pbonzini@redhat.com,
 kevin.tian@intel.com, reinette.chatre@intel.com, jing2.liu@intel.com,
 jing2.liu@linux.intel.com
Subject: [PATCH v1 0/4] Support dynamic MSI-X allocation
Date: Tue, 22 Aug 2023 03:29:23 -0400
Message-Id: <20230822072927.224803-1-jing2.liu@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.31; envelope-from=jing2.liu@intel.com;
 helo=mgamail.intel.com
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
supported. Qemu therefore when allocating a new interrupt, should first
release all previously allocated interrupts (including disable of MSI-X)
and re-allocate all interrupts that includes the new one.

The kernel series [1] adds the support of dynamic MSI-X allocation to
vfio-pci and uses the existing flag VFIO_IRQ_INFO_NORESIZE to guide user
space, that when dynamic MSI-X is supported the flag is cleared.

This series makes the behavior for VFIO PCI devices when dynamic MSI-X
allocation is supported. When guest unmasks an interrupt, Qemu can
directly allocate an interrupt on host for this and has nothing to do
with the previously allocated ones. Therefore, host only allocates
interrupts for those unmasked (enabled) interrupts inside guest when
dynamic MSI-X allocation is supported by device.

When guests enable MSI-X with all of the vectors masked, Qemu need match
the state to enable MSI-X with no vector enabled. During migration
restore, Qemu also need enable MSI-X first in dynamic allocation mode,
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

 hw/vfio/pci.c        | 126 +++++++++++++++++++++++++++++++++----------
 hw/vfio/pci.h        |   1 +
 hw/vfio/trace-events |   2 +-
 3 files changed, 101 insertions(+), 28 deletions(-)

-- 
2.27.0


