Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 928D874363D
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 09:51:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF8tH-0001tO-NS; Fri, 30 Jun 2023 03:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qF8tE-0001sI-Fy
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:50:00 -0400
Received: from mga03.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qF8tB-0002bO-Fv
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:50:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688111397; x=1719647397;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=UonVnseO0/8jSavni+NzU+cds/17q+LxzWG65jpZrYY=;
 b=Rsfq8JJwiFcNF70IV89kTIPw0XtiqNx4keqd79+/OSk+4HG70x1PRTlV
 HN0OY33ZRveTxndwT2iL8NrfDIM+iOAERJdRJH3f37zuyIky29D9dp0Kb
 o0BRnIOjUq9WsZhDipP1KYNVbmO+3GSUOn7z1B8u35zJf1CeuPs0EAyiA
 E2gCzDLxpPXPiMz7olci1UdKAfD0kHj+cVuzy8ep34Zwo726RjNPqbrR2
 QaQ13Et5HhC/loRNOujL6EoSQ2g7/4BDcOBmv3PSGJ4azrUVekNBY/HvO
 3yu70Ua/P6DrFcsEQ6vjqcwuvtcvNCQKg9DAFDNy0aYWBE+WE6S90E6NU w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="365824431"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; d="scan'208";a="365824431"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2023 00:49:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="841770765"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; d="scan'208";a="841770765"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2023 00:49:50 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, joao.m.martins@oracle.com,
 avihaih@nvidia.com, chao.p.peng@intel.com
Subject: [PATCH v5 0/7] VFIO migration related refactor and bug fix
Date: Fri, 30 Jun 2023 15:36:32 +0800
Message-Id: <20230630073637.124234-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.65;
 envelope-from=zhenzhong.duan@intel.com; helo=mga03.intel.com
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

PATCH4,5,7 refactors the VFIO migration blocker related code based on
suggestions from Joao and Cedric, so that code is simpler and
redundant "Migration disabled" isn't printed.

But before that works, also found some hotplug bugs when testing
blocker adding failed case. PATCH1-3,6 fix them.

See patch description for details.

v5: PATCH1-2 are not sent in v5 as Cedric already picked them
    Minor adjust on PATCH3 per Joao and Cedric
    Move PATCH4 after refactor patch per Joao
    Split refactor patch to three patches, PATCH4,5,7

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
  vfio/migration: Return bool type for some vfio migration related
    functions
  vfio/migration: Change vIOMMU blocker from global to per device
  vfio/migration: Free resources when vfio_migration_realize fails
  vfio/migration: Remove print of "Migration disabled"

 hw/vfio/common.c              | 59 ++++-------------------------------
 hw/vfio/migration.c           | 59 +++++++++++++++++++++++------------
 hw/vfio/pci.c                 |  8 +++--
 include/hw/vfio/vfio-common.h |  7 ++---
 4 files changed, 53 insertions(+), 80 deletions(-)

-- 
2.34.1


