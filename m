Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA378745614
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 09:29:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGDyu-0006Cg-4f; Mon, 03 Jul 2023 03:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qGDyq-0006Bz-RH
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 03:28:16 -0400
Received: from mga12.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qGDyo-0003wW-9I
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 03:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688369294; x=1719905294;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=VpIREP5MT8wVXbkjepEF3LfVGr8W4zBPTheqqga3rl0=;
 b=LFXuHvmqd/4L2TPGrzx0bY6y6JhjZfvQomYUHxqwkIfOrjpvN8mRc5t9
 61M3crW7dDr+vBOtmelaoHhyja5KcluIz7hkofX0K8zpLdUycDR6TFttG
 VzNI/TShdS/zTVdHs5qtZe/gtgQDe/Jw8MyR6IP2FtdGZEF+xcGsuiu14
 IVcUb4coqccbmTidG5esBBkBr/RYei1YggC7RlEiPU3TzTNuHq5XjpGtX
 OR8pHNhl0+2D4wBF1nMDi+rGKJrzbBMp1dDeausP9+0hCuwztll3ZkxsI
 ziJoiO0wL4Hq6JT3GQJ+IqHIqjozsZGHo8692VcDC3cr6OEhlaNH13AlX Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="342405624"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; d="scan'208";a="342405624"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2023 00:28:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="748058757"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; d="scan'208";a="748058757"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2023 00:28:07 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, joao.m.martins@oracle.com,
 avihaih@nvidia.com, chao.p.peng@intel.com
Subject: [PATCH v6 0/7] VFIO migration related refactor and bug fix
Date: Mon,  3 Jul 2023 15:15:05 +0800
Message-Id: <20230703071510.160712-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.136;
 envelope-from=zhenzhong.duan@intel.com; helo=mga12.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Hello,

PATCH4,6,7 refactors the VFIO migration blocker related code based on
suggestions from Joao and Cedric, so that code is simpler and
redundant "Migration disabled" isn't printed.

But before that works, also found some hotplug bugs when testing
blocker adding failed case. PATCH1-3,5 fix them.

See patch description for details.

v6: Update patch description with Joao suggested words
    Move rename patch to last and keep int return type for internal
    functions per Joao
    Move a check out from vfio_migration_deinit()
    Add Reviewed-by
v5: PATCH1-2 are not sent in v5 as Cedric already picked them
    Minor adjust on PATCH3 per Joao and Cedric
    Move PATCH4 after refactor patch per Joao
    Split refactor patch to three patches, PATCH4,5,7 per Cedric

v4: Rebased on [1] which contains Avihai's patchset [2]
    Add more patches to fix resource leak issue, split based on
    different fix TAG per Joao
    Change to not print "Migration disabled" with explicit
    enable-migration=off per Avihai
    Rename vfio_block_giommu_migration to vfio_viommu_preset per Joao

v3: Add PATCH1,2 to fix hotplug bug
    Fix bugs in PATCH3 Avihai and Joao pointed out

Tested vfio hotplug/unplug with vfio migration supported and unsupported cases,
and different param of enable-migration=[on/off/auto] and -only-migratable.

[1] https://github.com/legoater/qemu/tree/vfio-next
[2] https://lists.nongnu.org/archive/html/qemu-devel/2023-06/msg06117.html

Thanks

Zhenzhong Duan (5):
  vfio/pci: Disable INTx in vfio_realize error path
  vfio/migration: Change vIOMMU blocker from global to per device
  vfio/migration: Free resources when vfio_migration_realize fails
  vfio/migration: Remove print of "Migration disabled"
  vfio/migration: Return bool type for vfio_migration_realize()

 hw/vfio/common.c              | 51 ++---------------------------------
 hw/vfio/migration.c           | 51 ++++++++++++++++++++++++-----------
 hw/vfio/pci.c                 |  9 ++++---
 include/hw/vfio/vfio-common.h |  5 ++--
 4 files changed, 44 insertions(+), 72 deletions(-)

-- 
2.34.1


