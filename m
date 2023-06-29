Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D307422BE
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 10:54:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEnPO-0002J7-IT; Thu, 29 Jun 2023 04:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qEnPK-0002Hw-Pb
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 04:53:42 -0400
Received: from mga04.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qEnPI-0003dF-2Q
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 04:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688028820; x=1719564820;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ugogzwgcI9tCsqD5nYumKaiIyFOsPXS6z3mrHkSKZio=;
 b=S0w6ON5GSoY8VK3uocs2Jln8+WFYSC3lj8CplpCjbvdO1tnyl/RWJYe1
 kNbM8pWSIbd31VGnVftNpbcSxCeRvY4EDT2bOODx5M+fOKO/9eYn9X4vN
 3Ppj44/Bv2UlpD2Zi4KWloQX4OKypLO+IysmAEsJHAYNWAHYvh6AoZjCw
 EGf0y1JpNKQSzdZNws/y16OamhwSoRKYHCWiKH0kKsJs5o30atpPyPCky
 7gc6jRSAtG5tSaIgs01SuFJdJ0jjQkamjTkIOiCoROnlpAuOAbB0krQt3
 gh8r/OYZCfYRaG9A84aU8Y+hs0h/OGjx+vnZBbdNq49HMvMCHSGOSjugR w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="360908842"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; d="scan'208";a="360908842"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2023 01:53:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="720494288"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; d="scan'208";a="720494288"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2023 01:53:35 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, joao.m.martins@oracle.com,
 avihaih@nvidia.com, chao.p.peng@intel.com
Subject: [PATCH v4 0/5] VFIO migration related refactor and bug fix
Date: Thu, 29 Jun 2023 16:40:37 +0800
Message-Id: <20230629084042.86502-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.120;
 envelope-from=zhenzhong.duan@intel.com; helo=mga04.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

PATCH5 refactors the VFIO migration blocker related code based on
suggestions from Joao and Cedric, so that code is simpler and
"Migration disabled" printed in right case.

But before that works, also found some hotplug bugs when testing
blocker adding failed case. PATCH1-4 fix them.

See patch description for details.

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
  vfio/pci: Fix a segfault in vfio_realize
  vfio/pci: Free leaked timer in vfio_realize error path
  vfio/pci: Disable INTx in vfio_realize error path
  vfio/pci: Free resources when vfio_migration_realize fails
  vfio/migration: Refactor and fix print of "Migration disabled"

 hw/vfio/common.c              | 66 +++++++----------------------------
 hw/vfio/migration.c           | 30 +++++++++-------
 hw/vfio/pci.c                 | 18 +++++++---
 include/hw/vfio/vfio-common.h |  7 ++--
 4 files changed, 48 insertions(+), 73 deletions(-)

-- 
2.34.1


